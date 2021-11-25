---
layout: post
title:  "GPU Mining Guide"
date:   2021-11-25 11:17:00 -0500
---
GPU mining can be a great source of "passive" income and investment.  I say "passive" because there is work involved to buy, build, configure, and maintain your mining rig.  Once it's running smoothly though, you can pretty much sit back and collect your mining rewards!

It's impossible to address everything in regards to GPU mining but I'll hit on some of the most common topics and questions.

1. [Choosing an OS](#OS) 
2. [Hardware Choices](#hardware)
3. [Choosing a Miner](#chooseminer)
4. [Choosing a Pool](#choosepool)
5. [AMD Settings](#amd)
6. [NVidia Settings](#nvidia)
7. [NVidia LHR](#lhr)
8. [Wrap up](#wrap)

<br />
### Choosing an OS {#OS}

I am currently running two dedicated mining rigs, along with a laptop and a file server where mining is secondary.  I have an extensive Linux background, so my OS of choice is [Ubuntu](https://ubuntu.com/).  My file server is 7 or 8 years old and running Window 8.1.  I have heard good things about [HiveOS](https://hiveos.farm/) but I've also read about times where Hive itself was down.  I don't have any experience using Hive, but if system administration isn't something you're comfortable with, it is worth checking out if you plan on running dedicated mining rigs.  There is some costs associated with it if you run more than one rig, but it seems minimal.  Check their website for more information.

Most people are comfortable with Windows.  The latest and greatest AMD and NVidia drivers are available and there usually aren't any issues using them.  [MSI Afterburner](https://www.msi.com/Landing/afterburner/graphics-cards) is arguably the best GPU tweaking software available and it's only available for Windows.  You can modify GPU speeds, RAM speeds, voltages, fan speeds, and power limits.  You can save different profiles and have one auto-load on Windows startup.  That piece of software alone is a good reason to choose Windows.  Even those with limited sys admin experience can comfortably use it.  

While Windows is good option overall, I just wouldn't buy it.  If it came with your PC?  Sure.. but otherwise, spend that money on something else.  I personally chose Ubuntu for my rigs.  Ubuntu is completely free.  You will need some sys admin experience (and/or a willingness to learn) if you want to get the most out of your rig but hopefully this guide helps you get there.

No matter which OS you choose, you want a few things to be setup.  

The first is that your mining software starts on OS boot.  In Ubuntu, click on "Activities" and search for "startup".  You can add your commands to be run at startup there.  I use "xterm -e" followed by the command to start my miners at boot.  Windows has a [Startup Folder](https://helpdeskgeek.com/windows-10/how-to-access-the-windows-10-startup-folder/) that you can use to tell Windows to start whatever software you want to start at boot time.

_You may also want to set your BIOS to boot after power restore.  Check your motherboard manual for information on how to enable that feature._

The second thing you will want is remote access to your rigs.  Nothing causes me more heartburn than being hours from home and getting a notification that one of my rigs went down.  I start calculating just how much revenue I'll miss out on until I get back home!  Don't let that happen to you! 

For remote access, there are a couple of options to chose from.  This isn't an exhaustive list by any means, but they all are popular.

* Windows has [Remote Desktop](https://support.microsoft.com/en-us/windows/how-to-use-remote-desktop-5fe128d5-8fb1-7a23-3b8a-41e636865e8c) available depending on the verison you have.  
* [Chrome Remote Desktop](https://remotedesktop.google.com/?pli=1) is an option no matter if you are running Windows or Linux.  
* [TeamViewer](https://www.teamviewer.com/) is another great option.  They have a client for Windows, Linux, Raspberry Pi, Android, iOS, Mac, and Chrome OS.  It's free for personal use but you will need a license for commercial use.
* [Ubuntu Remote Desktop](https://ubuntu.com/tutorials/access-remote-desktop#1-overview) is a built in remote desktop capability in Ubuntu through [Remmina](https://remmina.org/)

<br />
Lastly, [these smart plugs](https://www.amazon.com/BN-LINK-Monitoring-Function-Compatible-Assistant/dp/B07CVPKD8Z/) can be life savers if you can't get remote access.  They allow you to remotely kill power to any of these plugs and then turn them back on.  It's an *absolute* last resort but it really can be a life saver if you can't get to your rig.

### Hardware Choices {#hardware}

One thing that is important to note about GPU mining is that you don't need expensive base hardware to have a high performing rig.  The motherboard needs PCIe slots for GPU cards and you will need the right power supplies, but that's about it for requirements.  My two dedicated rigs are vastly different.  One has an [ASRock H110 Pro BTC+](https://www.asrock.com/microsite/H110ProBTC+/) motherboard with a [7th Gen Intel Celeron](https://www.amazon.com/gp/product/B01MYTY55V/ref=ppx_yo_dt_b_search_asin_title?ie=UTF8&psc=1) and 16 GB RAM.  My second rig is "beefier" with a [ASUS ROG Crosshair VIII Dark Hero](https://rog.asus.com/us/motherboards/rog-crosshair/rog-crosshair-viii-dark-hero-model/) motherboard, an [AMD 5950x](https://www.amd.com/en/products/cpu/amd-ryzen-9-5950x) CPU and 64 GB RAM.  The ASRock has 13 PCIe slots while the ASUS only has 4 PCIe slots.  You can buy PCIe Splitters like this [one](https://www.amazon.com/Splitter-External-Adapter-Multiplier-Bitcoin/dp/B092R64W2V/ref=sr_1_3?crid=5I5E5SIWVBWN&keywords=pcie+splitter&qid=1637865056&sprefix=pcie+%2Caps%2C160&sr=8-3) but know that your motherboard may simply have a limit on the number of GPUs it can support.  For the ASUS, I can run 6 GPUs without a problem, even run 4 on that PCIe splitter if I wanted to.  The moment I try to add a 7th GPU, the rig won't post.  I tried everything I could think of but eventually gave up. 

I have an older Intel Core 2 Quad Core Q6600 (which came out in 2007) PC that still works.  It has 3 PCIe slots.  I actually did use it for a little while and it worked just fine.  So keep that in mind when figuring out your base hardware.  You don't need anything special unless you want to do other things with it while GPU mining.

When trying to figure out what power supply to buy, cheaper is NOT always better.  Platinum and Titanium PSUs are more expensive than Gold and Bronze PSUs, but they more efficient with their power consumption (leading to a lower electricity bill!).  When calculating what size PSU you need, I recommend dropping the max PSU wattage to 80%.  So that 1600 watt PSU you are eyeing?  Load it with no more than 1280 watts.  Two PSUs that I recommend and use are:

* [Corsair HX1200](https://www.amazon.com/CORSAIR-HX1200-Platinum-Certified-Modular/dp/B01MZ8A8NW/)
* [EVGA P2 1600](https://www.amazon.com/EVGA-Supernova-Platinum-Crossfire-220-P2-1600-X1/dp/B00NJG61JQ/)

<br />
Finding GPUs at MSRP can be extremely difficult.  The [Zotac Store](https://www.zotacstore.com/) has GPUs from time to time.  You can get in-stock alerts from a couple of Twitter and Discord accounts.  My favorite is [SnailMonitor](https://twitter.com/SnailMonitor).  No matter what, make sure you understand what you're buying and what your expected return is.  Read up on [What to Mine](https://whattomine.com/gpus) and have an idea of what GPUs you are willing to buy.  If you get an alert that GPUs are in stock, you usually only have a handful of seconds to make the purchase.  I also recommend signing up for the [NewEgg Shuffle](https://www.newegg.com/product-shuffle).  The chances you are selected are low, but possible.  I've actually been selected 3 times since early May but I enter every shuffle, every day they have one.

### Choosing a Miner {#chooseminer}

[NBMiner](https://github.com/NebuTech/NBMiner), [T-Rex](https://github.com/trexminer/T-Rex/releases), [Phoenix Miner](https://bitcointalk.org/index.php?topic=2647654.0), [TeamRedMiner](https://github.com/todxx/teamredminer/releases), and [GMiner](https://github.com/develsoftware/GMinerRelease/releases) are some of the more popular options to choose from.

| Miner   |   NVidia Support   |   LHR Support   |   AMD Support   |   ETHash Fee   | 
| :---- | :----: | :----: | :----: | :----: |
| NBMiner | X | X | X | 1% |
| T-Rex | X | X | - | 1% |
| Phoenix Miner | X | - | X | .65% |
| TeamRedMiner | - | - | X | .75% to 1 % |
| GMiner | X | X | X | .65% |

<br />
I use Phoenix Miner and T-Rex.  One of my rigs has NVidia and AMD GPUs.  My AMD GPUs are all PowerColor 5700 XTs.  Occasionally, one of the AMD GPUs will get into a weird state that eventually causes that rig to crash.  I did write a Perl script to email me updates every 6 hours and watch for any issues with the AMD GPUs (you can download them here-> [Phoenix Miner Watch](/tools/phoenix-watch.pl), [T-Rex Miner Watch](/tools/trex-watch.pl)).  Basically, the MH/S rate will jump over 1000%.  That's obviously not right.. so when my script sees that, it emails me and then reboots my rig.  I haven't tried TeamRedMiner, but I should try it to see if the AMD crashes are Phoenix related or GPU related.  I'll say that I've NEVER had an NVidia card crash on me using Phoenix Miner.  You can use a config file with Phoenix Miner but I simply pass everything on the command line through a script. One of my scripts looks like this:

{% include code_header.html %}
{% highlight bash %}
#!/bin/bash

sudo /opt/phoenix/nvidia-settings.sh
(sleep 300; perl /opt/phoenix/watch.pl) &

/opt/phoenix/PhoenixMiner -pool ssl://us1.ethermine.org:5555 -wal 0xXXXXXXXXXXXXXXXXXXXXXX -worker phoenix01 -mi 14 -epsw x -coin eth -mode 1 -nvidia -proto 3 -log 1 -logdir /opt/phoenix/logs -leaveoc -nvdo 1 -nvNew 1 -nvKernel 3 -prate .1104 -pool2 ssl://eu2.ethermine.org:5555 -cdmport 3333 -eres 6 -lidag 1 -config /opt/phoenix/config.txt -gpus 1,2,3
{% endhighlight %}

<br />
For my three Nvidia 3080 LHRs, I use T-Rex.  I get really good hashrates compared to expected (72 to 76 MH/s).  Lower the mining intensity if you are frequently running into LHR locks.  My T-Rex script looks like this:

{% include code_header.html %}
{% highlight bash %}
#!/bin/sh

sudo /opt/trex/nvidia-settings.sh

(sleep 300; perl /opt/trex/twatch.pl) &

mkdir /opt/trex/logs/archive
mv -nv -- /opt/trex/logs/trex.log /opt/trex/logs/archive/trex-$(date +'%Y%m%d_%H%M%S').log
rm -f /opt/trex/logs/*.log

/opt/trex/t-rex -a ethash --url stratum+ssl://us1.ethermine.org:5555 --user 0xXXXXXXXXXXXXXXXXXXXXXX -p x -w trex01 --log-path /opt/trex/logs/trex.log --no-watchdog --send-stales -d 3,4,5 --kernel 0 --lhr-tune 74,74,74 --lhr-autotune-mode full --coin eth --intensity 15.5,15.5,22.1
{% endhighlight %}

<br />
You'll ultimately need to determine for yourself which miner to use but I would recommend Phoenix Miner and T-Rex.

### Choosing a Pool {#choosepool}

Mining pools each have their own fee associated with them as well.  I've only every used [Ethermine.org](https://ethermine.org/).  Ethermine allows for payouts over the Ethereum network and the Polygon network.  The Polygon network has less fees for payouts and should be used by miners with lower hashrates (saves you transaction fees!).  There are a number of options you could choose from for pools.  For a total overview, checkout [PoolWatch.io](https://www.poolwatch.io/coin/ethereum).  For an explanation of payout modes (such as PPLNS and PPS), check out this [article](https://coinguides.org/pps-vs-pplns/).  Whichever pool you choose, make sure to choose their server that you have the lowest ping to!  It may not be the one that is geographically closest to you.  The faster your connection to the pool, the less likely that your shares would be considered stale.

Some of the more popular pools include:

| Pool   |  Payout Mode |  Mining Fee  | MEV Bonus |
| :---- | :----: | :----: | :----: |
| [Ethermine](https://ethermine.org/) | PPLNS | 1% | 100% |
| [Hiveon](https://hiveon.net/) | PPS+ | 0% | 90% |
| [Nanopool](https://nanopool.org/) | PPLNS | 1% | [Unclear](https://help.nanopool.org/article/47-faq) |
| [2Miners](https://2miners.com/) | PPLNS | 1% | 100% |
| [Flexpool](https://www.flexpool.io/) | PPLNS | .5% | 90% |

<br />

### AMD Settings {#amd}

I did have trouble with the AMD drivers and Ubuntu, major issues.. but I eventually worked it out.  I had to use an older kernel, 5.4.0-26, and slightly older AMD drivers, 20.40.  At one point I tried updating but I couldn't find the right combo to work, so I gave up.  I know that other people have been able to get newer AMD drivers to work but I haven't seen a performance difference between their GPUs and mine.  So take that for what it's worth.  If you want to modify AMD settings in Ubuntu, it's just not as straight forward as Windows.  AMD's Radeon software for Windows is fantastic for managing your GPU speeds and voltage.  (You can also use MSI Afterburner).  Since I really didn't get the results I wanted trying to over/underclock my AMD GPUs in Ubuntu, I decided to mod their BIOS.  Before doing that, I recommend trying to mod them through the OS.  [This](https://www.igorslab.de/en/amd-graphics-cards-under-linux-overclock-or-modify-goes-also/) is a good place to start.

Modifying the BIOS on a GPU can be nerve-racking. If you mess it up, you could brick your GPU and we all know how expensive GPU's are today.  The PowerColor 5700 XTs I bought have a BIOS switch.  One BIOS is the "normal" BIOS and the second is tweaked for performance by PowerColor.  I used the [Red Bios Editor](https://www.igorslab.de/en/red-bios-editor-and-morepowertool-adjust-and-optimize-your-vbios-and-even-more-stable-overclocking-navi-unlimited/) and Windows to create a BIOS for my AMD cards.  I dropped the GPU to 1400 MHz, bumped the memory to 885 MHz (gets multiplied by 2), and set the voltage to 900.  That configuration held for all 6 of my GPUs.  Now that they are flashed, I don't have to worry about any OS or miner OC settings.  They just boot exactly how I want them to run.

### NVidia Settings {#nvidia}

For NVidia, I had no problems configuring Ubuntu to over/underclock my GPUs.  If you are using Windows, it's even easier.  Use MSI Afterburner and sleep like a baby.  For Ubuntu, you need to do a couple of things.

Create an X11 configuration that contains your NVidia card information.  My NVidia entries look like this:

{% include code_header.html %}
{% highlight bash %}
Section "Monitor"
    Identifier     "NvidiaMonitor1"
    VendorName     "Unknown"
    ModelName      "Unknown"
    Option         "DPMS"
EndSection

Section "Device"
    Identifier     "NvidiaDevice1"
    Driver         "nvidia"
    Option         "TripleBuffer" "true"
    Option         "ConnectToAcpid" "0"
    Option         "Coolbits" "28"
    BusID          "PCI:04:0:0"
    VendorName     "NVIDIA Corporation"
EndSection

Section "Screen"
    Identifier     "NvidiaScreen1"
    Device         "NvidiaDevice1"
    Monitor        "NvidiaMonitor1"
    Option         "Coolbits" "28"
    Option         "ConnectedMonitor" "DFP"
    Option         "UseConnectedDevice" "DFP-0"
    Option         "AllowEmptyInitialConfiguration"  "True"
    DefaultDepth    24
    SubSection     "Display"
        Depth       24
    EndSubSection
EndSection
{% endhighlight %}

<br />
You need the "Coolbits" and "AllowEmptyInitialConfiguration" options under "Screen" and you need to set the "BusID" under "Device".  To get the Bus ID, run the following:

{% include code_header.html %}
{% highlight bash %}
lspci -k | grep VGA
{% endhighlight %}

<br />
The output should look like this:
{% include code_header.html %}
{% highlight bash %}
00:02.0 VGA compatible controller: Intel Corporation HD Graphics 610 (rev 04)
03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 [Radeon RX 5600 OEM/5600 XT / 5700/5700 XT] (rev c1)
04:00.0 VGA compatible controller: NVIDIA Corporation Device 2206 (rev a1)
05:00.0 VGA compatible controller: NVIDIA Corporation Device 2204 (rev a1)
06:00.0 VGA compatible controller: NVIDIA Corporation Device 2204 (rev a1)
07:00.0 VGA compatible controller: NVIDIA Corporation Device 2204 (rev a1)
0a:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 [Radeon RX 5600 OEM/5600 XT / 5700/5700 XT] (rev c1)
0d:00.0 VGA compatible controller: NVIDIA Corporation Device 2204 (rev a1)
10:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 [Radeon RX 5600 OEM/5600 XT / 5700/5700 XT] (rev c1)
11:00.0 VGA compatible controller: NVIDIA Corporation Device 2204 (rev a1)
12:00.0 VGA compatible controller: NVIDIA Corporation Device 2204 (rev a1)
15:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 [Radeon RX 5600 OEM/5600 XT / 5700/5700 XT] (rev c1)
18:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 [Radeon RX 5600 OEM/5600 XT / 5700/5700 XT] (rev c1)
1b:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 [Radeon RX 5600 OEM/5600 XT / 5700/5700 XT] (rev c1)
{% endhighlight %}

<br />
The first part of that output identifies the Bus ID.  Note that "lspci" outputs the Bus ID in hex form, while the Bus ID has to be decimal in the X11 file.  So "04:00.0" turns into "PCI:04:0:0" while "12:00.0" turns into "PCI:18:0:0".  If you arent good doing the conversions in your head, [this website](https://www.binaryhexconverter.com/hex-to-decimal-converter) is extremely valuable!

Now that you have your X11 file setup, you can start messing with your GPU settings.  I have a bash script for each miner and rig.  Here is one of my scripts with one Nvidia 1080 and 2 Nvidia 3090s.

{% include code_header.html %}
{% highlight bash %}
#!/bin/bash

sudo nvidia-smi -pm 1

sleep 3

# PNY 1080
# Nvidia Settings GPU 1
# Nvidia SMI GPU 0
nvidia-settings -c :0 -a [gpu:1]/GPUPowerMizerMode=1 &
sudo nvidia-smi -i 0 -pl 155
nvidia-settings -c :0 -a [gpu:1]/GPUGraphicsClockOffsetAllPerformanceLevels=50 &
nvidia-settings -c :0 -a [gpu:1]/GPUMemoryTransferRateOffset[2]=1100 &
nvidia-settings -c :0 -a [gpu:1]/GPUMemoryTransferRateOffset[3]=1100 &

# EVGA 3090
# Nvidia settings GPU 2
# Nvidia SMI GPUI 1
nvidia-settings -c :0 -a [gpu:2]/GPUPowerMizerMode=1 &
sudo nvidia-smi -i 1 -pl 300
nvidia-settings -c :0 -a [gpu:2]/GPUGraphicsClockOffsetAllPerformanceLevels=0 &
nvidia-settings -c :0 -a [gpu:2]/GPUMemoryTransferRateOffset[3]=2300 &
nvidia-settings -c :0 -a [gpu:2]/GPUMemoryTransferRateOffset[4]=2300 &

# Zotac 3090
# Nvidia settings GPU 3
# Nvidia SMI GPUI 2
nvidia-settings -c :0 -a [gpu:3]/GPUPowerMizerMode=1 &
sudo nvidia-smi -i 2 -pl 305
nvidia-settings -c :0 -a [gpu:3]/GPUGraphicsClockOffsetAllPerformanceLevels=0 &
nvidia-settings -c :0 -a [gpu:3]/GPUMemoryTransferRateOffset[3]=2200 &
nvidia-settings -c :0 -a [gpu:3]/GPUMemoryTransferRateOffset[4]=2200 &
{% endhighlight %}

<br />
You will use "nvidia-smi" to control the maximum power draw for a GPU and use "nvidia-settings" to control the GPU and RAM speeds.  Note that "nvidia-smi" and "nvidia-settings" have different references for the same GPU.  My 1080 is listed as GPU 1 for nvidia-smi and 0 for nvidia-settings.  Simply running "nvidia-smi" will list out all of your GPUs and their reference.  Run "nvidia-settings" to pull up the settings GUI and note the GPUs and their reference within nvidia-settings.

Each card behaves slightly different and your results may not match mine, but here are some of my settings.

| GPU | GPU Offset | RAM Offset | Power Limit | Avg MH/s |
| :---- | :----: | :----: | :----: | :----: |
| PNY 1080 | +50 MHz | +1100 MHz | 155 watts | 32 MH/s |
| PowerColor 5700xt | =1400 MHz | =885 MHz | 100 watts | 54.5 MH/s |
| Gigabyte 3080 | +200 MHz | +1100 MHz | 155 watts | 35 MH/s |
| Zotac 3080 LHR | +0 MHz | +2700 MHz | 230 watts | 74 MH/s | 
| Zotac 3090 OC | +0 MHz | +2100 MHz | 295 watts | 119.5 MH/s |
| MSI 3090 Gaming X Trio | +0 MHz | +2200 MHz | 305 watts | 121 MH/s |
| EVGA 3090 FTW3 Ultra | +0 MHz | +2200 MHz | 310 watts | 121 MH/s |
| Gigabyte Vision 3090 | +0 MHz | +1700 MHz | 310 watts | 35 MH/s |

<br />
### NVidia LHR {#lhr}

The NVidia LHR GPUs do need some special handling.  I've had good success with T-Rex.  In order to get the best performance, I let T-Rex auto-tune the LHR value up and down as needed but I did modify the mining intensity (MI) for each of my cards.  I found that the mining intesity was the key to limiting the number of locks that a GPU would encounter.  If a GPU locks, it stops mining for 20 seconds.  Over time, that'll have a drastic negative effect on your overall mining rate.  One of my cards I can run at a MI 22.1.  Another one of my cards will hit a lock every couple minutes if I have the MI set at 22.1.  After setting it to 15.5 though, I've had 1 lock over 8 days.  It's actually running at the same speed as the GPU with a 22.1 MI and has 42 more shares over nearly 8 days.  So while it might seem counter-intuitive to lower the MI to get better performance, that is the case here.  You will need to try different settings for your cards, but don't just settle for the default!

### Wrap up {#wrap}

There's way more to GPU mining than I could put into one post, but hopefully a lot of your questions have been answered!  The ETH 2.0 merge will happen sometime in June or July of 2022 so you still have some time to mine Eth.  If you need help with anything, please feel free to reach out!

Happy mining!