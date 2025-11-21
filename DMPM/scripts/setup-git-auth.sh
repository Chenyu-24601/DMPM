#!/bin/bash
# DMPM Git 认证配置脚本
# 用途：为团队成员配置共享的 Git 认证（只需运行一次）

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 项目根目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DMPM_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_DIR="$(dirname "$DMPM_DIR")"

cd "$PROJECT_DIR"

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🔐  DMPM Git 认证配置${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# 共享的团队配置
# 注意：Token 需要团队管理员提供，不要硬编码在脚本中
TEAM_GITHUB_USER="your-team-account"
TEAM_REPO_URL="https://github.com/your-team-account/DMPM.git"

# 检查是否提供了 Token
if [ -z "$DMPM_GITHUB_TOKEN" ]; then
    echo -e "${YELLOW}⚠️  未检测到 GitHub Token${NC}"
    echo ""
    echo "请联系团队管理员获取 GitHub Token，然后重新运行："
    echo ""
    echo "  export DMPM_GITHUB_TOKEN='your-token-here'"
    echo "  ./DMPM/scripts/setup-git-auth.sh"
    echo ""
    echo "或者直接在命令中指定："
    echo ""
    echo "  DMPM_GITHUB_TOKEN='your-token-here' ./DMPM/scripts/setup-git-auth.sh"
    echo ""
    exit 1
fi

TEAM_GITHUB_TOKEN="$DMPM_GITHUB_TOKEN"

# 检查是否已经是 Git 仓库
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}📦 初始化 Git 仓库...${NC}"
    git init
    git branch -M main
    echo -e "${GREEN}✅ Git 仓库初始化完成${NC}"
    echo ""
fi

# 配置远程仓库（带 token）
echo -e "${YELLOW}🔗 配置远程仓库...${NC}"
REMOTE_URL_WITH_TOKEN="https://${TEAM_GITHUB_TOKEN}@github.com/${TEAM_GITHUB_USER}/DMPM.git"

# 检查是否已有 origin
if git remote get-url origin &>/dev/null; then
    git remote set-url origin "$REMOTE_URL_WITH_TOKEN"
    echo -e "${GREEN}✅ 更新远程仓库地址${NC}"
else
    git remote add origin "$REMOTE_URL_WITH_TOKEN"
    echo -e "${GREEN}✅ 添加远程仓库${NC}"
fi
echo ""

# 配置 Git 用户信息（用于提交记录）
echo -e "${YELLOW}👤 配置 Git 用户信息...${NC}"
echo ""
read -p "请输入你的名字（用于标识提交者）: " USER_NAME
echo ""

if [ -z "$USER_NAME" ]; then
    USER_NAME=$(whoami)
    echo -e "${YELLOW}使用默认用户名: $USER_NAME${NC}"
fi

git config user.name "$USER_NAME"
git config user.email "${USER_NAME}@mininglamp.local"

echo -e "${GREEN}✅ 用户信息配置完成${NC}"
echo "   姓名: $USER_NAME"
echo "   邮箱: ${USER_NAME}@mininglamp.local"
echo ""

# 测试连接
echo -e "${YELLOW}🧪 测试 Git 连接...${NC}"
if git ls-remote origin &>/dev/null; then
    echo -e "${GREEN}✅ 连接成功！${NC}"
    echo ""
else
    echo -e "${RED}❌ 连接失败${NC}"
    echo ""
    echo -e "${YELLOW}可能的原因：${NC}"
    echo "  1. 网络问题"
    echo "  2. Token 已过期"
    echo "  3. 仓库地址错误"
    echo ""
    exit 1
fi

# 拉取最新内容
echo -e "${YELLOW}📥 拉取最新内容...${NC}"
if git pull origin main --rebase 2>/dev/null || git pull origin main --allow-unrelated-histories 2>/dev/null; then
    echo -e "${GREEN}✅ 拉取成功${NC}"
    echo ""
else
    echo -e "${YELLOW}⚠️  首次设置，跳过拉取${NC}"
    echo ""
fi

# 显示配置信息
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ Git 认证配置完成！${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${GREEN}现在你可以：${NC}"
echo ""
echo "  📥 获取团队最新内容："
echo "     ./DMPM/scripts/update-local.sh"
echo ""
echo "  📤 上传文件到团队："
echo "     ./DMPM/scripts/upload-file.sh <文件路径>"
echo ""
echo "  📤 分享你的变更："
echo "     ./DMPM/scripts/share-to-team.sh"
echo ""
echo -e "${YELLOW}💡 提示：${NC}"
echo "   - 提交记录会显示你的名字: $USER_NAME"
echo "   - Token 已配置，无需每次输入密码"
echo "   - 如需帮助，联系 @xiangchenyu"
echo ""
