#!/bin/bash

# Cursor IDE 安装脚本 for Ubuntu
# 此脚本避免使用libfuse2，改为提取AppImage方式运行

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================"
echo -e "    Cursor IDE 安装脚本"
echo -e "    适用于 Ubuntu 系统"
echo -e "================================${NC}"

# 检查是否为root用户
if [ "$EUID" -eq 0 ]; then
    echo -e "${RED}请不要使用root用户运行此脚本！${NC}"
    exit 1
fi

# 创建必要的目录
echo -e "${BLUE}创建必要的目录...${NC}"
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/icons
mkdir -p ~/Applications

# 下载Cursor AppImage
echo -e "${BLUE}下载 Cursor AppImage...${NC}"
CURSOR_URL="https://download.cursor.sh/linux/appImage/x64"
DOWNLOAD_PATH="$HOME/Applications/cursor.AppImage"

# 使用wget下载，如果失败则使用curl
if command -v wget &> /dev/null; then
    wget -O "$DOWNLOAD_PATH" "$CURSOR_URL" || {
        echo -e "${RED}wget下载失败，尝试使用curl...${NC}"
        curl -L -o "$DOWNLOAD_PATH" "$CURSOR_URL"
    }
elif command -v curl &> /dev/null; then
    curl -L -o "$DOWNLOAD_PATH" "$CURSOR_URL"
else
    echo -e "${RED}错误：需要安装wget或curl来下载文件${NC}"
    echo -e "${YELLOW}请运行: sudo apt update && sudo apt install wget${NC}"
    exit 1
fi

# 检查下载是否成功
if [ ! -f "$DOWNLOAD_PATH" ]; then
    echo -e "${RED}下载失败！${NC}"
    exit 1
fi

echo -e "${GREEN}下载完成: $DOWNLOAD_PATH${NC}"

# 使文件可执行
chmod +x "$DOWNLOAD_PATH"

# 提取AppImage内容（避免使用FUSE）
echo -e "${BLUE}提取 AppImage 内容...${NC}"
EXTRACT_DIR="$HOME/Applications/cursor-extracted"

# 如果提取目录已存在，先删除
if [ -d "$EXTRACT_DIR" ]; then
    rm -rf "$EXTRACT_DIR"
fi

# 提取AppImage
cd "$HOME/Applications"
"$DOWNLOAD_PATH" --appimage-extract > /dev/null 2>&1 || {
    echo -e "${YELLOW}直接提取失败，尝试其他方法...${NC}"
    
    # 检查是否安装了libfuse2t64 (Ubuntu 24.04+的新版本)
    if ! dpkg -l | grep -q libfuse2t64; then
        echo -e "${BLUE}安装 libfuse2t64...${NC}"
        sudo apt update
        sudo apt install -y libfuse2t64
    fi
    
    # 再次尝试提取
    "$DOWNLOAD_PATH" --appimage-extract > /dev/null 2>&1
}

# 重命名提取的目录
if [ -d "squashfs-root" ]; then
    mv squashfs-root "$EXTRACT_DIR"
else
    echo -e "${RED}提取失败！${NC}"
    exit 1
fi

echo -e "${GREEN}提取完成！${NC}"

# 下载Cursor图标
echo -e "${BLUE}下载 Cursor 图标...${NC}"
ICON_URL="https://us1.discourse-cdn.com/flex020/uploads/cursor1/original/2X/a/a4f78589d63edd61a2843306f8e11bad9590f0ca.png"
ICON_PATH="$HOME/.local/share/icons/cursor.png"

if command -v wget &> /dev/null; then
    wget -O "$ICON_PATH" "$ICON_URL" 2>/dev/null || curl -L -o "$ICON_PATH" "$ICON_URL" 2>/dev/null
elif command -v curl &> /dev/null; then
    curl -L -o "$ICON_PATH" "$ICON_URL" 2>/dev/null
fi

# 创建启动脚本
echo -e "${BLUE}创建启动脚本...${NC}"
LAUNCHER_SCRIPT="$HOME/.local/bin/cursor"

