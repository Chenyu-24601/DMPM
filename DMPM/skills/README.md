# DMPM Skills 目录

这里存放团队共享的 Claude Code Skills。

## 🚀 开始使用

### 首次设置

从现有的 `.claude/skills/` 迁移 Skills：

```bash
# 复制现有 Skills 到 DMPM
cp -r /Volumes/xcy/mininglamp/.claude/skills/* /Volumes/xcy/mininglamp/DMPM/skills/

# 分享到团队
cd /Volumes/xcy/mininglamp
./DMPM/scripts/share-to-team.sh
```

### 同步到本地

团队成员获取 Skills：

```bash
./DMPM/scripts/sync-from-team.sh
```

## 📁 当前可用的 Skills

> 提示：运行同步脚本后，这里会自动列出所有 Skills

待迁移的 Skills（从 `.claude/skills/`）：
- product-prototype - 产品原型全流程
- product-flow-diagram - 产品流程图绘制
- hk-ipo-analyzer - 港股 IPO 分析
- analyzing-financial-statements - 财务报表分析
- creating-financial-models - 财务模型创建
- applying-brand-guidelines - 品牌指南应用
- mininglamp-helper - Mininglamp 项目助手
- skill-creator - Skill 创建器

## ✨ 创建新 Skill

### 使用 skill-creator（推荐）

```
在 Claude Code 中说："创建一个新的 Skill"
```

### 手动创建

```bash
# 1. 创建目录
mkdir -p DMPM/skills/your-skill

# 2. 创建 SKILL.md
cat > DMPM/skills/your-skill/SKILL.md <<'EOF'
---
name: your-skill
description: 描述何时使用此 Skill（重要！）
version: 1.0.0
---

# Your Skill 标题

## 概述
[简短描述]

## 使用场景
[何时使用此 Skill]

## 工作流程
[详细步骤]

## 示例
[使用示例]
EOF

# 3. 测试
cp -r DMPM/skills/your-skill .claude/skills/
# 在 Claude Code 中测试

# 4. 分享
./DMPM/scripts/share-to-team.sh
```

## 📝 Skill 标准结构

### 最小结构（仅核心文件）

```
skill-name/
└── SKILL.md          # 必需
```

### 标准结构（推荐）

```
skill-name/
├── SKILL.md          # 主 Skill 文件
├── references/       # 参考文档
│   ├── guide.md
│   └── template.md
└── examples/         # 示例文件
    └── sample.md
```

### 完整结构（复杂 Skill）

```
skill-name/
├── SKILL.md          # 主 Skill 文件
├── references/       # 参考文档
├── examples/         # 示例文件
├── scripts/          # 辅助脚本
│   ├── helper.py
│   └── validate.sh
└── README.md         # Skill 说明（可选）
```

## 🎯 Skill 质量标准

### 必需项
- [x] 有 `SKILL.md` 文件
- [x] 有完整的 YAML frontmatter（name, description）
- [x] Description 清晰描述触发条件
- [x] 有详细的工作流程说明

### 推荐项
- [ ] 有版本号
- [ ] 有使用示例
- [ ] 有参考文档
- [ ] 结构清晰，易于理解

## 📚 更多信息

- [Skills 使用指南](../docs/SKILLS_GUIDE.md) - 详细的使用文档
- [贡献指南](../docs/CONTRIBUTING.md) - 如何贡献 Skills
- [快速入门](../QUICKSTART.md) - 5 分钟上手

## 🆘 需要帮助？

- 查看现有 Skills 作为参考
- 阅读 [Skills 使用指南](../docs/SKILLS_GUIDE.md)
- 在团队群提问
- 联系 @xiangchenyu
