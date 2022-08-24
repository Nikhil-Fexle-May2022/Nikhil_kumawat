public with sharing class ContactTriggHelper {
    public static void updateStatus(List<Contact> newList, Map<Id,Contact> oldMap){
        Map<Id, Contact> mapOfAccIdWithContact = new Map<Id, Contact>();
        // Insert or Update case
        if(newList != null){
            for(Contact con : newList){
                if(String.isBlank(con.Status__c) && con.AccountId != null){
                    mapOfAccIdWithContact.put(con.AccountId, con);       
                }
            }
            if(!mapOfAccIdWithContact.isEmpty()){
                for(Account acc : [SELECT Status__c FROM Account WHERE Id IN: mapOfAccIdWithContact.keySet()]){
                    mapOfAccIdWithContact.get(acc.Id).Status__c = acc.Status__c;
                }
            }
        }
    }
}