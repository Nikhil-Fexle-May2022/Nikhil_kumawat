public with sharing class Records_PDF_Controller {
    public List<Transaction_Entry__c> transaction_Entry_List{get;set;}
    public String startDateString {set;get;}
    public String endDateString {set;get;}
    public Contact contact_Object{set;get;} 

    public Records_PDF_Controller() {
        Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=BankStatement.pdf');
    }

    public void recordPdf(){
        Id idOfContacts = ApexPages.currentPage().getParameters().get('id');

        Transaction_Entry_List  = [SELECT Id, Name, Transaction_Date__c, Amount__c,  Type__c, Status__c 
                                            FROM Transaction_Entry__c WHERE Contact__c = :idOfContacts];
                                            System.debug('List Of Records'+Transaction_Entry_List);

        contact_Object = [SELECT Id, Title, Name , Email, Account_Number__c FROM Contact WHERE ID = :idOfContacts LIMIT 1];
        System.debug('Contacts' +contact_Object);
    }
}