// SPDX-License-Identifier: UNLICENSED

pragma solidity^0.8.7;

contract cryptokids{
    // owner dad
    address owner;

    constructor(){
        owner=msg.sender;
    }

    struct Kid{
        address payable walletaddress;
        string fname;
        string lname;
        uint release_time;
        uint amt;
        bool can_withdraw;
    }

    Kid[] public kids;
    modifier onlyOwner(){
       require(msg.sender==owner,"Only the owner can perform the operation"); 
       _;
    }

    function addKid( address payable walletaddress,string memory fname, string memory lname, uint release_time, uint amt, bool can_withdraw) public onlyOwner{
        kids.push(Kid(walletaddress,fname, lname, release_time, amt, can_withdraw));
    }

    function ofBalance () public view returns(uint) {
       return address(this).balance;
    }

    function deposit(address walletaddress) payable public{
        KidsBal(walletaddress);
    }

    function KidsBal(address walletaddress) private onlyOwner{
        for (uint i=0; i<kids.length; i++) 
        {
            if(kids[i].walletaddress==walletaddress)
            {
                kids[i].amt+=msg.value;
            }
        }
    }

    function getIndex(address walletaddress) private view returns (uint){
        for (uint i=0; i<kids.length; i++) 
        {
            if(kids[i].walletaddress==walletaddress)
            {
                return i;
            }
        }
        return 999;
    }

    function available_to_withdraw (address walletaddress)  public returns(bool){
        uint i=getIndex(walletaddress);
        if(block.timestamp>kids[i].release_time){
            kids[i].can_withdraw=true;
            return true;
        }
        else{
            return false;
        }
    }

    function withdraw(address payable walletaddress) payable public {
        uint i=getIndex(walletaddress);
        require(msg.sender==kids[i].walletaddress,"You must be the kid to withdraw");
        require(kids[i].can_withdraw==true,"you are not able to withdraw at this time");
        kids[i].walletaddress.transfer(kids[i].amt);
    }

}