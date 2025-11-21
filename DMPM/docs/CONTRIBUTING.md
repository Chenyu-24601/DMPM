# 贡献指南

感谢你为 DMPM 贡献！本指南帮助你快速开始。

## 🎯 贡献方式

### 1. 创建新的 Skill

适合：技术人员

```bash
# 使用 skill-creator（推荐）
# 在 Claude Code 中说："创建一个新的 Skill"

# 或手动创建
mkdir -p DMPM/skills/your-skill
vim DMPM/skills/your-skill/SKILL.md
```

### 2. 改进现有 Skill

适合：所有人

- 修正错误
- 补充文档
- 优化流程
- 添加示例

### 3. 提出 Skill 需求

适合：非技术人员

在团队群或 GitHub Issues 提出你的需求。

### 4. 完善文档

- 改进 README
- 补充使用指南
- 添加最佳实践

## 📝 提交规范

### Commit Message 格式

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Type（必需）：**
- `feat`: 新功能
- `fix`: Bug 修复
- `docs`: 文档变更
- `style`: 代码格式（不影响功能）
- `refactor`: 重构
- `test`: 测试相关
- `chore`: 构建/工具变更

**Scope（可选）：**
- `dmpm`: DMPM 框架
- `skill`: Skill 相关
- `scripts`: 脚本工具
- `docs`: 文档

**示例：**

```bash
# 新增 Skill
feat(skill): add competitor-analysis skill

新增竞品分析 Skill，支持产品对比和市场分析。

- 产品定位分析
- 功能对比矩阵
- 用户体验评估

# Bug 修复
fix(skill): correct product-prototype PRD template

修正 PRD 模板中的表格格式问题

# 文档更新
docs(guide): update skills usage examples

补充 Skills 使用示例，增加常见问题解答
```

### 分支策略

**简化流程（推荐）：**

直接在 `main` 分支工作，使用分享脚本推送。

```bash
# 修改文件
vim DMPM/skills/your-skill/SKILL.md

# 分享到团队
./DMPM/scripts/share-to-team.sh
```

**标准流程（可选）：**

```bash
# 创建功能分支
git checkout -b feature/new-skill

# 开发和提交
git add DMPM/skills/new-skill
git commit -m "feat(skill): add new-skill"

# 推送分支
git push origin feature/new-skill

# 创建 Pull Request
gh pr create --title "Add new-skill" --body "描述"
```

## ✅ Skill 质量检查清单

在提交前检查：

### 基础要求
- [ ] `SKILL.md` 文件存在
- [ ] 有完整的 YAML frontmatter
- [ ] `name` 字段准确
- [ ] `description` 清晰描述触发条件
- [ ] 内容使用中文（除非特殊需要）

### 内容质量
- [ ] 有清晰的使用场景说明
- [ ] 工作流程详细且逻辑清晰
- [ ] 有使用示例
- [ ] 输出说明明确

### 可选但推荐
- [ ] 有版本号
- [ ] 有 references/ 参考文档
- [ ] 有 examples/ 示例文件
- [ ] 代码格式统一

### 测试验证
- [ ] 在 Claude Code 中测试过
- [ ] 触发条件有效
- [ ] 输出符合预期
- [ ] 无明显错误

## 🔍 Code Review 指南

### 审查重点

**对于 Skill：**
1. Description 是否准确？
2. 工作流程是否清晰？
3. 是否有明显错误？
4. 是否与现有 Skill 冲突？

**对于脚本：**
1. 是否有安全隐患？
2. 错误处理是否完善？
3. 用户体验是否友好？

**对于文档：**
1. 信息是否准确？
2. 表达是否清晰？
3. 格式是否统一？

### 审查流程

1. **快速审查**（5分钟内）
   - 检查基本格式
   - 运行质量检查清单
   - 提出明显问题

2. **深度审查**（15分钟内）
   - 测试 Skill 功能
   - 验证逻辑正确性
   - 提出改进建议

