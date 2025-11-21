# DMPM 快速入门

5 分钟让你开始使用团队 Skills！

## 🎯 第一次使用

### Step 1: 同步 Skills

```bash
cd /Volumes/xcy/mininglamp

# 运行同步脚本
./DMPM/scripts/sync-from-team.sh
```

**这个脚本会：**
- ✅ 从 Git 拉取最新代码
- ✅ 复制 DMPM/skills/ 到 .claude/skills/
- ✅ 显示可用的 Skills 列表

### Step 2: 开始使用

打开 Claude Code，直接对话即可！

**示例 1：创建产品原型**
```
你：帮我创建一个用户注册功能的产品原型

Claude：
好的！我将使用 product-prototype Skill 帮你完成完整的产品设计流程...
```

**示例 2：分析港股 IPO**
```
你：分析某某公司的港股 IPO

Claude：
我将使用 hk-ipo-analyzer Skill 进行分析...
```

就这么简单！✨

---

## 🔄 日常更新

当团队有新的 Skills 或更新时：

```bash
# 方式 1：使用同步脚本（推荐）
./DMPM/scripts/sync-from-team.sh

# 方式 2：手动操作
git pull
cp -r DMPM/skills/* .claude/skills/
```

**建议：**
- 每周同步一次
- 收到更新通知后立即同步

---

## ✍️ 贡献新 Skill

### 技术人员

```bash
# 1. 创建 Skill 目录
mkdir -p DMPM/skills/my-skill

# 2. 创建 SKILL.md
cat > DMPM/skills/my-skill/SKILL.md <<'EOF'
---
name: my-skill
description: 描述何时使用此 Skill
version: 1.0.0
---

# My Skill

Skill 的详细内容...
EOF

# 3. 测试
cp -r DMPM/skills/my-skill .claude/skills/
# 在 Claude Code 中测试

# 4. 分享到团队
./DMPM/scripts/share-to-team.sh
```

### 非技术人员

在团队群告诉我们你的需求：

```
我需要一个 XXX 的 Skill

使用场景：...
期望功能：...
```

技术团队会帮你创建！

---

## 📚 查看所有 Skills

### 命令行查看

```bash
# 列出所有 Skills
ls -1 .claude/skills/

# 查看 Skill 详情
cat .claude/skills/product-prototype/SKILL.md
```

### 在 Claude Code 中查看

```
你：有哪些可用的 Skills？

Claude：
当前可用的 Skills 包括：
1. product-prototype - 产品原型全流程
2. hk-ipo-analyzer - 港股 IPO 分析
...
```

---

## 🆘 常见问题

### Q: Skills 没有生效？

**A: 检查以下几点：**

1. Skills 是否在 `.claude/skills/` 目录？
   ```bash
   ls .claude/skills/
   ```

2. SKILL.md 文件是否存在？
   ```bash
   ls .claude/skills/*/SKILL.md
   ```

3. 重启 Claude Code

### Q: 如何知道 Skill 被激活了？

**A:** Claude 会在响应中提示，例如：

```
我将使用 product-prototype Skill...
```

或者检查对话内容是否遵循 Skill 定义的流程。

### Q: 可以同时使用多个 Skills 吗？

**A:** 可以！Claude 会根据需要智能选择和组合 Skills。

### Q: 如何更新已有的 Skill？

**A:**
```bash
# 修改文件
vim DMPM/skills/skill-name/SKILL.md

# 分享到团队
./DMPM/scripts/share-to-team.sh
```

---

## 🎓 进阶学习

准备好深入了解？查看：

- [Skills 使用指南](docs/SKILLS_GUIDE.md) - 详细的 Skills 文档
- [贡献指南](docs/CONTRIBUTING.md) - 如何贡献 Skills
- [README](README.md) - 完整的项目说明

---

## 📞 需要帮助？

- **技术问题**：联系 @xiangchenyu
- **使用问题**：在团队群询问
- **Bug 报告**：创建 GitHub Issue

---

**开始享受团队 Skills 带来的效率提升吧！** 🚀
