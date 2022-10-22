public with sharing class VisualHelper {
    public list<Transaction_Entry__c> tran {get;set;} 
	public string searchstring {get;set;} 
    public Integer transactionEntries{get;set;}
    public List<string> options {get;set;}
    
    public String renderBlock{get;set;}
    

    public boolean amountFlag{get;set;}
    public decimal startAmount{get;set;}
    public decimal endAmount{get;set;}
    public List<Transaction_Entry__c> transactionListAmountBetween{get;set;}
    

    public boolean statusFlag{get;set;}
    public String status {get;set;}
    public List<Transaction_Entry__c> transactionListStatus{get;set;}
    

    public boolean typeFlag{get;set;}
    public String type{get;set;}
    public List<Transaction_Entry__c> transactionListType{get;set;}
    

    public boolean dateFlag{get;set;}
    public date startDate{get;set;}
    public date endDate{get;set;}
    public List<Transaction_Entry__c> transactionListWithDate{get;set;}
    
    
 
    public boolean accountNumberFlag{get;set;}
    public String accountNumber{get;set;}
    public List<Transaction_Entry__c> transactionListWithAccountNumber{get;set;}
    
    
    
    
	public VisualHelper() { 
       transactionListAmountBetween = new List<Transaction_Entry__c>();
       transactionListStatus = new List<Transaction_Entry__c>();
       transactionListType = new List<Transaction_Entry__c>();
       transactionListWithDate = new List<Transaction_Entry__c>();
       transactionListWithAccountNumber = new List<Transaction_Entry__c>();
        
	}
    
    public void transactions(){
      //  string searchquery='SELECT Id, Name, Amount__c, Status__c, Transaction_Date__c,Type__c FROM Transaction_Entry__c  '; 
        tran = [SELECT Id, Name, Amount__c, Status__c, Transaction_Date__c,Type__c, Contact__r.Account_Number__c FROM Transaction_Entry__c];
	//	transactionList= Database.query(searchquery); 
       // return tran;
    }
    
    public List<Selectoption> getselectOption(){
        
        List<Selectoption> listOption = new List<Selectoption>();
        
        listOption.add(new selectoption ('None', 'None'));
        listOption.add(new selectoption ('Amount Between', 'Amount Between'));
        listOption.add(new selectoption ('Status', 'Status')); 
        listOption.add(new selectoption ('Type', 'Type'));
        listOption.add(new selectoption ('Date Between', 'Date Between'));
        listOption.add(new selectoption ('Account Number', 'Account Number'));
        
        return listOption;
        
   }
    
    public void renderOptionsAction(){
        
        if(renderBlock == 'Amount Between'){
            amountFlag = true;
            statusFlag = false;
            typeFlag = false;
            dateFlag = false;
            accountNumberFlag = false;
        }
        
        if(renderBlock == 'Status'){
            amountFlag = false;
            statusFlag = true;
            typeFlag = false;
            dateFlag = false;
            accountNumberFlag = false;
        }
        
        if(renderBlock == 'Type'){
            amountFlag = false;
            statusFlag = false;
            typeFlag = true;
            dateFlag = false;
            accountNumberFlag = false;
        }
        
        if(renderBlock == 'Date Between'){
            amountFlag = false;
            statusFlag = false;
            typeFlag = false;
            dateFlag = true;
            accountNumberFlag = false;
        }
        
        if(renderBlock == 'Account Number'){
            amountFlag = false;
            statusFlag = false;
            typeFlag = false;
            dateFlag = false;
            accountNumberFlag = true;
        }
        
        
    }
    
    
    public pagereference transactionWithAmountBetween(){
        
       transactionListAmountBetween = new List<Transaction_Entry__c>();
        
       transactionListAmountBetween =  [SELECT Id,Name,Amount__c,Status__c,Type__c,Contact__r.Account_Number__c,Contact__r.Name,Transaction_Date__c 
                                                             FROM Transaction_Entry__c WHERE Amount__c >=:startAmount AND Amount__c <=:endAmount];
        
        
      return null;

    }
    
    
    public List<Selectoption> getStatusOption(){
        List<Selectoption> statusList = new List<Selectoption>();
        statusList.add(new selectOption('None','None'));
        statusList.add(new selectOption('Pending','Pending'));
        statusList.add(new selectOption('Completed','Completed'));
        statusList.add(new selectOption('Completed','Completed'));
        
        return statusList;
    }
    
    public pagereference transactionWithStatus(){
        transactionListStatus = [SELECT Id,Name,Amount__c,Status__c,Type__c,Contact__r.Account_Number__c,Contact__r.Name,Transaction_Date__c FROM Transaction_Entry__c WHERE Status__c =:status];
        
        return null;
        
    }
    
    
    public List<Selectoption> getTypeOption(){
        List<Selectoption> transactionType = new List<Selectoption>();
        transactionType.add(new selectOption('None','None'));
        transactionType.add(new selectOption('Debit','Debit'));
        transactionType.add(new selectOption('Credit','Credit'));
        
        return transactionType;
    }
    
    public pagereference transactionWithType(){
        
        transactionListType = [SELECT Id,Name,Amount__c,Status__c,Type__c,Contact__r.Account_Number__c,Contact__r.Name,Transaction_Date__c FROM Transaction_Entry__c
                               WHERE Type__c =:type];
        
        return null;
    }
    
     public pagereference transactionWithDate(){
        
        transactionListWithDate = [SELECT Id,Name,Amount__c,Status__c,Type__c,Contact__r.Account_Number__c,Contact__r.Name,Transaction_Date__c FROM Transaction_Entry__c
                                   WHERE Transaction_Date__c >=:startDate AND Transaction_Date__c <=:endDate];
        
        return null;
    }
    
    public pagereference transactionWithAccountNumber(){
        
        transactionListWithAccountNumber = [SELECT Id,Name,Amount__c,Status__c,Type__c,Contact__r.Account_Number__c,Contact__r.Name,Transaction_Date__c FROM Transaction_Entry__c WHERE Contact__r.Account_Number__c =:accountNumber];
        
        return null;
    }
}