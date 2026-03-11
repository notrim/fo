# 佛历应用部署指南

本指南将解释开发服务器的目的以及如何将应用部署上线。

## 开发服务器的目的

启动开发服务器（`npx expo start`）的主要目的是：

1. **实时预览**：在开发过程中实时查看应用的变化，无需重新编译
2. **热重载**：修改代码后，应用会自动更新，节省开发时间
3. **多设备测试**：通过二维码在多个设备上同时测试应用
4. **调试工具**：提供控制台日志、错误信息和性能分析
5. **模拟器集成**：方便在iOS和Android模拟器上测试

## 部署上线步骤

部署上线与开发测试的步骤不同，以下是将应用部署到iOS App Store的完整流程：

### 步骤1：准备工作

1. **创建Apple开发者账号**：
   - 访问 https://developer.apple.com/ 注册开发者账号（需要付费）
   - 完成账号验证和付费流程

2. **配置应用信息**：
   - 登录Apple开发者后台，创建App ID
   - 在`app.json`中更新`bundleIdentifier`为您的App ID

### 步骤2：构建生产版本

1. **安装依赖**：
   ```
   npm install
   ```

2. **执行Expo构建命令**：
   ```
   npx expo build:ios
   ```
   - 这会生成一个.ipa文件（iOS应用安装包）
   - 可能需要您登录Expo账号并提供Apple开发者账号信息

3. **或使用EAS Build**（推荐）：
   ```
   npx eas build -p ios
   ```
   - EAS (Expo Application Services) 是Expo官方推荐的构建服务
   - 提供更稳定和可靠的构建过程

### 步骤3：提交到App Store

1. **使用Transporter应用**：
   - 从Mac App Store下载Transporter应用
   - 登录您的Apple开发者账号
   - 上传构建好的.ipa文件

2. **在App Store Connect中配置**：
   - 访问 https://appstoreconnect.apple.com/
   - 创建新的App记录
   - 填写应用名称、描述、截图等信息
   - 提交审核

3. **等待审核**：
   - Apple审核通常需要1-2周时间
   - 审核通过后，应用会在App Store上架

### 步骤4：后续维护

1. **版本更新**：
   - 当需要更新应用时，修改代码后重新构建
   - 增加版本号（在app.json中）
   - 重新提交审核

2. **监控和分析**：
   - 使用App Store Connect查看应用下载量和用户评价
   - 集成分析工具（如Firebase Analytics）了解用户行为

## 开发服务器vs部署上线

| 功能 | 开发服务器 | 部署上线 |
|------|------------|----------|
| 目的 | 开发和测试 | 发布到App Store |
| 命令 | `npx expo start` | `npx expo build:ios` 或 `npx eas build -p ios` |
| 输出 | 本地服务器和二维码 | .ipa安装包 |
| 设备访问 | 通过Expo Go应用 | 通过App Store下载 |
| 性能 | 开发模式（较慢） | 生产模式（优化） |
| 适用场景 | 日常开发和测试 | 最终用户使用 |

## 常见问题

### 构建失败
- 检查依赖是否正确安装
- 确保Apple开发者账号有效
- 验证bundleIdentifier配置正确

### 审核被拒
- 确保应用内容符合App Store审核 guidelines
- 提供清晰的应用描述和截图
- 测试应用的所有功能，确保无崩溃

### 版本更新
- 每次更新都需要增加版本号
- 提供更新说明，说明新功能或 bug 修复

## 总结

- **开发服务器**是用于开发和测试阶段的工具，方便实时预览和调试
- **部署上线**是将应用发布到App Store的过程，需要构建生产版本并通过Apple审核
- 两者使用不同的命令和流程，但都是应用开发周期中不可或缺的部分

如果您需要更详细的部署指导，可以参考Expo官方文档：https://docs.expo.dev/build/introduction/