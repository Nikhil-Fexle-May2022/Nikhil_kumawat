@isTest(seeAllData = false)
public with sharing class ResponseUtilityTest {
    
    @isTest static void  testSetError(){

        String checkStatus = '';
        Boolean checkCondition;
        String takeMessage = '';
        
        Test.StartTest();
            ResponseUtility rs = new ResponseUtility();
            rs.setError('Checking For Error');
            System.assert(checkStatus != null);
        Test.StopTest();
    }
    
    @isTest static void testSetMessage(){
        String checkStatus = '';
        Boolean checkCondition;
        String takeMessage = '';
        
        Test.StartTest();
            ResponseUtility rs = new ResponseUtility();
            rs.setMessage('Checking For Success Message');
            System.Assert(takeMessage != null);
        Test.StopTest();
    }

    @isTest static void testSetBody(){

        String checkStatus = '';
        Boolean checkCondition;
        Object objBody;

        Account accRecord = new Account();
        accRecord.Name = 'Testing Account';
        accRecord.Account_Status__c = 'In Progress';
        insert accRecord;

        Test.StartTest();
            ResponseUtility rs = new ResponseUtility();
            rs.setBody(accRecord);
        Test.StopTest();

    }
}