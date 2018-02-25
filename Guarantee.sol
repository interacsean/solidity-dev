pragma solidity ^0.4.17;

contract Guarantee {
    
    uint waranteePeriod ;
    address arbitrator;
    address sender;
    address recipient;
    uint startDate;
    uint value;
    bool refunded;
    
    function Guarantee(
        address _arbitrator,
        address _recipient,
        uint _waranteePeriod
    ) public {
        sender = msg.sender;
        arbitrator = _arbitrator;
        recipient = _recipient;
        waranteePeriod = _waranteePeriod;
        startDate = now;
    }
    
    function payable() {
        value = msg.value;
        refunded = false;
    }
    
    function refund() public returns (bool result) {
        if (msg.sender != arbitrator && msg.sender != recipient) {
            return false;
            
        } else if (startDate + waranteePeriod > now) {
            return false;
            
        } else {
            if (tx.origin.send(value)) {
                return true;
            } else {
                return false;
            }
        }
    }
    
    function originator() public returns (address originatorAddr) {
        return tx.origin;
    }

}

