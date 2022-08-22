trigger OpportunityTrigger on Opportunity (after insert, after update) {
    // AFTER EVENT FIRES
    if(Trigger.isAfter){
        // INSERTION PART
        if(Trigger.isInsert || Trigger.isUpdate){
            OpportunityTriggerHelper.insertingRecord(Trigger.New, Trigger.oldMap);
            OpportunityTriggerHelper.sendingEmails(Trigger.new);
        }
    }
}