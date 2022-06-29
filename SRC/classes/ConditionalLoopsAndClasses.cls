/**
* Description   - Conditional loops , types and classes
*
* Created by    - Nikhil Kumawat
*
* Created Date  - 28/06/2022
*
* Revision log  -  V_1.0 - Created  - Nikhil Kumawat 
*                  

**/ 
public with sharing class ConditionalLoopsAndClasses {
        /**
        * Description   :  Conditional loops , types and classes and their various methods
        *
        * Created by    :  Nikhil Kumawat
        *
        * Arguments     :  Integer, Boolean, Double, String, sObject
        * 
        * Return        :  Void
        *
        * Revision log  :  V_1.0 - Created  - Nikhil Kumawat 
        *                  
        **/ 
    public void ifElseConditionqlStatement() {
        // ******************** IF-ELSE CONDITINAL STATEMENT *********************
        String customerName = 'Dexter'; 
		if (customerName == 'Dexter') {
   			System.debug('Special Discount given as Customer is Premium');
		}else if (customerName == 'Mortal') {
   			System.debug('Special Discount not given as Customer is not Premium');
		}else {
   			System.debug('Special Discount not given as Customer is not Premium');
        }
    }
    // ************************** SWITCH STATEMENT *************************
        public static void switchExample(){
            Integer num = 5;
            
            switch on num {
               when 3 {
                   System.debug('Value is less tham 5');
               }
               when 5{
                   System.debug('Value is equal to 5');
               }
               when else {
                   System.debug('When value was not less than or equal to');
            }
        }
    }
    // ************************** LOOPS IN APEX ***************************
    // DO-WHILE LOOP IN APEX
    public void doWhileLoop(){
        Integer count = 1;
        do {
            System.debug(count);
            count++;
        } while (count <= 10);
    }
    // WHILE LOOPS
    public void whileLoops(){
        Integer condition = 10;
        while(condition<=100){
            System.debug(condition);
            condition++;
        }
    }
    // TRADITIONAL FOR LOOP
    public void traditionalForLoop(){
        for (Integer initialization = 0; initialization < 5; initialization++) {
            System.debug(initialization);
        }
    }
    // LIST OR SET ITERATION FOR LOOPS
    public void listOrSetForLoop(){
        Integer[] myListSet = new Integer[]{1,2,3,4,5,6,7,8,9,10};
        for(Integer i : myListSet){
            System.debug(i);
        }
    }
    // ITERATING THE COLLECTIONS
    public void iteratingCollections(){
    List<Account> accs = [SELECT Id, Name FROM Account WHERE Name = 'Cluster']; 
    for(Account a : accs){
           a.Name = 'JamesBond';
        }
        update accs;
    }
    // CALL BY VALUE / CALL BY REFERENCE
    // CALL BY VALUE - Passing Primitive Data Type Arguments
    public void callByValue() {
        String msg = 'Hey | Jackson';
        processString(msg);
        System.debug(msg);
    }
    public void processString(String s) {
        s = 'Nice to meet you';
    }
    // CALL BY REFERENCE -  Passing Non-Primitive Data Type Arguments
    public void createTemperatureHistory() {
        List<Integer> fillMe = new List<Integer>();        
        reference(fillMe);
        System.debug(fillMe.size());        
        
        List<Integer> createMe = new List<Integer>();
        referenceNew(createMe);
        System.debug(createMe.size());     
    }
            
    public void reference(List<Integer> m) {
        m.add(70);
        m.add(68);
        m.add(75);
        m.add(80);
        m.add(82);
    }    
        
    public static void referenceNew(List<Integer> m) {
        m = new List<Integer>{55, 59, 62, 60, 63};
    }
    // Overloading in Apex
    Integer num;
    public void overloadingMethod(){
        System.debug('woof');
    }
    public void overloadingMethod(Integer num){
    	for(Integer i=0; i<num; i++)
    		System.debug('woof');
    }
}