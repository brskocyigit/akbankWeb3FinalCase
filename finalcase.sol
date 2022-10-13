// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//@custom:dev-run-script NatSpec tag.
//@dev:brs_kocyigit
contract FinalCase {

    struct Students {
        string name;
        string surname;
        string lesson;
        uint number;
        bool firstTime;
        
    }

    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    Students[] public students;

    mapping (uint => address) public lessonToOwner;

    function create(string calldata _name, string calldata _surname, string calldata _lesson, uint _number, bool _firstTime) public {
        students.push(Students(_name, _surname, _lesson, _number, _firstTime));
    }

    function get(uint _index) public view returns(string memory name, string memory surname, string memory lesson) {
        Students storage student = students[_index];
        return(student.name, student.surname, student.lesson);
    }

    function updateLesson(uint _index, string calldata _lesson) public {
        Students storage student = students[_index];
        student.lesson= _lesson;
    }

    function payLessonTuition(uint _index, uint _number,address _from, address _to, uint256 _tokenId) payable external {
        Students storage student = students[_index];
        require(student.firstTime == false);
        require(lessonToOwner[_number] == msg.sender);
        _transfer(_from, _to, _tokenId);
    }

    function _transfer(address _from, address _to, uint256 _tokenId) private {
        emit Transfer(_from, _to, _tokenId);
  }


 
}