3. **批准或请求修改**
   - 无问题：批准合并
   - 有问题：详细说明需要修改的地方

## 🚀 发布流程

### 版本号管理

遵循语义化版本：

```
MAJOR.MINOR.PATCH
1.0.0
```

**何时更新版本号：**

- **MAJOR (1.x.x → 2.0.0)**:
  - Skill 工作流程重大变更
  - 不兼容的修改

- **MINOR (1.0.x → 1.1.0)**:
  - 新增功能
  - 向后兼容的改进

- **PATCH (1.0.0 → 1.0.1)**:
  - Bug 修复
  - 文档更新
  - 小的优化

### 发布步骤

```bash
# 1. 更新版本号
vim DMPM/skills/your-skill/SKILL.md
# version: 1.0.0 → 1.1.0

# 2. 更新 CHANGELOG（如果有）
vim DMPM/CHANGELOG.md

# 3. 提交变更
git add .
git commit -m "chore(release): bump version to 1.1.0"

# 4. 打标签（可选）
git tag -a v1.1.0 -m "Release version 1.1.0"

# 5. 推送
git push origin main --tags

# 6. 通知团队
# 在团队群发布更新通知
```

## 💡 最佳实践

### Skill 开发

1. **从小开始**
   - 先创建简单的 Skill
   - 逐步完善功能
   - 收集用户反馈

2. **保持专注**
   - 一个 Skill 做一件事
   - 避免功能过载
   - 复杂需求拆分多个 Skills

3. **清晰的 Description**
   - 包含关键触发词
   - 描述具体场景
   - 避免模糊表述

4. **充分测试**
   - 多种触发方式
   - 边界情况
   - 与其他 Skills 的协作

### 文档编写

1. **面向用户**
   - 使用简单语言
   - 提供实际示例
   - 解答常见疑问

2. **结构清晰**
   - 使用标题和列表
   - 关键信息加粗
   - 代码块加语法高亮

3. **保持更新**
   - Skill 变更时同步更新文档
   - 补充新的使用场景
   - 修正过时信息

### 团队协作

1. **及时沟通**
   - 重大变更前讨论
   - 不确定时询问
   - 分享经验和技巧

2. **尊重他人工作**
   - 修改他人 Skill 前咨询
   - 保留原有功能
   - 说明变更原因

3. **主动分享**
   - 创建新 Skill 后通知
   - 分享使用心得
   - 帮助他人解决问题

## 🐛 问题报告

### Bug 报告模板

```markdown
## Bug 描述
[清晰简洁地描述问题]

## 复现步骤
1. 打开 Claude Code
2. 输入 "..."
3. 观察到问题

## 期望行为
[应该发生什么]

## 实际行为
[实际发生了什么]

## 环境信息
- Skill: [Skill 名称和版本]
- Claude Code: [版本]
- 操作系统: [macOS/Windows/Linux]

## 额外信息
[截图、日志等]
```

### 提交途径

1. **紧急问题**：团队群直接联系
2. **一般问题**：GitHub Issues
3. **改进建议**：团队群讨论

## 📞 获取帮助

### 遇到问题？

1. **查看文档**
   - [README](../README.md)
   - [Skills Guide](SKILLS_GUIDE.md)
   - [FAQ](SKILLS_GUIDE.md#常见问题)

2. **搜索已有问题**
   - GitHub Issues
   - 团队讨论记录

3. **寻求帮助**
   - 团队群提问
   - 联系技术负责人 @xiangchenyu
   - 创建 GitHub Issue

### 想要贡献但不知如何开始？

1. **浏览现有 Skills**
   - 看看其他人如何实现
   - 找找可以改进的地方

2. **从简单开始**
   - 修正拼写错误
   - 补充文档
   - 添加示例

3. **提出想法**
   - 在团队群分享
   - 收集反馈
   - 逐步实现

## 🎉 致谢

感谢所有为 DMPM 做出贡献的团队成员！

你的每一个贡献都让团队协作更高效。
