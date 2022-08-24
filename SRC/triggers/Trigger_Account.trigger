trigger Trigger_Account on Account (before insert, before update){
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            AccountTriggerHelper.updateStatus(Trigger.new, Trigger.oldMap); 
        }
        if(Trigger.isUpdate){
            AccountTriggerHelper.updateStatus(Trigger.new, Trigger.oldMap);      
        }
    }
}