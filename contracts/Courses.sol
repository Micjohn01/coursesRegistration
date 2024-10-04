// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract Courses {
    struct Course {
        uint id;
        string title;
        string description;
        address instructor;
    }

    uint public nextCourseId;
    address public admin;
    mapping(uint => Course) public courses;

    
    event CourseCreated(uint indexed id, string title, address indexed instructor);
    event CourseUpdated(uint indexed id, string title, address indexed instructor);
    event CourseDeleted(uint indexed id);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can perform this action");
        _;
    }

    constructor() {
        admin = msg.sender;
    }


    function createCourse(string memory _title, string memory _description, address _instructor) public onlyAdmin {
        require(bytes(_title).length != 0, "Title cannot be empty");
        require(bytes(_description).length != 0, "Description cannot be empty");
    
        courses[nextCourseId] = Course(nextCourseId, _title, _description, _instructor);
        emit CourseCreated(nextCourseId, _title, _instructor);
        nextCourseId++;
    }

    
    function getCourse(uint _id) public view returns (Course memory) {
        require(_id < nextCourseId, "Course does not exist");
        return courses[_id];
    }

    
    function updateCourse(uint _id, string memory _title, string memory _description, address _instructor) public onlyAdmin {
        require(_id < nextCourseId, "Course does not exist");

        Course storage course = courses[_id];
        course.title = _title;
        course.description = _description;
        course.instructor = _instructor;

        emit CourseUpdated(_id, _title, _instructor);
    }


    function deleteCourse(uint _id) public onlyAdmin {
        require(_id < nextCourseId, "Course does not exist");

        delete courses[_id];
        emit CourseDeleted(_id);
    }
}