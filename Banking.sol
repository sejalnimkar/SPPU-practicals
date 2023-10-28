// SPDX-License-Identifier: UNLICENSED

pragma solidity>=0.7.0;

contract bank{
    struct user{
        address payable walletaddress;
        uint amt;
        string fname;
        string lname;
    }

    user[] public users;

    function create_acc(address payable walletaddress, uint amt,string memory fname,string memory lname) public {
        users.push(user(walletaddress, amt, fname, lname));
    }

    function getIndex(address walletaddress) public view returns (uint)
    {
        for(uint i=0;i<users.length;i++){
            if(walletaddress==users[i].walletaddress){
                return i;
            }
        }
        return 999;
    }

    // deposit
    function deposit() public payable{
        uint i=getIndex(msg.sender);
        users[i].amt+=msg.value;
    }


    // withdraw
    function withdraw(address walletaddress) public payable {
        require(msg.sender==walletaddress, "Only the given account user can perform the following operation");
        uint i=getIndex(msg.sender);
        require(users[i].amt >= msg.value, "Insufficient balance");
        users[i].amt-=msg.value;
        users[i].walletaddress.transfer(msg.value);
    }

    //show balance
    function showBal(address payable walletaddress) public view returns(uint){
        uint i=getIndex(walletaddress);
        return users[i].amt;
    }

}