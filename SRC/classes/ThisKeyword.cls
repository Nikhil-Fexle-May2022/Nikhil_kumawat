/**
* Description   - This keyword (Use to avoid the name confliction and use itself class methods)
*
* Created by    - Nikhil Kumawat
*
* Created Date  - 29/06/2022
*
* Revision log  -  V_1.0 - Created  - Nikhil Kumawat 
*                  

**/ 
public with sharing class ThisKeyword {
    Integer a;
    public ThisKeyword(Integer a){
        this.a = a;
        System.debug(a);
    }
}