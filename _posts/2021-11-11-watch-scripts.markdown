---
layout: post
title:  "Phoenix Miner/T-Rex Watch Scripts"
date:   2021-11-11 10:40:00 -0500
---
I've been mining Ethereum with [Phoenix Miner](https://bitcointalk.org/index.php?topic=2647654.0){:target="_blank"} since February of this year (using Ubuntu 20.04).  One thing I wanted was automated updates on the status of my rigs.  I also had intermittent issues with my AMD cards which would cause one of my rigs to crash.  Looking at the log files, the AMD card that causes the crash would report an insane hashrate a minute or two before it actually would crash.  (I did make sure that the crashes aren't related to any over/under clocks I used, they aren't..)

When Phoenix Miner crashed from one of the AMD cards (PowerColor 5700 XTs), my system was completely locked up.  I installed [BN Link Smart Plugs](https://www.amazon.com/BN-LINK-Monitoring-Function-Compatible-Assistant/dp/B07CVPKD8Z/?th=1){:target="_blank"} to be able to remotely shutdown and restart the rig, but there's always risk with just cutting power to a server like that.  Ideally, it's shutdown or rebooted appropriately.

I'm not a Perl master, but I know enough to be dangerous.  So I put that to use and wrote a script that would tail the Phoenix Miner log.  The script assumes a Linux install and depends on "sendmail" and "perl".  You can install "sendmail" and "perl" by running the following (choose the appropriate one for your Linux platform):

{% include code_header.html %}
{% highlight bash %}
sudo dnf install -y sendmail perl
{% endhighlight %}
{% include code_header.html %}
{% highlight bash %}
sudo apt install -y sendmail perl
{% endhighlight %}
<br />
The Phoenix Miner script will report the following via an email:
* Hash Rate Summary every 6 hours
* Notification of an Invalid Hash Rate (the script will automatically reboot the server if this occurs to prevent a system lock up)
* Notification of a Reboot
* Notification of an Incorrect Eth Share
<br />
<br />

## T-Rex Miner ##
I recently bought some LHR Nvidia cards.  To mine with these cards, I switched to [T-Rex Miner](https://github.com/trexminer/T-Rex/releases){:target="_blank"}.  (Quick tip, mess with the mining intensity for each of your LHR cards with "auto tune" enabled.  A lower mining intensity can limit LHR locks overall and thus, increase your hash rate.)  I modified the Phoenix Miner script to work with T-Rex.

The T-Rex Miner script will report the following via an email:
* Hash Rate and LHR Summary every 6 hours
* Notification of a Reboot
* Notification of an Incorrect Eth Share

<br />
I've only ever had the invalid hash rate with the AMD cards and Phoenix Miner.  T-Rex is only for Nvidia cards and I've never encountered that with T-Rex, so that part of the script has been removed.  If you do encounter that issue, please send contact me and send me your log file!

## Usage ##
I call these Perl scipts from within my miner scripts.  The Perl scripts look for the newest log file in your specified log file directory.  So you do need to make sure that your miner software is already running.  To do that, I add this line to the beginning of my miner scripts:
{% include code_header.html %}
{% highlight bash %}
(sleep 300; perl /opt/phoenix/phoenix-watch.pl /opt/phoenix/logs sendtoemail@domain.com) &
{% endhighlight %}
<br />
My resulting Phoenix Miner startup script looks similar to this (you may not have an Nvidia under/overclock script, so just remove it or replace it with yours):
{% include code_header.html %}
{% highlight bash %}
#!/bin/bash

# Load Nvidia over/underclocks
sudo /opt/phoenix/nvidia-settings.sh

# Start the watcher
(sleep 300; perl /opt/phoenix/phoenix-watch.pl /opt/phoenix/logs sendtoemail@domain.com) &

# Start the miner 
/opt/phoenix/PhoenixMiner -pool ssl://us1.ethermine.org:5555 -wal 0xSetYourEthWalletAddressHere -worker phoenixworker -mi 14 -epsw x -coin eth -mode 1 -nvidia -proto 3 -log 1 -logdir /opt/phoenix/logs -leaveoc -nvdo 1 -nvNew 1 -nvKernel 3 -pool2 ssl://eu2.ethermine.org:5555 -cdmport 3333 -eres 6 -lidag 1 -config /opt/phoenix/config.txt -gpus 1,3,4,5
{% endhighlight %}
<br />

For T-Rex, my miner script looks similar to the following.  (If you don't want to archive your log files, just remove that section.  Also remove or replace the Nvidia over/underclocks script for your setup.)

{% include code_header.html %}
{% highlight bash %}
#!/bin/sh

# Load Nvidia over/underclocks
sudo /opt/trex/nvidia-settings.sh

# Start the watcher
(sleep 300; perl /opt/trex/trex-watch.pl /opt/trex/logs sendtoemail@domain.com) &

# Archive the existing log file
mkdir /opt/trex/logs/archive
mv -nv -- /opt/trex/logs/trex.log /opt/trex/logs/archive/trex-$(date +'%Y%m%d_%H%M%S').log

# Delete the previous log file
rm -f /opt/trex/logs/*.log

# Start the miner
/opt/trex/t-rex -a ethash --url stratum+ssl://us1.ethermine.org:5555 --user 0xSetYourEthWalletAddressHere -p x -w trexworker --log-path /opt/trex/logs/trex.log --no-watchdog --send-stales -d 1,5 --kernel 0 --lhr-tune 68,71 --lhr-autotune-mode full --coin eth --intensity 15.5,22.1
{% endhighlight %}
<br />

## Final Notes ##
The emails you receive from the script will most likely be marked as Spam.  So check your Spam folder for the emails.  If you add the sending email to your contacts, it's possible that your email provider might not mark it as spam.  The Sending email address will always be from "hostname@hostname.com" where "hostname" is the short hostname for the server the script is running on.  (If you try to use your Gmail email as the sender email, it won't go through.)

## Download ##
You can download the scripts and use them as you see fit.  You can change the email interval by modifying the "sendSummary" value in the script.  The current values will result in a summary email once every 6 hours.
<br />
* [Phoenix Miner Watch](/tools/phoenix-watch.pl)
* [T-Rex Miner Watch](/tools/trex-watch.pl)
<br />
<br />

Happy Mining!
