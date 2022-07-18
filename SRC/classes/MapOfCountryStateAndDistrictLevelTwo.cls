/**
*  Description     :  Inserting COuntry, states and districts dynamically
*
*  Created By      :  Nikhil Kumawat
*
*  Created Date    :  07/12/2022
*
*  Revision Logs   :    V1.0 - Created - Nikhil Kumawat
**/
public with sharing class MapOfCountryStateAndDistrictLevelTwo{
/**
    *   @description    :  Filling and finding the countries, states and districts dynamically
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 07/12/2022 - Developer Name - Nikhil Kumawat
    **/
    // FIRST : Declaring the top of all maps instance 
    public static Map<String, Map<String, List<String>>> mapOfCountryAndStateWithTheirRepresentativeDistricts = 
    new Map<String, Map<String, List<String>>>();

    // To Store the complete result in serialization format :
    // LIKE :- First Store the country then states in country and after that each districts in a particular state
    //         of the country.

    // Parameterized constructor : ->
    public MapOfCountryStateAndDistrictLevelTwo(String startingCharacter) {

        // Countries with their representative states in the map :->
        Map<String, List<String>> mapOfStateWithTheirRespectiveCountry = new Map<String, List<String>>();

        // For query taking custom object that initialize the list which is use to take data(Country) from query

       // List<Country__c> listOfCountryAndStates = [SELECT Id, Name, (SELECT Id, Name FROM States__r) FROM Country__c];
        for(Country__c country : [SELECT Id, Name, (SELECT Id, Name FROM States__r) FROM Country__c]) 
        {  
            // Creating a list that holds or receive various types of states data
            List<String> listOfVariousStates = new List<String>();
            for(State__c stateName : country.States__r) 
            {
                listOfVariousStates.add(stateName.Name); 
            }
            // Now, Putting the country Name in the map as a first argument and as a second argument we put list of states.
            mapOfStateWithTheirRespectiveCountry.put(country.Name, listOfVariousStates);
        }
        System.debug(mapOfStateWithTheirRespectiveCountry);

        // States with their respective districts :->
        Map<String, List<String>> mapOfDistrictWithTheirStates = new Map<String, List<String>>();

       // List<State__c> listOfVariousStatesAndDistricts = [SELECT Id, Name, (SELECT Id, Name FROM Districts__r) FROM State__c];
        // Now iterating the each one reserved states which is stored in 'states' instance
        for(State__c states : [SELECT Id, Name, (SELECT Id, Name FROM Districts__r) FROM State__c]) 
        {  
            // Created a instance of districts in particular states:->
            List<String> listOfDistricts = new List<String>();
            // Iterating
            for(District__c districtsName : states.Districts__r) 
            {
                listOfDistricts.add(districtsName.Name); 
            }
            mapOfDistrictWithTheirStates.put(states.Name, listOfDistricts);
        }
        System.debug(mapOfDistrictWithTheirStates);

        // Filling the top map with Country name, their state name , respective to their districts name
        for(String key : mapOfStateWithTheirRespectiveCountry.keySet()) {
            // Just checking that the map is empty or not.
            if(!mapOfCountryAndStateWithTheirRepresentativeDistricts.containsKey(key)) 
            // Putting the values(Country, state , districts into the map)
                mapOfCountryAndStateWithTheirRepresentativeDistricts.put(key, new Map<String, List<String>>());

                if(mapOfCountryAndStateWithTheirRepresentativeDistricts.containsKey(key)) {
                    for(String state : mapOfStateWithTheirRespectiveCountry.get(key)) {
                        mapOfCountryAndStateWithTheirRepresentativeDistricts.get(key).put(state, new List<String>());

                        if(mapOfCountryAndStateWithTheirRepresentativeDistricts.get(key).containsKey(state)) {
                            mapOfCountryAndStateWithTheirRepresentativeDistricts.get(key).get(state).addAll(mapOfDistrictWithTheirStates.get(state));
                        }
                    }
                }
            }

        // Printing Results
        for(String key : mapOfCountryAndStateWithTheirRepresentativeDistricts.keySet()) {
           // System.debug(key + mapOfCountryAndStateWithTheirRepresentativeDistricts.get(key));
        }   

        // Finding out the country , state and district starts with a particular chaaracter in the map.
        if(!mapOfCountryAndStateWithTheirRepresentativeDistricts.isEmpty()) {

            for(String country_cont : mapOfCountryAndStateWithTheirRepresentativeDistricts.keySet()) {
                if(country_cont.startsWith(startingCharacter.toUppercase())) {

                    for(String state_stte : mapOfCountryAndStateWithTheirRepresentativeDistricts.get(country_cont).keySet()) {             
                        if(state_stte.startsWith(startingCharacter.toUppercase())) {

                            for(String district_distc : mapOfCountryAndStateWithTheirRepresentativeDistricts.get(country_cont).get(state_stte)) {

                                if(district_distc.startsWith(startingCharacter.toUppercase())) {
                                    System.debug('Combination of Country, State and District with starting character =' +country_cont + ' -> ' + state_stte + ' -> ' + district_distc);
                                }
                            }
                        }
                    }
                }
            }
        }   
        countryJSONFormatGenerator('India');
    }
    
    // JSON FORMAT :-->
    public static void countryJSONFormatGenerator(String countryName) {

        List<Country__c> countries = [SELECT Name, Total_Number_of_Districts__c, Total_Number_of_States__c, Country_Code__c, Country_JSON_Data__c 
        FROM Country__c
        WHERE Name =: countryName ];
        
        if(!countries.isEmpty()) {
            List<CountryStateAndDistrictJSONGenerator.States> states = new List<CountryStateAndDistrictJSONGenerator.States>();
            if(!mapOfCountryAndStateWithTheirRepresentativeDistricts.get(countryName).keySet().isEmpty()){
                for(String state: mapOfCountryAndStateWithTheirRepresentativeDistricts.get(countryName).keySet()){
                    CountryStateAndDistrictJSONGenerator.States statesWrapper = new CountryStateAndDistrictJSONGenerator.States();
                    statesWrapper.stateName = state;
                    List<CountryStateAndDistrictJSONGenerator.Districts> Districts = new List<CountryStateAndDistrictJSONGenerator.Districts>();
                    if(!mapOfCountryAndStateWithTheirRepresentativeDistricts.get(countryName).get(state).isEmpty()){
                        for(String dis: mapOfCountryAndStateWithTheirRepresentativeDistricts.get(countryName).get(state)){
                            CountryStateAndDistrictJSONGenerator.Districts District = new CountryStateAndDistrictJSONGenerator.Districts();
                            District.districtName = dis;
                            Districts.add(District);
                        }
                    }
                    statesWrapper.districts = Districts;
                    states.add(statesWrapper);
                }
            }
            CountryStateAndDistrictJSONGenerator.Country countryWrapper = new CountryStateAndDistrictJSONGenerator.Country();
            countryWrapper.countryName = countries[0].Name;
            countryWrapper.countryCode = countries[0].Country_Code__c;
            countryWrapper.totalStatesNumber = (Integer)countries[0].Total_Number_of_States__c;
            countryWrapper.totalDistricts = (Integer)countries[0].Total_Number_of_Districts__c;
            countryWrapper.states = states;
            
            System.debug(countryWrapper);
            System.debug(JSON.serialize(countryWrapper));

            countries[0].Country_JSON_Data__c = JSON.serialize(countryWrapper);
            update countries[0];
        }
    }
}