cat > "$LAUNCHER_SCRIPT" << EOF
#!/bin/bash
# Cursor启动脚本

cd "$EXTRACT_DIR"
./AppRun --no-sandbox "\$@" > /dev/null 2>&1 &
disown
EOF

chmod +x "$LAUNCHER_SCRIPT"

# 创建桌面条目
echo -e "${BLUE}创建桌面条目...${NC}"
DESKTOP_ENTRY="$HOME/.local/share/applications/cursor.desktop"

cat > "$DESKTOP_ENTRY" << EOF
[Desktop Entry]
Type=Application
Name=Cursor AI IDE
GenericName=Code Editor
Comment=AI-powered code editor for developers
Exec=$LAUNCHER_SCRIPT %F
Icon=$ICON_PATH
Terminal=false
Categories=Development;IDE;TextEditor;
MimeType=text/plain;inode/directory;
Keywords=cursor;code;editor;ai;development;programming;
StartupWMClass=Cursor
EOF

chmod +x "$DESKTOP_ENTRY"

# 更新桌面数据库
if command -v update-desktop-database &> /dev/null; then
    update-desktop-database ~/.local/share/applications 2>/dev/null
fi

# 添加到PATH（如果尚未添加）
echo -e "${BLUE}配置命令行访问...${NC}"
SHELL_RC=""
if [ -n "$ZSH_VERSION" ]; then
    SHELL_RC="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_RC="$HOME/.bashrc"
else
    SHELL_RC="$HOME/.bashrc"  # 默认使用.bashrc
fi

# 检查PATH是否已包含~/.local/bin
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
    echo -e "${YELLOW}已添加 ~/.local/bin 到 PATH，请重新启动终端或运行: source $SHELL_RC${NC}"
fi

# 创建快速更新脚本
echo -e "${BLUE}创建更新脚本...${NC}"
UPDATE_SCRIPT="$HOME/.local/bin/cursor-update"

cat > "$UPDATE_SCRIPT" << EOF
#!/bin/bash
# Cursor更新脚本

echo "正在更新 Cursor..."

# 下载最新版本
CURSOR_URL="https://download.cursor.sh/linux/appImage/x64"
DOWNLOAD_PATH="$HOME/Applications/cursor.AppImage"
EXTRACT_DIR="$HOME/Applications/cursor-extracted"

# 备份当前版本
if [ -f "\$DOWNLOAD_PATH" ]; then
    mv "\$DOWNLOAD_PATH" "\$DOWNLOAD_PATH.backup"
fi

# 下载新版本
if command -v wget &> /dev/null; then
    wget -O "\$DOWNLOAD_PATH" "\$CURSOR_URL"
elif command -v curl &> /dev/null; then
    curl -L -o "\$DOWNLOAD_PATH" "\$CURSOR_URL"
fi

chmod +x "\$DOWNLOAD_PATH"

# 删除旧的提取目录
rm -rf "\$EXTRACT_DIR"

# 提取新版本
cd "$HOME/Applications"
"\$DOWNLOAD_PATH" --appimage-extract > /dev/null 2>&1
mv squashfs-root "\$EXTRACT_DIR"

echo "Cursor 更新完成！"
EOF

chmod +x "$UPDATE_SCRIPT"

echo -e "${GREEN}================================"
echo -e "    安装完成！"
echo -e "================================${NC}"
echo -e "${GREEN}✓ Cursor 已安装到: $EXTRACT_DIR${NC}"
echo -e "${GREEN}✓ 桌面启动器已创建${NC}"
echo -e "${GREEN}✓ 命令行工具已设置${NC}"
echo ""
echo -e "${BLUE}使用方法:${NC}"
echo -e "  • 从应用程序菜单启动"
echo -e "  • 命令行运行: ${YELLOW}cursor${NC}"
echo -e "  • 在项目目录运行: ${YELLOW}cursor .${NC}"
echo -e "  • 更新版本: ${YELLOW}cursor-update${NC}"
echo ""
echo -e "${YELLOW}注意: 如果命令行无法使用cursor命令，请重新启动终端或运行:${NC}"
echo -e "${YELLOW}source $SHELL_RC${NC}"