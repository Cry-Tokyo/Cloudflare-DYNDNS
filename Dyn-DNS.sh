#!/bin/bash
zone_id="found in overview"
auth_email="your cloudflare accounts email"
record_name="your domain name"
auth_key="found in api or overview"
logpath="/var/log/DDNS.log"

ip=("$(curl -s ifconfig.io)" "$(curl -s icanhazip.com)" "$(curl -s checkip.amazonaws.com)")

log="[`date '+%Y-%m-%d %H:%M:%S:%3N'`] $(whoami): ${ip[@]}\n"
if [ $(printf "%s\n" "${ip[@]}" | uniq -c | wc -l) -eq 1 ]; then
    GET=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records?type=A&name=$record_name" \
    -H "X-Auth-Email: $auth_email" \
    -H "Authorization: Bearer $auth_key" \
    -H "Content-Type: application/json")
    CF_ip=$(echo "$GET" | sed -E 's/.*"content":"(([0-9]{1,3}\.){3}[0-9]{1,3})".*/\1/')
    log+="[`date '+%Y-%m-%d %H:%M:%S:%3N'`] $(whoami): $GET\n"
    if [ $ip = $CF_ip ]; then
        echo -e "$log" >> "$logpath"
        exit 0
    fi
    record_id=$(echo "$GET" | sed -E 's/.*"id":"([A-Za-z0-9_]+)".*/\1/')
    PATCH=$(curl -s -X PATCH "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records/$record_id" \
     -H "X-Auth-Email: $auth_email" \
     -H "Authorization: Bearer $auth_key" \
     -H "Content-Type: application/json" \
     --data "{\"type\":\"A\",\"name\":\"$record_name\",\"content\":\"$ip\"}")
    log+="[`date '+%Y-%m-%d %H:%M:%S:%3N'`] $(whoami): $PATCH\n"
else
    log+="[`date '+%Y-%m-%d %H:%M:%S:%3N'`] $(whoami): public ips received do not match possilbe error or attack"
fi
echo -e "$log" >> "$logpath"
exit 0
