@isTest(seeAllData = false)
public with sharing class TestUpdateTest {
    
    @TestSetup
    static void createData(){
        List<Contact> conList = new List<Contact>();
        // List<Contact> updateConList = new List<Contact>();
        for(Integer i = 1; i <= 10; i++){
            Contact con = new Contact();
            con.FirstName = 'Test';
            con.LastName = 'Data ' +i ;
            con.Title = i + ' Data Title';
            con.Email = 'test' +i+'@data.com';
            conList.add(con);
        }        
        insert conList;
    }
    
    @isTest
    private static void testUpdateContact(){
        /*
        List<Contact> updateConList = new List<Contact>();
        List<Contact> conList =  [SELECT Id, FirstName, LastName, Title, Email FROM Contact Where CreatedDate=today Order By CreatedDate desc Limit 10];
        System.debug(conList);
        
        for(Contact conn : conList){
            Contact conData = new Contact();
            conData.FirstName = conn.FirstName;
            conData.LastName = conn.LastName;
            conData.Title = conn.Title;
            conData.Email = conn.Email;
            updateConList.add(conData);
        } 
        System.debug(updateConList);
       // update updateConList;
*/
        
        Test.startTest();
        TestUpdate obj = new TestUpdate();
        obj.updateContact();
        Test.stopTest();
        
        // System.assertEquals(10, updateConList.size());
    }
}