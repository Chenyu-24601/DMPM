#!/bin/bash
# DMPM 非技术人员专用 - 更新本地文件
# 用途：从团队获取最新的 Skills 和文档

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
CLAUDE_SKILLS_DIR="$PROJECT_DIR/.claude/skills"

cd "$PROJECT_DIR"

clear
echo ""
echo -e "${BLUE}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}${BOLD}   📥  获取团队最新内容${NC}"
echo -e "${BLUE}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${YELLOW}正在从团队下载最新内容...${NC}"
echo ""

# 保存当前状态
OLD_HEAD=$(git rev-parse HEAD 2>/dev/null || echo "")

# 静默拉取
if git pull origin main >/dev/null 2>&1 || git pull origin master >/dev/null 2>&1; then
    NEW_HEAD=$(git rev-parse HEAD 2>/dev/null || echo "")

    if [ "$OLD_HEAD" = "$NEW_HEAD" ]; then
        echo -e "${GREEN}${BOLD}✅ 你已经是最新版本了！${NC}"
        echo ""
        echo "没有新的更新。"
        echo ""
        exit 0
    fi

    echo -e "${GREEN}${BOLD}✅ 下载完成！${NC}"
    echo ""

    # 显示更新了什么
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}📝 更新内容：${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    # 提取变更的文件
    CHANGED_FILES=$(git diff --name-status $OLD_HEAD $NEW_HEAD | grep "DMPM/" | head -10)

    if [ -n "$CHANGED_FILES" ]; then
        echo "$CHANGED_FILES" | while read status file; do
            case $status in
                A)
                    echo -e "  ${GREEN}+ 新增${NC} $(basename $(dirname $file))/$(basename $file)"
                    ;;
                M)
                    echo -e "  ${YELLOW}↻ 更新${NC} $(basename $(dirname $file))/$(basename $file)"
                    ;;
                D)
                    echo -e "  ${RED}- 删除${NC} $(basename $(dirname $file))/$(basename $file)"
                    ;;
            esac
        done
    else
        echo "  其他项目文件的更新"
    fi

    echo ""

else
    echo ""
    echo -e "${RED}${BOLD}❌ 下载失败${NC}"
    echo ""
    echo -e "${YELLOW}可能的原因：${NC}"
    echo "  1. 网络连接问题"
    echo "  2. 第一次使用（需要设置）"
    echo ""
    echo -e "${YELLOW}解决方案：${NC}"
    echo "  找技术同事 @xiangchenyu 帮忙设置一下"
    echo "  或在团队群询问"
    echo ""
    exit 1
fi

# 同步 Skills
if [ -d "$DMPM_DIR/skills" ]; then
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}🔄 正在同步 Skills...${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""

    mkdir -p "$CLAUDE_SKILLS_DIR"

    SYNC_COUNT=0
    for skill_dir in "$DMPM_DIR/skills"/*; do
        if [ -d "$skill_dir" ] && [ "$(basename "$skill_dir")" != "README.md" ]; then
            skill_name=$(basename "$skill_dir")
            target_dir="$CLAUDE_SKILLS_DIR/$skill_name"

            # 检查是否需要同步
            if [ ! -d "$target_dir" ]; then
                cp -r "$skill_dir" "$target_dir"
                echo -e "  ${GREEN}+ 新增${NC} $skill_name"
                SYNC_COUNT=$((SYNC_COUNT + 1))
            elif ! diff -r "$skill_dir" "$target_dir" > /dev/null 2>&1; then
                cp -r "$skill_dir" "$target_dir"
                echo -e "  ${YELLOW}↻ 更新${NC} $skill_name"
                SYNC_COUNT=$((SYNC_COUNT + 1))
            fi
        fi
    done

    echo ""

    if [ $SYNC_COUNT -eq 0 ]; then
        echo -e "${GREEN}所有 Skills 都是最新的${NC}"
    else
        echo -e "${GREEN}${BOLD}✅ 已同步 $SYNC_COUNT 个 Skill(s)${NC}"
    fi

    echo ""
fi

# 完成
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}${BOLD}✅ 全部完成！${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "现在你可以在 Claude Code 中使用最新的 Skills 了。"
echo ""
echo -e "${YELLOW}💡 提示：${NC}"
echo "  - 建议每周一运行一次这个命令"
echo "  - 收到更新通知时也要运行"
echo ""
