/**
*  Description     :  Aggregating functions
*
*  Created By      :  Nikhil Kumawat
*
*  Created Date    :  07/13/2022
*
*  Revision Logs   :    V1.0 - Created - Nikhil Kumawat
**/
public with sharing class AggregateFunction {
    /**
    *   @description    :   Aggregating function to set total number of states and districts in a particular country
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 07/13/2022 - Developer Name - Nikhil Kumawat
    **/

    // FIRST:-> This is for setting the total number of states and districts in country record(or object).
    public static void  setTotalNumberOfStatesAndDistrictOnCountries() {
        // Querying the information in the 'AggregateResults' instance list
        List<AggregateResult> results  = [SELECT Country__c Country_Id,  
                                          COUNT(Id) Total_States, Sum(Total_number_of_Districts__c) Total_Districts 
                                          FROM State__c
                                          GROUP BY Country__c];
        // Collecting all the records in Custom type object list
        List<Country__c> collectionOfStageReco = new List<Country__c>();
        // then further iterating it
        for(AggregateResult ar : results) {
            // Integer typeCasting because it is in 'String' type
            Integer toatalStates = (Integer)ar.get('Total_States');
            // Now typecasting in the Id for a country Id
            Id CountryId = (Id)ar.get('Country_Id');
            // Now further typeCasting in the Decimal datatype because of fear of hit the limit by putting
            Decimal toatalDistrict = (Decimal)ar.get('Total_Districts');
            Country__c countryObjectOne= new Country__c();
            countryObjectOne.Total_number_of_States__c = toatalStates;
            countryObjectOne.Total_number_of_Districts__c = toatalDistrict;
            countryObjectOne.Id = CountryId;
            collectionOfStageReco.add(countryObjectOne);     
        }
        // If it done any kind of changes
        if(!collectionOfStageReco.isEmpty()){
            update collectionOfStageReco;
        }
    }

    // SECOND :-> This one is for setting total number of districts in state record(or object).
    public static void  setTotalNumberOfDistrictsOnStates() {
        // Querying
        List<AggregateResult> arr  = [SELECT State__c State_Id, 
                                      COUNT(Id) Total_Districts 
                                      FROM District__c
                                      GROUP BY State__c];
        // Listing up the result records and further iterate them.
        List<State__c> collectionOfDistrictReco  = new List<State__c>();
        for(AggregateResult Agg : arr ) {
            // TypeCasted in Integer
            Integer toatalDistricts = (Integer)Agg.get('Total_Districts');
            // TypeCasted in Id
            Id CountryId = (Id)Agg.get('State_Id');
            State__c stateObjectTwo = new State__c();
            stateObjectTwo.Total_number_of_Districts__c = toatalDistricts;
            stateObjectTwo.Id = CountryId;
            // Adding all the results to the instance of the list
            collectionOfDistrictReco .add(stateObjectTwo);
        }
        if(!collectionOfDistrictReco .isEmpty()){
            update collectionOfDistrictReco ;
        }
    }
}

/*
HOW TO RUN :-->>
1. For Total number of districts on state
AggregateFunction.setTotalNumberOfDistrictsOnStates();

2. For Total Number Of States And District On Countries
AggregateFunction.setTotalNumberOfStatesAndDistrictOnCountries();

OUTPUT:-->>

1. For Total number of districts on state --->>>
09:54:37:091 USER_DEBUG [57]|DEBUG|(State__c:{Total_Number_of_Districts__c=4, Id=a045i000006XSuCAAW}, State__c:{Total_Number_of_Districts__c=4, Id=a045i000006XSuDAAW}, State__c:{Total_Number_of_Districts__c=4, Id=a045i000006XStAAAW}, State__c:{Total_Number_of_Districts__c=3, Id=a045i000006XSskAAG}, State__c:{Total_Number_of_Districts__c=1, Id=a045i000006YOzqAAG}, State__c:{Total_Number_of_Districts__c=3, Id=a045i000006XSt9AAG}, State__c:{Total_Number_of_Districts__c=3, Id=a045i000006XSspAAG}, State__c:{Total_Number_of_Districts__c

2. For Total Number Of States And District On Countries
09:57:34:747 USER_DEBUG [30]|DEBUG|(Country__c:{Total_Number_of_States__c=3, Total_Number_of_Districts__c=12.0, Id=a035i000003K0cwAAC}, Country__c:{Total_Number_of_States__c=1, Total_Number_of_Districts__c=1.0, Id=a035i000003LslFAAS}, Country__c:{Total_Number_of_States__c=3, Total_Number_of_Districts__c=9.0, Id=a035i000003K170AAC}, Country__c:{Total_Number_of_States__c=3, Total_Number_of_Districts__c=11.0, Id=a035i000003K0jCAAS})
*/
