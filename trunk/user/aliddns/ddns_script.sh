# 自行测试哪个代码能获取正确的IP，删除前面的#可生效
arIpAddress () {
# IPv4地址获取
# 获得外网地址
curltest=`which curl`
if [ -z "$curltest" ] || [ ! -s "`which curl`" ] ; then
    #wget -T 5 -t 3 --user-agent "$user_agent" --quiet --output-document=- "https://www.cloudflare.com/cdn-cgi/trace" | awk -F= '/ip/{print $2}'
    #wget -T 5 -t 3 --user-agent "$user_agent" --quiet --output-document=- "http://myip.ipip.net" | grep "当前 IP" | grep -E -o '([0-9]+\.){3}[0-9]+' | head -n1 | cut -d' ' -f1
    wget -T 5 -t 3 --user-agent "$user_agent" --quiet --output-document=- "http://members.3322.org/dyndns/getip" | grep -E -o '([0-9]+\.){3}[0-9]+' | head -n1 | cut -d' ' -f1
    #wget -T 5 -t 3 --user-agent "$user_agent" --quiet --output-document=- "ip.3322.net" | grep -E -o '([0-9]+\.){3}[0-9]+' | head -n1 | cut -d' ' -f1
    #wget -T 5 -t 3 --user-agent "$user_agent" --quiet --output-document=- "http://ddns.oray.com/checkip" | grep -E -o '([0-9]+\.){3}[0-9]+' | head -n1 | cut -d' ' -f1
else
    #curl -L --user-agent "$user_agent" -s "https://www.cloudflare.com/cdn-cgi/trace" | awk -F= '/ip/{print $2}'
    #curl -L --user-agent "$user_agent" -s "http://myip.ipip.net" | grep "当前 IP" | grep -E -o '([0-9]+\.){3}[0-9]+' | head -n1 | cut -d' ' -f1
    curl -L --user-agent "$user_agent" -s "http://members.3322.org/dyndns/getip" | grep -E -o '([0-9]+\.){3}[0-9]+' | head -n1 | cut -d' ' -f1
    #curl -L --user-agent "$user_agent" -s ip.3322.net | grep -E -o '([0-9]+\.){3}[0-9]+' | head -n1 | cut -d' ' -f1
    #curl -L --user-agent "$user_agent" -s http://ddns.oray.com/checkip | grep -E -o '([0-9]+\.){3}[0-9]+' | head -n1 | cut -d' ' -f1
fi
}
arIpAddress6 () {
# IPv6地址获取
# 因为一般ipv6没有nat ipv6的获得可以本机获得
ifconfig $(nvram get lan0_ifname_t) | awk '/Global/{print $3}' | awk -F/ '{print $1}'
#curl -6 -s https://www.cloudflare.com/cdn-cgi/trace | awk -F= '/ip/{print $2}'
}
if [ "$IPv6_neighbor" != "1" ] ; then
if [ "$IPv6" = "1" ] ; then
arIpAddress=$(arIpAddress6)
else
arIpAddress=$(arIpAddress)
fi
else
arIpAddress=$inet6_neighbor
inet6_neighbor=""
IPv6_neighbor=0
fi
