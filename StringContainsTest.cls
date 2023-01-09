@isTest(seeAllData = false)
public with sharing class StringContainsTest {
    @isTest
    static void testData(){
        String name='Priyanka Mittal';
        String check = 'yank';

        Test.startTest();
        String finalResultsTwo = StringContains.Contains(name, check);
        Test.stopTest();
        
       System.assertEquals('true', finalResultsTwo);
    }
   /* 
    @isTest
    static void testDataTwo(){
        String nameTest = 'Test';
        String checktest = 'Check';
        
        Test.startTest();
        String finalResults = StringContains.Contains(nameTest, checktest);
        Test.stopTest();
    
        System.assertEquals('false', finalResults);
    } */
}