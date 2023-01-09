@isTest(seeAllData=false)
private class LightningDesignSystemControllerTest {
    @TestSetup static void testDataSetup(){    
        Contact c = new Contact(LastName='Test');
        insert c;
    }
    
	@isTest 
    static void testGetTypeOptions(){
        // FOR OPTION
        Test.StartTest();
            LightningDesignSystemController ldsController = new LightningDesignSystemController();
            List<SelectOption> optionList = ldsController.getTypeOptions();
            System.Assert(optionList!= NULL);
        Test.StopTest();
    }
    
    @isTest 
    static void testGetInterestOptions(){
        Test.StartTest();
            LightningDesignSystemController ldsController = new LightningDesignSystemController();
            List<SelectOption> optionList = ldsController.getInterestOptions();
            System.Assert(optionList!= NULL);
        Test.StopTest();
    }
    
    @isTest
    static void testCancel(){
        Test.StartTest();
            LightningDesignSystemController ldsController = new LightningDesignSystemController();
            PageReference referenceOfPage = ldsController.cancel();
            System.assertNotEquals(null, referenceOfPage, 'Page Reference is null');
        Test.StopTest();
    }
    
    @isTest
    static void testSave(){
        Test.StartTest();
	    LightningDesignSystemController ldsController = new LightningDesignSystemController();
	    List<Contact> con = [SELECT Id, LastName FROM Contact WHERE LastName = 'Test'];
	    ApexPages.currentPage().getParameters().put('name', 'Test Training');
	    ApexPages.currentPage().getParameters().put('hidden', con[0].Id);
	    ApexPages.currentPage().getParameters().put('mail', '');
            ApexPages.currentPage().getParameters().put('interest', '');
	    ApexPages.currentPage().getParameters().put('Birthday', '2023-01-01');
	    ApexPages.currentPage().getParameters().put('avatar', 'Test.png');
		
            PageReference referenceOfPage = ldsController.save();
            List<Training__c> trRecords = [SELECT Id, Name FROM Training__c WHERE Id =: referenceOfPage.getParameters().get('Id')];
            System.Assert(trRecords.size() != null);
        
            LightningDesignSystemController ldsControllerTwo = new LightningDesignSystemController();
            ApexPages.currentPage().getParameters().put('name', '');
            PageReference referenceOfPageTwo = ldsControllerTwo.save();
        Test.StopTest();
    }
    
    @isTest
    static void testDisplayData(){
        Test.StartTest();
            Contact con = [SELECT Id, LastName FROM Contact WHERE LastName = 'Test'];
            ApexPages.currentPage().getParameters().put('con', 'Test');
            LightningDesignSystemController ldsController = new LightningDesignSystemController();
            ldsController.DisplayData();
            System.assert(ldsController.conList.size() == 1, 'Expected 1 contact in search results');
        Test.StopTest();
    }     
}
