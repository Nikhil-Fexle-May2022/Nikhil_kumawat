trigger AccountTrigger on Account (before insert, after insert) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
        	AccountTriggerHelperClass.setPrefixOnAccount(Trigger.New);
    	}
    	if(Trigger.isAfter){
        	AccountTriggerHelperClass.sendEmail(Trigger.New);
        }
    }
}