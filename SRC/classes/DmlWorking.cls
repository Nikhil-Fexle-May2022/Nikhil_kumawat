/**
* Description   - DML operations
*
* Created by    - Nikhil Kumawat
*
* Created Date  - 09/06/2022
*
* Revision log  -  V_1.0 - Created  - Nikhil Kumawat 
*                  

**/
public with sharing class DmlWorking {
            /**
        * Description   :  Performing DML operations using various methods
        *
        * Created by    :  Nikhil Kumawat
        * 
        * Return        :  Void
        *
        * Revision log  :  V_1.0 - Created  - Nikhil Kumawat 
        *                  

        **/ 
    // HOW DML WORKS ?
    public void perfectUseOfDmlStatements() {
        List<Contact> updatedList = new List<Contact>();
        List<Contact> conList = [Select Title , Description from Contact];
        for(Contact con : conList) {
            if (con.Title == 'CFO') {
                con.Description = 'Newest Description';
                updatedList.add(con);
            }
        }
        update updatedList;
    }

    // ADDING AND RETRIEVING THE DATA
    public void addingAndRetrievingData(){
        Account accOne = [SELECT Name,Industry FROM Account WHERE Name = 'Karthik Kumawat' LIMIT 1];
        System.debug('Name => ' + accOne.Name); 
        System.debug('Name => ' + accOne.Industry); 

        accOne.Name = 'Swapnil Kataria';
        accOne.Industry = 'Dell-Mart';

        update accOne;
    }
    
    // INSERTING AND UPDATING RECORDS -->>
    // INSERTING RECORD
    public void insertingRecord(){
        try{
            Account acc = new Account(Name='SFDC Account');
            insert acc;
        
            ID accID = acc.ID;
        
            Contact con = new Contact(
                FirstName='David',
                LastName='Mallan',
                Phone='+12435467598',
                AccountId=accID);
            insert con;
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }
    // UPDATING RECORD
    public void updatingRecord(){     
        try {
            Contact updateContact = [SELECT Account.Name 
                                    FROM Contact 
                                    WHERE FirstName = 'David' AND LastName='Mallan'
                                    LIMIT 1];

            updateContact.Phone = '+919045678444';

            updateContact.Account.Industry = 'Gen-Pack';


            update updateContact;

            update updateContact.Account; 
        } catch(Exception e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }

    // VARIOUS DML OPERATIONS
    // 1. INSERTING
    public void insertingRecordToDatabase(){
        List<Account> accList = new List<Account>();
        Account insertAccOne = new Account(Name='Tech-Trash-One', Phone='3454678766');
        Account insertAccTwo = new Account(Name='Tech-Trash-Two', Phone='3478657896');
        accList.add(insertAccOne);
        accList.add(insertAccTwo);
        insert accList;
    }
    // INSERTING A CONTACT
    public void insertingContact(){
        Account insertAccThree = new Account(Name='Tech-Trash-Three', Phone='3451231243');
        insert insertAccThree;
                
        Contact con = new Contact(FirstName='Nikhil', LastName='Kumawat',AccountId=insertAccThree.Id);
        insert con;

        /*
        Contact con = [SELECT Id,FirstName,LastName,Phone FROM Contact WHERE FirstName = 'Nikhil' AND LastName = 'Kumawat'];
        con.Phone = '123456';
        
        update con;
        */
    }
    // 2. UPDATING
    public void updatingRecordToDatabase(){
        Account acc = [SELECT Id,Name,Phone FROM Account WHERE Name='Tech-Trash-One'];
        System.debug('Acc => ' +acc);
        acc.Phone = '909999';
        update acc;
        
     	Account updatedAcc = [SELECT Id,Name,Phone FROM Account WHERE Name='Tech-Trash-One'];
        System.assertEquals(updatedAcc.Phone, acc.Phone, 'Equal');
    }
    // 3. UPSERT
    public void upsertRecord(){
        List<Account> combine = new List<Account>();
        
        Account a = new Account(Name='Tech-Trash-Four', Phone = '232323');
        Account b = [SELECT Id,Name, Phone FROM Account WHERE Name='Tech-Trash-Two'];
        
        b.Phone = '777777';
        
        combine.add(a);
        combine.add(b);
        
        upsert combine;
    }
    // 4. MERGE
    public void mergeRecord(){
        // Accessing a existing Account record which do not have any contact
        Account acc4 = [SELECT Id, Name, Phone FROM Account WHERE Name='Tech-Trash-Four'];
        // Accessing a existing record which have contact details
        Account accMerge = [SELECT Id, Name, Phone FROM Account WHERE Name='Tech-Trash-Three'];
        // Now initiate the Merge operation
        merge acc4 accMerge;
    }
    // 5. DELETE RECORDS
    public void deleteRecord(){
        List<Account> delAcc = [SELECT Id,Name,Phone FROM Account WHERE Name = 'Tech-Trash-Two'];
        delete delAcc;
    }
    // 6. UNDELETE RECORDS
    public void unDeleteRecord(){
        List<Account> deletedAcc = [SELECT Id,Name,Phone FROM Account WHERE Name = 'Tech-Trash-Two' ALL ROWS];
        undelete deletedAcc;
    }
}