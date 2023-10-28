// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.7.0;

contract studData{

    struct stud{
        string fname;
        string lname;
        uint roll_no;
        uint age;
        string major;
    }

    stud[] public students;

    function addStudent(string memory fname, string memory lname, uint roll_no, uint age, string memory major) public {
        students.push(stud(fname,lname,roll_no,age,major));
    }

    function getNumberOfStudents() public view returns (uint) {
        return students.length;
    }

    // Fallback function to accept Ether transactions and perform custom logic
    fallback() external payable {
      
 }
   function checkBal() public view returns(uint){
    return address(this).balance;
   }

   receive() external payable { 

   }

}