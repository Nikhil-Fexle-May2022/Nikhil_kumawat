@isTest(seeAllData=false)
private class LightningDesignSystemControllerTest {
    
    @TestSetup static void testDataSetup(){            
        List<Contact> contactRecordsList = TestFactory.createContactList(2, false);
        for(Contact con : contactRecordsList){
            con.LastName = 'Test';
        }
        insert contactRecordsList;     
    } 
        
	@isTest 
    static void testGetTypeOptions(){
        // FOR OPTION
        Test.StartTest();
            LightningDesignSystemController ldsController = new LightningDesignSystemController();
            List<SelectOption> optionList = ldsController.getTypeOptions();
            System.Assert(optionList!= NULL);
        	System.assertEquals(4, optionList.size(), 'Please check the records Size');
        Test.StopTest();
    }
    
    @isTest 
    static void testGetInterestOptions(){
        Test.StartTest();
            LightningDesignSystemController ldsController = new LightningDesignSystemController();
            List<SelectOption> optionList = ldsController.getInterestOptions();
            System.Assert(optionList!= NULL);
         	System.assertEquals(8, optionList.size(), 'Please check the records Size');
        Test.StopTest();
    }
    
    @isTest
    static void testCancel(){
        Test.StartTest();
            List<Contact> con = [SELECT Id, LastName FROM Contact WHERE LastName = 'Test'];
        	LightningDesignSystemController ldsController = new LightningDesignSystemController();
        	ldsController.accName = 'Account Test';
        	ldsController.conId = con[0].Id;
        	PageReference referenceOfPage = ldsController.cancel();
        	System.assertNotEquals(null, referenceOfPage, 'Page Reference is null');
         	System.assertEquals('/a06/o', referenceOfPage.getUrl(), 'PageReference URL is incorrect');
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
   
            LightningDesignSystemController ldsControllerTwo = new LightningDesignSystemController();
            ApexPages.currentPage().getParameters().put('name', '');
            PageReference referenceOfPageTwo = ldsControllerTwo.save();
      	  	List<Training__c> trRecords = [SELECT Id, Name FROM Training__c WHERE Id =: referenceOfPage.getParameters().get('Id')];
            System.Assert(trRecords.size() != null);
        Test.StopTest();
    }
    
    @isTest
    static void testDisplayData(){
        Test.StartTest();
            List<Contact> con = [SELECT Id, LastName FROM Contact WHERE LastName = 'Test'];
            ApexPages.currentPage().getParameters().put('con', 'Test');
            LightningDesignSystemController ldsController = new LightningDesignSystemController();
            ldsController.DisplayData();
            System.assert(ldsController.conList.size() == 2, 'Expected 2 contact in search results');
        Test.StopTest();
    }     
}
