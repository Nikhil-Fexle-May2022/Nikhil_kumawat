/**
* Description   - Use of instanceOf keyword(If you need to verify at run time whether an object is actually an instance of a particular class)  
*
* Created by    - Nikhil Kumawat
*
* Created Date  - 29/06/2022
*
* Revision log  -  V_1.0 - Created  - Nikhil Kumawat 
*                  

**/ 
public with sharing class InstanceOfKeyword {
    public InstanceOfKeyword() {
        sObject s = new Account();
        
        // This one is for Account object
        Account a = (Account)s;
        // This one is for Contact object
        // Contact c = (Contact)s;
        
        if(s instanceOf Account){
            Account x = (Account)s;
            System.debug(x);
        }
        else if(s instanceOf Contact){
            Contact c = (Contact)s;
            System.debug(c);
        }
        else{
            System.debug('Not matches the condition');
        }
    }
}