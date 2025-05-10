// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title OSS Package Tracker
/// @notice Tracks downloads and usage stats for open-source smart contracts
contract TeaOSSPackage {
    struct Package {
        string name;
        string description;
        address author;
        uint256 installs;
    }

    mapping(bytes32 => Package) public packages;

    event PackagePublished(bytes32 indexed id, string name, string description, address author);
    event PackageInstalled(bytes32 indexed id, address user);

    function publishPackage(string memory name, string memory description) public {
        bytes32 id = keccak256(abi.encodePacked(name, msg.sender));
        packages[id] = Package(name, description, msg.sender, 0);
        emit PackagePublished(id, name, description, msg.sender);
    }

    function installPackage(bytes32 id) public {
        packages[id].installs += 1;
        emit PackageInstalled(id, msg.sender);
    }

    function getPackage(bytes32 id) public view returns (Package memory) {
        return packages[id];
    }
}
