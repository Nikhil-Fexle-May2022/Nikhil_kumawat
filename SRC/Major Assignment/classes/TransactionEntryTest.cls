@isTest
public class TransactionEntryTest {
    @testSetup
    private static void transactionRecordsTest(){
        List<Transaction_Limit__c> newList = new List<Transaction_Limit__c>();
        Transaction_Limit__c txnRecord = new Transaction_Limit__c();
        txnRecord.Name = 'Cipher';
        txnRecord.Maximum_Debit_Allowed_per_Month__c = 30000;
        txnRecord.Maximum_Transactions_Allowed_per_Month__c = 2;
        txnRecord.Maximum_Debit_Allowed_per_Day__c = 12000;
        txnRecord.Maximum_Transactions_Allowed_per_Day__c = 2;
        txnRecord.Maximum_Debit_Allowed_per_Transaction__c = 4000;
        newList.add(txnRecord);
        
        Transaction_Limit__c txnRecordOne = new Transaction_Limit__c();
        txnRecordOne.Name = 'Jett';
        txnRecordOne.Maximum_Debit_Allowed_per_Month__c = 40000;
        txnRecordOne.Maximum_Transactions_Allowed_per_Month__c = 4;
        txnRecordOne.Maximum_Debit_Allowed_per_Day__c = 15000;
        txnRecordOne.Maximum_Transactions_Allowed_per_Day__c = 3;
        txnRecordOne.Maximum_Debit_Allowed_per_Transaction__c = 5000;
        newList.add(txnRecordOne);
        
        insert newList;
        System.debug('Limits' +newList);
        
        List<Contact> conList = new List<Contact>();
        Contact con = new Contact();
        con.LastName = 'Valorant';
        con.Status__c = 'Active';
        con.Email = 'valo@onegmail.com';
        con.Transaction_Limit__c = newList[0].id;
        con.Available_Balance__c = 0;
        conList.add(con);
        
        Contact conOne = new Contact();
        conOne.LastName = 'Legends';
        conOne.Status__c = 'Active';
        conOne.Email = 'legend@onegmail.com';
        conOne.Transaction_Limit__c = newList[0].id;
        conOne.Available_Balance__c = 0;
        conList.add(conOne);
        
        insert conList;
        System.debug('Contact' +conList);
             
    }
    @isTest
    private static void testCreditAndDevit(){
        
        List<Contact> ListOfCon = [Select Id, LastName From Contact WHERE LastName = 'Valorant'];
        
        List<Transaction_Entry__c> txnList = new List<Transaction_Entry__c>();
        Transaction_Entry__c txnEntry = new Transaction_Entry__c();
        txnEntry.Amount__c = 25000;
        txnEntry.Type__c = 'Credit';
        txnEntry.Status__c = 'Pending';
        txnEntry.Transaction_Date__c = System.today();
        txnEntry.Contact__c = ListOfCon[0].id;
        txnList.add(txnEntry);
        insert txnEntry;
        
        List<Contact> noncept = [SELECT ID, Available_Balance__c FROM Contact WHERE Id = :ListOfCon[0].Id];
        system.assertEquals(25000, noncept[0].Available_Balance__c);
        
      	Transaction_Entry__c txnEntryOne = new Transaction_Entry__c();
        txnEntryOne.Amount__c = 2000;
        txnEntryOne.Type__c = 'Debit';
        txnEntryOne.Status__c = 'Pending';
        txnEntryOne.Transaction_Date__c = System.today();
        txnEntryOne.Contact__c = ListOfCon[0].id;
        txnList.add(txnEntryOne);
        insert txnEntryOne;
        
        List<Contact> noncept1 = [SELECT ID, Available_Balance__c FROM Contact WHERE Id = :ListOfCon[0].Id];
        system.assertEquals(23000, noncept1[0].Available_Balance__c);
        
        Transaction_Entry__c txnEntryTwo = new Transaction_Entry__c();
        txnEntryTwo.Amount__c = 1000;
        txnEntryTwo.Type__c = 'Debit';
        txnEntryTwo.Status__c = 'Pending';
        txnEntryTwo.Transaction_Date__c = System.today();
        txnEntryTwo.Contact__c = ListOfCon[0].id;
        txnList.add(txnEntryTwo);
        insert txnEntryTwo;
        
        List<Contact> noncept2 = [SELECT ID, Available_Balance__c FROM Contact WHERE Id = :ListOfCon[0].Id];
        system.assertEquals(22000, noncept2[0].Available_Balance__c);
        
        Transaction_Entry__c txnEntryThree = new Transaction_Entry__c();
        txnEntryThree.Amount__c = 1000;
        txnEntryThree.Type__c = 'Debit';
        txnEntryThree.Status__c = 'Pending';
        txnEntryThree.Transaction_Date__c = System.today();
        txnEntryThree.Contact__c = ListOfCon[0].id;
        txnList.add(txnEntryThree); 
        
        try{
            insert txnEntryThree;
        }
        catch(Exception d){
            System.debug('Limit exceed');
        }
        
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        List<Contact> conList = [Select Id, LastName From Contact WHERE LastName = 'Legends'];
        Transaction_Entry__c newEntry = new Transaction_Entry__c();
        newEntry.Amount__c = 30000;
        newEntry.Type__c = 'Credit';
        newEntry.Status__c = 'Pending';
        newEntry.Transaction_Date__c = System.today();
        newEntry.Contact__c = conList[0].id;
        insert newEntry;
        
        List<Contact> listOfLegendCon = [SELECT Id, LastName, Available_Balance__c FROM Contact WHERE ID =: conList[0].id];
        System.assertEquals(30000, listOfLegendCon.get(0).Available_Balance__c);
       
        List<Contact> conListOne = [Select Id, LastName From Contact WHERE LastName = 'Legends'];
        Transaction_Entry__c fourth = new Transaction_Entry__c();
        fourth.Amount__c = 1000;
        fourth.Type__c = 'Debit';
        fourth.Status__c = 'Pending';
        fourth.Transaction_Date__c = System.today();
        fourth.Contact__c = conListOne[0].id;
        insert fourth;
        
        List<Contact> listOfFive = [SELECT Id, LastName, Available_Balance__c FROM Contact WHERE ID =: conListOne[0].id];
        System.assertEquals(29000, listOfFive.get(0).Available_Balance__c);
        
        List<Contact> conListTwo = [Select Id, LastName From Contact WHERE LastName = 'Legends'];
        Transaction_Entry__c fifth = new Transaction_Entry__c();
        fifth.Amount__c = 2000;
        fifth.Type__c = 'Debit';
        fifth.Status__c = 'Pending';
        fifth.Transaction_Date__c = System.today();
        fifth.Contact__c = conListTwo[0].id;
        insert fifth;
        
        List<Contact> listOfFour = [SELECT Id, LastName, Available_Balance__c FROM Contact WHERE ID =: conList[0].id];
        System.assertEquals(27000, listOfFour.get(0).Available_Balance__c);
        
    /*    List<Transaction_Entry__c> listTxn = new List<Transaction_Entry__c>();
        for(Integer j=1;j<=2;j++){
            Transaction_Entry__c txset = new Transaction_Entry__c();
            txset.Amount__c = 500;
            txset.Type__c = 'Debit';
            txset.Status__c = 'Pending';
            txset.Transaction_Date__c = Date.newInstance(2022, 10, 10);
            txset.Contact__c = conList[0].id;
            listTxn.add(txset);
        }
        insert listTxn; */
       /*  
        List<Contact> listOfLegendCon1 = [SELECT Id, LastName, Available_Balance__c FROM Contact WHERE ID =: conList[0].id];
        System.assertEquals(29000, listOfLegendCon1[0].Available_Balance__c);
        
        Transaction_Entry__c newTwo = new Transaction_Entry__c();
        newTwo.Amount__c = 500;
        newTwo.Type__c = 'Debit';
        newTwo.Status__c = 'Pending';
        newTwo.Transaction_Date__c = System.today();
        newTwo.Contact__c = conList[0].id;
        
        try{
            insert newTwo;
        }catch(exception e){
            System.debug('Exceed');
        }
*/
    }
}