Sample init scripts and service configuration for gainproxd
==========================================================

Sample scripts and configuration files for systemd, Upstart and OpenRC
can be found in the contrib/init folder.

    contrib/init/gainproxd.service:    systemd service unit configuration
    contrib/init/gainproxd.openrc:     OpenRC compatible SysV style init script
    contrib/init/gainproxd.openrcconf: OpenRC conf.d file
    contrib/init/gainproxd.conf:       Upstart service configuration file
    contrib/init/gainproxd.init:       CentOS compatible SysV style init script

Service User
---------------------------------

All three Linux startup configurations assume the existence of a "gainproxcore" user
and group.  They must be created before attempting to use these scripts.
The OS X configuration assumes gainproxd will be set up for the current user.

Configuration
---------------------------------

At a bare minimum, gainproxd requires that the rpcpassword setting be set
when running as a daemon.  If the configuration file does not exist or this
setting is not set, gainproxd will shutdown promptly after startup.

This password does not have to be remembered or typed as it is mostly used
as a fixed token that gainproxd and client programs read from the configuration
file, however it is recommended that a strong and secure password be used
as this password is security critical to securing the wallet should the
wallet be enabled.

If gainproxd is run with the "-server" flag (set by default), and no rpcpassword is set,
it will use a special cookie file for authentication. The cookie is generated with random
content when the daemon starts, and deleted when it exits. Read access to this file
controls who can access it through RPC.

By default the cookie is stored in the data directory, but it's location can be overridden
with the option '-rpccookiefile'.

This allows for running gainproxd without having to do any manual configuration.

`conf`, `pid`, and `wallet` accept relative paths which are interpreted as
relative to the data directory. `wallet` *only* supports relative paths.

For an example configuration file that describes the configuration settings,
see `contrib/debian/examples/gainprox.conf`.

Paths
---------------------------------

### Linux

All three configurations assume several paths that might need to be adjusted.

Binary:              `/usr/bin/gainproxd`  
Configuration file:  `/etc/gainproxcore/gainprox.conf`  
Data directory:      `/var/lib/gainproxd`  
PID file:            `/var/run/gainproxd/gainproxd.pid` (OpenRC and Upstart) or `/var/lib/gainproxd/gainproxd.pid` (systemd)  
Lock file:           `/var/lock/subsys/gainproxd` (CentOS)  

The configuration file, PID directory (if applicable) and data directory
should all be owned by the gainproxcore user and group.  It is advised for security
reasons to make the configuration file and data directory only readable by the
gainproxcore user and group.  Access to gainprox-cli and other gainproxd rpc clients
can then be controlled by group membership.

### Mac OS X

Binary:              `/usr/local/bin/gainproxd`  
Configuration file:  `~/Library/Application Support/GainproxCore/gainprox.conf`  
Data directory:      `~/Library/Application Support/GainproxCore`
Lock file:           `~/Library/Application Support/GainproxCore/.lock`

Installing Service Configuration
-----------------------------------

### systemd

Installing this .service file consists of just copying it to
/usr/lib/systemd/system directory, followed by the command
`systemctl daemon-reload` in order to update running systemd configuration.

To test, run `systemctl start gainproxd` and to enable for system startup run
`systemctl enable gainproxd`

### OpenRC

Rename gainproxd.openrc to gainproxd and drop it in /etc/init.d.  Double
check ownership and permissions and make it executable.  Test it with
`/etc/init.d/gainproxd start` and configure it to run on startup with
`rc-update add gainproxd`

### Upstart (for Debian/Ubuntu based distributions)

Drop gainproxd.conf in /etc/init.  Test by running `service gainproxd start`
it will automatically start on reboot.

NOTE: This script is incompatible with CentOS 5 and Amazon Linux 2014 as they
use old versions of Upstart and do not supply the start-stop-daemon utility.

### CentOS

Copy gainproxd.init to /etc/init.d/gainproxd. Test by running `service gainproxd start`.

Using this script, you can adjust the path and flags to the gainproxd program by
setting the GAINPROXD and FLAGS environment variables in the file
/etc/sysconfig/gainproxd. You can also use the DAEMONOPTS environment variable here.

### Mac OS X

Copy org.gainprox.gainproxd.plist into ~/Library/LaunchAgents. Load the launch agent by
running `launchctl load ~/Library/LaunchAgents/org.gainprox.gainproxd.plist`.

This Launch Agent will cause gainproxd to start whenever the user logs in.

NOTE: This approach is intended for those wanting to run gainproxd as the current user.
You will need to modify org.gainprox.gainproxd.plist if you intend to use it as a
Launch Daemon with a dedicated gainproxcore user.

Auto-respawn
-----------------------------------

Auto respawning is currently only configured for Upstart and systemd.
Reasonable defaults have been chosen but YMMV.
