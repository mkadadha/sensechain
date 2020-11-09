pragma solidity ^0.5.11;

pragma experimental ABIEncoderV2;

contract SenseChainUsers{

    address admins; // admins of the system

    struct UserInfo{ // struct for the information of a given token

        bytes32 Type;

        int Reputation;

        uint256 Staticstics;

        int totalrequests;

        int userrelevent;//completed for worker and cancelled for requester

        bytes32 [] datatypes;

    }

    // mapping for users and their accessable devices

    mapping (address => UserInfo) public Users;

    // mapping for devices at a fog node

     constructor () public{

        admins=msg.sender; //creater of contract is the first admin

    }


    function getUser(address s) public returns( bytes32, int, uint256,int,int){

      return ( Users[s].Type,Users[s].Reputation,Users[s].Staticstics,Users[s].totalrequests,Users[s].userrelevent);

    }

    function addUser(address s, bytes32 t)public{

        Users[s].Reputation=50;

        Users[s].totalrequests=0;

        Users[s].userrelevent=0;

        Users[s].Type=t;

        Users[s].Staticstics=0;

        emit UserAdded(s,t,Users[s].Reputation,0);

    }

    

    event UserAdded(address u, bytes32 t, int r,uint256 s);

    // delete a given user

    function delUser () public{ 

      delete Users[msg.sender];

      emit UserDeleted(msg.sender);

    }

    event UserDeleted(address a);

  
    function updateUserReputation(address u, int r, int t)public{

        //function for updating reputation

        Users[u].userrelevent=Users[u].userrelevent+r;

        Users[u].totalrequests=Users[u].totalrequests+t;
        
        int currentrep = Users[u].userrelevent*25/Users[u].totalrequests;
        
        Users[u].Reputation =  Users[u].Reputation*75/100 +currentrep;
       emit ReputationUpdated(u,Users[u].Reputation);

    }

    function updateUserStats(address u, uint256 s)public{
        Users[u].Staticstics+=s;

        emit StatisticsUpdated(u,Users[u].Staticstics);

    }

    event ReputationUpdated(address a, int r);

    event StatisticsUpdated(address a, uint256 s);

    

    function userExists(address u) public returns (bool) {

        if(Users[u].Type !="")

        return true;

        else return false;

    }

    function userRequester(address u) public returns (bool) {

        if(Users[u].Type =="r")

        return true;

        else return false;

    }

    function userReputation(address u) public returns (int){

        if(Users[u].Reputation >= 0)
        return Users[u].Reputation;
        else return -1;

    }

}

