#!/bin/bash

cp -r /tmp/scripts /root/
chmod 775 /root/scripts/*
mv /root/scripts/StartMonMode.service /etc/systemd/system/
chmod 775 /etc/systemd/system/StartMonMode.service
mv /root/scripts/WfHunter.service /etc/systemd/system/
chmod 775 /etc/systemd/system/WfHunter.service
systemctl daemon-reload
systemctl start WfHunter.service
systemctl enable WfHunter.service
systemctl start StartMonMode.service
systemctl enable StartMonMode.service

