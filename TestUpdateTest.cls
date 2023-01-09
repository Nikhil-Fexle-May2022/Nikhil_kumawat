@isTest(seeAllData = false)
public with sharing class TestUpdateTest {
    
    @TestSetup
    static void createData(){
        
        List<Contact> conList = TestFactory.createContactList(10, false);
        for(Contact con : conList){
            con.FirstName = 'Test';
            con.LastName = 'Data';
            con.Title = 'Data should be verified';
            con.Email = 'test@salesforce.com';
        }
        
        if(!conList.isEmpty()){
            insert conList;
        } 
    }
    
    @isTest
    private static void testUpdateContact(){
        
        List<Contact> con = [SELECT Id, FirstName, LastName, Title, Email FROM  Contact];
        
        Test.startTest();
            TestUpdate obj = new TestUpdate();
            obj.updateContact();
        	System.assert(con.size() != Null, 'List Could Not be null');
        	System.assertEquals('Test', con[0].FirstName, 'First name does not match');
            System.assertEquals('Data', con[0].LastName, 'Last name does not match');
            System.assertEquals('Data should be verified', con[0].Title, 'Title does not match');
            System.assertEquals('test@salesforce.com', con[0].Email, 'Email does not match');
        Test.stopTest();

    }
}
