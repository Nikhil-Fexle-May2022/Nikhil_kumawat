public class TransactionEntry {
    public static void transaction(Map<Id, Transaction_Entry__c> MapOfTransactionEntry){
        
        Set<Id> setOfContactId = new Set<Id>();       // Contact Ids
        List<Id> listOfCreditId = new List<Id>();   // Credit Ids
        List<Id> listOfDebitId = new List<Id>();   // Debit Ids
        // Hold Contact Id as key, and transaction entry record as a value
        Map<Id, Transaction_Entry__c> MapOfTransactionEntryRecord = new Map<Id, Transaction_Entry__c>();
        // Hold Transac. entry id as a key and entry record as a value
        Map<Id, Transaction_Entry__c> mapOfTrasacRecordIdAndValues = new Map<Id, Transaction_Entry__c>();
        for(String Ids: MapOfTransactionEntry.keySet()){
            setOfContactId.add(MapOfTransactionEntry.get(Ids).Contact__c);
            
            MapOfTransactionEntryRecord.put(MapOfTransactionEntry.get(Ids).Contact__c, MapOfTransactionEntry.get(Ids));
            if(MapOfTransactionEntry.get(ids).type__c == 'Credit'){
                listOfCreditId.add(ids);
            }
            if(MapOfTransactionEntry.get(ids).type__c == 'Debit'){
                listOfDebitId.add(ids);
                mapOfTrasacRecordIdAndValues.put(ids, MapOfTransactionEntry.get(Ids));
            }
        }
        System.debug('Running');
        
        // List for update contact object
        List<Contact> listOfContact = new List<Contact>();
        // List for update transaction entry object
        List<Transaction_Entry__c> listOfTransactionEntryRecord = new List<Transaction_Entry__c>();
        
        // Child to Parent query -> Contact to Transaction Limit-> fetch transaction field data with filter -> "setOfContactId"
        Map<Id, Contact> mapofTransactionLimit = new Map<Id, Contact>([Select Id, Transaction_Limit__r.Maximum_Debit_Allowed_per_Day__c, 
                                                                       Transaction_Limit__r.Maximum_Debit_Allowed_per_Month__c, 
                                                                       Transaction_Limit__r.Maximum_Debit_Allowed_per_Transaction__c, 
                                                                       Transaction_Limit__r.Maximum_Transactions_Allowed_per_Day__c, 
                                                                       Transaction_Limit__r.Maximum_Transactions_Allowed_per_Month__c 
                                                                       From Contact Where Id In: setOfContactId ]);
        System.debug('mapofTransactionLimit =====>  ' + mapofTransactionLimit);
        
        Integer mnth = System.Today().Month();
        
        // Parent to child query -> Contact to Transaction Entry
        // Filter Parent Contact records with => "setOfContactId"
        // Filter child transaction entry records with => "Current Month"
        for(Contact con: [Select Id, Available_Balance__c, Status__c, (Select Id, Amount__c, Type__c, Status__c, Transaction_Date__c From Transaction_Entries__r  Where CALENDAR_MONTH(Transaction_Date__c) = :mnth) From Contact Where Id In: setOfContactId])
        {
            System.debug('Inside for parent to child');
            //Transaction_Entry__c transactionObj = new Transaction_Entry__c();
            
            if(con.status__c.equals('Active')){
                
                Integer transactionPerDayCount = 0;               // HOLD number of transaction one day
                Decimal transactionAmountPerDayCount = 0;         // HOLD total transaction amount of one day
                Integer transactionPerMonthCount = 0;             // HOLD total transaction of one month
                Decimal transactionAmountPerMonthCount = 0;       // HOLD total transaction amount of one month
                Id idOfDebit;
                List<Id> listOfNewDebitId = new List<Id>();
                System.debug('Active');
                
                for(Transaction_Entry__c trans: con.Transaction_Entries__r){
                    System.debug('For loop runing');
                    
                    if(trans.type__c == 'Debit'){
                        System.debug('Debiting executing');
                        
                        if(trans.Transaction_Date__c == System.today()){
                            transactionPerDayCount += 1;
                            transactionAmountPerDayCount += trans.Amount__c;
                            System.debug(' Debiting today');
                        }
                        
                        transactionPerMonthCount += 1;
                        transactionAmountPerMonthCount += trans.Amount__c;
                        if(listOfDebitId.contains(trans.id)){
                            //idOfDebit = trans.id;
                            listOfNewDebitId.add(trans.id);
                        }
                    }
                    else if(trans.Type__c == 'Credit' && listOfCreditId.contains(trans.id)){
                        // for credit the amount
                        System.debug('Credit is executing');
                        
                        
                        if(con.Available_Balance__c == null){
                            con.Available_Balance__c = 0 + trans.Amount__c;
                        }
                        else{
                            //con.Available_Balance__c = con.Available_Balance__c + MapOfTransactionEntryRecord.get(con.Id).Amount__c;
                            con.Available_Balance__c = con.Available_Balance__c + trans.Amount__c;
                            System.debug('Available Balance');
                        }    
                        //listOfContact.add(conObj);
                        
                        Transaction_Entry__c transactionObj = new Transaction_Entry__c();
                        //transactionObj.Id = MapOfTransactionEntryRecord.get(con.Id).Id;
                        transactionObj.Id = trans.Id;
                        transactionObj.Status__c = 'Completed';
                        listOfTransactionEntryRecord.add(transactionObj);
                    }                    
                }
                
                for(Id idsOfDebit: listOfNewDebitId){
                    if(transactionAmountPerDayCount != 0){
                        System.debug('After Per Day Amount Counting');
                        if(con.Available_Balance__c >= 3000){
                            System.debug('Checking Limit should be greater than 3000');
                            if(transactionAmountPerDayCount <= mapofTransactionLimit.get(con.Id).Transaction_Limit__r.Maximum_Debit_Allowed_per_Day__c){
                                System.debug('Maximum Debit Allowed perticular Dat');
                                if(transactionPerDayCount <= mapofTransactionLimit.get(con.Id).Transaction_Limit__r.Maximum_Transactions_Allowed_per_Day__c){
                                    System.debug('Maximum transactions Allowed per day');
                                    if(transactionPerMonthCount <= mapofTransactionLimit.get(con.Id).Transaction_Limit__r.Maximum_Debit_Allowed_per_Month__c){
                                        System.debug('Maximum debit allowed per month');
                                        if(transactionAmountPerMonthCount <= mapofTransactionLimit.get(con.Id).Transaction_Limit__r.Maximum_Debit_Allowed_per_Month__c){
                                            System.debug('Maximum debit allowed per month');
                                            if(mapofTransactionLimit.get(con.Id).Transaction_Limit__r.Maximum_Debit_Allowed_per_Transaction__c >= mapOfTrasacRecordIdAndValues.get(idsOfDebit).Amount__c){
                                                System.debug('Maximum debit allowed per transaction');
                                                con.Available_Balance__c = con.Available_Balance__c - mapOfTrasacRecordIdAndValues.get(idsOfDebit).Amount__c;
                                                Transaction_Entry__c transactionObj = new Transaction_Entry__c();
                                                transactionObj.Id = mapOfTrasacRecordIdAndValues.get(idsOfDebit).Id;
                                                transactionObj.Status__c = 'Completed';
                                                listOfTransactionEntryRecord.add(transactionObj);
                                            }
                                            else{
                                                mapOfTrasacRecordIdAndValues.get(idsOfDebit).addError('You have exceed your amount limit');
                                            }
                                        }
                                        else{
                                            mapOfTrasacRecordIdAndValues.get(idsOfDebit).addError('You have exceed your transaction amount of this month');
                                        }
                                    }
                                    else{
                                        mapOfTrasacRecordIdAndValues.get(idsOfDebit).addError('You have exceed your transaction limit of this month');
                                    }
                                }
                                else{
                                    mapOfTrasacRecordIdAndValues.get(idsOfDebit).addError('You have exceed your transaction limit');
                                }
                            }
                            else{
                                mapOfTrasacRecordIdAndValues.get(idsOfDebit).Amount__c.addError('You have exceed your today amount limit');
                            }
                        }
                        else{
                            mapOfTrasacRecordIdAndValues.get(idsOfDebit).addError('You don\'t have amount');
                        }
                    }
                }
            }
            
            else{
                MapOfTransactionEntryRecord.get(con.Id).addError('Contact is deactivated you can\'t create entry');
            }

            if(con.id != null){
                listOfContact.add(con);
            }     
        }
        
        if(!listOfContact.isEmpty()){
            update listOfContact;
        }
        if(!listOfTransactionEntryRecord.isEmpty()){
            update listOfTransactionEntryRecord;
        }
    }
    
    // For Global Validation Rule No 5
    public static void updateEntries(List<Transaction_Entry__c> listOfUpdateRecord){
        System.debug('List' +listOfUpdateRecord);
        List<Contact> listOfCon = new List<Contact>();
        List<Id> listOfContactId = new List<Id>();
        for(Transaction_Entry__c entry : listOfUpdateRecord){
            if(entry.Status__c == 'Cancelled'){
                listOfContactId.add(entry.Contact__c);
            }
        }
        System.debug('Ids' +listOfContactId);
        Map<Id,Contact> mapOfContact = new Map<Id, Contact>([SELECT Id, Available_Balance__c FROM Contact WHERE Id In :listOfContactId]);
        for(Transaction_Entry__c entryRecord : listOfUpdateRecord){
            if(listOfContactId.contains(entryRecord.Contact__c)){
               if(entryRecord.Type__c == 'Debit'){
                   mapOfContact.get(entryRecord.Contact__c).Available_Balance__c = mapOfContact.get(entryRecord.Contact__c).Available_Balance__c + entryRecord.Amount__c;
                   System.debug('Cancel');
               }
                else{
                    mapOfContact.get(entryRecord.Contact__c).Available_Balance__c = mapOfContact.get(entryRecord.Contact__c).Available_Balance__c - entryRecord.Amount__c;
                    System.debug('Cancel');
                }
        }
    }
        if(!mapOfContact.isEmpty()){
            update mapOfContact.values();
        }
}
}