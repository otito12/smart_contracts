//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Ownable {
    address owner;
    modifier isOwner() {
        require(msg.sender == owner, "must be owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }
}

contract SecretVault {
    string secret;

    constructor(string memory _secret) {
        secret = _secret;
        super;
    }

    function getSecret() public view returns (string memory) {
        return secret;
    }
}

contract Contract is Ownable {
    address vault_address;

    constructor(string memory _secret) {
        SecretVault _vault = new SecretVault(_secret);
        vault_address = address(_vault);
        super;
    }

    function getSecret() public view isOwner returns (string memory) {
        return SecretVault(vault_address).getSecret();
    }
}
