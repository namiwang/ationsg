# Set the working application directory
# working_directory "/path/to/your/app"
working_directory "/home/dev/production/ationsg"

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "/home/dev/production/ationsg/tmp/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "/home/dev/production/ationsg/log/unicorn.log"
stdout_path "/home/dev/production/ationsg/log/unicorn.log"

# Unicorn socket
# listen "/tmp/unicorn.[app name].sock"
listen "/tmp/unicorn.ationsg.sock"

# Number of processes
# worker_processes 4
worker_processes 4

# Time-out
timeout 30