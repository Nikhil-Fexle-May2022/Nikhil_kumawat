@isTest(seeAllData = false)
public with sharing class SobjectControllerTest {
    
    @isTest 
    static void testGetallObjects(){
        
        List<Contact> conList = TestFactory.createContactList(2, false);
        for(Contact con : conList){
            con.Id = TestFactory.getFakeId(Contact.SObjectType);
            con.FirstName = 'Contact';
        }
        
        MockDAO.ContactMockDAO contactMockDAOInstance = new MockDAO.ContactMockDAO();
        contactMockDAOInstance.contactList = conList;
        
        Test.StartTest();
            ContactDAO.IContactDAO contactDAOInstance = new ContactDAO();
            contactDAOInstance = contactMockDAOInstance;
            List<Contact> contacts = contactDAOInstance.generateContact();
        	SobjectController controllerInst = new SobjectController();
        	List<SelectOption> result = controllerInst.getallObjects();
        	controllerInst.selectedobject = contacts[0];
        	Schema.DescribeFieldResult desribeResult = Account.Name.getDescribe();
        	controllerInst.desribeResult = desribeResult;	
        
            System.Assert(result != null);
        	System.assertEquals('None', result[0].getValue());
       		System.assertNotEquals(0, result.size());
        	System.assertEquals(true, Schema.getGlobalDescribe().get(result[1].getValue()).getDescribe().isUpdateable() && Schema.getGlobalDescribe().get(result[1].getValue()).getDescribe().isSearchable());
        Test.StopTest();
    }
    
    @isTest static void testGetFieldsTrue(){
        Test.StartTest();
        	SobjectController controllerInstTwo = new SobjectController();
        	controllerInstTwo.val = 'Contact';
        	controllerInstTwo.getFields();
        
         	System.Assert(controllerInstTwo.getFields() == null);
        	System.assertEquals(true, controllerInstTwo.abc, 'Error ! Conditions not confirmed yet');
        	System.assertEquals(false, controllerInstTwo.fields, 'Conditions yet to be Confirmed');
        Test.StopTest();
    }
    
    @isTest static void testGetFieldsFalse(){
        Test.StartTest();
            SobjectController controllerInst = new SobjectController();
            controllerInst.val = 'None';
            controllerInst.getFields();
        
        	System.assertEquals(false, controllerInst.abc, 'Error ! Conditions not confirmed yet');
        	System.assertEquals(true, controllerInst.fields, 'Conditions yet to be Confirmed');
        Test.StopTest();
    }
    
    @isTest static void testObjectRecordsTrue(){
        SobjectController controllerInstThree = new SobjectController();
        controllerInstThree.displayfield = '[LastName]';
        controllerInstThree.val = 'Contact';
        controllerInstThree.test = 'Record';
        controllerInstThree.conditionfield = '[LastName]';
        
        Test.StartTest();
        	controllerInstThree.ObjectRecords();
        	Person__c personRecord = new Person__c(Name='Test person', phone__c='4545654321', Gender__c='Male');
        	controllerInstThree.sobj = personRecord;
        
            System.assertEquals(true, controllerInstThree.records);
        	System.assertNotEquals(1, controllerInstThree.sobjlist.size());
       	 	System.assertNotEquals(1, controllerInstThree.lstFlds.size());
        Test.StopTest();
    }
    
    @isTest static void testObjectRecordsFalse(){      
        SobjectController controllerInstFour = new SobjectController();
        controllerInstFour.test = '';
        controllerInstFour.displayfield = '[]';
        controllerInstFour.conditionfield = '[]';
        
        Test.StartTest();
        	controllerInstFour.ObjectRecords();
        	controllerInstFour.objectlist = new Map<String, Schema.SObjectType>();
        	System.assertEquals(true, controllerInstFour.records);
        Test.StopTest();
    }
}
