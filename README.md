# Cloudflare-DYNDNS

Script that uses Cloudflare's API to implement DDNS(Dynamic Domain Name Service)

## Installing
Clone Cloudflare-DYNDNS:
```
$ git clone https://github.com/MCgit2024/Cloudflare-DYNDNS-script.git DDNS
$ cd DDNS
$ chmod 700 Dyn-DNS.sh
```
## Configuration

### Credentials
Use your email tied to your Domain and your record_name should just be your Domain's name.
```
auth_email="" # myemail@mail.com
record_name="" # mydomain.org
```
### Tokens
Your **Zone ID** can be found in your Domain's overview.

https://developers.cloudflare.com/fundamentals/setup/find-account-and-zone-ids/
```
zone_id="" # Copy and Paste it here 
```
You should create an **API token** for the sole purpose of changing the Domain Record. This can be found in your Cloudflare dashboard, go to **My Profile > API Tokens > Create Tokens**.

https://developers.cloudflare.com/fundamentals/api/get-started/create-token/
```
auth_key"" # Copy and Paste it here
```
### Public Ip-Address
In order for this script to work the **IP** must be in the format of **"xxx.xxx.xxx.xxx"** (for example 104.130.1.209) 
you could use curl, dig (aka nslookup), or upnpc to get your current public ip but make sure it is in the correct format.
```
ip=(
  curl -s ifconfig.io # You can curl any thing as long as it gives you the responpse using HTTPS
  dig +short myip.opendns.com @resolver1.opendns.com # You can dig anything as long as dig is using etheir DoHTTPS or DoTLS
  upnpc -s | grep ^ExternalIPAddress # **DO NOT USE THIS** UPnP is inherntaly insecure only use if configured correctly 
)
```
### Logs
Logs will be pushed to whatever diretory and file is stated here.
```
logpath="/var/log/DDNS.log"
```
## Deployment
you will ussaly not mannuely run this script but use a crontab to run this once a day , 6 hours, hour , or mins as its quite unlickly ur isp will re-lease a new ip everyday
### systemd/timers
```
$ 
```
### cron.d
```
# sudo crontab -e # This will open your editor being VI or nano with root priviglies, you may run this command with whatever user you choose but it will run with those users persmisons
```
Add this line to your file: 

`30 11 * * * /path-to-your-script/DDNS/Dyn-DNS.sh`
```
# sudo crontab -l # Now verfy your entry has saved and is one of your current cron jobs
30 11 * * * /path-to-your-script/DDNS/Dyn-DNS.sh
```
## Built With

cloudflare api

## Contributing

feel free to open up a issue if you any chnages or fixes you seem nessarcry 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details

## Acknowledgments

cloudflare docs

