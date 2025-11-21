# DMPM - Document Management & Plugin Manager

Mininglamp 团队文档与 Skills 分享框架

## 📖 项目简介

DMPM 是 Mininglamp 团队用于共享 Claude Code Skills、文档模板和工作流程的统一框架。

### 核心功能

- **Skills 共享** - 团队成员共同创建和使用的 Claude Code Skills
- **文档模板** - 标准化的 PRD、技术规范等模板
- **自动化工具** - 简化分享和同步的脚本工具
- **版本管理** - 通过 Git 进行版本控制和协作

## 📁 目录结构

```
DMPM/
├── skills/                  # 团队共享 Skills
│   ├── product-prototype/   # 产品原型全流程
│   ├── hk-ipo-analyzer/    # 港股 IPO 分析
│   └── ...
├── scripts/                # 自动化脚本
│   ├── share-to-team.sh    # 一键分享工具
│   └── sync-from-team.sh   # 一键同步工具
├── docs/                   # 文档
│   ├── SKILLS_GUIDE.md     # Skills 使用指南
│   └── CONTRIBUTING.md     # 贡献指南
└── .github/                # GitHub 配置
    └── workflows/          # 自动化工作流
```

## 🚀 快速开始

### 👥 非技术人员（推荐）

**只需要记住两个命令！**

```bash
# 📥 获取团队最新内容
./DMPM/scripts/update-local.sh

# 📤 上传你的文件
./DMPM/scripts/upload-file.sh <文件路径>
```

📖 **详细说明：** [非技术人员使用指南](NON_TECH_GUIDE.md)

---

### 💻 技术人员

#### 首次使用

```bash
# 1. 克隆仓库（如果还没有）
cd /Volumes/xcy/mininglamp

# 2. 同步 Skills
./DMPM/scripts/sync-from-team.sh
```

#### 获取最新更新

```bash
# 方式 1：使用简化脚本（推荐）
./DMPM/scripts/update-local.sh

# 方式 2：手动操作
git pull
./DMPM/scripts/sync-from-team.sh
```

## 📝 贡献 Skills

### 方式 1：技术人员直接创建

```bash
# 1. 在 DMPM/skills/ 创建新 Skill
mkdir -p DMPM/skills/your-skill
vim DMPM/skills/your-skill/SKILL.md

# 2. 使用分享脚本
./DMPM/scripts/share-to-team.sh

# 脚本会自动：
# - 检查变更
# - 创建 Git 提交
# - 推送到远程仓库
```

### 方式 2：非技术人员提需求

1. 在团队群或 GitHub Issues 提出需求
2. 技术负责人评估并创建
3. 自动通知团队成员更新

## 📚 可用的 Skills

### 产品设计类

#### product-prototype
产品原型全流程 Skill（流程图 → PRD → 交互原型）

**触发词**："创建产品原型"、"设计产品流程"

#### product-flow-diagram
专业的产品功能流程图绘制

**触发词**："画流程图"、"绘制业务流程"

### 财务分析类

#### hk-ipo-analyzer
港股 IPO 全面分析

**触发词**："分析港股 IPO"、"研究新股"

#### analyzing-financial-statements
财务报表分析与指标计算

**触发词**："分析财务报表"、"计算财务比率"

### 工具类

#### mininglamp-helper
Mininglamp 项目开发助手

**触发词**：自动激活

#### skill-creator
快速创建标准化的 Skill

**触发词**："创建 Skill"

## 🔄 工作流程

```
创建/修改 Skill
    ↓
使用分享脚本
    ↓
推送到 Git 仓库
    ↓
团队成员 git pull
    ↓
自动同步到 Claude Code
    ↓
所有人都可使用
```

## 🛠️ 自动化工具

### share-to-team.sh
一键分享 Skills 到团队

```bash
./DMPM/scripts/share-to-team.sh
```

功能：
- ✅ 自动检测变更
- ✅ 生成提交信息
- ✅ 推送到远程仓库
- ✅ 显示分享结果

### sync-from-team.sh
一键同步团队最新 Skills

```bash
./DMPM/scripts/sync-from-team.sh
```

功能：
- ✅ 拉取最新代码
- ✅ 复制到 Claude Code 配置
- ✅ 显示更新内容

## 📞 联系方式

- **技术负责人**：@xiangchenyu
- **团队群**：Mininglamp 开发群
- **GitHub**：[mininglamp/mininglamp](https://github.com/mininglamp/mininglamp)

## 📄 许可证

MIT License - 团队内部使用
