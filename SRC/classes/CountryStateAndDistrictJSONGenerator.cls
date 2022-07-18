/**
*  Description     :  Wrapper classes
*
*  Created By      :  Nikhil Kumawat
*
*  Created Date    :  07/14/2022
*
*  Revision Logs   :    V1.0 - Created - Nikhil Kumawat
**/
public with sharing class CountryStateAndDistrictJSONGenerator {
/**
    *   @description    :   Wrapper classes used for JSON formatting and serialization
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 07/14/2022 - Developer Name - Nikhil Kumawat
    **/    
    public List<String> countryList{get; set;}
    
    public class States{
        public string stateName{get; set;}
        public List<Districts> districts{get; set;}
    }
    
    public class Districts{
        public string districtName{get; set;}
    }
    
    public class Country{
        public String countryName{get; set;}
        public String countryCode{get; set;}
        public Integer totalStatesNumber{get; set;}
        public Integer totalDistricts{get; set;}
        public List<States> states{get; set;}
    }
}