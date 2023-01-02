@isTest(seeAllData = false)
private with sharing class SchedulBatchForDataTemplateQueueableJB {

    @isTest
    public static void testDataMethod(){
        Data_Template__c testData = new Data_Template__c();
        testData.Name = 'TestDataTemplate';
        insert testData;
        
        Test.StartTest();
            SchedulBatchForDataTemplateQueueableJob obj = new SchedulBatchForDataTemplateQueueableJob(testData);
            String scheduleExp = '0 0 * * * ?';
            System.schedule('Test Job', scheduleExp, obj);
        Test.StopTest();
        System.Assert(obj != null);
    }
}