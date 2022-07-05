/**
 *  Description     :  Find district names who start with s and length should be greater than or equal
 *
 *  Created By      :  Nikhil Kumawat
 *
 *  Created Date    :  05/07/2022
 *
 *  Revision Logs   :    V1.0 - Created - Nikhil Kumawat
 **/
public with sharing class CountryStateAndDistrict{
    
    public static void findDistrictName(String countryCode, String countryName_1, String  stateName, String startWithChar) {

        Map<String, Map<String, Map<String, List<String>>>> countryCodeNameStateAndDistrict = new Map<String, Map<String, Map<String, List<String>>>>();

        // Add district on list
        List<String> rajasthanDistricts = new List<String>{'Ajmer','Alwar','Banswara','Barmer','Bharatpur','Bhilwara','Bikaner','Bundi','Chittorgarh',
                                                    'Churu','Dausa','Dholpur','Dungarpur','Hanumangarh','Jaipur','Jaisalmer','Jalore',
                                            'Jhalawar','Jhunjhunu','Jodhpur','Karauli','Kota','Nagaur','Pali','Pratapgarh',
                                            'Rajsamand','Sawai Madhopur','Sikar','Sirohi','Sri Ganganagar','Tonk','Udaipur'};
        List<String> madhyaPradeshDistricts =  new List<String>{'Anuppur', 'Satna', 'Ujjain', 'Indore'};
        List<String> maharashtraDistricts = new List<String>{'Ahmednagar','Mumbai','Pune','Sindhudurg','Solapur','Beed'};

        // Add district on map in state key
        Map<String, List<String>> state = new Map<String, List<String>>();
        state.put('Rajasthan', rajasthanDistricts);
        state.put('Madhya Pradesh', madhyaPradeshDistricts);
        state.put('Maharashtra', maharashtraDistricts);       
        
        // Add states on map in countries key 
        Map<String, Map<String, List<String>>> countryName = new Map<String, Map<String, List<String>>>();
        countryName.put('India', state);

        // Add district on list
        List<String> andalusiaDistricts =  new List<String>{'Huelva', 'Cádiz', 'Sevilla', 'Málaga', 'Granada','Almería'};
        List<String> cataloniaDistricts =  new List<String>{'Barcelona', 'Girona', 'Lleida', 'Tarragona'};
        List<String> galiciaDistricts =  new List<String>{'Krakau', 'Sandomir', 'Lublin', 'Belz', 'Red Ruthenia','Podolia'};

        // Add district on map in state key
        Map<String, List<String>> state_2 = new Map<String, List<String>>();
        state_2.put('Andalusia', andalusiaDistricts);
        state_2.put('Catalonia', cataloniaDistricts);
        state_2.put('Galicia', galiciaDistricts);

        // Add states on map in countries key 
        Map<String, Map<String, List<String>>> countryName_2 = new Map<String, Map<String, List<String>>>();
        countryName_2.put('Spain', state_2);

        // Add district on list
        List<String> arunKshetraDistricts =  new List<String>{'Arundel', 'Bognor Regis', 'Littlehampton'};
        List<String> janakpurKshetraDistricts =  new List<String>{'Dhanusha' , 'Madhesh'};
        List<String> kathmanduDistricts = new List<String>{'Dolpa', 'Humla', 'Taplejung', 'Gorkha'};
        
        // Add district on map in state key
        Map<String, List<String>> state_3 = new Map<String, List<String>>();
        state_3.put('Arun Kshetra', arunKshetraDistricts);
        state_3.put('Janakpur Kshetra', janakpurKshetraDistricts);
        state_3.put('Kathmandu', kathmanduDistricts);

        // Add states on map in countries key 
        Map<String, Map<String, List<String>>> countryName_3 = new Map<String, Map<String, List<String>>>();
        countryName_3.put('Nepal', state_3);

        // Add country with country code on map
        countryCodeNameStateAndDistrict.put('IN(+91)', countryName);
        countryCodeNameStateAndDistrict.put('ES(+34)', countryName_2);
        countryCodeNameStateAndDistrict.put('Np(+977)', countryName_3);

        // Find the code, country name, states and districts
        for(String code : countryCodeNameStateAndDistrict.keySet()) {
            if(code.equals(countryCode)) {
                for(String countryNames : countryCodeNameStateAndDistrict.get(code).keySet()) {
                    if(countryNames.equals(countryName_1)) {
                        for(String stateNames : countryCodeNameStateAndDistrict.get(code).get(countryNames).keySet()) {
                            if(stateNames.equals(stateName)) {                            
                                for(String districtName : countryCodeNameStateAndDistrict.get(code).get(countryNames).get(stateNames)) {                                 
                                    if(districtName.startsWith(startWithChar) && districtName.length() >= 5) {
                                        System.debug(districtName);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
