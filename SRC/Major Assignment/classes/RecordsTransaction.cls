public with sharing class RecordsTransaction {
    @AuraEnabled(cacheable=true)
    public static List<Transaction_Entry__c> takeRecords(Id recordId, Integer transLimit){
        // Querying records From object through selecting Their fields (Custom As well as Standard).
        List<Transaction_Entry__c> newList = [SELECT Name, Amount__c, Type__c, Status__c, 
                                            Transaction_Date__c FROM Transaction_Entry__c 
                                            WHERE Contact__c = :recordId LIMIT :transLimit];

        return newList;
    }
}