/*
-> HOW TO RUN ---
We created this assignment in class constructor so we can run through simple new keyword and constructor name 
and pass a string starting letter as an argument to find the combination of country, state and district.

Like :-> **** new MapOfCountryStateAndDistrictLevelTwo('A'); ****    

OUTPUT :->
09:44:19:394 USER_DEBUG [31]|DEBUG|{America=(Texas, Florida, Alaska), China=(Tinanan), India=(Madhya Pradesh, Gujrat, Rajasthan), Spain=(Galicia, Catalonia, Andalusia)}
09:44:20:839 USER_DEBUG [54]|DEBUG|{Alaska=(Chatham, Annette, Bering), Andalusia=(Almeria, Huelva, Sevilla, Granada), Catalonia=(Girona, Tarragona, Barcelona), Florida=(Brevard, Bradford, Calhoun), Galicia=(Krakow, Podol, Belz, Lublin), Gujrat=(Narmada, Gandhinagar, Ahmedabad, Kachchh), Madhya Pradesh=(Ujjain, Bhopal, Panna, Anuppur), Rajasthan=(Ajmer, Jaipur, Udaipur, Kota), Texas=(Houston, Austin, Dallas), Tinanan=(Jetpai), ...}
09:44:20:851 USER_DEBUG [77]|DEBUG|Spain{Andalusia=(Almeria, Huelva, Sevilla, Granada), Catalonia=(Girona, Tarragona, Barcelona), Galicia=(Krakow, Podol, Belz, Lublin)}
09:44:20:852 USER_DEBUG [77]|DEBUG|India{Gujrat=(Narmada, Gandhinagar, Ahmedabad, Kachchh), Madhya Pradesh=(Ujjain, Bhopal, Panna, Anuppur), Rajasthan=(Ajmer, Jaipur, Udaipur, Kota)}
09:44:20:852 USER_DEBUG [77]|DEBUG|America{Alaska=(Chatham, Annette, Bering), Florida=(Brevard, Bradford, Calhoun), Texas=(Houston, Austin, Dallas)}
09:44:20:852 USER_DEBUG [77]|DEBUG|China{Tinanan=(Jetpai)}
09:44:20:856 USER_DEBUG [93]|DEBUG|Combination of Country, State and District with starting character =America -> Alaska -> Annette
09:44:21:627 USER_DEBUG [140]|DEBUG|{"totalStatesNumber":3,"totalDistricts":9,"states":[{"stateName":"Texas","districts":[{"districtName":"Houston"},{"districtName":"Austin"},{"districtName":"Dallas"}]},{"stateName":"Florida","districts":[{"districtName":"Bradford"},{"districtName":"Calhoun"},{"districtName":"Brevard"}]},{"stateName":"Alaska","districts":[{"districtName":"Chatham"},{"districtName":"Annette"},{"districtName":"Bering"}]}],"countryName":"America","countryCode":"1"}
*/