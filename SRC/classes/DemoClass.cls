public class DemoClass {
	
    public List<Contact> contactList{get;set;}
    
    public void getContactDetails(){
        contactList = [select id, name, isDeleted from contact where isDeleted = true ALL ROWS];
       
    }
    
    public static void getContactDetails1(){
        List<Contact> contactList1 = [select id, name, isDeleted from contact where isDeleted = true ALL ROWS];
        System.debug('Check Deleted Data ::: ' + contactList1);
       
    }
}