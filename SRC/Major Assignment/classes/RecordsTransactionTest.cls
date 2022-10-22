@isTest(seeAllData = false)
public class RecordsTransactionTest {
	@testSetup 
    private static void setupTestData()
    {
        //Inserting Limit 
        Transaction_Limit__c transaction_Limit_Obj = new Transaction_Limit__c(Name = 'Bank Limits', 
                                                                              Maximum_Debit_Allowed_per_Month__c = 20000, 
                                                                              Maximum_Debit_Allowed_per_Day__c = 4000, 
                                                                              Maximum_Debit_Allowed_per_Transaction__c = 3000, 
                                                                              Maximum_Transactions_Allowed_per_Month__c = 60, 
                                                                              Maximum_Transactions_Allowed_per_Day__c = 3);

        insert transaction_Limit_Obj;
        
        //Inserting Contact
        Contact contact_Obj = new Contact(FirstName = 'Con ' + 1, LastName = 'Hydra', Transaction_Limit__c =         
                              transaction_Limit_Obj.Id, Email = 'hydraDan@abcd.com', 
                              Available_Balance__c = 20000, Status__c = 'Active' );
        
        insert contact_Obj;
        
        //date
        Date dt = Date.newInstance(2022,10,1);
        Date dt2 = Date.newInstance(2022,11,1);

        //List to hold Transaction
        List<Transaction_Entry__c> transaction_Entry_List = new List<Transaction_Entry__c>();
            
        //Inserting First Transaction
        transaction_Entry_List.add(new Transaction_Entry__c(Amount__c = 100, 
                                                            type__c = 'Debit', 
                                                            Status__c = 'Pending', 
                                                            Contact__c = contact_Obj.Id, 
                                                            Transaction_Date__c = dt));

        transaction_Entry_List.add(new Transaction_Entry__c(Amount__c = 200, 
                                                            type__c = 'Debit', 
                                                            Status__c = 'Pending', 
                                                            Contact__c = contact_Obj.Id, 
                                                            Transaction_Date__c = dt));

        transaction_Entry_List.add(new Transaction_Entry__c(Amount__c = 300, type__c = 'Debit', Status__c = 'Pending', Contact__c = contact_Obj.Id, Transaction_Date__c = dt));

        insert transaction_Entry_List;
    }
    @isTest
    private static void safeTestRecords(){
        Test.startTest();

        //Getting contact id
        Contact con = [SELECT Id FROM Contact];

        //Method two
        List<Transaction_Entry__c> Transaction_Entry_List_Method2 = RecordsTransaction.takeRecords(con.Id,10);

        Test.stopTest();
    }
}