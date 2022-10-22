trigger ContactTrigger on Contact (before delete) {
	if(Trigger.isBefore){
        if(Trigger.isDelete){
            ContactTriggerHelper.notToDeleteContact(Trigger.old);
        }
    }
}