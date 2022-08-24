public with sharing class StateTriggerHelper {
    // Taking newState and old state as a input to clarify things
    public static void updateOnCountry(List<State__c> newStates, Map<Id, State__c> oldStates){
        // Using Map to take all of the changes that we did on it
        Map<Id, Country__c> updationCountry = new Map<Id, Country__c>();
        for(State__c State : (newStates != null ? newStates : oldStates.values())){ 
            // Truling all of the new And old values by iterating them
            if(oldStates == null){ // Check for initial processing as a condition
                if(State.Country__c != null){
                    updationCountry.put(State.Country__c, new Country__c(Id = State.Country__c, 
                                                                         Total_Count_District_By_Trigger__c = 0, 
                                                                         Total_Count_State_By_Trigger__c = 0));
                }
            }
            // Check for Updation processing as well as NULL Pointer exception
            else if(oldStates != null){ // Old states
               if(State.Country__c != oldStates.get(State.Id).Country__c && State.Country__c != null || 
                                      State.Total_Count_Districts_By_Trigger__c != oldStates.get(State.Id).Total_Count_Districts_By_Trigger__c){
                    updationCountry.put(oldStates.get(State.Id).Country__c, new Country__c(Id = oldStates.get(State.Id).Country__c, Total_Count_District_By_Trigger__c = 0, Total_Count_State_By_Trigger__c = 0));
                    updationCountry.put(State.Country__c, new Country__c(Id = State.Country__c, Total_Count_District_By_Trigger__c = 0, 
                                                                         Total_Count_State_By_Trigger__c = 0));
                }
                if(newStates == null){ // For newely Changes happens
                   updationCountry.put(State.Country__c, new Country__c(Id = State.Country__c, 
                                                                        Total_Count_District_By_Trigger__c = 0, 
                                                                        Total_Count_State_By_Trigger__c = 0));
               }
           }
        }
        // Checking if map is empty or not by taking with his values as Not of True
        if(!updationCountry.values().isEmpty()){
            // Iteration using SOQL Query by calculating result as a aggregate Functions
            for(AggregateResult aggDistrictState : [SELECT Country__c, COUNT(Id)totalStateId, SUM(Total_Count_Districts_By_Trigger__c)TotalDistrict FROM State__c WHERE Country__c IN: updationCountry.keySet() GROUP BY Country__c]){
                updationCountry.get((Id)aggDistrictState.get('country__c')).Total_Count_District_By_Trigger__c = (Decimal)aggDistrictState.get('TotalDistrict') != null ? (Decimal)aggDistrictState.get('TotalDistrict') : 0;
                // CrossCheck for state and as well as district field change on country
                updationCountry.get((Id)aggDistrictState.get('country__c')).Total_Count_State_By_Trigger__c = (Decimal)aggDistrictState.get('totalStateId');   
            }   
            // FINAL CAlling for updation part as a final result
            update updationCountry.values();
            new MapOfCountryStateAndDistrictLevelTwo('I');
            MapOfCountryStateAndDistrictLevelTwo.countryJSONFormatGenerator('India');
        }
    }
}