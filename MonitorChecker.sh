#/usr/bin/env bash

function setLaptopScreen {
	xrandr \
		--output eDP \
		--mode 1920x1080 \
		--pos 0x0 \
		--rotate normal \
		--output HDMI-A-0 --off
}

function setMonitorScreen {
	xrandr \
		--output eDP --off \
		--output HDMI-A-0 --primary \
		--mode 1920x1080 --pos 0x0 \
		--rotate normal
}

function monitorDisconnected {
	[[ $(xrandr | grep "HDMI-A-0" | awk '{print $2}') == "disconnected" ]]
}

function checkMonitorConnectedButNotUsed {
	[[ $(xrandr | grep "HDMI-A-0" | awk '{print $2}') == "connected" ]] && \
		[[ ! $(xrandr | grep "HDMI-A-0" | awk '{print $4}') == "1920x1080+0+0" ]]
}

(checkMonitorConnectedButNotUsed && setMonitorScreen) \
	|| (monitorDisconnected && setLaptopScreen)
