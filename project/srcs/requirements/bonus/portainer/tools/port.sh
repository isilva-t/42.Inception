#!/bin/sh

exec ./portainer/portainer \
	--admin-password-file=/run/secrets/port_pass \
	--data /data
