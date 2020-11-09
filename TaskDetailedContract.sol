
contract TaskDetailedContract {

    struct Solution{

        address worker;

        int data;

        int quality;

        int rep;

        uint deadline;

    }
    struct Reservations{

        address worker;

        int distance;

        int duration;

        int rep;

        int QoI;

    }
    Reservations [] public workerreservations;
    address owner;
    address user_contract;
    address task_contract;
    int8 status;
    bytes16 DataType;
    uint Duration;
    uint deposit;
    bytes16 location;
    uint rsolutions;
    uint ssolutions;
    uint tolerance;
    int maxqoi;
    int minqoi;
    Solution [] public SubmittedSolutions;
    uint minPay;
    uint minRep;
    uint startTime;

    constructor  (address o, bytes16 d, uint dur, uint dep,bytes16 loc,uint sol, uint tol,uint minr, address ucont, address tcont) public payable{

        if(msg.value==0)

            revert();

        user_contract=ucont;
        task_contract=tcont;
        owner= o;
        DataType=d;
        status=0;
        Duration=dur;
        deposit=msg.value;
        location=loc;
        ssolutions=sol;
        rsolutions=sol;
        tolerance=tol;
        minqoi=20000;
        minPay=deposit/(sol*2);
        minRep = minr;
        startTime = now;
        emit taskdetail(address(this),"created");

    }

    event taskdetail(address s,string msg);

    function TaskAttributes() public{

        emit Display(owner,DataType,status,Duration,deposit,location,tolerance,minRep);

    }

    function getSolutionsNumber() public returns (uint){

        return SubmittedSolutions.length;

    }

    function getSolution(uint s)  public returns (address, int,int,int){

        return (SubmittedSolutions[s].worker,SubmittedSolutions[s].data,SubmittedSolutions[s].quality,SubmittedSolutions[s].rep);

    }


    event Display(address owner, bytes16 DataType,int8 status, uint d, uint dep, bytes16 loc, uint tol,uint minrep);

    function submitSolution (address sender, int data) public returns(uint){

        // only people with reserveSlot 

        for( uint a = 0; a < SubmittedSolutions.length ; a++){

            if(SubmittedSolutions[a].worker==sender&& SubmittedSolutions[a].quality == -1 ){// && SubmittedSolutions[a].deadline > time ){

                SubmittedSolutions[a].data=data;

                emit Submitted(sender,data,DataType,ssolutions,SubmittedSolutions[a].rep);

                ssolutions=ssolutions-1;
                 if(ssolutions==0){

                        evaluateSolutions(1);
            
                    }
                return (2);
            }

        }

    }

    event TaskAdd(address a);

    event notSubmitted(address sen, int d, bytes16 t,uint ss,int rep);

    event Submitted(address sen, int d, bytes16 t,uint ss,int rep);

    function timeout() public{
        evaluateSolutions(1);
    }

    function requestRes( address sender, int dist, int dur, int qoi) public {
        SenseChainUsers t = SenseChainUsers(user_contract);
        // get the reputation
        int rep = t.userReputation(sender);
        workerreservations.push(Reservations(sender,dist,dur,rep,qoi));

    }
    // evaluates the reservation and only accepts best QoI workers
    function evaluateReservations() public{
      
    }
    
    function successfulreservation( address sender) public returns (uint8){
          for( uint h = 0; h < SubmittedSolutions.length ; h++ ){
                if(SubmittedSolutions[h].worker==sender)
                    return(1);
          }
          return(0);
    }


    function evaluateSolutions(uint8 ty) public payable{

        int max=0;
        int min =100;
        int sum_quality=0;
        uint accepted=0;
        // if no one submitted then drop task
        SenseChainTasks SCR = SenseChainTasks(task_contract);
        SenseChainUsers t = SenseChainUsers(user_contract);

        if( SubmittedSolutions.length==0){
            owner.transfer(deposit);
            if( ty == 1){
                t.updateUserReputation(owner,0,1);
    
            }
            status=-2;
            SCR.UpdateStatus(status);
        }

        else{

        // if 1 solution then we have to accept it completely
        if(SubmittedSolutions.length ==1 ){
            SubmittedSolutions[0].quality=100;
            max=  SubmittedSolutions[0].quality;
            EvaluationResult(address(this),SubmittedSolutions[0].worker,SubmittedSolutions[0].data,SubmittedSolutions[0].quality);
            sum_quality=100;
            accepted=1;
        }

        else{
            for( uint h = 0; h < SubmittedSolutions.length ; h++ ){
                if(SubmittedSolutions[h].data!=0)
                    accepted++;
                }
            }
            for( uint i = 0; i < SubmittedSolutions.length ; i++ ){

                int sum=0;

                int data = SubmittedSolutions[i].data;
                
                if(data ==0){
                    SubmittedSolutions[i].quality=0;
                    EvaluationResult(address(this),SubmittedSolutions[i].worker,SubmittedSolutions[i].data,SubmittedSolutions[i].quality);
                    continue;
                }
                for(uint j = 0; j <SubmittedSolutions.length;j++){

                    if(i!=j && SubmittedSolutions[j].data!=0 ){
                        if( data > SubmittedSolutions[j].data)
                            sum=sum+(100/(data-SubmittedSolutions[j].data));
                        else if(data < SubmittedSolutions[j].data)
                            sum=sum+(100/(SubmittedSolutions[j].data-data));

                    }
                }
                    
                if(accepted==1)
                    SubmittedSolutions[i].quality=  (sum)/int(accepted);
                else
                    SubmittedSolutions[i].quality=  (sum)/int(accepted-1);

                sum_quality+=SubmittedSolutions[i].quality;

                if(SubmittedSolutions[i].quality>max)

                    max=SubmittedSolutions[i].quality;

                else if (SubmittedSolutions[i].quality< min )

                    min = SubmittedSolutions[i].quality;

                EvaluationResult(address(this),SubmittedSolutions[i].worker,SubmittedSolutions[i].data,SubmittedSolutions[i].quality);
            }

        }
        
        uint remaining= deposit-(minPay*accepted);
        min= int(sum_quality)/int(accepted);

        for( uint k = 0; k < SubmittedSolutions.length ; k++ ){
            uint pay=0;

              if(max- SubmittedSolutions[k].quality<=int(tolerance)){

                t.updateUserReputation(SubmittedSolutions[k].worker,1,1);
                pay = minPay+ remaining*uint(SubmittedSolutions[k].quality)/uint(sum_quality);
                SubmittedSolutions[k].worker.transfer(pay);
                }
              else{
                t.updateUserReputation(SubmittedSolutions[k].worker,0,1);
                
              }
            payment(SubmittedSolutions[k].worker,deposit,SubmittedSolutions[k].quality,pay);
        }

        if( ty == 1){
            t.updateUserReputation(owner,0,1);
        }
        status=2;
        SCR.UpdateStatus(status);
        SCR.minq(this,min);

    }
    event payment(address a, uint dep, int q, uint p);

    event EvaluationResult(address cont,address user, int data, int evaluation);

    event Evaluate(string s);

}
