//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract HotelRoom {
    enum Statuses {
        Vacant,
        Occupied
    }

    Statuses public currentStatus;
    bytes public dataa;

    event Occupy(address _occupant, uint _value);

    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant() {
        require(currentStatus == Statuses.Vacant, "Currently Occupied");
        _;
    }

    modifier costs(uint _amount) {
        require(msg.value >= _amount, "Not enough ether");
        _;
    }

    function book() public payable onlyWhileVacant costs(2 ether) {
        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        dataa = data;
        require(sent == true);
        currentStatus = Statuses.Occupied;
        emit Occupy(msg.sender, msg.value);
    }
}
