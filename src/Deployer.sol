// SPDX-License-Identifier: MIT
pragma solidity 0.8.12;

import "./Multicall3.sol";

/// @title Deployer to deploy contract with create2
contract Deployer {
    function deploy(
        bytes32 _salt
    ) public payable returns (address) {
        return address(new Multicall3{salt: _salt}());
    }

    function getBytecode(address _owner, uint _foo) public pure returns (bytes memory) {
        bytes memory bytecode = type(Multicall3).creationCode;

        return abi.encodePacked(bytecode, abi.encode(_owner, _foo));
    }

    function getAddress(
        bytes memory bytecode,
        uint _salt
    ) public view returns (address) {
        bytes32 hash = keccak256(
            abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(bytecode))
        );

        return address(uint160(uint(hash)));
    }
}
