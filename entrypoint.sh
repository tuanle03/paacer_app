#!/bin/bash
set -e

# Xoá file PID nếu tồn tại
rm -f /rails/tmp/pids/server.pid

# Tiếp tục lệnh CMD gốc
exec "$@"
