@isTest(seeAllData = false)
public class SortWrapperTest {
	
    @TestSetup 
    static void testData(){
        
        List<Contact> contactRecords = TestFactory.createContactList(5, false);
        for(Contact con : contactRecords){
            con.FirstName = 'Test';
            con.LastName = 'Contact';
            con.Phone = '8989897878';
        }
        
        if(!contactRecords.isEmpty()){
            insert contactRecords;
        }
    }
    
    @isTest static void testSortMethod(){
        List<Contact> cn = [SELECT Id, FirstName, LastName, Phone, Contact.Name FROM Contact];
        
        Test.StartTest();
            SortWrapper sc = new SortWrapper();    
            SortWrapper.ContactInfoWrapper conWrapper = new SortWrapper.ContactInfoWrapper(cn[0]);
        Test.StopTest();
	
        System.assertEquals(5, cn.size(),'Size is not fullfilled');
        System.assertEquals('Test Contact', cn[0].Name, 'Incorrect Contact name');
        System.assertEquals('8989897878', cn[0].Phone, 'Incorrect Contact phone');
    }
}
