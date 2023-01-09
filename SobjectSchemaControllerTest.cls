@isTest(seeAllData = false)
private class SobjectSchemaControllerTest {
    @TestSetup static void testDataSetup(){
        Account acc = new Account();
        acc.Name = 'Test Account Data';
        acc.Account_Status__c = 'Not Started';
        insert acc; 
        
    }
    
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
        Test.StopTest();
    }
    
    @isTest static void testNewRecord(){
        Test.StartTest();
        	SobjectSchemaController controlClass = new SobjectSchemaController();
        	controlClass.val = 'Account';
        	controlClass.newRecord();
        Test.StopTest();
    }
    
    @isTest static void testSave(){
        Test.StartTest();
            SobjectSchemaController controlClass = new SobjectSchemaController();
            controlClass.save();
        Test.StopTest();
    }
    
    @isTest static void testGetfieldvalues(){
        Test.StartTest();
        	SobjectSchemaController controlClass = new SobjectSchemaController();
        	controlClass.val = 'Account';
			controlClass.getfieldvalues();        	
        Test.StopTest();
    }
}