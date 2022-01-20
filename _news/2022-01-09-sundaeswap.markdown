---
layout: post
title:  "SundaeSwap and Cardano 1.33 Update"
---
Big things are happening on the Cardano network in 2022.  There are a number of DEX's (Decentralized Exchanges) that are slated to be released this year.  Cardano released their smart contract capability with the Alonzo upgrade on Sept 12th, 2021.  There was a lot of controversy in the community when the details of the implementation came out.  Some people questioned why it took so long for Cardano to release this capability.  Others questioned choosing Plutus (based on Haskell) for the smart contract programming language and the [eUTXO](https://iohk.io/en/research/library/papers/the-extended-utxo-model/) transaction model.  The arguments were that Cardano was behind the curve by releasing this capability so "late", that Haskell isn't a well known programming language, and that the eUTXO model would limit blocks to one transaction, (basically making the network too slow to use).  IOHK, the main company behind Cardano, released a [statement](https://iohk.io/en/blog/posts/2021/09/10/concurrency-and-all-that-cardano-smart-contracts-and-the-eutxo-model/) pushing back against the naysayers.  

I don't think anyone would argue that smart contracts need to be secure and easily verifiable.  There have been a number of hacks on other crypto networks where the hacker exploited a smart contract to gain access to funds.  ([This hack](https://arstechnica.com/information-technology/2021/12/hackers-drain-31-million-from-cryptocurrency-service-monox-finance/) cost users $31 million USD.)  Haskell was chosen because it is a functional programming language.  Functional languages are a great choice for high-assurance software that needs to be easily verifiable.

eUTXO is an extension of the UTXO model which was originally used by Bitcoin.  The eUTXO model makes predicting the cost of executing a smart contract much easier than the Ethereum model.  If you used the Ethereum network, you know that there can be a big range of estimated cost for executing a transaction.  As a user, knowing the exact transaction cost up front makes the network more appealing.  IOHK further explained eUTXO to dispell some of the FUD:

<figure>
    <blockquote>
        <div class="quote-line-container">
            <p class="quote">DApps built on Cardano are not limited to one transaction per block. In fact, the block budget (that is the maximum number of transactions it can hold) allows the execution of hundreds of simple transactions and several complex scripts. However, the eUTXO model allows spending a transaction output only once. Given that users can face contention issues trying to access the same UTXO, it is important to use many different UTXOs. Note that this is important unless such a design would benefit from a strict ordering of clients. Sets of UTXOs can be used to implement design patterns that include semaphores. In addition, different users can interact with one smart contract without any concurrency failure. That is because a smart contract can handle a number of different UTXOs that make up its current state and off-chain metadata that allows interpreting those UTXOs.</p>
        </div>
    </blockquote>
    <figcaption style="float:right !important"><cite style="font-size:24px !important">-IOHK</cite></figcaption>
</figure>
<br />
<br />

### SundaeSwap ###
Arguably, the most highly anticipated Cardano DEX is [SundaeSwap](https://sundaeswap.finance/){:target="_blank"}.  SundaeSwap [released to the Cardano TestNet](https://sundaeswap-finance.medium.com/lets-sample-some-flavors-sundaeswap-testnet-announcement-7c160f0ded99){:target="_blank"} on Dec 5th, 2021.  The team conducted a mainnet load test on Dec 18th and recently released an [update](https://sundaeswap-finance.medium.com/expectations-congestion-mainnet-launch-e9da5abfd819){:target="_blank"} regarding their upcoming mainnet release.  

First impressions can be lasting impressions.  During their testnet phase, they have been working with IOHK to refine the network protocols.  Their Dec 18th mainnet load test revealed some potential network delays and issues.  While it's impossible to predict the exact load SundaeSwap will put on the Cardano network, given the amount of attention the project has garnered, I wouldn't be suprised if there were some bumps after it's rolled out. The SundaeSwap team also [agrees](https://sundaeswap-finance.medium.com/expectations-congestion-mainnet-launch-e9da5abfd819){:target="_blank"}:

<figure>
    <blockquote>
        <div class="quote-line-container">
            <p class="quote">Even with all these factors in play, due to staggering levels of demand and excitement from our community, we expect a large backlog on mainnet as well — even under our most optimistic predictions. To be as transparent as we can, we want to inform you all that while orders (including swapping, providing liquidity and withdrawing liquidity) may take days to process, everybody’s orders will be processed fairly and in the order they were received and executable. It will also be possible to cancel orders at any time before they are processed by the Scoopers.<br>
            Although we expect this backlog during the first days of the protocol, we’re very confident that the protocol can meet the normal day-to-day load once things settle down. Given the size of our community and the excitement around our launch, this initial swell of activity is inevitable. As we saw with the testnet, once the Scoopers burn through any large surges and the backlog, orders for common pools should execute within a few blocks.
            </p>
        </div>
    </blockquote>
    <figcaption style="float:right !important"><cite style="font-size:24px !important">-SundaeSwap Labs</cite></figcaption>
</figure>
<br />
<br />

### Cardano Node 1.33.0 Update ###
In anticipation of network growth from SundaeSwap and other DEX's, IOHK has been working on performance related changes.  [Release 1.33.0](https://github.com/input-output-hk/cardano-node/releases/tag/1.33.0){:target="_blank"} is a performance focused release that was delivered on Jan 7th.  They have reduced memory usage (which I did see after updating the [4WARD](https://4wardpool.swiftcryptollc.com){:target="_blank"} pool) and brought significant improvements to the sync time and block propogation time.  It's a positive step towards the potential explosion of transactions on the network once SundaeSwap and other DEX's get released on Cardano's mainnet.
<br />
<br />

### Looking to the Future ###
2022 has the potential to bring massive growth to the Cardano network if they can successfully navigate the deployment of SundaeSwap and the other upcoming DEX's.  If needed, the configurable nature of their network should allow them to move fairly quickly to address any issues that pop up.  IOHK has moved slowly through their development process and a lot of people have disagreed with that approach over the years.  Generally speaking, it isn't considered a good "business" move, but it may prove to have been the right decision.  What happens during 2022 should answer that question once and for all.