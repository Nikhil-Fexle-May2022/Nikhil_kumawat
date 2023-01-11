@isTest(seeAllData = false)
public class SortWrapperTest {
    
    @isTest 
    static void testSortMethod(){
        
        List<Contact> contactRecords = TestFactory.createContactList(5, false);
        for(Contact con : contactRecords){
            con.Id = TestFactory.getFakeId(Contact.SObjectType);
            con.Phone = '8989897878';
        }
        
        MockDAO.ContactMockDAO contactMockDAOInstance = new MockDAO.ContactMockDAO();
        contactMockDAOInstance.contactList = contactRecords;
            
            Test.StartTest();
                ContactDAO.IContactDAO contactDAOInstance = new ContactDAO();
                contactDAOInstance = contactMockDAOInstance;
                List<Contact> contacts = contactDAOInstance.generateContact();
                SortWrapper sc = new SortWrapper(); 
                SortWrapper.ContactInfoWrapper conWrapper = new SortWrapper.ContactInfoWrapper(contacts[0]);
                System.assertEquals(5, contacts.size(),'Size is not fullfilled');
                System.assertEquals('8989897878', contacts[0].Phone, 'Incorrect Contact phone');
            Test.StopTest();
    }
}
