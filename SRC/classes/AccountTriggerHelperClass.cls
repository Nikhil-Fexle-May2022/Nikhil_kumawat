public with sharing class AccountTriggerHelperClass {
    public static void setPrefixOnAccount(List<Account> newList){
        for(Account acc : newList){
            if(acc.AccountType__c == 'Saving Account'){
                acc.AccountNumber = 'SA-'+acc.AccountNumber;
        	}
            else if(acc.AccountType__c == 'Fixed-Deposit'){
                acc.AccountNumber = 'FD-'+acc.AccountNumber;
            }
        }
    }
    
    // SENDING EMAIL TO THE CUSTOMER
    public static void sendEmail(List<Account> newList){
        // CREATING A MASTER LIST TO CONTAIN THE EMAILS
        List<Messaging.SingleEmailMessage> emailSending = new List<Messaging.SingleEmailMessage>();
        for(Account acc : newList){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String> {acc.EmailToCustomer__c});
            email.setSubject('Congratulations'+acc.Name);
            String body = ('Mr/Ms' + '<br>' + acc.Name + 'Welcome in the world bank' + '<br>' + 'You have successfully created a bank account' + '<br>' + 'Your account Number is ' + acc.AccountNumber);
            email.setHtmlBody(body);
            emailSending.add(email);
        }
        // FINAL CALL FOR SENDING EMAILLIST
        Messaging.sendEmail(emailSending);
    }
}