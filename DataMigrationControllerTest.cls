@isTest(seeAllData=false)
private class DataMigrationControllerTest {
	@TestSetup
    static void testDataSetup(){

        Account acc = new Account(Name='Test Account', Account_Status__c = 'Not Started');
        insert acc;
        
        Connection__c connection = new Connection__c();
        connection.Access_Token__c = '00D5g000004gZLhEAM001AB854967213025';
        connection.InstanceUrl__c = 'https://test.salesforce.com';
        insert connection;
        
        Object_Mapping__c obj = new Object_Mapping__c();
        obj.External_Id__c = 'AccountNumber';
        obj.Referenced_Field__c = 'AccountNumber';
        obj.Connection__c = connection.Id;
        obj.Target_Org_Object_Name__c = 'Account';
        obj.Source_Org_Object_Name__c = 'Account';
        insert obj;
        
        Data_Migration__c dataMigrationTestData = new Data_Migration__c();
        dataMigrationTestData.Name = 'Data Migration Test 1';
        dataMigrationTestData.Connection__c = connection.Id;
        dataMigrationTestData.DML_Operation__c = 'Create';
        dataMigrationTestData.ObjectMapping__c = obj.Id;
        dataMigrationTestData.Where_Clause__c = 'CreatedDate=today';
        dataMigrationTestData.isAlreadyRun__c = false;
        insert dataMigrationTestData;	
        
        Field_Mapping__c fieldData = new Field_Mapping__c();
        fieldData.Source_Org_Field_Name__c = 'Name';
        fieldData.Target_Org_Field_Name__c = 'Name';
        fieldData.ObjectMapping__c = obj.Id;
        insert fieldData;
        
        Migration_Batch__c migrationBatchData = new Migration_Batch__c();
        migrationBatchData.Data_Migration__c = dataMigrationTestData.Id;
        migrationBatchData.IsChild__c = true;
        insert migrationBatchData; 
        
        Migration_Status__c migrationStatusData = new Migration_Status__c();
        migrationStatusData.Migration_Failed_Batch__c = migrationBatchData.Id;
        migrationStatusData.Migration_Succeeded_Batch__c = migrationBatchData.Id;
		migrationStatusData.Failure_Reason__c = 'Error ! Check your Data';
        migrationStatusData.Source_Record_Link__c = dataMigrationTestData.Id;
        migrationStatusData.Target_Record_Link__c = dataMigrationTestData.Id;
       	insert migrationStatusData;
        
        Data_Migration__c dataMigrationTestData2 = new Data_Migration__c();
        dataMigrationTestData2.Name = 'Test Migration';
        dataMigrationTestData2.DML_Operation__c = '';
        dataMigrationTestData2.Connection__c = connection.Id;
        dataMigrationTestData2.ObjectMapping__c = obj.Id;
        dataMigrationTestData2.Where_Clause__c = 'CreatedDate=today';
        dataMigrationTestData2.Child_Object__c = 'This is process for Test Composition.';
        dataMigrationTestData2.isAlreadyRun__c = false;
        insert dataMigrationTestData2;	
        
        Data_Migration__c dataMigrationTestData3 = new Data_Migration__c();
        dataMigrationTestData3.Name = 'Test Migration 3';
        dataMigrationTestData3.DML_Operation__c = 'Update';
        dataMigrationTestData3.Connection__c = connection.Id;
        dataMigrationTestData3.ObjectMapping__c = obj.Id;
        dataMigrationTestData3.Where_Clause__c = 'CreatedDate=today';
        dataMigrationTestData3.Child_Object__c = 'This is process for Test Composition 2nd method';
        dataMigrationTestData3.isAlreadyRun__c = false;
        insert dataMigrationTestData3;
        
        Data_Migration__c dataMigrationTestData4 = new Data_Migration__c();
        dataMigrationTestData4.Name = 'Test Migration 4';
        dataMigrationTestData4.DML_Operation__c = 'Create';
        dataMigrationTestData4.Connection__c = connection.Id;
        dataMigrationTestData4.ObjectMapping__c = obj.Id;
        dataMigrationTestData4.Where_Clause__c = 'CreatedDate=today';
        dataMigrationTestData4.Child_Object__c = 'This is process for Test Composition 2nd method True Condition';
        dataMigrationTestData4.isAlreadyRun__c = false;
        insert dataMigrationTestData4;
        
        Data_Migration__c runMethodTestData = new Data_Migration__c();
        runMethodTestData.Name = 'Run Method Test data';
        runMethodTestData.DML_Operation__c = 'Delete';
        runMethodTestData.Connection__c = connection.Id;
        runMethodTestData.ObjectMapping__c = obj.Id;
        runMethodTestData.Where_Clause__c = 'CreatedDate=today';
        runMethodTestData.isAlreadyRun__c = false;
        insert runMethodTestData;

        LookupMapping__c lookupData = new LookupMapping__c();
        lookupData.FieldMapping__c = fieldData.Id;
        lookupData.Target_Object_Name__c = 'Account';
        lookupData.Data_Migration__c = dataMigrationTestData.Id;
        insert lookupData; 
        
    }
    
