#!/bin/bash
# DMPM 非技术人员专用 - 上传文件到团队
# 用途：分享你创建/修改的文件给团队

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# 项目根目录
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DMPM_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_DIR="$(dirname "$DMPM_DIR")"

cd "$PROJECT_DIR"

clear
echo ""
echo -e "${BLUE}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}${BOLD}   📤  上传文件到团队${NC}"
echo -e "${BLUE}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# 检查参数
if [ $# -eq 0 ]; then
    echo -e "${RED}${BOLD}❌ 错误：缺少文件路径${NC}"
    echo ""
    echo -e "${YELLOW}使用方法：${NC}"
    echo "  ./DMPM/scripts/upload-file.sh <文件路径>"
    echo ""
    echo -e "${YELLOW}示例：${NC}"
    echo "  ./DMPM/scripts/upload-file.sh DMPM/skills/my-skill/SKILL.md"
    echo "  ./DMPM/scripts/upload-file.sh DMPM/skills/product-prototype/references/template.md"
    echo ""
    echo -e "${YELLOW}💡 提示：${NC}"
    echo "  - 文件必须在 DMPM/ 目录下"
    echo "  - 可以拖拽文件到终端自动填充路径"
    echo ""
    exit 1
fi

FILE_PATH="$1"

# 标准化路径
if [[ "$FILE_PATH" != /* ]]; then
    FILE_PATH="$PROJECT_DIR/$FILE_PATH"
fi

# 检查文件是否存在
if [ ! -f "$FILE_PATH" ]; then
    echo -e "${RED}${BOLD}❌ 错误：文件不存在${NC}"
    echo ""
    echo "找不到文件：$FILE_PATH"
    echo ""
    echo -e "${YELLOW}💡 提示：${NC}"
    echo "  - 检查文件路径是否正确"
    echo "  - 确保文件在 DMPM/ 目录下"
    echo ""
    exit 1
fi

# 检查文件是否在 DMPM 目录下
RELATIVE_PATH="${FILE_PATH#$PROJECT_DIR/}"
if [[ "$RELATIVE_PATH" != DMPM/* ]]; then
    echo -e "${RED}${BOLD}❌ 错误：只能上传 DMPM 目录下的文件${NC}"
    echo ""
    echo "你的文件：$RELATIVE_PATH"
    echo "必须在：DMPM/ 目录下"
    echo ""
    echo -e "${YELLOW}💡 提示：${NC}"
    echo "  - 先将文件移动到 DMPM/ 目录"
    echo "  - 或联系技术同事帮忙"
    echo ""
    exit 1
fi

# 检查 Git 仓库
if [ ! -d ".git" ]; then
    echo -e "${RED}${BOLD}❌ 错误：还没有设置 Git${NC}"
    echo ""
    echo "请找技术同事 @xiangchenyu 帮忙设置一下。"
    echo ""
    exit 1
fi

# 显示文件信息
echo -e "${YELLOW}📄 准备上传的文件：${NC}"
echo ""
echo "  $RELATIVE_PATH"
echo ""

# 检查文件大小（警告大文件）
FILE_SIZE=$(du -h "$FILE_PATH" | cut -f1)
echo "  文件大小：$FILE_SIZE"
echo ""

# 确认上传
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
read -p "$(echo -e ${YELLOW}确认上传这个文件吗？\(y/N\)${NC} )" -n 1 -r
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${RED}❌ 已取消上传${NC}"
    exit 0
fi

# 获取用户信息
AUTHOR=$(git config user.name 2>/dev/null || whoami)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M')

# 生成提交信息
FILENAME=$(basename "$FILE_PATH")
SKILL_NAME=$(basename $(dirname $(dirname "$FILE_PATH")))

COMMIT_MSG="docs: update $FILENAME

Updated by: $AUTHOR
Time: $TIMESTAMP
File: $RELATIVE_PATH"

echo -e "${YELLOW}📝 准备上传...${NC}"
echo ""

# 添加文件
git add "$FILE_PATH"

# 检查是否有变更
if git diff --cached --quiet; then
    echo -e "${YELLOW}⚠️  文件没有变化${NC}"
    echo ""
    echo "这个文件和团队版本一样，不需要上传。"
    echo ""
    exit 0
fi

# 提交
echo -e "${YELLOW}💾 创建记录...${NC}"
git commit -m "$COMMIT_MSG" >/dev/null 2>&1

# 推送
echo -e "${YELLOW}📤 正在上传...${NC}"
echo ""

if git push origin main 2>/dev/null || git push origin master 2>/dev/null; then
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}${BOLD}✅ 上传成功！${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "你上传的文件："
    echo "  $RELATIVE_PATH"
    echo ""
    echo -e "${GREEN}团队成员运行以下命令即可获得：${NC}"
    echo "  ./DMPM/scripts/update-local.sh"
    echo ""
    echo -e "${YELLOW}💡 建议：${NC}"
    echo "  在团队群通知大家你上传了新内容"
    echo ""
else
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${RED}${BOLD}❌ 上传失败${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${YELLOW}可能的原因：${NC}"
    echo "  1. 网络问题"
    echo "  2. 权限不足"
    echo "  3. 团队有新的更新，需要先同步"
    echo ""
    echo -e "${YELLOW}解决方案：${NC}"
    echo ""
    echo "  # 先运行更新命令"
    echo "  ./DMPM/scripts/update-local.sh"
    echo ""
    echo "  # 然后重新上传"
    echo "  ./DMPM/scripts/upload-file.sh $RELATIVE_PATH"
    echo ""
    echo "  # 如果还是失败，找技术同事帮忙"
    echo "  联系：@xiangchenyu 或在团队群询问"
    echo ""
    exit 1
fi
