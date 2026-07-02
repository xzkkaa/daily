# ============================================
# 台式机 SSH 服务端一键配置脚本
# 在台式机（Windows）管理员 PowerShell 中运行
# ============================================

Write-Host "=== 台式机 SSH Server 配置 ===" -ForegroundColor Cyan

# 1. 安装 OpenSSH Server
Write-Host "`n[1/4] 安装 OpenSSH Server..." -ForegroundColor Yellow
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
if ($LASTEXITCODE -ne 0) {
    Write-Host "可能已安装或安装失败，继续..." -ForegroundColor Gray
}

# 2. 配置 SSH 服务自动启动
Write-Host "`n[2/4] 配置 sshd 服务..." -ForegroundColor Yellow
Set-Service -Name sshd -StartupType 'Automatic'
Start-Service sshd
Write-Host "sshd 状态: $(Get-Service sshd | Select-Object -ExpandProperty Status)" -ForegroundColor Green

# 3. 防火墙放行 22 端口
Write-Host "`n[3/4] 配置防火墙..." -ForegroundColor Yellow
New-NetFirewallRule -Name "OpenSSH-Server" -DisplayName "OpenSSH Server (sshd)" -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22 2>$null
Write-Host "防火墙规则已添加（如已存在则跳过）" -ForegroundColor Green

# 4. 显示台式机 IP
Write-Host "`n[4/4] 台式机网络信息:" -ForegroundColor Yellow
Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -notlike "127.*" -and $_.PrefixOrigin -ne "WellKnown" } | Format-Table IPAddress, InterfaceAlias

Write-Host "`n=== 配置完成！===" -ForegroundColor Green
Write-Host "现在回到笔记本电脑，用以下命令连接:" -ForegroundColor Cyan
Write-Host "  ssh 你的用户名@台式机IP" -ForegroundColor White
Write-Host "`n提示: 如果两台电脑不在同一局域网，还需要安装 Tailscale" -ForegroundColor Gray
Write-Host "  winget install tailscale.tailscale" -ForegroundColor Gray
