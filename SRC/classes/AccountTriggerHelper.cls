public with sharing class AccountTriggerHelper {
    public static void updateStatus(List<Account> newAccount, Map<Id,Account> oldAccounts){
        Map<Id, Account> mapOfAccIdWithAccount = new Map<Id, Account>();
         // Insert or Update case
         if(newAccount != null){
            for(Account acc : newAccount){
                if(String.isBlank(acc.Status__c) && acc.Property__c != null){
                    mapOfAccIdWithAccount.put(acc.Property__c, acc);       
                }
            }
            if(!mapOfAccIdWithAccount.isEmpty()){
                for(Property__c property : [SELECT Status__c FROM Property__c WHERE Id IN: mapOfAccIdWithAccount.keySet()]){
                    mapOfAccIdWithAccount.get(property.Id).Status__c = property.Status__c;
                }
            }
        }
    }
}