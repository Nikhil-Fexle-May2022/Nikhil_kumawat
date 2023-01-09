@isTest(seeAllData = false)
private with sharing class ConcatStringTest {
 
    @isTest
    private static void testConcat(){

        String firstName = 'Priyanka';
        String lastName = 'Mittal';

        Test.startTest();
        	String testInstance = ConcatString.concat(firstName, lastName);
        Test.stopTest();
        System.debug(testInstance);
        System.assertEquals('PriyankaMittal', testInstance, 'Arguments Error !');
    }
}