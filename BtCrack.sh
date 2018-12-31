#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
export PATH
LANG=en_US.UTF-8;

clear;
echo '================================================================';
echo ' 欢迎安装宝塔面板Pro破解版！';
echo ' 只适用于宝塔面板5.9x系列专业版';
echo ' 如已安装更高版本的宝塔面板，请先卸载高版本再安装';
echo ' 使用本脚本出现的任何不良后果，本人概不负责';
echo ' https://www.sxsay.com';
echo '================================================================';


red='\033[0;31m';
blue='\033[0;34m';

function ConfirmInstall()
{
#检查是否为Root
[ $(id -u) != "0" ] && { echo -e "${red}[错误]${blue} 你必须以 root 用户执行此安装程序"; exit 1; }
#判断确定破解
while [ "$Yes" != 'y' ] && [ "$Yes" != 'n' ];
do
    read -p "确定要安装吗？(y/n): " Yes;
	UpInstall;
done;
if [ "$Yes" = 'n' ];then
    exit;
fi;
}
function UpInstall()
{
wget -O update.sh https://www.sxsay.com/bt/update.sh && chmod 775 update.sh && bash update.sh pro 2>&1 | tee update.log;
}
function Crack()
{
    rm -rf update.sh
	export Crack_file=/www/server/panel/class/common.py
	echo -e "${red}[注意] ${blue}破解执行中...";
    /etc/init.d/bt stop;
    sed -i $'164s/panelAuth.panelAuth().get_order_status(None)/{\'status\': \True, \'msg\': {\'endtime\': 32503651199}}/g' ${Crack_file};
    touch /www/server/panel/data/userInfo.json;
    /etc/init.d/bt restart;
	rm -rf BtCrack.sh
}
execute_bt_panel() {
    if ! grep '/etc/init.d/bt restart' /etc/crontab; then
        systemctl enable cron.service
        systemctl start cron.service
        echo "0  0    * * *   root    /etc/init.d/bt restart" >> /etc/crontab
        /etc/init.d/cron restart
    fi
}
# BT Update Crack Installing ****************************************************************************
ConfirmInstall;
UpInstall;
Crack;
execute_bt_panel;

echo '================================================================';
	echo '宝塔面板破解版已安装成功.';
	echo "请使用破解之前的后台地址！";
	echo "账号、密码，登录宝塔面板并使用！";
	echo '如有问题请在网站提交:https://www.sxsay.com';
echo '================================================================';

