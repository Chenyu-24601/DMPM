# DMPM 目录结构

```
DMPM/                                    # 团队文档与 Skills 分享框架
├── README.md                            # 项目说明文档
├── QUICKSTART.md                        # 快速入门指南
├── CHANGELOG.md                         # 更新日志
├── STRUCTURE.md                         # 本文件 - 目录结构说明
├── .gitignore                           # Git 忽略文件配置
│
├── skills/                              # 团队共享 Skills（核心目录）
│   │
│   ├── README.md                        # Skills 目录说明
│   │
│   └── (待添加团队 Skills)              # 从 .claude/skills/ 迁移现有 Skills
│       ├── product-prototype/           # 示例：产品原型全流程
│       │   ├── SKILL.md                 # 主 Skill 文件
│       │   ├── references/              # 参考文档
│       │   └── examples/                # 示例文件
│       │
│       ├── hk-ipo-analyzer/            # 示例：港股 IPO 分析
│       │   ├── SKILL.md
│       │   ├── workflow.md
│       │   └── sources.md
│       │
│       └── ...                          # 更多 Skills
│
├── scripts/                             # 自动化工具脚本
│   ├── share-to-team.sh                # ✨ 一键分享工具
│   ├── sync-from-team.sh               # ✨ 一键同步工具
│   └── (待扩展)
│       └── validate-skills.sh          # 验证 Skills 格式
│
├── docs/                                # 文档目录
│   ├── SKILLS_GUIDE.md                 # 📖 Skills 详细使用指南
│   ├── CONTRIBUTING.md                 # 🤝 贡献者指南
│   └── (待扩展)
│       ├── FAQ.md                      # 常见问题
│       └── BEST_PRACTICES.md           # 最佳实践
│
└── .github/                             # GitHub 配置
    └── workflows/                       # GitHub Actions 工作流
        ├── notify-skill-update.yml     # 🔔 Skills 更新通知
        └── (待扩展)
            └── validate-pr.yml         # PR 验证
```

## 核心目录说明

### skills/
**团队共享的 Skills**

这是 DMPM 的核心目录，存放所有团队成员共同使用和维护的 Claude Code Skills。

**标准 Skill 结构：**
```
skill-name/
├── SKILL.md          # 主文件（必需）
├── references/       # 参考文档（可选）
├── examples/         # 示例文件（可选）
└── scripts/          # 辅助脚本（可选）
```

### scripts/
**自动化工具**

简化日常操作的脚本工具。

**主要脚本：**
- `share-to-team.sh` - 将你创建/修改的 Skills 分享到团队
- `sync-from-team.sh` - 从团队仓库同步最新的 Skills

### docs/
**文档中心**

详细的使用指南和开发文档。

**主要文档：**
- `SKILLS_GUIDE.md` - 全面的 Skills 使用指南
- `CONTRIBUTING.md` - 如何为 DMPM 做贡献

### .github/workflows/
**自动化工作流**

GitHub Actions 配置，实现自动化通知和验证。

---

## 使用流程

### 📥 同步 Skills（使用者）

```bash
./DMPM/scripts/sync-from-team.sh
```

**流程：**
```
Git 仓库 → DMPM/skills/ → .claude/skills/ → Claude Code
```

### 📤 分享 Skills（贡献者）

```bash
# 1. 在 DMPM/skills/ 创建/修改 Skill
vim DMPM/skills/your-skill/SKILL.md

# 2. 使用分享脚本
./DMPM/scripts/share-to-team.sh
```

**流程：**
```
本地修改 → DMPM/skills/ → Git 提交 → 远程仓库 → 团队通知
```

---

## 扩展计划

### 待添加的功能

#### scripts/
- `validate-skills.sh` - 验证 Skills 格式和质量
- `list-skills.sh` - 列出所有可用 Skills 及其描述
- `search-skills.sh` - 搜索 Skills 的内容

#### docs/
- `FAQ.md` - 常见问题解答
- `BEST_PRACTICES.md` - Skills 开发最佳实践
- `EXAMPLES.md` - 完整的使用示例集合

#### .github/workflows/
- `validate-pr.yml` - PR 自动验证
- `weekly-summary.yml` - 每周 Skills 使用统计
- `auto-release.yml` - 自动版本发布

---

## 文件命名规范

### Skills
- 目录名：小写，连字符分隔（如 `product-prototype`）
- 主文件：`SKILL.md`（大写）
- 辅助文件：小写，描述性命名

### 脚本
- 格式：`动词-对象.sh`
- 示例：`share-to-team.sh`, `sync-from-team.sh`

### 文档
- 主要文档：大写（如 `README.md`, `CONTRIBUTING.md`）
- 辅助文档：大写（如 `FAQ.md`, `CHANGELOG.md`）

---

## 版本控制

### Git 工作流

```
main/master 分支
    ↓
DMPM/
    ↓
团队成员 git pull
    ↓
使用 sync-from-team.sh
```

### 提交规范

```
<type>(<scope>): <subject>

示例：
feat(skill): add competitor-analysis skill
fix(scripts): correct sync-from-team.sh path issue
docs(guide): update skills usage examples
```

---

## 获取帮助

- **查看文档**：`cat DMPM/docs/SKILLS_GUIDE.md`
- **快速入门**：`cat DMPM/QUICKSTART.md`
- **贡献指南**：`cat DMPM/docs/CONTRIBUTING.md`
- **联系支持**：@xiangchenyu 或团队群

