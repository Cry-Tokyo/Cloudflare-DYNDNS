#!/bin/bash
auth_email="cloudflareemail@here.now" # email used on your Cloudflare account
auth_key=""
zone_identifier=""
record_name="name of your A Record"
ttl="3600"                                          
proxy="false"# true if proxied false if not proxied
sitename="the domain you want to use"
auth_header="Authorization: Bearer"
ip=$(upnpc -s | grep -oP "ExternalIPAddress = \K.*")#or curl a cloudflare api https://cloudflare.com/cdn-cgi/trace
record=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$zone_identifier/dns_records?type=A&name=$record_name" \
                      -H "X-Auth-Email: $auth_email" \
                      -H "$auth_header $auth_key" \
                      -H "Content-Type: application/json")
record_identifier=$(echo "$record" | sed -E 's/.*"id":"([A-Za-z0-9_]+)".*/\1/')
curl -s -X PATCH "https://api.cloudflare.com/client/v4/zones/$zone_identifier/dns_records/$record_identifier" \
                     -H "X-Auth-Email: $auth_email" \
                     -H "$auth_header $auth_key" \
                     -H "Content-Type: application/json" \
                     --data "{\"type\":\"A\",\"name\":\"$record_name\",\"content\":\"$ip\",\"ttl\":\"$ttl\",\"proxied\":${proxy}}"
