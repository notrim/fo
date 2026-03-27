# Flutter环境配置脚本
# 在Trae IDE终端中运行此脚本配置Flutter环境

# 设置Flutter路径
$flutterPath = "C:\tools\flutter_windows_3.41.2-stable\flutter\bin"

# 检查Flutter路径是否存在
if (Test-Path $flutterPath) {
    Write-Host "✅ Flutter SDK路径正确: $flutterPath" -ForegroundColor Green
    
    # 临时设置环境变量（仅当前会话有效）
    $env:PATH = "$flutterPath;" + $env:PATH
    
    Write-Host "✅ Flutter环境变量已设置" -ForegroundColor Green
    
    # 验证Flutter安装
    Write-Host "正在验证Flutter安装..." -ForegroundColor Yellow
    
    try {
        $flutterVersion = & "$flutterPath\flutter.bat" --version
        Write-Host "✅ Flutter版本信息:" -ForegroundColor Green
        Write-Host $flutterVersion
        
        Write-Host ""
        Write-Host "🎉 Flutter环境配置成功！" -ForegroundColor Cyan
        Write-Host "现在你可以在Trae IDE中使用Flutter命令了" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "常用命令:" -ForegroundColor Yellow
        Write-Host "  flutter doctor          # 检查开发环境"
        Write-Host "  flutter pub get         # 安装依赖"
        Write-Host "  flutter run            # 运行应用"
        Write-Host "  flutter build apk       # 构建Android应用"
        Write-Host "  flutter build ios       # 构建iOS应用"
        
    } catch {
        Write-Host "❌ Flutter验证失败: $_" -ForegroundColor Red
    }
    
} else {
    Write-Host "❌ Flutter SDK路径不存在: $flutterPath" -ForegroundColor Red
    Write-Host "请检查Flutter SDK是否正确安装" -ForegroundColor Red
}