# Cloudflare-DYNDNS

Script that uses Cloudflare's API to implement DDNS(Dynamic Domain Name Service)

### Installing


Clone Cloudflare-DYNDNS:

```
git clone https://github.com/MCgit2024/Cloudflare-DYNDNS-script.git DDNS
cd DDNS
chmod 700 Dyn-DNS.sh
```


### Configuration

Credentials:
```
auth_email="" #
record_name="" #
```
Zone ID:
ussaly found in your domain's overview
![](https://raw.githubusercontent.com/MCgit2024/stuff/main/zone_id.png)
```
zone_id="" #overview
```
![]()
```
auth_key"" #api key
```
ip
```
ip=(
  dig
  curl
  upnpc -s
)
```
log
```
logpath="/var/log/DDNS.log"
```
## Deployment
you will ussaly not mannuely run this script but use a crontab to run this once a day , 6 hours, hour , or mins as its quite unlickly ur isp will re-lease a new ip everyday
#systemd/timers
```

```
#cron.d
```
cron
```
## Built With

cloudflare api

## Contributing

feel free to open up a issue if you any chnages or fixes you seem nessarcry 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details

## Acknowledgments

cloudflare docs

