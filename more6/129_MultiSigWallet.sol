//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.7;

contract MultiSigWallet {
    //Deposit will fire when ether is deposited to this multisigwallet
    //Submit will fire when a transaction is submitted waiting for the other owners to approve
    //Approve will fire when the transaction is approved.
    //Revoke will fire when owners change their mind and revoke approved transaction. (But I am not
    // sure here. revoke may probably mean rejecting transaction also).
    //Execute will fire when there is sufficient amount approvals, then the contract(Does
    // "contract" mean "transaction"?) can be executed.
    event Deposit(address indexed sender, uint amount);
    event Submit(uint indexed txId);
    event Approve(address indexed owner, uint indexed txId);
    event Revoke(address indexed owner, uint indexed txId);
    event Execute(uint indexed txId);

    //This struct will create transaction records. Then we will store these records in an array.
    struct Transaction {
        address to; // recipient of our transaction.
        uint value;
        bytes data; //data sent with the transaction.
        bool executed; //if transaction is successfull or not.
    }

    //Defining the array of owners. Only the owners will be able to call most of the 
    // functions above.
    address[] public owners;

    //If an address is owner of multisigwallet it will return true.
    mapping(address => bool) public isOwner;

    //number of approvals required to approve transaction.
    //For our exercise, we will assume 3 owners and 2 approvals will be required.
    uint public required;

    //Here will record transactions (in Transaction struct format).
    Transaction[] public transactions;

    //Here we will need to define a mapping to save approvals for each transaction.
    //uint is the index of the transaction. 
    mapping(uint => mapping(address => bool)) public approved;


}