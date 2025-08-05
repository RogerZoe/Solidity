// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Project {
    // HERE WE NEED TO CREATE AN EVENT ,SO FO AN EVENT WE HAVE TO CREATE A STRUCTURE
    //BECAUSE IN EVENTS THERE WILL BE MANY THINGS WILLL BE DONE

    struct Event {
        string name;
        address organizer;
        uint256 price;
        uint256 date;
        uint256 Ticketcount;
        uint256 TicketRemain;
    }

    // next THERE WILL BE MMORE EVENTS SO WE NEED MAPPING

    mapping(uint256 => Event) public events;
    mapping(address => mapping(uint256 => uint256)) public tickets; //WE NEED TO STORE THE TICKETS.....
    uint256 nextID; //ID TO INSERT/REMOVE/CHECK THE EVENTS...

    function CreateEvent(
        string memory name,
        uint256 price,
        uint256 date,
        uint256 Ticketcount
    ) public {
        // NEED TO CHECK THE CONDITIONS...

        require(
            date > block.timestamp,
            "You can organize event for future date"
        ); // check will happens with seconds unix time.. not for the past
        require(
            Ticketcount > 0,
            "You can organize event only if you create more than 0 tickets"
        ); // condtion to to create an event

        events[nextID++] = Event(
            name,
            msg.sender,
            price,
            date,
            Ticketcount,
            Ticketcount
        );
    }

    //BUYING MORE THAN ONE TICKETS......

    function BuyTicket(uint256 id, uint256 Quantity) external payable {
        Event storage _event = events[id]; //storing event id into _event variable ,so that we can use it
        //BY USING THIS ID WE CAN CHECK FOR PRICE,TICKETCOUNT ALL  THESE CAN CHECK.........

        require(events[id].date != 0, "Event does not exist");
        require(events[id].date > block.timestamp, "Event has already occured");

        require(msg.value == (_event.price * Quantity), " Ether is not Enough"); // checking ticketprice should be equal to which are buying the tickets...
        require(_event.Ticketcount >= Quantity, " Not Enough tickets"); // after selecting the Quantity ,remaining ticktets should <= to the Quantity..

        // after all check done now BOOK THE TICKET FOR THIS.............................
        // so,we need to remove the Quantity from the remaining tickets  ==> [100 remainging ,20 quantity ,newtotal = 80]

        _event.TicketRemain -= Quantity;

        // now 21 line will be helpful..
        // its like tickets[address1][id1];

        // so we Update the [ account address with id ] with how many tickets he book..

        tickets[msg.sender][id] += Quantity;
    }

    // if we want to transfer the ticket then we  need event id ,receiver address,quantity..
    function TransferTicket(
        uint256 id,
        address to,
        uint256 Quantity
    ) external {
        require(events[id].date != 0, "Event does not exist");
        require(events[id].date > block.timestamp, "Event has already occured");
        require(
            tickets[msg.sender][id] >= 0,
            " NOT ENOUGH TICKETS TO TRANSFER"
        );

        tickets[msg.sender][id] -= Quantity; // cutting the  price/tickets from the sender
        tickets[to][id] += Quantity; // adding the price/tickets to the receiver from the sender
    }
}
