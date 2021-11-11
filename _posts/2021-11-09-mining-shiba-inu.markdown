---
layout: post
title:  "Mining Shiba Inu"
date:   2021-11-09 11:17:00 -0500
---
You can mine SHIB on just about any CPU with XMRig (results will vary of course) and [Unmineable](https://www.unmineable.com/). It's not very profitable, but if you are already running servers then you might as well give them something else to do!

Your first step is to download [XMRig](https://github.com/xmrig/xmrig/releases).

You'll also need to setup an Ethereum based wallet.  I always recommend getting a hardware wallet like a [Ledger Nano X](https://shop.ledger.com/products/ledger-nano-x).  Some software wallets include [Metamask](https://metamask.io/) and [Coinbase](https://wallet.coinbase.com/).  You can connect your hardware wallet to both of those wallets.  Here are [instructions](https://www.ledger.com/academy/security/the-safest-way-to-use-metamask) on connecting Metamask to a Ledger hardware wallet.

After setting up XMRig and your wallet, you'll want to tweak your OS settings to enable [Hugepages](https://xmrig.com/docs/miner/hugepages).  It'll offer a significant performance boost.

Now you are ready to create a script to run XMRig.

Windows: (Run it as admin to enabling huge pages)
{% include code_header.html %}
{% highlight bash %}
@echo off

C:\opt\xmrig-dir\xmrig-6.15.2\xmrig.exe --cpu-affinity 0xFF -o rx.unmineable.com:3333 -u SHIB:0xABCDEFGHIJKLMNOPQRSTUVWXYX1234567890.worker1#vumh-d27t -p x -k --hugepage-size=1280 --huge-pages-jit --threads=8

pause
{% endhighlight %}
<br />

Linux:
{% include code_header.html %}
{% highlight bash %}
/opt/xmrig/xmrig --cpu-affinity 0xFF -o rx.unmineable.com:3333 -u SHIB:0xABCDEFGHIJKLMNOPQRSTUVWXYX1234567890.worker1#vumh-d27t -p x -k --hugepage-size=1280 --huge-pages-jit --threads=8 --randomx-1gb-pages
{% endhighlight %}
<br />

Replace
"0xABCDEFGHIJKLMNOPQRSTUVWXYX1234567890.worker1" with your SHIB (ERC20/ETH) wallet address and change "worker1" to your worker name (can be whatever you want).

The "vumh-d27t" is my referral code.  It will set your fee to .75% instead of 1%. Small difference, but it'll add up over time.

Change the location of the XMRig executable file based on where you installed it, and change "threads" to however many CPUs you have. Note that sometimes it'll run better if you don't use all of your available CPUs. Press "h" to check the CPU speeds. Try 50%, 75%, 90%, and 100% of your available CPUs (including threads) to find the sweet spot for your CPU. 

Once you start mining, go to [Unmineable/SHIB](https://www.unmineable.com/coins/SHIB/address) and enter your ETH/ERC20 public wallet address to track your earning!

Happy mining!
