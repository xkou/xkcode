#! /bin/sh

### BEGIN INIT INFO
# Provides:          logbus
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Should-Start:      $named
# Default-Start:     2 3 4 5
# Default-Stop:
# Short-Description: fast remote file copy program daemon
# Description:       rsync is a program that allows files to be copied to and
#                    from remote machines in much the same way as rcp.
#                    This provides rsyncd daemon functionality.
### END INIT INFO

set -e

# /etc/init.d/rsync: start and stop the rsync daemon

DAEMON=/usr/local/ta-logBus/bin/logbus
RSYNC_PID_FILE=/var/run/logbus.pid
. /lib/lsb/init-functions


rsync_start() {
      cd /usr/local/ta-logBus/bin
      log_daemon_msg "Start logbus daemon"
      ./logbus start
      log_end_msg $?
} # rsync_start


case "$1" in
  start)
        rsync_start
        ;;
  stop)
        log_daemon_msg "Stopping logbus daemon" "logbus"
        $DAEMON stop
        log_end_msg $?
        rm -f $RSYNC_PID_FILE
        ;;

  reload|force-reload)
        log_warning_msg "Reloading rsync daemon: not needed, as the daemon"
        log_warning_msg "re-reads the config file whenever a client connects."
        ;;

  restart)


       ;;

  status)

        exit $? # notreached due to set -e
        ;;
  *)
        echo "Usage: /etc/init.d/rsync {start|stop|reload|force-reload|restart|status}"
        exit 1
esac

exit 0
