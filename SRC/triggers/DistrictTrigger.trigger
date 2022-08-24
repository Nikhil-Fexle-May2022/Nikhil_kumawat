trigger DistrictTrigger on District__c (after insert , after update, after delete) {
    // After Updation Part
    if(Trigger.isAfter){
        DistrictTriggerHelper.finalizingCountOfDistrictOnStates(Trigger.New, Trigger.oldMap);
    }
}