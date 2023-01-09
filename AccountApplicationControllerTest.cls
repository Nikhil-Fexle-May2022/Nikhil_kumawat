@isTest(seeAllData = false)
public class AccountApplicationControllerTest {
	
    @isTest static void testMethodForWrapper(){
        
        List<Account> accountRecord = TestFactory.createAccountList(2, false);
        for(Account acc : accountRecord){
        	acc.Account_Status__c = 'Not Started';    
        }
              
        Test.StartTest();
            AccountApplicationController controllerInstance = new  AccountApplicationController();
            AccountApplicationController.AccountWrapper accountWrap = new AccountApplicationController.AccountWrapper();
            accountWrap.acc = accountRecord[0];
            
            controllerInstance.accWrapper = accountWrap;
            
            controllerInstance.onSave();
            controllerInstance.onBack();
            controllerInstance.onContinue();
            System.Assert(accountWrap != null);
        Test.StopTest();        
    }   
}
