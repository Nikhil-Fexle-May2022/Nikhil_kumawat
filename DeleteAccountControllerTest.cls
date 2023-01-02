@isTest(seeAllData = false)
public with sharing class DeleteAccountControllerTest {
    
    @isTest static void testDeleteLog(){
        Account acc = new Account(Name='Test Site', Account_Status__c = 'Not started');
        MockDAO.AccountMockDAO accountMockInstance = new MockDAO.AccountMockDAO();
        accountMockInstance.accounts.add(acc);

        Test.StartTest();
            List<Account> accList = [SELECT Id From Account];
            System.debug(accList);
            List<Account> accList1 = accountMockInstance.generateAccount();
            ApexPages.StandardSetController standardController = new ApexPages.StandardSetController(accList1);
            DeleteAccountController controller = new DeleteAccountController(standardController);
            controller.deleteLog();
        Test.StopTest();
        System.Assert(controller != null);
    }
}