# Ubuntu 安装 Cursor IDE 完整指南

Cursor 是一款强大的AI驱动代码编辑器，本指南将教您如何在Ubuntu系统上安全地安装Cursor。

## 方法一：使用安装脚本（推荐）

### 1. 下载并运行安装脚本

```bash
# 下载安装脚本
wget https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/install_cursor.sh

# 或者使用 curl
curl -O https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/install_cursor.sh

# 添加执行权限
chmod +x install_cursor.sh

# 运行安装脚本
./install_cursor.sh
```

### 2. 安装脚本功能

- ✅ 自动下载最新版本的Cursor
- ✅ 避免使用可能导致系统问题的libfuse2
- ✅ 创建桌面启动器
- ✅ 配置命令行访问
- ✅ 包含自动更新功能

## 方法二：手动安装

### 1. 下载 Cursor AppImage

```bash
# 创建应用程序目录
mkdir -p ~/Applications

# 下载最新版本的Cursor
wget -O ~/Applications/cursor.AppImage "https://download.cursor.sh/linux/appImage/x64"

# 或者使用curl
curl -L -o ~/Applications/cursor.AppImage "https://download.cursor.sh/linux/appImage/x64"

# 使文件可执行
chmod +x ~/Applications/cursor.AppImage
```

### 2. 处理依赖（如果需要）

**Ubuntu 24.04+ 用户：**
```bash
# 安装新版本的libfuse（更安全）
sudo apt update
sudo apt install libfuse2t64
```

**Ubuntu 22.04 及更早版本：**
```bash
# 安装传统libfuse2
sudo apt update
sudo apt install libfuse2
```

### 3. 创建启动器

#### 下载图标
```bash
# 创建图标目录
mkdir -p ~/.local/share/icons

# 下载Cursor图标
wget -O ~/.local/share/icons/cursor.png "https://us1.discourse-cdn.com/flex020/uploads/cursor1/original/2X/a/a4f78589d63edd61a2843306f8e11bad9590f0ca.png"
```

#### 创建桌面条目
```bash
# 创建应用程序目录
mkdir -p ~/.local/share/applications

# 创建桌面条目文件
cat > ~/.local/share/applications/cursor.desktop << EOF
[Desktop Entry]
Type=Application
Name=Cursor AI IDE
GenericName=Code Editor
Comment=AI-powered code editor for developers
Exec=$HOME/Applications/cursor.AppImage --no-sandbox %F
Icon=$HOME/.local/share/icons/cursor.png
Terminal=false
Categories=Development;IDE;TextEditor;
MimeType=text/plain;inode/directory;
Keywords=cursor;code;editor;ai;development;programming;
StartupWMClass=Cursor
EOF

# 使桌面条目可执行
chmod +x ~/.local/share/applications/cursor.desktop
```

### 4. 配置命令行访问

```bash
# 创建命令行工具目录
mkdir -p ~/.local/bin

# 创建cursor命令脚本
cat > ~/.local/bin/cursor << 'EOF'
#!/bin/bash
$HOME/Applications/cursor.AppImage --no-sandbox "$@" > /dev/null 2>&1 &
disown
EOF

# 使脚本可执行
chmod +x ~/.local/bin/cursor

# 添加到PATH（如果尚未添加）
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# 重新加载bash配置
source ~/.bashrc
```

## 方法三：适用于Ubuntu 24.04+的提取方式（最安全）

如果您遇到libfuse相关问题，可以使用此方法：

### 1. 下载并提取AppImage

```bash
# 下载AppImage
wget -O ~/Applications/cursor.AppImage "https://download.cursor.sh/linux/appImage/x64"
chmod +x ~/Applications/cursor.AppImage

# 提取AppImage内容
cd ~/Applications
./cursor.AppImage --appimage-extract

# 重命名提取的目录
mv squashfs-root cursor-extracted
```

### 2. 创建启动脚本

```bash
# 创建启动脚本
cat > ~/.local/bin/cursor << EOF
#!/bin/bash
cd "$HOME/Applications/cursor-extracted"
./AppRun --no-sandbox "\$@" > /dev/null 2>&1 &
disown
EOF

chmod +x ~/.local/bin/cursor
```

