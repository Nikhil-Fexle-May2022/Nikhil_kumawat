@isTest
// MINI STATEMENT
public class StatementTest {
	 @testSetup 
    static void setupTestData()
    {
        //Inserting Limit 
        Transaction_Limit__c transaction_Limit_Obj = new Transaction_Limit__c(Name = 'Bank Limit', 
                                                                              Maximum_Debit_Allowed_per_Month__c = 10000, 
                                                                              Maximum_Debit_Allowed_per_Day__c = 3000, 
                                                                              Maximum_Debit_Allowed_per_Transaction__c = 2000, 
                                                                              Maximum_Transactions_Allowed_per_Month__c = 100, 
                                                                              Maximum_Transactions_Allowed_per_Day__c = 7);

        insert transaction_Limit_Obj;
        
        //Inserting Contact
        Contact contact_Obj = new Contact(FirstName = 'Con ' + 1, LastName = 'Test', Transaction_Limit__c =         
                              transaction_Limit_Obj.Id, Email = 'abcd@abcd.com', 
                              Available_Balance__c = 20000, Status__c = 'Active' );
        
        insert contact_Obj;
        
        //date
        Date dt = Date.newInstance(2022,10,1);
        Date dt2 = Date.newInstance(2022,11,1);

        //List to hold Transaction
        List<Transaction_Entry__c> transaction_Entry_List = new List<Transaction_Entry__c>();
            
        //Inserting First Transaction
        transaction_Entry_List.add(new Transaction_Entry__c(Amount__c = 100, type__c = 'Debit', Status__c = 'Completed', Contact__c = contact_Obj.Id, Transaction_Date__c = Date.today()));

        transaction_Entry_List.add(new Transaction_Entry__c(Amount__c = 200, type__c = 'Debit', Status__c = 'Completed', Contact__c = contact_Obj.Id, Transaction_Date__c = Date.today()));

        transaction_Entry_List.add(new Transaction_Entry__c(Amount__c = 300, type__c = 'Debit', Status__c = 'Completed', Contact__c = contact_Obj.Id, Transaction_Date__c = Date.today()));

        insert transaction_Entry_List;


    }

    @isTest
    static void testTransactionEntriesAndEmail()
    {
        Test.startTest();
        
        //date 
        Date dt = Date.newInstance(2022,10,1);
        Date dt2 = Date.newInstance(2022,11,1);
        String date1 = string.valueOf(dt);
        String date2 = string.valueOf(dt2);
        
        //Getting contact id
        Contact con = [SELECT Id FROM Contact];

        //Method two
        List<Transaction_Entry__c> Transaction_Entry_List_Method2 = EmailStatement.getStatement(con.Id,dt,dt2);

        //Method three
        EmailStatement.sendEmail(con.Id);
        
        Integer invocations = Limits.getEmailInvocations();
        
		Test.stopTest();
        
        //Assert to check number of email sent
        System.assertEquals(1, invocations, 'An email should be sent');

    }
}