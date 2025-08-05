// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// https://dapp-world.com/problem/gavin-and-bookstore-SggR/problem

contract Bookstore {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    struct Libr {
        // uint256 id;
        string title;
        string author;
        string publication;
        bool boo;
    }
    Libr lib;
    uint256 count = 0;
    mapping(uint256 => Libr) public Connect;
    mapping(uint256 => bool) received;
    mapping(string=>uint[]) booksIdByTotal;

    modifier OnlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }
    modifier NoBook(uint id)
    {
        require(received[id], "Not Found the id");
        _;
    }

    // this function can add a book and only accessible by gavin
    function addBook(
        string memory _title,
        string memory _author,
        string memory _publication
    ) public OnlyOwner {
        // require(Connect[count],"book already added");
        Connect[count] = Libr(_title, _author, _publication, true);
        received[count] = true;
        booksIdByTotal[_title].push(count);      ///////////////////////////////////////////////
        count++;
    }

    // this function makes book unavailable and only accessible by gavin
    function removeBook(uint256 id) public OnlyOwner {
        delete Connect[id];
    }

    // this function modifies the book details and only accessible by gavin
    function updateDetails(
        uint256 id,
        string memory title,
        string memory author,
        string memory publication,
        bool available 
    ) public OnlyOwner NoBook(id) {
         
        Connect[id] = Libr(title, author, publication, available);
    }

    // this function returns the ID of all books with given title
    function findBookByTitle(string memory title) public  view returns (uint256[] memory)
    {
    uint256[] storage ids = booksIdByTotal[title];
    if (msg.sender == owner) {
        return ids;
    } else {
        uint256[] memory availableIds;
        uint256 countAvailable = 0;
        for (uint256 i = 0; i < ids.length; i++) {
            if (Connect[ids[i]].boo) {
                availableIds[countAvailable] = ids[i];
                countAvailable++;
            }
        }
        return availableIds;
    }
}


    // this function returns the ID of all books with given publication
    function findAllBooksOfPublication(string memory publication) public view  returns (uint256[] memory) {
         uint256[] storage ids = booksIdByTotal[publication];
    if (msg.sender == owner) {
        return ids;
    } else {
        uint256[] memory availableIds;
        uint256 countAvailable = 0;
        for (uint256 i = 0; i < ids.length; i++) {
            if (Connect[ids[i]].boo) {
                availableIds[countAvailable] = ids[i];
                countAvailable++;
            }
        }
        return availableIds;
    }
    }

    // this function returns the ID of all books with given author
    function findAllBooksOfAuthor(string memory author) public  view returns (uint256[] memory) {
        uint256[] storage ids = booksIdByTotal[author];
    if (msg.sender == owner) {
        return ids;
    } else {
        uint256[] memory availableIds;
        uint256 countAvailable = 0;
        for (uint256 i = 0; i < ids.length; i++) {
            if (Connect[ids[i]].boo) {
                availableIds[countAvailable] = ids[i];
                countAvailable++;
            }
        }
        return availableIds;
    }
    }

    // this function returns all the details of book with given ID
    function getDetailsById(uint256 id)public  NoBook(id) view returns (string memory title,string memory author,string memory publication,bool available) 
    {
           require(msg.sender == owner || Connect[id].boo, "Book not available");

    Libr memory book = Connect[id];
    title = book.title;
    author = book.author;
    publication = book.publication;
    available = book.boo;
    return (title, author, publication, available);    ///////////////////////////////
    }
}
