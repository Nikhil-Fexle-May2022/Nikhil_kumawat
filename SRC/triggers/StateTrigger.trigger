trigger StateTrigger on State__c (after insert, after update, after delete) {
    if(Trigger.isAfter){
        StateTriggerHelper.updatingStateAndDistrictCountOnCountry(Trigger.new, Trigger.oldmap);   
    }
}