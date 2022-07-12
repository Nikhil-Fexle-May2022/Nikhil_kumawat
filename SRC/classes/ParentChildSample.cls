/**
* Description   - Parent-Child Record creation together
*
* Created by    - Nikhil Kumawat
*
* Created Date  - 09/06/2022
*
* Revision log  -  V_1.0 - Created  - Nikhil Kumawat 
*                  

**/
public with sharing class ParentChildSample {
        /**
        * Description   :  Creating Parent-Child relationship record together
        *
        * Created by    :  Nikhil Kumawat
        * 
        * Return        :  Void
        *
        * Revision log  :  V_1.0 - Created  - Nikhil Kumawat 
        *                  

        **/ 
    public static void InsertParentChild() {
    Date dt = Date.today();
    dt = dt.addDays(7);
    Opportunity newOpportunity = new Opportunity(
        Name='OpportunityWithAccountInsert',
        StageName='Prospecting',
        CloseDate=dt);
    
    // Create the parent reference.
    // Used only for foreign key reference
    // and doesn't contain any other fields.
    Account accountReference = new Account(
        MyExtID__c='SAP111111');                
    newOpportunity.Account = accountReference;
    
    // Create the Account object to insert.
    // Same as above but has Name field.
    // Used for the insert.
    Account parentAccount = new Account(
        Name='Hallie',
        MyExtID__c='SAP111111');      
    
    // Create the account and the opportunity.
    Database.SaveResult[] results = Database.insert(new SObject[] {
        parentAccount, newOpportunity });
    
    // Check results.
    for (Integer i = 0; i < results.size(); i++) {
        if (results[i].isSuccess()) {
        System.debug('Successfully created ID: '
              + results[i].getId());
        } 
        else {
        System.debug('Error: could not create sobject '
              + 'for array element ' + i + '.');
        System.debug('   The error reported was: '
              + results[i].getErrors()[0].getMessage() + '\n');
            }
        }
    }
}
/*
HOW TO RUN IN ANONYMOUS WINDOW :-> 
    ExternalId.createAccountWithFieldAndOpportunity();

OUTPUT -> 
17:07:31:175 USER_DEBUG [53]|DEBUG|Successfully created ID: 0015i00000AgldoAAB
17:07:31:175 USER_DEBUG [53]|DEBUG|Successfully created ID: 0065i000005eRxYAAU
*/
