# 定时报时提醒

一个基于 GitHub Actions 的定时自动化：从早上 5 点开始，每隔 5 小时提醒你一次当前时间。

## 提醒时间（北京时间 UTC+8）

- 05:00
- 10:00
- 15:00
- 20:00
- 01:00（次日凌晨）

> GitHub Actions 的 cron 使用 UTC 时区，因此在 `.github/workflows/time-reminder.yml` 中
> 实际配置为 UTC 的 `02 / 07 / 12 / 17 / 21` 点，对应上面的北京时间。

## 工作原理

- 完全运行在 GitHub 的服务器上，**不依赖任何聊天会话或本地电脑**，无需保持对话窗口开启。
- 每次触发时，工作流会换算出当前北京时间，并在一个带 `time-reminder` 标签的
  Issue 下追加一条评论（首次运行时自动创建该 Issue）。
- 你会通过 GitHub 的通知（网页 / 邮件 / App）收到提醒。

## 手动测试

在仓库的 **Actions** 页面选择「定时报时提醒」工作流，点击 **Run workflow** 即可立即触发一次，验证效果。

## 备注

- 定时触发由 GitHub 调度，可能会有几分钟延迟，属正常现象。
- 如需修改时间，编辑 `.github/workflows/time-reminder.yml` 里的 `cron` 表达式即可（记得按 UTC 换算）。