### 3. 更新桌面条目

```bash
# 更新桌面条目以使用提取的版本
cat > ~/.local/share/applications/cursor.desktop << EOF
[Desktop Entry]
Type=Application
Name=Cursor AI IDE
GenericName=Code Editor
Comment=AI-powered code editor for developers
Exec=$HOME/.local/bin/cursor %F
Icon=$HOME/.local/share/icons/cursor.png
Terminal=false
Categories=Development;IDE;TextEditor;
MimeType=text/plain;inode/directory;
Keywords=cursor;code;editor;ai;development;programming;
StartupWMClass=Cursor
EOF
```

## 使用方法

安装完成后，您可以通过以下方式启动Cursor：

1. **从应用程序菜单**：在活动概览或应用程序菜单中搜索"Cursor"
2. **命令行**：
   ```bash
   cursor                    # 打开Cursor
   cursor .                  # 在当前目录打开Cursor
   cursor /path/to/project   # 在指定目录打开Cursor
   ```

## 更新Cursor

### 使用脚本更新（如果使用了安装脚本）
```bash
cursor-update
```

### 手动更新
```bash
# 下载新版本
wget -O ~/Applications/cursor.AppImage.new "https://download.cursor.sh/linux/appImage/x64"

# 备份旧版本
mv ~/Applications/cursor.AppImage ~/Applications/cursor.AppImage.backup

# 使用新版本
mv ~/Applications/cursor.AppImage.new ~/Applications/cursor.AppImage
chmod +x ~/Applications/cursor.AppImage

# 如果使用提取方式，重新提取
cd ~/Applications
rm -rf cursor-extracted
./cursor.AppImage --appimage-extract
mv squashfs-root cursor-extracted
```

## 故障排除

### 问题1：无法启动Cursor
**解决方案：**
```bash
# 检查是否需要--no-sandbox参数
~/Applications/cursor.AppImage --no-sandbox

# 检查依赖
sudo apt install libfuse2t64  # Ubuntu 24.04+
# 或
sudo apt install libfuse2     # Ubuntu 22.04及更早版本
```

### 问题2：图标不显示
**解决方案：**
```bash
# 更新桌面数据库
update-desktop-database ~/.local/share/applications

# 更新图标缓存
gtk-update-icon-cache -f -t ~/.local/share/icons/hicolor 2>/dev/null || true
```

### 问题3：命令行cursor命令不工作
**解决方案：**
```bash
# 检查PATH
echo $PATH | grep "$HOME/.local/bin"

# 如果没有找到，添加到PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### 问题4：Ubuntu 24.04桌面环境损坏
如果安装libfuse2导致桌面环境问题：

```bash
# 重启到恢复模式，选择root shell
sudo apt-get install --reinstall ubuntu-desktop

# 或者
sudo apt install ubuntu-desktop-minimal
```

## 卸载Cursor

```bash
# 删除应用程序文件
rm -rf ~/Applications/cursor*

# 删除桌面条目
rm -f ~/.local/share/applications/cursor.desktop

# 删除图标
rm -f ~/.local/share/icons/cursor.png

# 删除命令行工具
rm -f ~/.local/bin/cursor
rm -f ~/.local/bin/cursor-update

# 从.bashrc中移除PATH设置（手动编辑）
nano ~/.bashrc
```

## 注意事项

1. **避免使用root权限**：不要用sudo运行安装脚本
2. **Ubuntu 24.04+用户**：优先使用libfuse2t64而不是libfuse2
3. **系统兼容性**：如果遇到图形问题，使用提取方式而不是直接运行AppImage
4. **定期更新**：定期检查并更新到最新版本以获得最佳体验

## 替代安装方法

### 官方一键安装脚本
```bash
curl -sSL https://gitrollup.com/r/install-cursor.sh | sudo bash
```

### 使用第三方包管理器
某些第三方仓库可能提供Cursor的deb包，但请确保来源可信。

---

**祝您使用Cursor编程愉快！** 🚀