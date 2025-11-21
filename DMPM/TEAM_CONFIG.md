# DMPM 团队配置说明

本文档说明如何配置团队共享的 Git 认证信息。

## 📋 配置信息

在创建团队 GitHub 仓库后，需要更新以下配置：

### 1. 更新 setup-git-auth.sh

编辑文件：`DMPM/scripts/setup-git-auth.sh`

找到并修改以下行：

```bash
TEAM_GITHUB_USER="your-team-account"        # 改为你的团队 GitHub 账号
TEAM_REPO_URL="https://github.com/your-team-account/DMPM.git"  # 改为实际仓库地址
```

### 2. 团队成员使用方式

**方式 A：通过环境变量（推荐）**

团队成员首次配置时：

```bash
# 设置 Token 环境变量
export DMPM_GITHUB_TOKEN='团队管理员提供的 Token'

# 运行配置脚本
cd /Volumes/xcy/mininglamp
./DMPM/scripts/setup-git-auth.sh
```

**方式 B：一次性命令**

```bash
DMPM_GITHUB_TOKEN='团队管理员提供的 Token' ./DMPM/scripts/setup-git-auth.sh
```

**方式 C：添加到 shell 配置文件（长期使用）**

将以下行添加到 `~/.zshrc` 或 `~/.bashrc`：

```bash
export DMPM_GITHUB_TOKEN='团队管理员提供的 Token'
```

然后重新加载：

```bash
source ~/.zshrc  # 或 source ~/.bashrc
```

## 🔐 Token 管理

### 创建 Token

1. 登录团队 GitHub 账号
2. 访问：https://github.com/settings/tokens/new
3. 设置：
   - **Note**: `DMPM Team Token`
   - **Expiration**: 选择有效期（建议 1 年）
   - **权限**: 勾选 `repo` （完整仓库权限）
4. 生成后复制 Token

### Token 安全

⚠️ **重要安全提示**：

- Token 等同于密码，不要泄露给团队外人员
- 不要将 Token 提交到 Git 仓库中
- 定期更换 Token（建议每 3-6 个月）
- Token 过期前提前通知团队成员更新

### Token 分发

**建议方式**：

1. 管理员创建 Token 后
2. 通过团队内部安全渠道（如企业微信、钉钉）私信发送
3. 告知成员有效期
4. 成员使用后删除聊天记录中的 Token

**不要**：
- ❌ 不要在群聊中发送 Token
- ❌ 不要通过邮件发送 Token
- ❌ 不要在文档中记录 Token

## 📝 配置检查清单

创建团队仓库后，完成以下步骤：

- [ ] 创建团队 GitHub 账号（如果还没有）
- [ ] 创建 DMPM 仓库
- [ ] 生成 Personal Access Token
- [ ] 更新 `DMPM/scripts/setup-git-auth.sh` 中的账号和仓库地址
- [ ] 提交并推送更新
- [ ] 将 Token 安全地分发给团队成员
- [ ] 测试团队成员是否能成功配置和推送

## 🆘 常见问题

### Q: Token 泄露了怎么办？

A: 立即执行以下步骤：
1. 在 GitHub 撤销当前 Token
2. 生成新的 Token
3. 通知所有团队成员更新
4. 团队成员重新运行配置脚本

### Q: Token 过期了怎么办？

A:
1. 管理员生成新 Token
2. 安全地发送给团队成员
3. 成员重新运行配置脚本即可

### Q: 如何查看当前配置的仓库地址？

A:
```bash
cd /Volumes/xcy/mininglamp
git remote -v
```

---

**配置完成后，可以删除此文档，或将其移动到团队内部知识库。**
