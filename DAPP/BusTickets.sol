// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TicketBooking {
    uint256[20] arr;
    mapping(uint256 => bool) Checking;
    event BookSeats(string message);
    event TicketsBooked(string message);
    event AvailableSeats(string message);

    //To book seats
    function bookSeats(uint256[] memory seatNumbers) public {
        require(seatNumbers.length != 0, "Empty array");
        require(seatNumbers.length <= 4, "Out of Bounds");
        bool flag;
        for (uint256 i = 0; i < seatNumbers.length; i++) {
            if (seatNumbers[i] >= 1 && seatNumbers[i] <= 20 && !Checking[seatNumbers[i]]) {
                flag = true;
                Checking[seatNumbers[i]] = true;
                arr[i] = seatNumbers[i];
            }
        }
        require(flag,"does not contain only the available seats ");
        emit BookSeats("You Tickets have been booked");
    }

    //To get available seats
    function showAvailableSeats() public   returns (uint256[] memory) {
        uint256[] memory arr2=new uint256[](20); //////////
        uint256 j = 0;
        for (uint256 i = 0; i < 20; i++) {
            if (!Checking[i+1]) {
                arr2[j] = i+1;
                j++;
            }
        }
        emit AvailableSeats("these are the avaialeble seats");
        return arr2;
    }

    //To check availability of a seat
    function checkAvailability(uint256 seatNumber) public   returns (bool) {
        require(seatNumber >=1 && seatNumber <=20,"Not available seat number ");
        emit AvailableSeats("True available");
        return !Checking[seatNumber];       ///////
        


    }

    //To check tickets booked by the user
    function myTickets() public   returns (uint256[] memory) {
        // uint[] memory  BookedNumbers;
        uint256[] memory BookedNumbers = new uint256[](20);
        uint j=0;
        for(uint i=0;i<20;i++)
        {
            if(Checking[i+1])
            {
                     BookedNumbers[j]=i+1;
                     j++;
            }
        }
        emit TicketsBooked("above tickets are booked");
        return BookedNumbers;

    }
}
