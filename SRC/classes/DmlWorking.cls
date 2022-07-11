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
    public static void perfectUseOfDmlStatements() {
        List<Contact> updatedList = new List<Contact>();
        List<Contact> conList = [Select Title , Description from Contact];
        for(Contact con : conList) {
            if (con.Title == 'CFO') {
                con.Description = 'Newest Description';
                updatedList.add(con);
            }
        }
        update updatedList;
        System.debug('Contact List ' +updatedList);
    }
    /*
    HOW TO RUN IN ANONYMOUS WINDOW :-> 
        DmlWorking.perfectUseOfDmlStatements();

    OUTPUT -> 
    16:38:46:257 USER_DEBUG [35]|DEBUG|Contact List (Contact:{Title=CFO, Id=0035i000006KdOZAA0, Description=Newest Description}, Contact:{Title=CFO, Id=0035i000006KdOpAAK, Description=Newest Description})
    */

    // ADDING AND RETRIEVING THE DATA
    public static void addingAndRetrievingData(){
        Account accOne = [SELECT Name,Industry FROM Account WHERE Name = 'Karthik Kumawat' LIMIT 1];
        System.debug('Name => ' + accOne.Name); 
        System.debug('Name => ' + accOne.Industry); 

        accOne.Name = 'Swapnil Kataria';
        accOne.Industry = 'Dell-Mart';

        update accOne;
        System.debug('List ' +accOne);
    }
    /*
    HOW TO RUN IN ANONYMOUS WINDOW :-> 
        DmlWorking.addingAndRetrievingData();

    OUTPUT -> 
    16:40:21:258 USER_DEBUG [36]|DEBUG|List (Account:{Name=Swapnil Kataria, Industry=Dell-Mart})
    */
    
    // INSERTING AND UPDATING RECORDS -->>
    // INSERTING RECORD
    public static void insertingRecord(){
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
            System.debug('Account '+acc);
            System.debug('Contact ' +con);
        } catch(DmlException e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }
    /*
    HOW TO RUN IN ANONYMOUS WINDOW :-> 
        DmlWorking.insertingRecord();

    OUTPUT -> 
    16:47:38:220 USER_DEBUG [66]|DEBUG|Account Account:{Name=SFDC Account, Id=0015i00000AglVVAAZ}
    16:47:38:220 USER_DEBUG [67]|DEBUG|Contact Contact:{FirstName=David, LastName=Mallan, Phone=+12435467598, AccountId=0015i00000AglVVAAZ, Id=0035i000009jPn0AAE}
    */

    // UPDATING RECORD
    public static void updatingRecord(){     
        try {
            Contact updateContact = [SELECT Account.Name 
                                    FROM Contact 
                                    WHERE FirstName = 'David' AND LastName='Mallan'
                                    LIMIT 1];

            updateContact.Phone = '+919045678444';
            updateContact.Account.Industry = 'Gen-Pack';

            update updateContact;

            update updateContact.Account; 
            System.debug('Updated ' +updateContact);
        } catch(Exception e) {
            System.debug('An unexpected error has occurred: ' + e.getMessage());
        }
    }
    /*
    HOW TO RUN IN ANONYMOUS WINDOW :-> 
        DmlWorking.updatingRecord();

    OUTPUT -> 
    16:58:02:459 USER_DEBUG [88]|DEBUG|Updated Contact:{AccountId=0015i00000AglVVAAZ, Id=0035i000009jPn0AAE, Phone=+919045678444}
    */

    // VARIOUS DML OPERATIONS
    // 1. INSERTING
    public static void insertingRecordToDatabase(){
        List<Account> accList = new List<Account>();
        Account insertAccOne = new Account(Name='Tech-Trash-One', Phone='3454678766');
        Account insertAccTwo = new Account(Name='Tech-Trash-Two', Phone='3478657896');
        accList.add(insertAccOne);
        accList.add(insertAccTwo);
        insert accList;

        System.debug('RecordList -' +accList);
    }
    /*
    HOW TO RUN IN ANONYMOUS WINDOW :-> 
        DmlWorking.insertingRecordToDatabase();

    OUTPUT -> 
    15:23:52:162 USER_DEBUG [98]|DEBUG|List -(Account:{Name=Tech-Trash-One, Phone=3454678766, Id=0015i00000AgkplAAB}, Account:{Name=Tech-Trash-Two, Phone=3478657896, Id=0015i00000AgkpmAAB})
    */

    // INSERTING A CONTACT
    public static void insertingContact(){
        Account insertAccThree = new Account(Name='Tech-Trash-Three', Phone='3451231243');
        insert insertAccThree;
                
        Contact con = new Contact(FirstName='Nikhil', LastName='Kumawat',AccountId=insertAccThree.Id);
        insert con;

        System.debug('Account List -> ' +insertAccThree);
        System.debug('Contact List ->' +con);

        /*
        Contact con = [SELECT Id,FirstName,LastName,Phone FROM Contact WHERE FirstName = 'Nikhil' AND LastName = 'Kumawat'];
        con.Phone = '123456';
        
        update con;
        */
    }
    /*
    HOW TO RUN IN ANONYMOUS WINDOW :-> 
        DmlWorking.insertingContact();

    OUTPUT -> 
    16:15:32:590 USER_DEBUG [108]|DEBUG|Account List -> Account:{Name=Tech-Trash-Three, Phone=3451231243, Id=0015i00000AglJFAAZ}
    16:15:32:590 USER_DEBUG [109]|DEBUG|Contact List ->Contact:{FirstName=Nikhil, LastName=Kumawat, AccountId=0015i00000AglJFAAZ, Id=0035i000009jPBzAAM}
    */
    
    // 2. UPDATING
    public static void updatingRecordToDatabase(){
        Account acc = [SELECT Id,Name,Phone FROM Account WHERE Name='Tech-Trash-One'];
        System.debug('Acc => ' +acc);
        acc.Phone = '909999';
        update acc;
        
     	Account updatedAcc = [SELECT Id,Name,Phone FROM Account WHERE Name='Tech-Trash-One'];
        System.debug('Updated List -> ' +updatedAcc);
        System.assertEquals(updatedAcc.Phone, acc.Phone, 'Equal');
    }
    /*
    HOW TO RUN IN ANONYMOUS WINDOW :-> 
    DmlWorking.updatingRecordToDatabase();

    OUTPUT -> 
    16:22:35:035 USER_DEBUG [120]|DEBUG|Acc => Account:{Id=0015i00000AgkplAAB, Name=Tech-Trash-One, Phone=909999}
    16:22:35:208 USER_DEBUG [125]|DEBUG|Updated List -> Account:{Id=0015i00000AgkplAAB, Name=Tech-Trash-One, Phone=909999}
    */

    // 3. UPSERT
    public static void upsertRecord(){
        List<Account> combine = new List<Account>();
        Account a = new Account(Name='Tech-Trash-Four', Phone = '232323');
        Account b = [SELECT Id,Name, Phone FROM Account WHERE Name='Tech-Trash-Two'];
        b.Phone = '777777';
        combine.add(a);
        combine.add(b);
        
        upsert combine;
        System.debug('Inserted And Updated List ' +combine);
    }
    /*
    HOW TO RUN IN ANONYMOUS WINDOW :-> 
    DmlWorking.upsertRecord();

    OUTPUT -> 
    16:27:05:640 USER_DEBUG [141]|DEBUG|Inserted And Updated List (Account:{Name=Tech-Trash-Four, Phone=232323, Id=0015i00000AglNlAAJ}, Account:{Id=0015i00000AgkpmAAB, Name=Tech-Trash-Two, Phone=777777})
    */

    // 4. MERGE
    public static void mergeRecord(){
        // Accessing a existing Account record which do not have any contact
        Account acc4 = [SELECT Id, Name, Phone FROM Account WHERE Name='Tech-Trash-Four'];
        // Accessing a existing record which have contact details
        Account accMerge = [SELECT Id, Name, Phone FROM Account WHERE Name='Tech-Trash-Three'];
        // Now initiate the Merge operation
        merge acc4 accMerge;
        System.debug('After Merge ' +acc4);
    }
    /*
    HOW TO RUN IN ANONYMOUS WINDOW :-> 
    DmlWorking.mergeRecord();

    OUTPUT -> 
    16:30:07:625 USER_DEBUG [151]|DEBUG|After Merge Account:{Id=0015i00000AglNlAAJ, Name=Tech-Trash-Four, Phone=232323}
    */

    // 5. DELETE RECORDS
    public static void deleteRecord(){
        List<Account> delAcc = [SELECT Id,Name,Phone FROM Account WHERE Name = 'Tech-Trash-Two'];
        delete delAcc;
        System.debug('Deleted record ' +delAcc);
    }
    /*
    HOW TO RUN IN ANONYMOUS WINDOW :-> 
    DmlWorking.deleteRecord();

    OUTPUT -> 
    16:32:39:036 USER_DEBUG [157]|DEBUG|Deleted record ()
    */

    // 6. UNDELETE RECORDS
    public static void unDeleteRecord(){
        List<Account> deletedAcc = [SELECT Id,Name,Phone FROM Account WHERE Name = 'Tech-Trash-Two' ALL ROWS];
        undelete deletedAcc;
        System.debug('Undeleted record ' +deletedAcc);
    }
    /*
    HOW TO RUN IN ANONYMOUS WINDOW :-> 
    DmlWorking.unDeleteRecord();

    OUTPUT -> 
    16:35:16:653 USER_DEBUG [163]|DEBUG|Undeleted record (Account:{Id=0015i00000AgkpmAAB, Name=Tech-Trash-Two, Phone=777777})
    */
}
