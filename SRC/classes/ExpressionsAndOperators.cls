/**
* Description   - Expression Opartor and Type Casting
*
* Created by    - Nikhil Kumawat
*
* Created Date  - 24/06/2022
*
* Revision log  -  V_1.0 - Created  - Nikhil Kumawat 
*                  

**/ 

public with sharing class ExpressionsAndOperators {    
    public ExpressionsAndOperators(Integer a, Integer b, Integer c, Boolean d, Boolean e) {
        /**
        * Description   :  ExpressionAndOperators Constructor using to calculate all operators
        *
        * Created by    :  Nikhil Kumawat
        *
        * Arguments     :  Integer, Boolean
        * 
        * Return        :  Void
        *
        * Revision log  :  V_1.0 - Created  - Nikhil Kumawat 
        *                  

        **/     

        // ******************** UNARY EXPRESSION ******************* 
        System.debug(~a);           //(Minus of total positive value which starts from 0)  
        System.debug(~b);           // (Positive of total minus, positive starts from 0)  
        System.debug(!d);           // (Opposite of boolean value)  
        System.debug(!e);           //(Opposite of boolean value)
        
        // ******************** ARITHMETIC EXPRESSION ***************
        System.debug(a+b);  
        System.debug(a-b); 
        System.debug(a*b); 
        System.debug(a/b); 
        
        // ******************** LEFT SHIFT EXPRESSION ******************* 
        System.debug(a<<b);   // for ex - 10*2^2=10*4=40   

        // ********************* RIGHT SHIFT EXPRESSION ******************
        System.debug(a>>b);   //for ex - 10/2^2=10/4=2  

        // ***************** AND EXPRESSION ******************  
        System.debug(a<b&&a<c);
        System.debug(a<b&a<c);

        // ******************** OR EXPRESSION *******************
        System.debug(a>b||a++<c);
        System.debug(a>b|a++<c);

        // ********************* TERNARY EXPRESSION ******************
        Integer min=(a<b)?a:b;  
        System.debug(min); 

        // ********************** ASSIGNMENT EXPRESSION *****************
        System.debug(a += b);
        System.debug(b -= c);
        System.debug(c *= a);
        System.debug(b /= a);
        System.debug(c *= a*b);
        System.debug(b += a-c );

        // ******************** RELATION EXPRESSION ******************** 
        System.debug(a == b);
        System.debug(c != b);  
        System.debug(c > a);  
        System.debug(b < a);  
        System.debug(a >= c);  
        System.debug(b <= c);

        // ************************* ROLE OF CONVERSION ******************* 
        double mywide1 = a; // Widening(Automatic) casting: Integer to Double
        decimal mywide2 = b;
        System.debug(mywide1);
        System.debug(mywide2); 

        Double mynarrow1 = 9.78d;
        Integer mynarrow2 = (Integer) mynarrow1; // Narrowing(Manual) casting: Double to Integer
        Long mynarrow3 = (long) mynarrow1;
        System.debug(mynarrow2);
        System.debug(mynarrow3);
        Decimal mywide3 = mynarrow2;     
        System.debug(mywide3);
    }
    public static void safeNavigationOperator(){
        String studentName = [SELECT Name FROM Student__c WHERE Name = 'Nukul' LIMIT 1]?.Name;
        System.debug(studentName);
    }
}