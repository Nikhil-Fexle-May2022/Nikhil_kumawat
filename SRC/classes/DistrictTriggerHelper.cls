public with sharing class DistrictTriggerHelper {
    // FIRST :->>>
    // Static method to take newInput as a newList and oldData in oldMap With the help of District__c object.
    public static void finalizingCountOfDistrictOnStates(List<District__c> newData, Map<Id, District__c> oldMap){
        // Using Map to take the changed data or Contains the data
        Map<Id, State__c> dataToBeChange = new Map<Id, State__c>(); 
        // Iterating Number of Districts
        for(District__c district : (newData != null ? newData : oldMap.values())){ // Instead of if-Else using Conditionals operation/Operator 
            if(oldMap == null){
                if(district.State__c != null){ // Checking for insertion
                    dataToBeChange.put(district.State__c, new State__c(Id = district.State__c, Total_Count_Districts_By_Trigger__c = 0));
                }
            }
            else if(oldMap != null){ // Checking for Updation
                // Checking if new data(State) and oldMap data(State) is not same (Or Not equal)
                if(district.State__c != oldMap.get(district.Id).State__c && district.State__c != null){
                    dataToBeChange.put(oldMap.get(district.Id).State__c, new State__c(Id = oldMap.get(district.Id).State__c, Total_Count_Districts_By_Trigger__c = 0));
                    dataToBeChange.put(district.State__c, new State__c(Id = district.State__c, Total_Count_Districts_By_Trigger__c = 0));
                }
                if(newData == null){ // Checking if it is Null or Not
                    dataToBeChange.put(district.State__c, new State__c(Id = district.State__c, Total_Count_Districts_By_Trigger__c = 0));
                }
            }
        }
        // SECOND :->>> 
        // Checking and querying for aggregate function or result 
        if(!dataToBeChange.values().isEmpty()){
            for(AggregateResult aggRe : [SELECT COUNT(Id) totalDistricts, State__c state FROM District__c WHERE State__c IN: dataToBeChange.keySet() GROUP BY State__c]){
                //Updating the district count on state
                dataToBeChange.get((Id)aggRe.get('state')).Total_Count_Districts_By_Trigger__c = (Decimal)aggRe.get('totalDistricts');
            }
            update dataToBeChange.values();
        }   
    }
}