@isTest(seeAllData = false)
private class SobjectSchemaControllerTest {
    
    @isTest static void testGetallObjects(){
        Test.StartTest();
            Boolean found;
            SobjectSchemaController controlClass = new SobjectSchemaController();
            List<SelectOption> listOfOption = controlClass.getallObjects();
            for(SelectOption so : listOfOption){
                if(so.getValue() == 'Account'){
                    found = true;
                    break;
                }
            }
            System.assertEquals(found, true);
        	System.Assert(listOfOption != Null);
        Test.StopTest();
    }
    
    @isTest static void testGetPermissions(){
        Test.StartTest();
        	SobjectSchemaController controlClass = new SobjectSchemaController();
        	controlClass.getPermissions();
        
            SobjectSchemaController controlClassOne = new SobjectSchemaController();
            controlClassOne.val = 'Account';
            controlClassOne.getPermissions();
        
            System.assert(controlClassOne != null);
        	System.assertEquals(false, controlClassOne.flagsave, 'Error ! Conditions are not satisfied');
        	System.assertEquals(false, controlClassOne.dispalyfield, 'Error ! Conditions are not fulfilled');
        Test.StopTest();
    }
    
    @isTest static void testNewRecord(){
        Test.StartTest();
        	SobjectSchemaController controlClass = new SobjectSchemaController();
        	controlClass.val = 'Account';
        	controlClass.newRecord();
        
        	System.Assert(controlClass.selectedobject != Null);
        	System.assertEquals(true, controlClass.flagsave, 'Error Not be specified');
        	System.assertEquals(false, controlClass.dispalyfield, 'Error Could not be specified');
        Test.StopTest();
    }
    
    @isTest static void testSave(){
        Test.StartTest();
            SobjectSchemaController controller = new SobjectSchemaController();
        	controller.val = 'Account';
        
            List<Account> accountRecordList = TestFactory.createAccountList(2, false);
            for(Account acc : accountRecordList){
                acc.Account_Status__c = 'Not Started';
            }
        	
        	MockDAO.AccountMockDAO accountMockDAOInstance = new MockDAO.AccountMockDAO();
            accountMockDAOInstance.accounts = accountRecordList;
        
        	AccountDAO.IAccountDAO accountDAOInstance = new AccountDAO();
        	accountDAOInstance = accountMockDAOInstance;
        	List<Account> accList = accountDAOInstance.generateAccount();
        	controller.selectedobject = accList[0];
        	controller.objectlist = new Map<String, Schema.SObjectType>();
            controller.save();
        
        	System.assertEquals(false, controller.flagsave, 'Matched not specified');
        	System.Assert(controller.selectedobject != Null);
        Test.StopTest();
    }
    
    @isTest static void testGetfieldvalues(){
        Test.StartTest();
        	SobjectSchemaController controlClass = new SobjectSchemaController();
        	controlClass.val = 'Account';
			controlClass.getfieldvalues();  
        	
        	System.assert(controlClass.FieldvalueList != Null);
        	System.assertEquals(true, controlClass.dispalyfield, 'Fields are not specified');
        	System.assertEquals(false, controlClass.flagsave, 'Conditions not match');
        Test.StopTest();
    }
}
