@isTest(seeAllData = false)
public class RecordPdfTest {
	@testSetup
    private static void gettingData(){
        List<Contact> newContact = new List<Contact>();
        Contact con = new Contact();
        con.LastName = 'Sagar';
        con.Status__c = 'Active';
        con.Email = 'sagarsafe@gamil.com';
        con.Available_Balance__c = 0;
        newContact.add(con);
        insert newContact;
        
        List<Transaction_Entry__c> entryList = new List<Transaction_Entry__c>();
        Transaction_Entry__c newEntry = new Transaction_Entry__c();
        newEntry.Amount__c = 20000;
        newEntry.Type__c = 'Debit';
        newEntry.Status__c = 'Pending';
        newEntry.Contact__c = newContact[0].id;
        newEntry.Transaction_Date__c = System.today();     
        entryList.add(newEntry);
        
        Transaction_Entry__c secondEntry = new Transaction_Entry__c();
        secondEntry.Amount__c = 20000;
        secondEntry.Type__c = 'Debit';
        secondEntry.Status__c = 'Pending';
        secondEntry.Contact__c = newContact[0].id;
        secondEntry.Transaction_Date__c = System.today();     
        entryList.add(secondEntry);
   	}
    
    @isTest
    private static void testingData(){
        List<Contact> conlist = [SELECT Id, Title, Name , Email, Account_Number__c FROM Contact WHERE LastName = 'Sagar'];
        System.assertEquals(1, conlist.size());
        Test.startTest();
        Records_PDF_Controller obj = new Records_PDF_Controller();
        obj.recordPdf();
        Test.stopTest();
    }
}