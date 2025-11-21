# DMPM 非技术人员使用指南

**只需要记住三个命令！** 🎯

---

## ⚙️ 首次使用：配置 Git 认证（只需一次）

第一次使用前，需要配置 Git 认证：

```bash
cd /Volumes/xcy/mininglamp
./DMPM/scripts/setup-git-auth.sh
```

**这个脚本会：**
- ✅ 自动配置团队共享的 GitHub 账号
- ✅ 设置你的名字（用于标识你的提交）
- ✅ 测试连接是否成功

**只需要运行一次**，之后就可以使用下面的命令了。

---

## 📥 命令 1：获取最新内容

当你想获取团队最新的 Skills 时：

```bash
./DMPM/scripts/update-local.sh
```

**这个命令会：**
- ✅ 自动下载团队最新的 Skills
- ✅ 更新你本地的文件
- ✅ 显示更新了什么内容

**什么时候用？**
- 每周一上班时
- 收到"团队更新"通知时
- 开始新项目前

---

## 📤 命令 2：上传你的文件

当你想分享你创建/修改的文件给团队时：

```bash
./DMPM/scripts/upload-file.sh <文件路径>
```

**示例：**

```bash
# 上传你创建的 Skill
./DMPM/scripts/upload-file.sh DMPM/skills/my-skill/SKILL.md

# 上传你修改的 PRD 模板
./DMPM/scripts/upload-file.sh DMPM/skills/product-prototype/references/prd-template.md
```

**这个命令会：**
- ✅ 自动上传你指定的文件
- ✅ 通知团队有新内容
- ✅ 无需访问 GitHub

**什么时候用？**
- 创建了新的 Skill
- 修改了模板文件
- 更新了文档

---

## 🎓 完整示例

### 场景 1：获取团队最新 Skills

```bash
# 早上打开电脑，先获取最新内容
./DMPM/scripts/update-local.sh

# 输出：
# 🔄 正在获取团队最新内容...
# ✅ 已更新 3 个 Skills
# - product-prototype (v1.2.0)
# - hk-ipo-analyzer (v2.0.0)
# - new-skill (新增)
```

---

### 场景 2：你创建了一个新的 PRD 模板

```bash
# 你在 DMPM/skills/product-prototype/references/ 下创建了新模板
# simple-prd-template.md

# 上传这个文件
./DMPM/scripts/upload-file.sh DMPM/skills/product-prototype/references/simple-prd-template.md

# 输出：
# 📤 正在上传文件...
# ✅ 上传成功！
#
# 团队成员运行更新命令后即可获得这个文件。
```

---

### 场景 3：你修改了现有文件

```bash
# 你修改了 product-prototype 的 SKILL.md

# 上传修改后的文件
./DMPM/scripts/upload-file.sh DMPM/skills/product-prototype/SKILL.md

# 输出：
# 📤 正在上传文件...
# ✅ 上传成功！
#
# 变更内容：
# - 优化了 PRD 模板结构
# - 添加了流程图说明
```

---

## 📝 常见问题

### Q1: 我需要懂 Git 吗？
**A:** 不需要！只要会运行这两个命令就够了。

### Q2: 会不会覆盖我本地的修改？
**A:** 不会。如果有冲突，脚本会提示你，并保留你的版本。

### Q3: 上传失败怎么办？
**A:** 找技术同事 @xiangchenyu 帮忙，或在团队群说一声。

### Q4: 我可以上传任何文件吗？
**A:** 只能上传 `DMPM/` 目录下的文件。其他文件请联系技术同事。

### Q5: 怎么知道团队有更新？
**A:**
- 飞书群会收到通知
- 或者每周一运行一次更新命令

---

## 🆘 需要帮助？

**遇到问题？**
1. 先看看屏幕上的错误提示
2. 截图发到团队群
3. 或直接找 @xiangchenyu

**想学更多？**
- 不需要！这两个命令就够用了 😊
- 如果真的感兴趣，可以看 [完整指南](docs/SKILLS_GUIDE.md)

---

## ⚡ 快捷方式（可选）

### 创建桌面快捷方式

**macOS：**
```bash
# 在桌面创建快捷方式
ln -s /Volumes/xcy/mininglamp/DMPM/scripts/update-local.sh ~/Desktop/更新团队Skills.command
ln -s /Volumes/xcy/mininglamp/DMPM/scripts/upload-file.sh ~/Desktop/上传文件.command
```

然后你就可以双击桌面图标运行命令了！

---

**就这么简单！** 🎉

记住：
- 📥 `update-local.sh` - 获取最新
- 📤 `upload-file.sh <文件>` - 上传文件
