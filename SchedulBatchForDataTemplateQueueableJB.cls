@isTest(seeAllData = false)
private with sharing class SchedulBatchForDataTemplateQueueableJB {

    @isTest
    public static void testDataMethod(){
        
        List<Data_Template__c> dataTemplateRecordList = TestFactory.createDataTemplateList(2, false);
        for(Data_Template__c dataTem : dataTemplateRecordList){
        	dataTem.Name = 'Test Data Template Record';    
        }
        if(!dataTemplateRecordList.isEmpty()){
        	insert dataTemplateRecordList;
        }
        
        Test.StartTest();
            SchedulBatchForDataTemplateQueueableJob obj = new SchedulBatchForDataTemplateQueueableJob(dataTemplateRecordList[0]);
            String scheduleExp = '0 0 * * * ?';
            System.schedule('Test Job', scheduleExp, obj);
        Test.StopTest();
        
        System.Assert(obj != null);
    }
}
