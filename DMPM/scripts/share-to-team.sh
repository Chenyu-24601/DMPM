#!/bin/bash
# DMPM 团队 Skills 一键分享工具
# 用途：快速分享你创建/修改的 Skills 到团队

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
echo -e "${BLUE}📤  DMPM 团队 Skills 分享工具${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# 检查是否是 Git 仓库
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ 错误：当前目录不是 Git 仓库${NC}"
    echo ""
    echo "请先初始化 Git 仓库："
    echo "  git init"
    echo "  git add ."
    echo '  git commit -m "Initial commit"'
    exit 1
fi

# 检查是否有变更
echo -e "${YELLOW}🔍 检查 DMPM 变更...${NC}"
echo ""

HAS_CHANGES=0
if ! git diff --quiet DMPM/ 2>/dev/null; then
    HAS_CHANGES=1
fi
if ! git diff --cached --quiet DMPM/ 2>/dev/null; then
    HAS_CHANGES=1
fi

if [ $HAS_CHANGES -eq 0 ]; then
    echo -e "${GREEN}✅ 没有 DMPM 变更需要分享${NC}"
    echo ""
    echo "提示："
    echo "  - 修改 DMPM/skills/ 中的文件"
    echo "  - 然后重新运行此脚本"
    exit 0
fi

# 显示变更文件
echo -e "${GREEN}📝 检测到以下变更：${NC}"
echo ""
git status --short DMPM/
echo ""

# 提取变更的 Skills
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}📋 变更的 Skills：${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

CHANGED_SKILLS=$(git status --short DMPM/skills/ 2>/dev/null | awk '{print $2}' | grep "DMPM/skills/" | cut -d'/' -f3 | sort -u)

if [ -n "$CHANGED_SKILLS" ]; then
    for skill in $CHANGED_SKILLS; do
        echo -e "  ${GREEN}•${NC} $skill"
    done
else
    echo -e "  ${YELLOW}• 其他 DMPM 文件${NC}"
fi
echo ""

# 确认分享
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
read -p "$(echo -e ${YELLOW}🤔 确认分享这些变更到团队吗？\(y/N\)${NC} )" -n 1 -r
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}❌ 已取消分享${NC}"
    exit 0
fi

# 生成提交信息
TIMESTAMP=$(date '+%Y-%m-%d %H:%M')
AUTHOR=$(git config user.name 2>/dev/null || whoami)

# 构建提交信息
COMMIT_MSG="feat(dmpm): update team skills

Updated by: $AUTHOR
Time: $TIMESTAMP"

if [ -n "$CHANGED_SKILLS" ]; then
    COMMIT_MSG="$COMMIT_MSG

Changed Skills:"
    for skill in $CHANGED_SKILLS; do
        COMMIT_MSG="$COMMIT_MSG
- $skill"
    done
fi

echo -e "${BLUE}📝 提交信息：${NC}"
echo ""
echo "$COMMIT_MSG"
echo ""

# 添加变更
echo -e "${YELLOW}📦 添加变更...${NC}"
git add DMPM/

# 提交
echo -e "${YELLOW}💾 创建提交...${NC}"
git commit -m "$COMMIT_MSG"

echo ""

# 推送
echo -e "${YELLOW}📤 推送到远程仓库...${NC}"
if git push origin main 2>/dev/null || git push origin master 2>/dev/null; then
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}✅ 分享成功！${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${GREEN}团队成员可以通过以下方式获取：${NC}"
    echo ""
    echo "  1. git pull"
    echo "  2. 运行 ./DMPM/scripts/sync-from-team.sh"
    echo ""
    echo -e "${YELLOW}💡 提示：建议在团队群通知大家更新${NC}"
    echo ""
else
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${RED}❌ 推送失败${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${YELLOW}可能的原因：${NC}"
    echo "  1. 网络问题"
    echo "  2. 权限不足（需要配置 Git 凭证）"
    echo "  3. 远程仓库有更新，需要先 pull"
    echo ""
    echo -e "${YELLOW}建议的解决方案：${NC}"
    echo ""
    echo "  # 如果远程有更新"
    echo "  git pull --rebase"
    echo "  然后重新运行此脚本"
    echo ""
    echo "  # 如果是首次推送"
    echo "  git remote add origin <仓库地址>"
    echo "  git push -u origin main"
    echo ""
    exit 1
fi
