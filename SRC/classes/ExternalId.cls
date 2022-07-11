/**
* Description   - Using External Id As a field
*
* Created by    - Nikhil Kumawat
*
* Created Date  - 09/06/2022
*
* Revision log  -  V_1.0 - Created  - Nikhil Kumawat 
*                  

**/
public with sharing class ExternalId {
        /**
        * Description   :  Use of External ID field of account object
        *
        * Created by    :  Nikhil Kumawat
        * 
        * Return        :  Void
        *
        * Revision log  :  V_1.0 - Created  - Nikhil Kumawat 
        *                  

        **/ 
    public void createAccountWithFieldAndOpportunity() {
        Opportunity newOpportunity = new Opportunity(
            Name='OpportunityWithAccountInsert',
            StageName='Prospecting',
            CloseDate=Date.today().addDays(7));
        
        // Create the parent record reference.
        // An account with external ID = 'SAP111111' already exists.
        // This sObject is used only for foreign key reference
        // and doesn't contain any other fields.
        Account accountReference = new Account(
            MyExtID__c='SAP111111');                
        
        // Add the account sObject to the opportunity.
        newOpportunity.Account = accountReference;
        
        // Create the opportunity.
        Database.SaveResult results = Database.insert(newOpportunity);
    }
}