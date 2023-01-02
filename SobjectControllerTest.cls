@isTest(seeAllData = false)
public with sharing class SobjectControllerTest {
    
    @TestSetup
    static void createTestData(){
        Account newAccRecord = new Account();
        newAccRecord.Name = 'Test Domain';
        newAccRecord.Account_Status__c = 'Not started';
        insert newAccRecord;
        
        Contact conRealtedAcc = new Contact();
        conRealtedAcc.FirstName = 'Contact';
        conRealtedAcc.LastName = 'Test Record';
        conRealtedAcc.AccountId = newAccRecord.Id;
        insert conRealtedAcc;
    }
    
    @isTest static void testGetallObjects(){
        List<Contact> conList = [SELECT Id, FirstName, LastName FROM Contact WHERE FirstName = 'Contact'];
        
        Test.StartTest();
        	SobjectController controllerInst = new SobjectController();
        	List<SelectOption> result = controllerInst.getallObjects();
        Test.StopTest();
        System.Assert(result != null);
    }
    
    @isTest static void testGetFields(){
        Test.StartTest();
        	SobjectController controllerInstTwo = new SobjectController();
        	controllerInstTwo.val = 'Contact';
        	controllerInstTwo.getFields();
        
            SobjectController controllerInst = new SobjectController();
            controllerInst.val = '';
            controllerInst.getFields();
        Test.StopTest();
        System.Assert(controllerInstTwo.getFields() != null);
    }
    
    @isTest static void testObjectRecords(){
        SobjectController controllerInstThree = new SobjectController();
        //controllerInstThree.displayfield = 'Id';
        controllerInstThree.displayfield = '[LastName]';
        controllerInstThree.val = 'Contact';
        controllerInstThree.test = 'Record';
        controllerInstThree.conditionfield = '[LastName]';
        
        SobjectController controllerInstFour = new SobjectController();
        controllerInstFour.test = '';
        controllerInstFour.displayfield = '[]';
        controllerInstFour.conditionfield = '[]';
        
        Test.StartTest();
        	controllerInstThree.ObjectRecords();
        	controllerInstFour.ObjectRecords();
        Test.StopTest();
        System.assertEquals(true, controllerInstThree.records);
        System.assertEquals(true, controllerInstFour.records);
    }
}