    @isTest
    static void testSaveDataTrue(){
        Test.StartTest();
            List<Data_Migration__c> dataColl= [SELECT Id, Name, Connection__c, DML_Operation__c,ObjectMapping__c, Object_Mapping__c 
                                               FROM Data_Migration__c 
                                               WHERE Name = 'Data Migration Test 1'];
        	ApexPages.StandardController mockController = new ApexPages.StandardController(dataColl[0]);
            DataMigrationController dataController = new DataMigrationController(mockController);
            dataController.data = dataColl[0];
            PageReference saveData = dataController.saveData();
            System.assertEquals('Data Migration Test 1', dataColl[0].Name);
        
            List<Data_Migration__c> dataCollTwo = [SELECT Id, Name, Connection__c, DML_Operation__c,ObjectMapping__c, Object_Mapping__c 
                                                   FROM Data_Migration__c 
                                                   WHERE Name = 'Test Migration'];      
        	ApexPages.StandardController mockControllerTwo = new ApexPages.StandardController(dataCollTwo[0]);
            DataMigrationController dataControllerTwo = new DataMigrationController(mockControllerTwo);
            dataControllerTwo.data = dataCollTwo[0];
            PageReference saveDataTwo = dataControllerTwo.saveData();
            System.assertEquals('Test Migration', dataCollTwo[0].Name); 
        Test.StopTest();
    }
    
    @isTest
    static void testSaveDataFalse(){
        Test.StartTest();
            Data_Migration__c emptyDataList = new Data_Migration__c();
            ApexPages.StandardController mockController = new ApexPages.StandardController(emptyDataList);
            DataMigrationController dataController = new DataMigrationController(mockController);
        	dataController.data = Null;
        	dataController.awaitingMigrationList = Null;
        	PageReference savedData = dataController.saveData();
       		System.assertEquals(Null, savedData);
        Test.StopTest();
    }
    
    @isTest
    static void testRunBatch(){
        Test.StartTest();
            //List<Data_Migration__c> storedData = [Select Id, Where_Clause__c,Child_Object__c,Connection__c,Connection__r.InstanceUrl__c, isAlreadyRun__c, DML_Operation__c,ObjectMapping__c, Data_Migration__r.Name,ObjectMapping__r.Name From Data_Migration__c Where isAlreadyRun__c = False AND Name = 'Test Migration 3' Order By CreatedDate Desc];
			List<Data_Migration__c> storedData = [SELECT Id, Name, Connection__c, DML_Operation__c,ObjectMapping__c
                                                  FROM Data_Migration__c 
                                                  WHERE Name = 'Run Method Test data'];
        	ApexPages.StandardController mockController = new ApexPages.StandardController(storedData[0]);
            DataMigrationController dataController = new DataMigrationController(mockController);
            dataController.dataTableIndex = 2;
            PageReference testBatch = dataController.runBatch();
        	System.Assert(testBatch != Null);
        Test.StopTest();
    }
    
    
    @isTest
    static void testEditMigrationFalse(){
        Test.StartTest();
            List<Data_Migration__c> storedDataForClass = [SELECT Id, Name, Connection__c, DML_Operation__c,ObjectMapping__c,Data_Migration__c, 
                                                          Object_Mapping__c FROM Data_Migration__c 
                                                          WHERE Name LIKE 'Data Migration Test 1'];
            ApexPages.StandardController mockingControl = new ApexPages.StandardController(storedDataForClass[0]);
            DataMigrationController dataController = new DataMigrationController(mockingControl);
            ApexPages.currentPage().getParameters().put('index', '0');
            //dataController.awaitingMigrationList = storedDataForClass;
            dataController.editMigration();
        	System.assertEquals(true, dataController.isMapping, 'Not Getting the Solution');
        Test.StopTest();
    }
    
    @isTest
    static void testGetAvilableObjectMappingFalse(){
        Test.StartTest();
            List<Data_Migration__c> dataColl= [SELECT Id, Name, Connection__c, DML_Operation__c,ObjectMapping__c, Object_Mapping__c 
                                               FROM Data_Migration__c 
                                               WHERE Name = 'Data Migration Test 1'];
            ApexPages.StandardController mockController = new ApexPages.StandardController(dataColl[0]);
            DataMigrationController dataController = new DataMigrationController(mockController);
        	dataController.getAvilableObjectMapping();
		Test.StopTest();
    }
    
    
    @isTest
    static void testGetAvilableObjectMappingTrue(){
        Test.StartTest();
            Data_Migration__c dataColl= [SELECT Id, Name, Connection__c, DML_Operation__c,ObjectMapping__c, Object_Mapping__c 
                                         FROM Data_Migration__c 
                                         WHERE Name = 'Test Migration 3'];
            ApexPages.StandardController mockController = new ApexPages.StandardController(dataColl);
            DataMigrationController dataController = new DataMigrationController(mockController);
        	dataController.data = dataColl;
            dataController.getAvilableObjectMapping();
        Test.StopTest();
    } 
}