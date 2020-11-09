
contract SenseChainTasks{
    address [] TasksContracts;
    address user_contract;
    struct Task{ //the information of a given Task

        address Owner; 

        int reputation;

        int8 Status; // status of a given task

        bytes16 DataType; // type of requested task

        uint Duration; // duration for accepted solution

        uint Deposit; // Reward for users

        bytes16 location; // geographical constraints

        uint totalsolutions;

        uint tolerance;

        uint minPayment;

        uint minReputation;

    }

    mapping (address => Task[]) public TasksList;

    // update status and deletes completed tasks
    function UpdateStatus(int8 s ) public{

        TasksList[msg.sender][0].Status=s;

       emit TaskContract(msg.sender,TasksList[msg.sender][0].Owner,TasksList[msg.sender][0].reputation,TasksList[msg.sender][0].DataType,TasksList[msg.sender][0].Duration,TasksList[msg.sender][0].Deposit,TasksList[msg.sender][0].location,s,TasksList[msg.sender][0].totalsolutions,TasksList[msg.sender][0].tolerance,TasksList[msg.sender][0].minPayment,TasksList[msg.sender][0].minReputation);

        if(s==2){

            for(uint i =0; i<TasksContracts.length;i++){

                if(TasksContracts[i]==msg.sender){

                    delete TasksContracts[i];
                    if(TasksContracts.length>1)

                        TasksContracts[i]=TasksContracts[TasksContracts.length-1];

                    TasksContracts.length--;

                    break;

                }

            }

        }

    }

    // reduce pending SolutionsReduced

    function ReduceSolutions(address cont) public{

        TasksList[cont][0].totalsolutions=TasksList[cont][0].totalsolutions-1;

        emit SolutionsReduced(cont,TasksList[cont][0].totalsolutions);

    }

    event SolutionsReduced(address s,uint totals);

    constructor (address ucont) public{
        user_contract=ucont;

    }

    // adding admin by other admins

    function addTask(address cont, address sender, bytes16 data, uint deposit, uint dur, bytes16 loc,uint sol,uint tol,uint minrep) public {

        // create new detailed contract

        TasksContracts.push(cont);

        // adds task to the list of aviable tasks

        SenseChainUsers t = SenseChainUsers(user_contract);

        int rep = t.userReputation(sender);

        uint minPay = deposit/(sol*2);

        TasksList[cont].push(Task(sender,rep,0,data,dur,deposit,loc,sol,tol,minPay,minrep));

        emit TaskContract(cont,sender,rep, data,dur,deposit,loc,0,sol,tol,minPay,minrep);

    }

    function getPendingTasksNumber() public returns (uint){

        return TasksContracts.length;

    }

    function getPendingTasks(uint s) public returns (address, address, int, int8,bytes16,uint,uint,bytes16,uint,uint,uint){

        address g = TasksContracts[s];

        return (g,TasksList[g][0].Owner,TasksList[g][0].reputation,TasksList[g][0].Status,TasksList[g][0].DataType,TasksList[g][0].Duration,TasksList[g][0].Deposit,TasksList[g][0].location,TasksList[g][0].totalsolutions,TasksList[g][0].tolerance,TasksList[g][0].minReputation);

    }

    event pending (uint s);

    event add (string s);

    event taskdetail(address s);

    event TaskContract(address a,address s, int rep, bytes16 data, uint dur, uint dep, bytes16 loc,int8 stat,uint sol,uint tol,uint min, uint minrep);

    function cancelTask(address sender, address add) public{

    }
    function minq(address c, int qu) public{

       emit minquality(c,qu);

    }

        event minquality(address cont, int q);

}
