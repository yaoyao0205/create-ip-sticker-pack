# Yaoyao IP 表情包制作 Skill

从人物、宠物、物品或产品的参考图出发，建立一致的原创 IP，制作静态表情包，并导出、检查微信表情提交素材。

适用于支持 Skill、文件操作和图片生成的 AI Agent 环境。

## 能做什么

- 提取轮廓、比例、花纹和识别特征，探索不同角色风格。
- 保存角色规格与纠错记录，方便换主题、续做下一套。
- 规划表情的使用场景、情绪、动作和短文案。
- 先制作无字母版，再通过脚本添加准确的中文文字。
- 检查肢体、角色一致性、小尺寸可读性及深浅背景效果。
- 导出主图、缩略图、总览和上传 ZIP；按需制作封面、图标、详情横幅和赞赏素材。

## 安装

将本仓库克隆到 Codex 的 skills 目录：

```bash
git clone https://github.com/yaoyao0205/yaoyao-create-ip-sticker-pack.git \
  ~/.codex/skills/create-ip-sticker-pack
```

本仓库公开可访问，克隆无需 GitHub 登录。安装后，在新对话中请求制作表情包；若未自动触发，可明确指定使用 `create-ip-sticker-pack` Skill。

如果使用其他 Agent，将仓库放入该环境支持的 Skill 目录，并确认它能够读取 `SKILL.md`。

## 使用示例

附上参考图片，然后对 Agent 说：

> 用这些照片制作一套 16 张的原创宠物表情包。先探索角色方向，等我选定后继续。保留原有花纹，配简短中文文案，最后导出微信素材。

也可以授权自动完成：

> 基于这张参考图自动选择最合适的角色方向，完成一套 16 张日常聊天表情包。先内部检查关键样张，再继续整套制作。

续做主题包：

> 沿用上一套批准的角色、花纹和字体，制作一套上班主题表情包，避免重复动作。

针对性修改：

> 尾巴必须从根部到尖端都是橘色，不能出现白尖。把这条记入角色禁改项，再修正受影响的图片。

## 制作流程

1. 检查参考图，区分身份、花纹、姿势和风格参考。
2. 建立角色特征锚点，探索并选择设计方向。
3. 保存角色规格、参考图和用户纠正记录。
4. 规划整套表情的聊天场景、动作和文案。
5. 先验证中性、大动作、强表情等代表样张，再扩展整套。
6. 检查无字母版，程序加字，复核小尺寸和深浅背景效果。
7. 导出素材，通过检查后生成上传 ZIP。

用户要求分阶段确认时等待选择；授权自动完成时，在内部质量检查通过后继续。

## 依赖与限制

- **图片生成**：需要可用的 `imagegen` Skill 及对应图片生成能力；本仓库不包含模型服务或 API 密钥。
- **文字合成**：`compose_text.swift` 使用 Swift；当前工作流面向 macOS，其他系统需要适配。
- **素材导出**：需要 Bash、FFmpeg、FFprobe 和 ZIP。
- **平台规则**：脚本中的尺寸、数量和文件大小限制是本地预设，交付前仍需核实微信当前规则；脚本通过不代表平台审核通过。
- **质量检查**：角色相似度、肢体合理性、文字效果和透明边缘仍需实际看图确认。
- **范围**：以静态表情素材为主，不包含自动上传或自动提交审核。

## 脚本使用

以下命令均在本仓库根目录执行；素材路径按实际项目位置替换。

### 添加文字

准备 UTF-8 TSV，每行依次为文件名、文案和可选旋转角度，列之间使用真正的 Tab。**不要添加表头**：脚本会把表头当作图片文件名。文字内换行写成字面量 `\n`，旋转角度省略时为 0。

例如下面两行（列之间为 Tab）：

```tsv
01-hello.png	你好呀	0
02-thanks.png	谢谢\n收到啦	-5
```

输入使用 PNG 母版。脚本内置橘色文字、深色描边、白色外圈和顶部排版；如需其他风格，需调整脚本并检查长文案是否裁切。

```bash
swift scripts/compose_text.swift \
  stickers/masters-no-text captions.tsv stickers/masters-text
```

### 导出微信素材

母版使用两位连续编号，例如 `01-hello.png`、`02-thanks.png`。默认接受 8、16 或 24 张。

```bash
bash scripts/export_wechat_pack.sh \
  stickers/masters-text stickers/export-v01
```

导出生成 `main-240/`（240×240 GIF）、`thumb-120/`（120×120 PNG）、`overview.png` 和 `wechat-upload-kit.zip`。主图 GIF 是由静态母版转换而来，不代表生成了动画。

导出时保持图片比例并补齐画布。重复或缺失编号会被拦截；已有导出不会被覆盖，请为新版本使用新的目录。检查失败时不生成新的上传 ZIP。

可选配套图片应预先放入输出目录的 `package-assets/`。详细要求见 [微信交付规范](references/wechat-deliverables.md)。

## 文件结构

```text
.
├── SKILL.md                       # Agent 工作流与质量要求
├── agents/openai.yaml             # Skill 展示元数据
├── references/
│   ├── identity-consistency.md    # 角色一致性
│   ├── character-record.md        # 角色档案与纠错记录
│   ├── style-routing.md           # 风格选择
│   ├── prompt-recipes.md          # 提示词结构
│   ├── anatomy-prop-quality.md    # 肢体与道具检查
│   ├── caption-design.md          # 文案与文字设计
│   └── wechat-deliverables.md     # 微信交付素材
└── scripts/
    ├── compose_text.swift         # 确定性文字合成
    └── export_wechat_pack.sh      # 导出、检查和打包
```

从 [SKILL.md](SKILL.md) 查看完整工作要求。项目实际图片、角色档案、提示词和导出文件保存在各自项目目录，不需要提交到本仓库。
