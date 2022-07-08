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
                                    System.debug('Country Name  -> ' + country + ' ' + 'State Name -> ' + state + ' ' + 'District Name  -> ' + district);
                                 //   System.debug('State Name : ' + state);
                                  //  System.debug('District Name  : ' + district);
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
        List<String> showAllDistricts = new List<String>();
        for(String districtLength : allDistricts){
            // cheacking district length 
            if(districtLength.length()>=5){
                // print the district  given length
                showAllDistricts.add(districtLength);
            }
        }
        System.debug(showAllDistricts);
    }
}
/*
:::: --- >>> How to run the code in developer console in org
1. Firstly we need to write our class Name in anonyomous window.
2. Then simply use the (.) dot notation to access the class method.

Running command for current program - CountryInformation.insertDataValues();

OUTPUT :: -- >>
00:51:50.234 (234518081)|USER_INFO|[EXTERNAL]|0055i000001Usz2|nikhil.kumawat@fexle.com.training.staging|(GMT-07:00) Pacific Daylight Time (America/Los_Angeles)|GMT-07:00
00:51:50.234 (234550780)|EXECUTION_STARTED
00:51:50.234 (234559592)|CODE_UNIT_STARTED|[EXTERNAL]|execute_anonymous_apex
00:51:50.234 (238596605)|USER_DEBUG|[65]|DEBUG|Country Name  : Spain
00:51:50.234 (238650630)|USER_DEBUG|[66]|DEBUG|State Name : Andalusia
00:51:50.234 (238669278)|USER_DEBUG|[67]|DEBUG|District Name  : Sevilla
00:51:50.234 (239527684)|USER_DEBUG|[98]|DEBUG|District of Given Length : Ajmer
00:51:50.234 (239567227)|USER_DEBUG|[98]|DEBUG|District of Given Length : Alwar
00:51:50.234 (239602827)|USER_DEBUG|[98]|DEBUG|District of Given Length : Banswara
00:51:50.234 (239630587)|USER_DEBUG|[98]|DEBUG|District of Given Length : Barmer
00:51:50.234 (239657633)|USER_DEBUG|[98]|DEBUG|District of Given Length : Bharatpur
00:51:50.234 (239689500)|USER_DEBUG|[98]|DEBUG|District of Given Length : Bhilwara
00:51:50.234 (239716097)|USER_DEBUG|[98]|DEBUG|District of Given Length : Bikaner
00:51:50.234 (239742887)|USER_DEBUG|[98]|DEBUG|District of Given Length : Bundi
00:51:50.234 (239768801)|USER_DEBUG|[98]|DEBUG|District of Given Length : Chittorgarh
00:51:50.234 (239799899)|USER_DEBUG|[98]|DEBUG|District of Given Length : Churu
00:51:50.234 (239825767)|USER_DEBUG|[98]|DEBUG|District of Given Length : Dausa
00:51:50.234 (239851476)|USER_DEBUG|[98]|DEBUG|District of Given Length : Dholpur
00:51:50.234 (239881931)|USER_DEBUG|[98]|DEBUG|District of Given Length : Dungarpur
00:51:50.234 (239908445)|USER_DEBUG|[98]|DEBUG|District of Given Length : Hanumangarh
00:51:50.234 (239940276)|USER_DEBUG|[98]|DEBUG|District of Given Length : Jaipur
00:51:50.234 (239971622)|USER_DEBUG|[98]|DEBUG|District of Given Length : Jaisalmer
00:51:50.234 (239998247)|USER_DEBUG|[98]|DEBUG|District of Given Length : Jalore
00:51:50.234 (240054083)|USER_DEBUG|[98]|DEBUG|District of Given Length : Jhalawar
00:51:50.234 (240087197)|USER_DEBUG|[98]|DEBUG|District of Given Length : Jhunjhunu
00:51:50.234 (240113727)|USER_DEBUG|[98]|DEBUG|District of Given Length : Jodhpur
00:51:50.234 (240139430)|USER_DEBUG|[98]|DEBUG|District of Given Length : Karauli
00:51:50.234 (240197346)|USER_DEBUG|[98]|DEBUG|District of Given Length : Nagaur
00:51:50.234 (240240814)|USER_DEBUG|[98]|DEBUG|District of Given Length : Pratapgarh
00:51:50.234 (240271449)|USER_DEBUG|[98]|DEBUG|District of Given Length : Rajsamand
00:51:50.234 (240297391)|USER_DEBUG|[98]|DEBUG|District of Given Length : Sawai Madhopur
00:51:50.234 (240324699)|USER_DEBUG|[98]|DEBUG|District of Given Length : Sikar
00:51:50.234 (240350195)|USER_DEBUG|[98]|DEBUG|District of Given Length : Sirohi
00:51:50.234 (240380212)|USER_DEBUG|[98]|DEBUG|District of Given Length : Sri Ganganagar
00:51:50.234 (240423665)|USER_DEBUG|[98]|DEBUG|District of Given Length : Udaipur
00:51:50.234 (240454681)|USER_DEBUG|[98]|DEBUG|District of Given Length : Anuppur
00:51:50.234 (240480243)|USER_DEBUG|[98]|DEBUG|District of Given Length : Satna
00:51:50.234 (240506384)|USER_DEBUG|[98]|DEBUG|District of Given Length : Ujjain
00:51:50.234 (240536169)|USER_DEBUG|[98]|DEBUG|District of Given Length : Indore
00:51:50.234 (240561848)|USER_DEBUG|[98]|DEBUG|District of Given Length : Betul
00:51:50.234 (240587645)|USER_DEBUG|[98]|DEBUG|District of Given Length : Bhopal
00:51:50.234 (240614543)|USER_DEBUG|[98]|DEBUG|District of Given Length : Chhatarpur
00:51:50.234 (240645059)|USER_DEBUG|[98]|DEBUG|District of Given Length : Datia
00:51:50.234 (240670662)|USER_DEBUG|[98]|DEBUG|District of Given Length : Dewas
00:51:50.234 (240696349)|USER_DEBUG|[98]|DEBUG|District of Given Length : East Nimar
00:51:50.234 (240743635)|USER_DEBUG|[98]|DEBUG|District of Given Length : Harda
00:51:50.234 (240779816)|USER_DEBUG|[98]|DEBUG|District of Given Length : Jabalpur
00:51:50.234 (240806352)|USER_DEBUG|[98]|DEBUG|District of Given Length : Jhabua
00:51:50.234 (240829600)|USER_DEBUG|[98]|DEBUG|District of Given Length : Katni
00:51:50.234 (240851567)|USER_DEBUG|[98]|DEBUG|District of Given Length : Mandla
00:51:50.234 (240877542)|USER_DEBUG|[98]|DEBUG|District of Given Length : Mandsaur
00:51:50.234 (240899865)|USER_DEBUG|[98]|DEBUG|District of Given Length : Narsinghpur
00:51:50.234 (240922343)|USER_DEBUG|[98]|DEBUG|District of Given Length : Panna
00:51:50.234 (240944483)|USER_DEBUG|[98]|DEBUG|District of Given Length : Raisen
00:51:50.234 (240970598)|USER_DEBUG|[98]|DEBUG|District of Given Length : Rajgarh
00:51:50.234 (240993148)|USER_DEBUG|[98]|DEBUG|District of Given Length : Shahdol
00:51:50.234 (241015740)|USER_DEBUG|[98]|DEBUG|District of Given Length : Ahmedabad
00:51:50.234 (241042031)|USER_DEBUG|[98]|DEBUG|District of Given Length : Bharuch
00:51:50.234 (241064115)|USER_DEBUG|[98]|DEBUG|District of Given Length : Gandhinagar
00:51:50.234 (241086562)|USER_DEBUG|[98]|DEBUG|District of Given Length : Dahod
00:51:50.234 (241112772)|USER_DEBUG|[98]|DEBUG|District of Given Length : Gandhi Nagar
00:51:50.234 (241135067)|USER_DEBUG|[98]|DEBUG|District of Given Length : Jamnagar
00:51:50.234 (241164745)|USER_DEBUG|[98]|DEBUG|District of Given Length : Junagadh
00:51:50.234 (241197389)|USER_DEBUG|[98]|DEBUG|District of Given Length : Kachchh
00:51:50.234 (241226071)|USER_DEBUG|[98]|DEBUG|District of Given Length : Kheda
00:51:50.234 (241248763)|USER_DEBUG|[98]|DEBUG|District of Given Length : Mahesana
00:51:50.234 (241271024)|USER_DEBUG|[98]|DEBUG|District of Given Length : Narmada
00:51:50.234 (241297635)|USER_DEBUG|[98]|DEBUG|District of Given Length : Panch Mahals
00:51:50.234 (241319619)|USER_DEBUG|[98]|DEBUG|District of Given Length : Rajkot
00:51:50.234 (241341557)|USER_DEBUG|[98]|DEBUG|District of Given Length : Sabarkantha
00:51:50.234 (241367397)|USER_DEBUG|[98]|DEBUG|District of Given Length : Huelva
00:51:50.234 (241389720)|USER_DEBUG|[98]|DEBUG|District of Given Length : Cádiz
00:51:50.234 (241441094)|USER_DEBUG|[98]|DEBUG|District of Given Length : Sevilla
00:51:50.234 (241467947)|USER_DEBUG|[98]|DEBUG|District of Given Length : Málaga
00:51:50.234 (241490890)|USER_DEBUG|[98]|DEBUG|District of Given Length : Granada
00:51:50.234 (241513115)|USER_DEBUG|[98]|DEBUG|District of Given Length : Almería
00:51:50.234 (241557793)|USER_DEBUG|[98]|DEBUG|District of Given Length : Barcelona
00:51:50.234 (241581565)|USER_DEBUG|[98]|DEBUG|District of Given Length : Girona
00:51:50.234 (241603878)|USER_DEBUG|[98]|DEBUG|District of Given Length : Lleida
00:51:50.234 (241630312)|USER_DEBUG|[98]|DEBUG|District of Given Length : Tarragona
00:51:50.234 (241653300)|USER_DEBUG|[98]|DEBUG|District of Given Length : Krakau
00:51:50.234 (241675293)|USER_DEBUG|[98]|DEBUG|District of Given Length : Sandomir
00:51:50.234 (241697576)|USER_DEBUG|[98]|DEBUG|District of Given Length : Lublin
00:51:50.234 (241738569)|USER_DEBUG|[98]|DEBUG|District of Given Length : Red Ruthenia
00:51:50.234 (241761171)|USER_DEBUG|[98]|DEBUG|District of Given Length : Podolia
00:51:50.234 (241788060)|USER_DEBUG|[98]|DEBUG|District of Given Length : Houston
00:51:50.234 (241810259)|USER_DEBUG|[98]|DEBUG|District of Given Length : Dallas
00:51:50.234 (241832075)|USER_DEBUG|[98]|DEBUG|District of Given Length : Austin
00:51:50.234 (241858222)|USER_DEBUG|[98]|DEBUG|District of Given Length : Bradford
00:51:50.234 (241880467)|USER_DEBUG|[98]|DEBUG|District of Given Length : Brevard
00:51:50.234 (241902584)|USER_DEBUG|[98]|DEBUG|District of Given Length : Calhoun
00:51:50.234 (241924736)|USER_DEBUG|[98]|DEBUG|District of Given Length : Bering
00:51:50.234 (241951448)|USER_DEBUG|[98]|DEBUG|District of Given Length : Annette
00:51:50.234 (241973489)|USER_DEBUG|[98]|DEBUG|District of Given Length : Chatham
00:51:50.242 (242035348)|CUMULATIVE_LIMIT_USAGE
00:51:50.242 (242035348)|LIMIT_USAGE_FOR_NS|(default)|
  Number of SOQL queries: 0 out of 100
  Number of query rows: 0 out of 50000
  Number of SOSL queries: 0 out of 20
  Number of DML statements: 0 out of 150
  Number of Publish Immediate DML: 0 out of 150
  Number of DML rows: 0 out of 10000
  Maximum CPU time: 0 out of 10000
  Maximum heap size: 0 out of 6000000
  Number of callouts: 0 out of 100
  Number of Email Invocations: 0 out of 10
  Number of future calls: 0 out of 50
  Number of queueable jobs added to the queue: 0 out of 50
  Number of Mobile Apex push calls: 0 out of 10

00:51:50.242 (242035348)|CUMULATIVE_LIMIT_USAGE_END

00:51:50.234 (242101051)|CODE_UNIT_FINISHED|execute_anonymous_apex
00:51:50.234 (242117867)|EXECUTION_FINISHED

13:21:52.395 ended Execute Anonymous Apex

*/
