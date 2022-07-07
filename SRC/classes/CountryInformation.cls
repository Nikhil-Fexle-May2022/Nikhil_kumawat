public with sharing class CountryInformation { 

    public static void insertDataValues(){
        Map<String, Map<String, Map<String, List<String>>>> mapOfCountry = new Map<String, Map<String, Map<String,List<String>>>>();
       
        //Create List of District with State Of India
        List<String> madhyaPradeshDistrict = new List<String>{'Anuppur', 'Satna', 'Ujjain', 'Indore','Betul','Bhopal','Chhatarpur',
                                                              'Datia','Dewas','East Nimar', 'Guna','Harda','Jabalpur','Jhabua','Katni',
                                                              'Mandla', 'Mandsaur','Narsinghpur','Panna','Raisen','Rajgarh','Shahdol'};

        List<String> rajasthanDistrict = new List<String>{'Ajmer','Alwar','Banswara','Barmer','Bharatpur','Bhilwara','Bikaner','Bundi','Chittorgarh',
                                                          'Churu','Dausa','Dholpur','Dungarpur','Hanumangarh','Jaipur','Jaisalmer','Jalore',
                                                          'Jhalawar','Jhunjhunu','Jodhpur','Karauli','Kota','Nagaur','Pali','Pratapgarh',
                                                          'Rajsamand','Sawai Madhopur','Sikar','Sirohi','Sri Ganganagar','Tonk','Udaipur'};

        List<String> gujaratDistrict = new List<String>{'Ahmedabad','Bharuch','Gandhinagar','Dahod','Gandhi Nagar', 'Jamnagar','Junagadh',
                                                        'Kachchh', 'Kheda', 'Mahesana','Narmada','Panch Mahals','Rajkot','Sabarkantha'};

        //Create List of District with State Of Spain
        List<String> andalusiaDistrict = new List<String>{'Huelva', 'Cádiz', 'Sevilla', 'Málaga', 'Granada','Almería'};
        List<String> cataloniaDistrict = new List<String>{'Barcelona', 'Girona', 'Lleida', 'Tarragona'};
        List<String> galiciaDistrict = new List<String>{'Krakau', 'Sandomir', 'Lublin', 'Belz', 'Red Ruthenia','Podolia'};

        //Create List of District with State Of America
        List<String> texasDistrict = new List<String>{'Houston','Dallas','Austin'};
        List<String> floridaDistrict = new List<String>{'Bradford','Brevard','Calhoun'};
        List<String> alaskaDistrict = new List<String>{'Bering','Annette','Chatham'};
        
        // Assigning List of district according to state
        Map<String, List<String>> indiaStateMap = new  Map<String, List<String>>{'Rajasthan' => rajasthanDistrict, 'Madhya-Pradesh' => madhyaPradeshDistrict, 'Gujarat' => gujaratDistrict};
        Map<String, List<String>> spainStateMap = new  Map<String, List<String>>{'Andalusia' => andalusiaDistrict, 'Catalonia' => cataloniaDistrict, 'Galicia' => galiciaDistrict};
        Map<String, List<String>> americaStateMap = new  Map<String, List<String>>{'Texas' => texasDistrict, 'Florida' => floridaDistrict , 'Alaska' => alaskaDistrict};

        // Assigning List of state according to Country
        Map<String, Map<String, List<String>>> indiaMap = new  Map<String,  Map<String, List<String>>>{'India' => indiaStateMap};
        Map<String, Map<String, List<String>>> spainMap = new  Map<String,  Map<String, List<String>>>{'Spain' => spainStateMap};
        Map<String, Map<String, List<String>>> americaMap = new  Map<String,  Map<String, List<String>>>{'America' => americaStateMap};

        // Assigning List of Country Code
        // mapCountryCode = new Map<Integer, Map<String, Map<String, List<String>>>>{91 => IndiaMap, 880 => BangladeshMap, 1 => AmericaMap};
        mapOfCountry.put('+91',indiaMap);
        mapOfCountry.put('+880',spainMap);
        mapOfCountry.put('+1',americaMap);
        
        // Find The Combination Of Country State and District
        for(String countryCode : mapOfCountry.keySet()){
        //Get Country Name   
            Map<String,Map<String,List<String>>> countriesName = mapOfCountry.get(countryCode); 

            for(String country : countriesName.keySet()){
            
                if(country.startsWith('S')){
                //Get State Name   
                   Map<String,List<String>> stateNames = countriesName.get(country);
                    
                    for(String state : stateNames.keySet()){
                                                 
                        if(state.startsWith('A')){
                        //Get District Name    
                            List<String> districtList = stateNames.get(state);
                             
                            for(String district : districtList){
                                 
                                if(district.startsWith('S')&&district.length()>=5){
                                    System.debug('Country Name  : ' + country);
                                    System.debug('State Name : ' + state);
                                    System.debug('District Name  : ' + district);
                                }
                            }
                        }
                    }
                }
            }
        }
       
        // Finding  Districts which length is more or equal to some number
        List<String> allDistricts = new List<String>();
        for(String countryCode : mapOfCountry.keySet()){
    
            Map<String,Map<String,List<String>>> countriesName = mapOfCountry.get(countryCode);
            for(String country : countriesName.keySet()){
                // get state map
                Map<String,List<String>> stateNames = countriesName.get(country); 
                for(String state : stateNames.keySet()){
                    // get district name list 
                    List<String> districtList = stateNames.get(state);
                        // add all district in districtList
                        allDistricts.addAll(districtList);
                }
            }
        }

        // get districts from all district list
        for(String districtLength : allDistricts){
            // cheacking district length 
            if(districtLength.length()>=1 && districtLength.length()>=5){
                // print the district  given length
                System.debug('District of Given Length : ' +districtLength);
            }
        }
    }
}

/*
:::: --- >>> How to run the code in developer console in org
1. Firstly we need to write our class Name in anonyomous window.
2. Then simply use the (.) dot notation to access the class method.

Running command for current program - CountryInformation.insertDataValues();

OUTPUT :: -- >>

USER_DEBUG| Country Name : Spain 
USER_DEBUG| State Name : Andalusia 
USER_DEBUG| Country Name : Sevilla 

*/