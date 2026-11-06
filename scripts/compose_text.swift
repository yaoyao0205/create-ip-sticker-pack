#!/usr/bin/env swift

import AppKit
import Foundation

struct StickerSpec {
    let file: String
    let caption: String
    let tilt: CGFloat
}

guard CommandLine.arguments.count == 4 else {
    fputs("Usage: compose_text.swift INPUT_DIR CAPTIONS.tsv OUTPUT_DIR\n", stderr)
    fputs("TSV columns: filename<TAB>caption<TAB>optional rotation degrees; encode line breaks as \\n\n", stderr)
    exit(2)
}

let inputDir = URL(fileURLWithPath: CommandLine.arguments[1], isDirectory: true)
let captionsURL = URL(fileURLWithPath: CommandLine.arguments[2])
let outputDir = URL(fileURLWithPath: CommandLine.arguments[3], isDirectory: true)
try FileManager.default.createDirectory(at: outputDir, withIntermediateDirectories: true)

let rawTSV = try String(contentsOf: captionsURL, encoding: .utf8)
let specs: [StickerSpec] = rawTSV.split(whereSeparator: \.isNewline).compactMap { rawLine in
    var line = String(rawLine)
    if line.hasPrefix("\u{feff}") { line.removeFirst() }
    if line.trimmingCharacters(in: .whitespaces).isEmpty || line.hasPrefix("#") { return nil }
    let fields = line.components(separatedBy: "\t")
    guard fields.count >= 2 else {
        fputs("Skipping malformed TSV line: \(line)\n", stderr)
        return nil
    }
    let caption = fields[1].replacingOccurrences(of: "\\n", with: "\n")
    let tilt = fields.count >= 3 ? CGFloat(Double(fields[2]) ?? 0) : 0
    return StickerSpec(file: fields[0], caption: caption, tilt: tilt)
}

guard !specs.isEmpty else {
    fputs("No valid caption rows found.\n", stderr)
    exit(2)
}

// Patch these three colors to match the selected IP palette.
let fillColor = NSColor(calibratedRed: 0.94, green: 0.36, blue: 0.12, alpha: 1)
let darkColor = NSColor(calibratedRed: 0.15, green: 0.12, blue: 0.10, alpha: 0.94)
let lightColor = NSColor.white

func font(for caption: String, canvasWidth: CGFloat) -> NSFont {
    let compact = caption.replacingOccurrences(of: "\n", with: "")
    let ratio: CGFloat
    if caption.contains("\n") { ratio = 0.089 }
    else if compact.count >= 6 { ratio = 0.089 }
    else if compact.count == 5 { ratio = 0.099 }
    else { ratio = 0.113 }
    let size = canvasWidth * ratio
    // Rounded, friendly display face for toy and sticker packs. Keep robust fallbacks.
    return NSFont(name: "HannotateSC-W7", size: size)
        ?? NSFont(name: "PingFangSC-Semibold", size: size)
        ?? NSFont.systemFont(ofSize: size, weight: .bold)
}

func baseAttributes(caption: String, width: CGFloat) -> [NSAttributedString.Key: Any] {
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = .center
    paragraph.lineSpacing = -width * 0.0064
    paragraph.lineBreakMode = .byClipping
    return [
        .font: font(for: caption, canvasWidth: width),
        .paragraphStyle: paragraph,
        .kern: width * 0.0003,
    ]
}

func outerAttributes(caption: String, width: CGFloat) -> [NSAttributedString.Key: Any] {
    var attributes = baseAttributes(caption: caption, width: width)
    attributes[.foregroundColor] = NSColor.clear
    attributes[.strokeColor] = lightColor
    attributes[.strokeWidth] = 15.0
    return attributes
}

func innerAttributes(caption: String, width: CGFloat) -> [NSAttributedString.Key: Any] {
    var attributes = baseAttributes(caption: caption, width: width)
    attributes[.foregroundColor] = fillColor
    attributes[.strokeColor] = darkColor
    attributes[.strokeWidth] = -7.5
    return attributes
}

func render(_ spec: StickerSpec) throws {
    let inputURL = inputDir.appendingPathComponent(spec.file)
    let outputURL = outputDir.appendingPathComponent(spec.file)
    guard let source = NSImage(contentsOf: inputURL),
          let sourceRep = source.representations.first else {
        throw NSError(domain: "ComposeText", code: 1,
                      userInfo: [NSLocalizedDescriptionKey: "Cannot open \(inputURL.path)"])
    }

    let width = CGFloat(sourceRep.pixelsWide)
    let height = CGFloat(sourceRep.pixelsHigh)
    guard width > 0, height > 0 else { throw NSError(domain: "ComposeText", code: 2) }

    guard let bitmap = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: Int(width),
        pixelsHigh: Int(height),
        bitsPerSample: 8,
        samplesPerPixel: 4,
        hasAlpha: true,
        isPlanar: false,
        colorSpaceName: .deviceRGB,
        bytesPerRow: 0,
        bitsPerPixel: 0
    ) else { throw NSError(domain: "ComposeText", code: 3) }

    bitmap.size = NSSize(width: width, height: height)
    guard let graphics = NSGraphicsContext(bitmapImageRep: bitmap) else {
        throw NSError(domain: "ComposeText", code: 4)
    }

    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = graphics
    graphics.imageInterpolation = .high
    NSColor.clear.setFill()
    NSRect(x: 0, y: 0, width: width, height: height).fill()

    let artRect = NSRect(x: width * 0.069, y: height * 0.011,
                         width: width * 0.861, height: height * 0.861)
    source.draw(in: artRect, from: .zero, operation: .sourceOver, fraction: 1)

    let multiline = spec.caption.contains("\n")
    let headlineRect = NSRect(
        x: width * 0.028,
        y: height * (multiline ? 0.794 : 0.834),
        width: width * 0.944,
        height: height * (multiline ? 0.191 : 0.142)
    )

    let cg = graphics.cgContext
    cg.saveGState()
    let center = CGPoint(x: headlineRect.midX, y: headlineRect.midY)
    cg.translateBy(x: center.x, y: center.y)
    cg.rotate(by: spec.tilt * .pi / 180)
    cg.translateBy(x: -center.x, y: -center.y)
    let text = spec.caption as NSString
    text.draw(in: headlineRect, withAttributes: outerAttributes(caption: spec.caption, width: width))
    text.draw(in: headlineRect, withAttributes: innerAttributes(caption: spec.caption, width: width))
    cg.restoreGState()

    graphics.flushGraphics()
    NSGraphicsContext.restoreGraphicsState()

    guard let data = bitmap.representation(using: .png, properties: [:]) else {
        throw NSError(domain: "ComposeText", code: 5)
    }
    try data.write(to: outputURL, options: .atomic)
    print("built \(spec.file): \(spec.caption.replacingOccurrences(of: "\n", with: " / "))")
}

for spec in specs { try render(spec) }
