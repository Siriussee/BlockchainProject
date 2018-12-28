pragma solidity >=0.4.22 <0.5.0;

contract AnimalInteration {

    struct Bid {
        bytes32 blindedBid;
        uint deposit;
    }

    address public seller;
    uint public biddingStart;
    uint public biddingEnd;
    uint public biddingTime;
    uint public revealPending;
    bool public started;
    bool public ended;

    mapping(address => Bid) public bids;

    address public highestBidder;
    uint public highestBid;

    mapping(address => uint) pendingReturns;

    event AuctionStarted(
        address sender, 
        uint startTime
    );

    event AuctionEnded(
        address winner, 
        uint highestBid
    );

    event animalInfo (
        bytes32 indexed animalId,
        string animalName,
        address indexed founder,
        uint birthDate,
        uint lastSeen,
        string location,
        bool isAdopted,
        address indexed adopter,
        bool isAlive
    );

    modifier onlyBefore(uint _time) { 
        require(
            now < _time,
            "Cannot do before"
        );
        _; 
    }
    modifier onlyAfter(uint _time) { 
        require(
            now > _time,
            "Cannot do after"
        ); 
        _; 
    }

    constructor(
        uint _biddingTime,
        uint _revealPending,
        address _seller
    ) public {
        seller = _seller;
        biddingTime = _biddingTime;
        revealPending = _revealPending;
        started = false;
        ended = false;
    }

    // find a new animal
    function find(
        string animalName, 
        string currentLocation
    ) public{
        // use hash(name, address, now) to generate an ID which will not lead to repeat animal Id
        emit animalInfo(
            keccak256(animalName, now), 
            animalName, 
            msg.sender, 
            now, 
            now, 
            currentLocation, 
            false, 
            address(0), 
            true
        );
    }

    // see an existing animal
    function see(
        bytes32 id, 
        string name, 
        address founder, 
        uint birth, 
        string currentLocation, 
        bool isAdopted, 
        address Adopter, 
        bool isAlive
    ) public{
        //update lastseen state, location, or isAlive state
        emit animalInfo(id, name, founder, birth, now, currentLocation, isAdopted, Adopter, isAlive);
    }

    // selling an anmianl adopted by you
    function sell(
        bytes32 id, 
        string name, 
        address founder, 
        uint birth, 
        string currentLocation, 
        address Adopter, 
        bool isAlive
    ) public {
        require(
            isAlive == true, 
            "You cannot sell a dead animal."
        );
        require(
            Adopter == msg.sender, 
            "You must adopte this animal."
        );
        emit animalInfo(id, name, founder, birth, now, currentLocation, false, address(0), isAlive);
    }

    //buy 
    function buy(
        bytes32 id, 
        string name, 
        address founder, 
        uint birth, 
        string currentLocation, 
        bool isAdopted,
        address Adopter, 
        bool isAlive, 
        uint value,
        bool fake,
        string secret
    ) 
        public
        payable
        onlyAfter(biddingStart)
        onlyBefore(biddingEnd)
    {
        require(
            isAlive == true, 
            "You cannot buy a dead animal."
        );
        require(
            Adopter == address(0) && isAdopted == false, 
            "This animal is already adopted."
        );
        bids[msg.sender] = Bid({
            blindedBid: keccak256(value, fake, secret),
            deposit: msg.value
        });
    }

    function auctionStart() public   
    {
        require(
            !started,
            "Already started"
        );
        emit AuctionStarted(msg.sender, now);
        biddingStart = now;
        started = true;
        biddingEnd = biddingTime + now;
        ended = false;
    }

    function placeBid(address bidder, uint value) internal
            returns (bool success)
    {
        if (value <= highestBid) {
            return false;
        }
        if (highestBidder != address(0)) {
            // 返还之前的最高出价
            pendingReturns[highestBidder] += highestBid;
        }
        highestBid = value;
        highestBidder = bidder;
        return true;
    }

    /// 取回出价（当该出价已被超越）
    function withdraw() public {
        uint amount = pendingReturns[msg.sender];
        if (amount > 0) {
            pendingReturns[msg.sender] = 0;
            msg.sender.transfer(amount);
        }
    }

    function reveal(
        uint _value,
        bool _fake,
        string _secret
    )
        public
        onlyAfter(biddingEnd)
    {
        uint refund;
        Bid storage bid = bids[msg.sender];
        if (bid.blindedBid == keccak256(_value, _fake, _secret)) {
            refund += bid.deposit;
            if (!_fake && bid.deposit >= _value) {
                if (placeBid(msg.sender, _value))
                    refund -= _value;
            }
            // 使发送者不可能再次认领同一笔订金
            bid.blindedBid = bytes32(0);
            msg.sender.transfer(refund);
        }
    }

    function auctionEnd(bytes32 id,string name,address founder,uint birth,string currentLocation)
        public
        onlyAfter(biddingEnd + revealPending)
    {
        require(!ended);
        emit AuctionEnded(highestBidder, highestBid);
        ended = true;
        seller.transfer(highestBid);
        emit animalInfo(id, name, founder, birth, now, currentLocation, true, highestBidder, true);
        started = false;
    }
}