@isTest
public class MiniStatementTest {
	@isTest
    private static void testMini(){
        Contact con = new Contact();
        con.LastName = 'Scout';
        con.Status__c = 'Active';
        con.Email = 'differentUser@gmail.com';
        con.Available_Balance__c = 0;
        insert con;
        
        Transaction_Entry__c trex = new Transaction_Entry__c();
        trex.Amount__c = 10000;
        trex.Type__c = 'Credit';
        trex.Status__c = 'Pending';
        trex.Contact__c = con.Id;
        trex.Transaction_Date__c = System.today();
        insert trex;
        
        RecordsTransaction.takeRecords(con.Id, 1);
    }
}