# DMPM 更新日志

所有重要的变更都会记录在这个文件中。

格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)。

## [Unreleased]

### 计划中
- 更多财务分析 Skills
- 自动化测试工具
- 团队协作工作流

## [1.0.0] - 2024-11-21

### 新增
- 🎉 初始化 DMPM 框架
- 📁 创建标准目录结构
- 🔧 添加自动化脚本
  - `share-to-team.sh` - 一键分享工具
  - `sync-from-team.sh` - 一键同步工具
- 📚 完整的文档体系
  - README - 项目说明
  - QUICKSTART - 快速入门
  - SKILLS_GUIDE - Skills 使用指南
  - CONTRIBUTING - 贡献指南
- 🤖 GitHub Actions 自动通知工作流
- 📋 Skills 目录结构（待填充团队 Skills）

### 文档
- 添加详细的 Skills 使用指南
- 添加贡献者指南
- 添加快速入门文档

---

## 版本说明

### [Unreleased]
未发布的变更

### [1.0.0] - 2024-11-21
初始版本发布

---

## 更新日志格式说明

### 变更类型

- **新增** (Added) - 新功能
- **变更** (Changed) - 现有功能的变更
- **弃用** (Deprecated) - 即将移除的功能
- **移除** (Removed) - 已移除的功能
- **修复** (Fixed) - Bug 修复
- **安全** (Security) - 安全性改进

### 示例

```markdown
## [1.1.0] - 2024-12-01

### 新增
- 新增 competitor-analysis Skill
- 添加自动版本检查功能

### 变更
- 优化 product-prototype Skill 的 PRD 模板
- 更新 sync-from-team.sh 脚本输出格式

### 修复
- 修复 share-to-team.sh 在某些情况下推送失败的问题
- 修正 SKILLS_GUIDE 中的拼写错误

### 文档
- 补充常见问题解答
- 添加更多使用示例
```

---

## 如何记录变更

### 何时更新

- ✅ 添加新 Skill
- ✅ 修改现有 Skill 的重要功能
- ✅ 修复 Bug
- ✅ 更新文档
- ✅ 改进工具脚本

### 如何更新

```bash
# 1. 编辑 CHANGELOG.md
vim DMPM/CHANGELOG.md

# 2. 在 [Unreleased] 下添加你的变更

# 3. 提交时引用 CHANGELOG
git commit -m "feat(skill): add new-skill

详见 CHANGELOG.md"
```

### 发布新版本时

```bash
# 1. 将 [Unreleased] 的内容移到新版本号下
## [1.1.0] - 2024-12-01

### 新增
- ...

# 2. 清空 [Unreleased]
## [Unreleased]

### 计划中
- ...

# 3. 创建 Git tag
git tag -a v1.1.0 -m "Release version 1.1.0"
git push origin v1.1.0
```

---

[Unreleased]: https://github.com/mininglamp/mininglamp/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/mininglamp/mininglamp/releases/tag/v1.0.0
