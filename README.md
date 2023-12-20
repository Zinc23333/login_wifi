# 自动登陆南京工业大学宿舍区网络
目前仅适用于电信网络

Linux 下的指令:
`curl -X POST  "http://10.50.255.12:801/eportal/portal/login?callback=dr1003&login_method=1&user_account=%2C0%2C<你的学号>%40telecom&user_password=<你的密码>&wlan_user_ip=$(ip addr show | grep 'inet 10' |sed 's/inet //g' | sed 's/\/16.*$//g' | tr -d ' ')&wlan_user_ipv6=&wlan_user_mac=000000000000&wlan_ac_ip=&wlan_ac_name=&jsVersion=4.1.3&terminal_type=1&lang=zh-cn&v=660&lang=zh"`

Windows & 安卓端：

使用 Flutter 构建

每次打开会自动尝试登陆，在安卓端登陆成功后会自动退出程序