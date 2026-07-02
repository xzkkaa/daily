# 2026_07_02 每日练习

## 基本信息

- **日期**：2026-07-02
- **项目建立时间**：2026-07-02 19:14:13
- **IP 地址**：240a:42d4:a800:489c:c1b7:c07d:ef04:46ca

## 项目总结

### 1. GitHub SSH 连接修复

**问题**：Windows 用户文件夹 `Admin（无密码）` 含中文全角括号，SSH 路径编码不匹配，无法读取 `~/.ssh/config` 和 `known_hosts`，导致 `Host key verification failed`。

**解决方案**：
- 在 `C:\Users\Public\.ssh\`（纯英文路径）生成新的 ed25519 密钥对
- 将新公钥添加到 GitHub
- 通过 `git config --global core.sshCommand` 直接内联 SSH 参数，绕过 config 文件路径问题
- 22 端口被运营商封锁，走 `ssh.github.com:443`

**验证结果**：SSH 认证成功、git ls-remote/fetch 正常。

### 2. 开源数学题库调研

搜索了 GitHub 上的开源高中数学题库资源：
- **NuminaMath**（~90万题，英文，Apache 2.0）
- **HighMATH**（5,293题，中文高考，EMNLP 2025）
- **BlueMO**（小蓝书14册，中文奥数）

### 3. 数学公式 OCR 工具调研

搜索了图像转 LaTeX 公式的开源项目：
- **TexTeller**：8000万训练数据，支持手写/拍照/中英混合
- **FMatPix**：免费 exe 离线工具，开箱即用
- **pix2tex (LaTeX-OCR)**：最成熟，12k+ Stars，有 GUI

### 4. TexTeller 部署尝试（未完成）

- ✅ Python 3.10.11 安装成功
- ✅ pip 升级至最新版
- ❌ `pip install texteller` 因 opencv-python-headless 下载哈希校验失败（网络不稳定）

### 5. 远程操作台式机使用 Claude 方案

**目标**：在性能较弱的笔记本电脑上，通过 SSH 远程操作高性能台式机运行 Claude Code。

**笔记本电脑环境**：
- IP：100.83.159.45（公网） / 10.141.89.238（内网）
- SSH 客户端：OpenSSH 10.3p1
- 443 端口可达（22 端口被封锁）

**方案设计**：

| 层级 | 方案 | 适用场景 |
|------|------|----------|
| 局域网 | SSH 直连台式机 IP | 同一 WiFi/路由器下 |
| 异地组网 | Tailscale（免费）| 不在同一网络 |
| 备选 | frp / ZeroTier / Cloudflare Tunnel | 特殊网络环境 |

**操作流程**：
1. 台式机运行 `setup_desktop.ps1` → 开启 SSH Server
2. 两台电脑都装 Tailscale → 组成虚拟局域网
3. 笔记本 `ssh 用户名@台式机IP` → 进入台式机终端
4. 在台式机上运行 `claude` → 享受高性能

**本机已完成**：
- SSH 客户端配置就绪
- 创建了 `setup_desktop.ps1`（台式机一键开启 SSH）
- 创建了 `connect.sh`（笔记本连接脚本）

**待台式机端操作**：运行 `setup_desktop.ps1`，然后安装 Tailscale 组网。

## 项目结构

```
2026_07_02/
├── README.md
├── test_images/
└── remote-claude/
    ├── setup_desktop.ps1      # 台式机 SSH 服务端配置脚本
    ├── connect.sh             # 笔记本连接脚本
    └── ssh_config_template    # SSH 客户端配置模板
```
