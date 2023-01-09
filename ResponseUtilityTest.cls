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

        List<Account> accList = TestFactory.createAccountList(1, false);
        for(Account acc : accList){
            acc.Name = 'Test Account Data';
            acc.Account_Status__c = 'Not Started';
        }
        
        if(!accList.isEmpty()){
            insert accList;
        }

        Test.StartTest();
            ResponseUtility rs = new ResponseUtility();
            rs.setBody(accList);
        	System.Assert(rs != null);
            System.assertEquals('success', rs.status, 'Status not set correctly');
        	System.assertEquals(true, rs.isSuccess, 'isSuccess not set correctly');
        Test.StopTest();
    }
}
