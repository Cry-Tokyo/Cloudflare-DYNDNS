# Cloudflare-DYNDNS

Bash Script that uses Cloudflare's API to implement DDNS (Dynamic Domain Name Service).

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

You can use whatever job schedular you choose, just make sure you dont over abuse Cloudflare's api or you may be ratelimited, once a day is more then enough time between Ip leases. 
### system.d/timers
What ever user creates and enables this systemd timer, the script will run with that user's privileges so run these commands with root or a user with the least amount of privliges.

Create a service unit:
```
# vi /etc/systemd/system/Dyn-DNS.service
[Unit]
Description=Cloudflare Dyn-DNS script, should be ran around once day but use at your discreation

[Service]
Type=simple
ExecStart=/path-to-your-script/DDNS/myscript.sh
```
Create a Timer Unit:
```
# vi /etc/systemd/system/Dyn-DNS.timer
[Unit]
Description=Timer for Cloudflare Dyn-DNS script

[Timer]
OnCalendar=*-*-* 11:00:00
Persistent=true

[Install]
WantedBy=timers.target
```
Save the file, reload Systemd, and start and enable the timer.
```
# systemctl daemon-reload
# systemctl start Dyn-DNS.timer
# systemctl enable Dyn-DNS.timer
# systemctl status myscript.timer # Make sure the timer was saved and is running
```
### cron.d
Run these commands with root or a user with the least amount of privliges as cron jobs are typically executed with the permissions of the user who created them.
```
# crontab -e # This will open your editor being VI or nano
```
Add this line to the file: 

`30 11 * * * /path-to-your-script/DDNS/Dyn-DNS.sh`

Save the file.
```
# crontab -l # Now verfy your entry has saved and is one of your current cron jobs
30 11 * * * /path-to-your-script/DDNS/Dyn-DNS.sh
```
## Contributing

Feel free to open up an issue if you have any changes or fixes you deem necessary. 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE).
