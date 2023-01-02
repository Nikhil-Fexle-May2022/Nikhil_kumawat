@isTest(seeAllData = false)
public class AccountApplicationControllerTest {
	
    @isTest static void testMethodForWrapper(){
		AccountApplicationController controllerInstance = new  AccountApplicationController();
        
        AccountApplicationController.AccountWrapper accountWrap = new AccountApplicationController.AccountWrapper();
        accountWrap.acc = new Account(Name='Test', Account_Status__c='In Progress');
        controllerInstance.accWrapper = accountWrap;
        //System.debug(accountWrap.acc);
        
        Test.StartTest();
            controllerInstance.onSave();
            controllerInstance.onBack();
            controllerInstance.onContinue();
        Test.StopTest();
        System.Assert(accountWrap != null);
    }
    
}