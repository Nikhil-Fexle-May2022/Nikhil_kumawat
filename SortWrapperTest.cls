@isTest(seeAllData = false)
public class SortWrapperTest {
	
    @TestSetup 
    static void testData(){
    	Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Account_Status__c = 'In Progress';
        insert acc;
        
            Contact con = new Contact();
            con.FirstName = 'Test';
            con.LastName = 'Contact';
            con.Phone = '94994844';
            con.AccountId = acc.Id;
        insert con;
        
    }
    
    @isTest static void testSortMethod(){
        List<Contact> cn = [SELECT Id, FirstName, LastName, Phone, Account.Name FROM Contact];
        
        Test.StartTest();
            SortWrapper sc = new SortWrapper();    
            SortWrapper.ContactInfoWrapper conWrapper = new SortWrapper.ContactInfoWrapper(cn[0]);
        Test.StopTest();
        System.assertEquals(1, cn.size(),'Size is not fullfilled');
    }
}