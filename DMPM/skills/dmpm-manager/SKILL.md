---
name: dmpm-manager
description: 当用户需要更新团队 Skills、上传文件到团队、同步 DMPM 内容时使用此技能
version: 1.0.0
---

# DMPM 管理助手

帮助用户更新和分享团队 Skills。

## 功能

### 1. 更新本地内容（获取团队最新 Skills）

**触发词：**
- "更新团队 Skills"
- "获取最新内容"
- "同步团队文件"
- "dmpm 更新"

**操作流程：**

```markdown
用户说："更新团队 Skills"

回复：
好的！我来帮你获取团队最新的 Skills 和文档。

即将运行更新命令，这会：
- ✅ 自动下载团队最新的 Skills
- ✅ 更新你本地的文件
- ✅ 显示更新了什么内容

运行以下命令：
```

然后执行：

```bash
cd /Volumes/xcy/mininglamp && ./DMPM/scripts/update-local.sh
```

**执行后解读输出：**
- 如果成功，告诉用户更新了哪些 Skills
- 如果失败，根据错误提示给出解决方案
- 提醒用户可以在 Claude Code 中使用最新的 Skills

---

### 2. 上传文件到团队

**触发词：**
- "上传文件"
- "分享文件给团队"
- "提交文件"
- "dmpm 上传"

**操作流程：**

#### Step 1: 询问文件路径

```markdown
好的！我来帮你上传文件到团队。

请告诉我你要上传的文件路径。

**示例：**
- DMPM/skills/my-skill/SKILL.md
- DMPM/skills/product-prototype/references/new-template.md

**提示：**
- 文件必须在 DMPM/ 目录下
- 可以直接说文件名，我帮你找
```

#### Step 2: 验证文件

用户提供文件路径后：

1. **如果用户只说了文件名**（如 "SKILL.md"）：
   - 使用 Glob 搜索：`DMPM/**/文件名`
   - 如果找到多个，列出让用户选择
   - 如果找到一个，确认是否正确

2. **如果用户提供了完整路径**：
   - 使用 Read 工具验证文件存在
   - 显示文件路径和大小

3. **检查文件是否在 DMPM/ 目录下**：
   - 路径必须以 `DMPM/` 开头或包含 `/DMPM/`

#### Step 3: 确认并上传

```markdown
找到文件：
  路径：DMPM/skills/my-skill/SKILL.md
  大小：[文件大小]

确认上传这个文件吗？

回复 "确认" 或 "是" 来上传。
```

用户确认后，执行：

```bash
cd /Volumes/xcy/mininglamp && ./DMPM/scripts/upload-file.sh DMPM/skills/my-skill/SKILL.md
```

#### Step 4: 解读结果

- **成功**：
  ```
  ✅ 上传成功！

  你的文件已分享给团队：
  DMPM/skills/my-skill/SKILL.md

  团队成员运行更新命令后即可获得。

  💡 建议在团队群通知大家。
  ```

- **失败**：
  ```
  ❌ 上传失败

  [根据错误信息给出具体建议]

  常见解决方案：
  1. 先运行更新命令同步最新内容
  2. 检查网络连接
  3. 联系 @xiangchenyu 寻求帮助
  ```

---

### 3. 列出可上传的文件

**触发词：**
- "有哪些文件可以上传"
- "显示 DMPM 文件"
- "我能上传什么"

**操作：**

使用 Glob 列出 DMPM 目录下的主要文件：

```bash
# 列出 Skills
DMPM/skills/*/SKILL.md

# 列出文档
DMPM/docs/*.md

# 列出参考文件
DMPM/skills/*/references/*.md
```

展示给用户：

```markdown
DMPM 目录下的主要文件：

📁 Skills:
- DMPM/skills/product-prototype/SKILL.md
- DMPM/skills/hk-ipo-analyzer/SKILL.md
- ...

📚 文档:
- DMPM/docs/SKILLS_GUIDE.md
- DMPM/docs/CONTRIBUTING.md
- ...

📄 参考文件:
- DMPM/skills/product-prototype/references/prd-template.md
- ...

你可以上传这些文件中的任何一个。
```

---

## 工作原则

### 安全检查

1. **文件路径验证**
   - 必须在 `/Volumes/xcy/mininglamp/DMPM/` 下
   - 不允许上传系统文件或敏感文件

2. **用户确认**
   - 上传前必须确认
   - 显示文件路径和大小

3. **错误处理**
   - 提供清晰的错误信息
   - 给出解决方案
   - 告诉用户找谁帮忙

### 用户体验

1. **友好的语言**
   - 使用简单易懂的描述
   - 避免技术术语
   - 多用 emoji 提升可读性

2. **清晰的步骤**
   - 分步骤引导
   - 明确下一步操作
   - 及时反馈结果

3. **智能辅助**
   - 模糊文件名自动搜索
   - 多个匹配让用户选择
   - 提供使用建议

---

## 示例对话

### 示例 1：更新内容

```
用户：更新团队 Skills

助手：
好的！我来帮你获取团队最新的 Skills。

即将运行更新命令...

[执行 update-local.sh]

✅ 更新完成！

更新内容：
- product-prototype (v1.3.0) - 优化了 PRD 模板
- new-competitor-skill (新增) - 竞品分析 Skill

现在你可以在 Claude Code 中使用这些最新的 Skills 了。

💡 提示：如果要创建产品原型，直接说 "帮我创建产品原型" 即可。
```

---

### 示例 2：上传文件（提供完整路径）

```
用户：上传文件到团队

助手：
好的！请告诉我文件路径。

示例：DMPM/skills/my-skill/SKILL.md

---

用户：DMPM/skills/competitor-analysis/SKILL.md

助手：
找到文件：
  路径：DMPM/skills/competitor-analysis/SKILL.md
  大小：15 KB

这是一个竞品分析 Skill 文件。

确认上传吗？回复 "是" 或 "确认"。

---

用户：确认

助手：
正在上传...

[执行 upload-file.sh]

✅ 上传成功！

你的竞品分析 Skill 已分享给团队。

团队成员运行以下命令即可获得：
  /dmpm-update

或者说："更新团队 Skills"

💡 建议在团队群通知：
"我上传了竞品分析 Skill，大家记得更新一下"
```

---

### 示例 3：上传文件（只说文件名）

```
用户：上传 template.md

助手：
让我搜索一下 "template.md" 文件...

找到 3 个匹配的文件：
1. DMPM/skills/product-prototype/references/prd-template.md
2. DMPM/skills/design-spec/references/design-template.md
3. DMPM/docs/template-guide.md

请告诉我你要上传哪一个？（回复序号或完整路径）

---

用户：1

助手：
好的，你选择了：
  DMPM/skills/product-prototype/references/prd-template.md

这是 PRD 模板文件，大小 8 KB。

确认上传吗？

---

用户：是

助手：
[执行上传流程...]
```

---

## 重要提醒

### 对于用户

1. **定期更新**
   - 建议每周一运行一次更新
   - 收到通知时及时更新

2. **上传后通知**
   - 上传文件后在团队群说一声
   - 让大家知道有新内容

3. **遇到问题**
   - 不要慌张
   - 截图发到团队群
   - 联系 @xiangchenyu

### 对于 Claude

1. **始终使用 Bash 工具执行脚本**
   - 不要只显示命令
   - 必须实际执行
   - 解读执行结果

2. **安全第一**
   - 验证文件路径
   - 需要用户确认
   - 清晰的错误提示

3. **用户友好**
   - 简单的语言
   - 清晰的步骤
   - 及时的反馈
