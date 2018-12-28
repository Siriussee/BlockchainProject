# 区块链技术-期末项目-报告

- [区块链技术-期末项目-报告](#区块链技术-期末项目-报告)
    - [项目成果展示](#项目成果展示)
        - [演示视频](#演示视频)
        - [截图说明](#截图说明)
            - [UI界面组件概述](#ui界面组件概述)
            - [发现动物](#发现动物)
            - [与动物互动](#与动物互动)
            - [购买动物](#购买动物)
                - [开始竞标](#开始竞标)
                - [投标](#投标)
                - [揭露标书](#揭露标书)
                - [竞标取胜与收养](#竞标取胜与收养)
            - [弃养](#弃养)
    - [环境](#环境)
    - [文件结构](#文件结构)
    - [App 部署](#app-部署)
    - [项目背景](#项目背景)
    - [项目说明](#项目说明)
    - [后端接口](#后端接口)
        - [数据存储与数据结构](#数据存储与数据结构)
        - [状态更新接口说明](#状态更新接口说明)
        - [匿名投标接口设计](#匿名投标接口设计)
        - [接口测试](#接口测试)
            - [tuffle test](#tuffle-test)
    - [前端界面](#前端界面)
        - [合约的部署](#合约的部署)
        - [事件监听机制](#事件监听机制)
        - [后端函数调用](#后端函数调用)
        - [使用 MetaMask](#使用-metamask)
    - [BUG 分析](#bug-分析)
    - [参考资料](#参考资料)


## 项目成果展示

[GitHub传送门](https://github.com/Siriussee/BlockchainProject)

### 演示视频

如果想略过冗长的图片文字，直接观看这个 DApp 功能演示，请选择观看演示视频。视频时长6分钟。

[演示视频传送门](http://f.cangg.cn:81/data/2018122719251355360178.mp4)

> 上一次外链可靠性检测时间：2018-12-28 12:00

### 截图说明

#### UI界面组件概述

![201812271955366955.png](https://f.cangg.cn:82/data/201812271955366955.png)

#### 发现动物

![201812271955595337.png](https://f.cangg.cn:82/data/201812271955595337.png)
![201812271956519536.png](https://f.cangg.cn:82/data/201812271956519536.png)

#### 与动物互动

![201812271957101181.png](https://f.cangg.cn:82/data/201812271957101181.png)
![201812271957231343.png](https://f.cangg.cn:82/data/201812271957231343.png)

这里可以明显发现有 BUG 的存在，我会在报告的后半部分[BUG 分析](#bug-分析)中详细讨论这个问题。

![201812271957365615.png](https://f.cangg.cn:82/data/201812271957365615.png)

#### 购买动物

##### 开始竞标

![201812271958269393.png](https://f.cangg.cn:82/data/201812271958269393.png)
![201812271958413533.png](https://f.cangg.cn:82/data/201812271958413533.png)

##### 投标

![201812271958565556.png](https://f.cangg.cn:82/data/201812271958565556.png)
![201812271959061928.png](https://f.cangg.cn:82/data/201812271959061928.png)
![201812271959195178.png](https://f.cangg.cn:82/data/201812271959195178.png)

##### 揭露标书

![201812271959315568.png](https://f.cangg.cn:82/data/201812271959315568.png)
![201812271959448089.png](https://f.cangg.cn:82/data/201812271959448089.png)
![201812272000009218.png](https://f.cangg.cn:82/data/201812272000009218.png)

##### 竞标取胜与收养

![201812272000162631.png](https://f.cangg.cn:82/data/201812272000162631.png)
![201812272000483502.png](https://f.cangg.cn:82/data/201812272000483502.png)
![201812272001005833.png](https://f.cangg.cn:82/data/201812272001005833.png)
![201812272001125356.png](https://f.cangg.cn:82/data/201812272001125356.png)

#### 弃养

![201812272001225287.png](https://f.cangg.cn:82/data/201812272001225287.png)
![201812272001321414.png](https://f.cangg.cn:82/data/201812272001321414.png)

全部功能测试完毕。

## 环境

本次项目使用 Linux 作为以太坊节点和 web server，在 Windows 下完成代码编写和测试。

- OS: Ubuntu 16.04 LTS server
- node: v8.13.0
- npm: 6.4.1
- web3js: web3@0.20.7
- testRPC: EthereumJS TestRPC v6.0.3 (ganache-core: 2.0.2)
- Truffle: Truffle v4.1.14
- compiler: 0.4.23-nightly.2018.4.17+commit.5499db01.Emscripten.clang
- Web Server: Caddy 0.11.1

## 文件结构

- `index.html` App的前端交互界面
- `main.css` index的css样式表
- `AnimalInteration.sol` 智能合约的源码
- `img*.jpg` 前端中使用的图片

以防外链失效，测试视频和截图也一并上传至 `test_backup/`

## App 部署

如果想要在远程环境运行测试，至少需要安装对应版本的上述环境的`node` `npm` `testRPC` `Caddy`，然后进行如下操作：

```shell
# SERVER SIDE: run testrpc
testrpc
```

在 [Remix](http://remix.ethereum.org) 选择 `0.4.23-nightly.2018.4.17+commit.5499db01.Emscripten.clang` 版本的编译器，部署到 web3 provider http://your_server_ip:8545 上。


```shell
# in another shell
cd path/to/index.html
# set tha address of AnimalInteration in index.html:569
# run webserver
caddy
# visit  to test the app
```

访问 http://your_server_ip:2015 开始测试这个app。

如果在本地环境运行测试，可以省略 caddy webserver 的步骤。

## 项目背景

中山大学东校区的宿舍区有很多流浪动物，惹人怜爱的同时也造成了很多问题：

- 传播疾病和寄生虫，
- 捕杀鸟类等小动物，
- 随地大小便破坏校园环境。

诸如此类的问题对校园环境和卫生造成了极大的影响。因此，我们亟需一个合理而有效的系统，将同学们对流浪小动物的爱心整合起来，形成一个完整的流浪动物溯源和收养系统 Animal Interaction，解决校园流浪动物缺乏有组织的管理的问题。

## 项目说明

Animal Interaction 项目是一个基于以太坊的，实现了流浪动物认养，流浪动物追踪和互动功能的 DApp。用户可以通过在web界面记录自己看到的流浪动物，发现并上传新的流浪动物，并将这些交互都记录到区块链中。本 DApp 会将全部用户的交互记录整合为单个动物的 Action Log，从而实现流浪动物的追踪溯源功能。此外，用户还可以在本 DApp 中对心仪的动物进行竞标，由智能合约的特点为竞标的真实性和可靠性担保，实现去中心化的匿名招标投标机制。

## 后端接口

智能合约内容详见 `AnimalInteration.sol`.

### 数据存储与数据结构

流浪动物的档案，包括其发现，以及状态更新，都以 `event` 的形式记载在区块链上，其数据组成如下：

```solidity
event animalInfo (
    bytes32 indexed animalId,   //动物的ID，由姓名和时间戳通过哈希生成，独一无二
    bytes32 indexed animalName, //动物姓名，由发现者命名
    address indexed founder,    //发现者的钱包地址
    uint birthDate,             //发现动物的日期
    uint lastSeen,              //上次观察到该动物的日期
    bytes32 location,           //上次观察到动物的地址字符串
    bool isAdopted,             //收养状态：被收养=True; 流浪=false
    address adopter,            //收养者钱包地址，如果流浪中则为address(0)
    bool isAlive,               //是否存活
);
```

由于区块链系统存储需要消费大量的gas，因此使用 `event` 将基本信息存放在 log 中以节省开销。

此外，由于区块链的不可篡改特性，每次更新状态只能进行增量更新而不可 `insert or update`，故每次更新都是新写入一个event。这个特性在带来缺点的同时也具有一个优点：用户可以根据 event 获取该动物从上链到如今全部的状态讯息，有利于流浪动物的收容管理和追踪溯源。

### 状态更新接口说明

我设计了如下几个接口来实现动物状态的更新：

发现动物。用户发现了新的流浪动物时，可以调用这个接口来插入一个新的动物 event。
```
function find(bytes32 name, bytes32 location) public{}
```

看见动物。流浪动物会被许多人看见。当有用户看见动物时，他们可以调用此接口更新动物的信息。
```
function see(event animal) public{}
```

出售动物。可能有用户想要弃养收养的动物，可以调用这个接口，使其收养状态重新变化为流浪，同时可以进行竞标购买。 
```
function sell(event animal) public{}
```

竞标动物。调用这个接口，对可收养的动物进行投暗标（hashCode），在一定时间后以价高者得的模式购买此动物。
```
function buy(event animal, bytes32 hashCode) public{}
```

交付动物。竞拍结束后，调用这个接口，交付加密货币和动物，并且更新动物的收养信息。
```
function auctionEnd() public onlyAfter(biddingEnd + revealPending){}
```

### 匿名投标接口设计

先简单说明一下匿名投标的机制。

由于区块链系统上传的全部内容都是公开透明的，因此不能使用传统的方法实现匿名投标。因此，考虑使用加密技术对标书内容进行加密，并且使用哈希保证标书前后不会被篡改，从而实现一个分两步实现的匿名投标系统。具体流程如下：

0. 设置投标系统参数。确定竞标开始时间，竞标时间和暗标揭露时间。
1. 竞拍者投出标书。竞拍者不直接投出明文标书，而是先使用 `hashCode = keccak256(value, fake, secret)` 对标书的内容进行哈希，从而实现加密的功能。其中 `value` 是投标的价格，`fake` 是标志位，用于标记这个标书是否为真实的投标；`secret` 是投标人选择的密文，用于保证如果竞标失败，取回的依然是投标者本人。
2. 停止投标，揭露暗标。设定时间到达后，停止一切投标，投标人各自揭露自己的暗标：投标人将 `(value, fake, secret)` 的明文发送至区块链系统，智能合约调用 `keccak256(value, fake, secret)` 检验与 `hashCode` 是否一致：
    1. 一致且 `fake=false` ，则这个标书成立，进入价格比较环节
    2. 一致且 `fake=true`，是个假标书，直接退还这部分标书的费用
3. 价格比较。对符合条件的标书进行价格比较，将出价最高的价格及其用户钱包地址记录到 event 上。
4. 交付货款。交送动物，更新动物的收养信息，并且将数字货币转账到原收养人手中。

具体实现的函数接口如下：
```
constructor(uint _biddingTime, uint _revealPending, address _seller) public {} //合约构造函数，设置投标系统参数。
function buy(event animal, bytes32 hashCode) public{} //竞拍者投出标书
function reveal(uint[] _values, bool[] _fake, bytes32[] _secret)   public onlyAfter(biddingEnd){} //揭露暗标
function auctionEnd() public onlyAfter(biddingEnd + revealPending) {} //交付货款
``` 

### 接口测试

使用开发框架 `tuffle` 对智能合约的接口进行测试。

#### tuffle test

直接 `apt install nodejs` 是不行的（至少在ubuntu16.04），你会得到一个4.x的古董级别版本，根本装不了`tuffle`。 

使用PPA安装新版 NodeJs：

```bash
# instasll NodeJs
sudo apt install curl
curl -sL https://deb.nodesource.com/setup_8.x | sudo bash -
sudo apt install nodejs

# test NodeJs
node -v # failed
npm -v
```

node命令不存在，引起这个错误的主要的主要原因是Node.js在ubuntu上默认被装到了`/usr/bin/nodejs` 目录下，所以默认只能用`nodejs`来调用。使用文件链接解决：

```bash
sudo ln -s /usr/bin/nodejs /usr/bin/node
node -v # pass
```

安装 tuffle

```bash
sudo npm install -g truffle
```
打开一个示例项目，然后把里面要用的东西改成我的

```bash
mkdir Dapp
cd Dapp
truffle unbox metacoin
# mv file in /contracts and /test to make it myself
```

使用 `truffle` 对上述接口的实现进行测试。

## 前端界面

前端与智能合约交互的逻辑相见 `index.html`.

请注意，与是能合约的交互是基于 `web3js 0.20` 版本，其接口与 `1.0` 版本有着巨大的差异且完全不向兼容。

### 合约的部署

合约的部署理论上可以由前端完成，但是由于这个合约要求对各用户参加竞标，因此不适合在每次打开网页都部署一个新的合约。
最后，我使用 Remix 完成合约的部署。

从 Remix 处取得 `ABI` `ADDRESS_OF_CONTRACT` 两个参数。

连接到 `testRPC`:
```js
if (typeof web3 !== 'undefined') {
    web3 = new Web3(web3.currentProvider);
} else {
    // set the provider you want from Web3.providers
    web3 = new Web3(new Web3.providers.HttpProvider("http://192.168.142.129:8545"));
}
```

设置账户，合约ABI，合约实例地址：
```js
web3.eth.defaultAccount = web3.eth.accounts[0];
//personal.unlockAccount(web3.eth.defaultAccount) // no need
var AnimalInteration = web3.eth.contract(ABI)
var animalInteraction = AnimalInteration.at(ADDRESS_OF_CONTRACT);
```

### 事件监听机制

事件监听是实现溯源机制的关键。后端将事件以 `event` 的形式记录在区块链上，前端将监听，过滤，并把这些事件实时更新渲染到 HTML 上。

监听全部事件，调用 `contractInstance.allEvents([filterObj, ...])` 函数，可以实现对全部事件的获取，使用过滤器对象，可以实现条件过滤。如果过滤的是事件的字段的话，就可以实现分类过滤了。需要注意的一点是，过滤器只能过滤 `Indexed` 的字段，而一个事件最多只能有三个 `Indexed` 的字段，太贪心反而不好。

使用 JQuery 的 `watch()` 方法监听 `allEvent` 对象的变化。使用 callback 机制（`function(error, result){}`）对变化执行动态更新。

```js
var allEvent = animalInteraction.allEvents({ fromBlock: 0, toBlock: 'latest' });
//              ^^^ 合约实例       ^^ 表示监听全部事件   ^^^^^^^^^^^^^^^^^^^^ 事件发生的范围:全部
allEvent.watch(function(error, result){
    if (!error)	
    {
        data = data_handling(result)
        $("#event").append(data + '</br>');
        console.log(result);
    } else {
        console.log(error);
    }
```

监听单个事件，调用 `contractInstance.myEvent([filterObj, ...])`，可以针对一类（就是同名的）事件进行监听，其作用机制与上文完全相同。在这里，我将其用于对每个动物的追踪溯源信息，进行分离，获取，过滤和渲染。

```js
var CharlesEvent = animalInteraction.animalInfo({animalId: Charles.id}, { fromBlock: 0, toBlock: 'latest'});
CharlesEvent.watch(function(error, result){
    if (!error)	
    {
        data = data_handling(result)
        $("#Charles").append(data + '</br>');
        console.log(result);
    } else {
        console.log(error);
    }
})
```

### 后端函数调用

使用 JQuery，给按钮注册一个点击的事件，调用 `contractInstance.myfunc([args1,...], function(error, result){})`即可。有一个比较特殊的事情是，如果你使用了 MetaMask 的 `inpage.js` 的话，它会果断拒绝没有 callback 的调用，并且返回一个“这是为了你好”的 error（对，他*的直接返回一个error）。因此只要使用 MetaMask，请务必带上 callback。

```js
$("#endAuction").click(function() {
    animalInteraction.auctionEnd(Charles.id, Charles.name,
    Charles.founder, Charles.birth, Charles.location
    ,function(error, result){
        if(!error)
            console.log('end Auction' +result)
        else
            console.log('end error' + error)
    })
});
```

### 使用 MetaMask

MetaMask 主要嵌入了一个 `inpage.js` ，对交易确认和账户切换实现了一个比较和谐的 UI。

安装 MetaMask 插件，将 customRPC 设置为 `https://your_server_ip:8545` ，使用开启 testRPC 时出现的私钥或者 seed phrase 导入 MetaMask，就可以正常使用了。

## BUG 分析

显然的，我们在演示视频和截图中都发现出现了重复交易和重复事件的 BUG 存在。这个重复事件的问题会在刷新后清除，所以基本可以排除是由于编程的失误导致的问题。

搜寻 testRPC 的 [issue](https://github.com/trufflesuite/ganache-cli/issues/150) 后，我发现有人也和我产生了相同的问题。

其原因是 testRPC 是和小规模的测试以太坊系统，同一事件可能在短时间内被多个块挖出，而 `watch()` 对事件的监听是实时的，因此会同时发现许多重复事件。提问者提出的解决方法是添加 20ms 的延迟，即可使 testRPC 多个块变回一个；而开发者将这个问题标记为 `web3js0.x.x` 的问题，而 `webjs@1.0.0` 已经修复了这个问题。

## 参考资料

- [truffle pet shop](https://truffleframework.com/tutorials/pet-shop)
- [solidity safe remote purchase](https://solidity.readthedocs.io/en/v0.4.21/solidity-by-example.html#safe-remote-purchase)
- [web3js event filter](https://github.com/ethereum/wiki/wiki/JavaScript-API#web3ethfilter)
- [WHAT THE FxxK IS vm exception while processing transaction:revert](https://vmexceptionwhileprocessingtransactionrevert.com/)
- [Interacting-with-a-Smart-Contract-through-Web3.js](https://coursetro.com/posts/code/99/Interacting-with-a-Smart-Contract-through-Web3.js-(Tutorial))
- [Duplicate events firing in a Web3 listener issue](https://github.com/trufflesuite/ganache-cli/issues/150)
- [MetaMask just dont want any sync method](https://github.com/MetaMask/faq/blob/master/DEVELOPERS.md#dizzy-all-async---think-of-metamask-as-a-light-client)
- 我的聪明才智
- 我的肝

2018-12-28 凌晨