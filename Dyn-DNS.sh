#!/bin/bash
zone_id="found in overview"
auth_email="your cloudflare accounts email"
record_name="your domain name"
auth_key="found in api or overview"
ip1=$(curl -s ifconfig.io)
ip2=$(curl -s icanhazip.com)
ip3=$(curl -s checkip.amazonaws.com)
if [[ "$ip1" = "$ip2" && "$ip2" = "$ip3" ]]; then
    GET=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records?type=A&name=$record_name" \
    -H "X-Auth-Email: $auth_email" \
    -H "Authorization: Bearer $auth_key" \
    -H "Content-Type: application/json")
    CF_ip=$(echo "$GET" | sed -E 's/.*"content":"(([0-9]{1,3}\.){3}[0-9]{1,3})".*/\1/')
    if [ "$ip3" = "$CF_ip" ]; then
        exit 0
    fi
    record_id=$(echo "$GET" | sed -E 's/.*"id":"([A-Za-z0-9_]+)".*/\1/')
    curl -s -X PATCH "https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records/$record_id" \
     -H "X-Auth-Email: $auth_email" \
     -H "Authorization: Bearer $auth_key" \
     -H "Content-Type: application/json" \
     --data "{\"type\":\"A\",\"name\":\"$record_name\",\"content\":\"$ip3\"}"
fi
exit 0
