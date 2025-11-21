#!/bin/bash
# DMPM 团队 Skills 同步工具
# 用途：从团队仓库同步最新的 Skills 到本地 Claude Code 配置

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 目录定义
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DMPM_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_DIR="$(dirname "$DMPM_DIR")"
CLAUDE_SKILLS_DIR="$PROJECT_DIR/.claude/skills"

cd "$PROJECT_DIR"

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🔄  DMPM 团队 Skills 同步工具${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# 检查是否是 Git 仓库
if [ ! -d ".git" ]; then
    echo -e "${RED}❌ 错误：当前目录不是 Git 仓库${NC}"
    echo ""
    echo "请先初始化 Git 仓库或克隆团队仓库"
    exit 1
fi

# 拉取最新代码
echo -e "${YELLOW}📥 拉取最新代码...${NC}"
echo ""

# 保存当前的 HEAD
OLD_HEAD=$(git rev-parse HEAD 2>/dev/null)

# 拉取代码
if git pull origin main 2>/dev/null || git pull origin master 2>/dev/null; then
    echo ""

    # 获取新的 HEAD
    NEW_HEAD=$(git rev-parse HEAD 2>/dev/null)

    # 检查是否有更新
    if [ "$OLD_HEAD" = "$NEW_HEAD" ]; then
        echo -e "${GREEN}✅ 已是最新版本，无需更新${NC}"
        UPDATE_AVAILABLE=0
    else
        echo -e "${GREEN}✅ 代码已更新${NC}"
        UPDATE_AVAILABLE=1

        # 显示更新的文件
        echo ""
        echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${BLUE}📝 更新的文件：${NC}"
        echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""
        git diff --name-status $OLD_HEAD $NEW_HEAD | grep "DMPM/" || echo -e "  ${YELLOW}(无 DMPM 相关更新)${NC}"
        echo ""
    fi
else
    echo ""
    echo -e "${YELLOW}⚠️  拉取失败或没有配置远程仓库${NC}"
    echo ""
    echo "如果是首次使用，请先配置："
    echo "  git remote add origin <仓库地址>"
    echo ""
    UPDATE_AVAILABLE=1  # 即使拉取失败也继续同步本地的 DMPM
fi

# 检查 DMPM/skills 目录
if [ ! -d "$DMPM_DIR/skills" ]; then
    echo -e "${YELLOW}⚠️  DMPM/skills 目录不存在${NC}"
    echo ""
    echo "DMPM 框架中还没有 Skills。"
    echo ""
    echo "提示："
    echo "  - 从 .claude/skills/ 复制现有 Skills 到 DMPM/skills/"
    echo "  - 或使用 skill-creator 创建新的 Skills"
    exit 0
fi

# 创建 .claude/skills 目录（如果不存在）
mkdir -p "$CLAUDE_SKILLS_DIR"

# 同步 Skills
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🔄 同步 Skills 到 Claude Code...${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

SYNC_COUNT=0
for skill_dir in "$DMPM_DIR/skills"/*; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        target_dir="$CLAUDE_SKILLS_DIR/$skill_name"

        # 检查是否需要同步
        NEED_SYNC=0
        if [ ! -d "$target_dir" ]; then
            NEED_SYNC=1
            echo -e "  ${GREEN}+ 新增${NC} $skill_name"
        elif ! diff -r "$skill_dir" "$target_dir" > /dev/null 2>&1; then
            NEED_SYNC=1
            echo -e "  ${YELLOW}↻ 更新${NC} $skill_name"
        fi

        if [ $NEED_SYNC -eq 1 ]; then
            cp -r "$skill_dir" "$target_dir"
            SYNC_COUNT=$((SYNC_COUNT + 1))
        fi
    fi
done

echo ""

if [ $SYNC_COUNT -eq 0 ]; then
    echo -e "${GREEN}✅ 所有 Skills 已是最新版本${NC}"
else
    echo -e "${GREEN}✅ 同步完成！共同步 $SYNC_COUNT 个 Skill(s)${NC}"
fi

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}📊 当前可用的 Skills：${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# 列出所有 Skills
for skill_dir in "$CLAUDE_SKILLS_DIR"/*; do
    if [ -d "$skill_dir" ] && [ -f "$skill_dir/SKILL.md" ]; then
        skill_name=$(basename "$skill_dir")

        # 提取 description
        description=$(grep "^description:" "$skill_dir/SKILL.md" 2>/dev/null | head -1 | cut -d':' -f2- | xargs)

        if [ -n "$description" ]; then
            echo -e "  ${GREEN}•${NC} ${BLUE}$skill_name${NC}"
            echo -e "    $description"
            echo ""
        else
            echo -e "  ${GREEN}•${NC} ${BLUE}$skill_name${NC}"
            echo ""
        fi
    fi
done

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${GREEN}✅ 同步完成！现在可以在 Claude Code 中使用这些 Skills${NC}"
echo ""
echo -e "${YELLOW}💡 提示：${NC}"
echo "  - Claude Code 会自动加载 .claude/skills/ 中的 Skills"
echo "  - 使用时只需自然对话，Skills 会自动激活"
echo "  - 查看详细说明：cat DMPM/docs/SKILLS_GUIDE.md"
echo ""
