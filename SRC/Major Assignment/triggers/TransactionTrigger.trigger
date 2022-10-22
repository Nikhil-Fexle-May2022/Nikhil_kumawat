trigger TransactionTrigger on Transaction_Entry__c (after insert, before update) {
    if(Trigger.isAfter){ 
        if(Trigger.isInsert){
            TransactionEntry.transaction(Trigger.newMap);
        }
    }
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            TransactionEntry.updateEntries(Trigger.new);
        }
    }
}