public class OpportunityTriggerHelper {
    
    public static Set<String> takeAll = new Set<String>();
    // After Insert Record
    public static void insertingRecord(List<Opportunity> newListOpp, Map<Id, Opportunity> oldMapOpp){
        // Global List For collecting Automobile Sensor Records from UI
        List<Automobile_Sensor__c> sensorRecord = new List<Automobile_Sensor__c>();
        // Global List For collecting Automobile Presence Sensor Records
        List<Automobile_Presence_Sensor__c> presenceRecord = new List<Automobile_Presence_Sensor__c>();
        // Global List For collecting Automobile Tag Sensor Records
        List<Automobile_Tag__c> tagRecord = new List<Automobile_Tag__c>();
        // Global List For collecting Automobile TDU Sensor Records
        List<Automobile_TDU__c> tduRecord = new List<Automobile_TDU__c>();
        List<sObject> listOfSensor = new List<sObject>();
        List<Opportunity> listOfOpp = new List<Opportunity>();

        Set<String> setOfRecord = new Set<String>();
        Set<String> noSetOfRecord = new Set<String>();
        Boolean isDuplicateRecord = false;
        for(Opportunity opp : newListOpp){ // Checking the condition
            Opportunity oppOne = new Opportunity();
            if((oldMapOpp == null || opp.StageName != oldMapOpp.get(opp.Id).StageName )){
                if(opp.StageName == 'Shipped To Customer' || opp.StageName == 'Return To HQ' || opp.StageName == 'Return To Customer'){
                    // Spliting by new Line
                    if(opp.Automobile_Tag_Details_1__c != null){
                    	setOfRecord.addAll(opp.Automobile_Tag_Details_1__c.Split('\n'));
                    }
                    if(opp.Automobile_Tag_Details_2__c != null){
                    	setOfRecord.addAll(opp.Automobile_Tag_Details_2__c.Split('\n'));
                    }
                    if(opp.Automobile_Tag_Details_3__c != null){
                    	setOfRecord.addAll(opp.Automobile_Tag_Details_3__c.Split('\n'));
                    }
                    if(opp.Return_To_HQ__c != null){
                        setOfRecord.addAll(opp.Return_To_HQ__c.Split('\n'));
                    }
                    takeAll.addAll(setOfRecord);
                }
                for(String str : setOfRecord){
                    // For Automobile sensor record
                    Automobile_Sensor__c newSensorRecord = new Automobile_Sensor__c();
                    if(str.startsWith('00:11:CE:00')){
                        if(str.length()>18){
                            newSensorRecord.Name = str.substring(0, 18);
                        }
                        else{
                            newSensorRecord.Name = str;
                        }
                        if(!isDuplicateRecord){
                            newSensorRecord.Account__c = opp.AccountId;
                            newSensorRecord.Opportunity__c = opp.id;
                            sensorRecord.add(newSensorRecord);
                        }
                        listOfSensor.add(newSensorRecord);
                    }
                    // For Automobile presence sensor record
                    Automobile_Presence_Sensor__c newPresenceRecord = new Automobile_Presence_Sensor__c();
                    if(str.startsWith('00:11:CE:D')){
                        if(str.length()>18){
                            newPresenceRecord.Name = str.substring(0, 18);
                        }
                        else{
                            newPresenceRecord.Name = str;
                        }
                        if(!isDuplicateRecord){
                            newPresenceRecord.Account__c = opp.AccountId;
                            newPresenceRecord.Opportunity__c = opp.id;
                            presenceRecord.add(newPresenceRecord);
                        }
                        listOfSensor.add(newPresenceRecord);
                    }
                    // For Automobile Tag Record   
                    Automobile_Tag__c newTagRecord = new Automobile_Tag__c();
                    if(str.startsWith('00:11:CE:E')){
                        if(str.length()>18){
                            newTagRecord.Name = str.substring(0, 18);
                        }
                        else{
                            newTagRecord.Name = str;
                        }
                        if(!isDuplicateRecord){
                            newTagRecord.Account__c = opp.AccountId;
                            newTagRecord.Opportunity__c = opp.Id;
                            tagRecord.add(newTagRecord);
                        }
                        listOfSensor.add(newTagRecord);
                    }
                    // For Automobile TDU Record
                    Automobile_TDU__c newTduRecord = new Automobile_TDU__c();
                    if(str.substring(0, 3).isNumeric()){
                        if(str.length()>18){
                            newTduRecord.Name = str.substring(0, 18);
                        }
                        else{
                            newTduRecord.Name = str;
                        }
                        if(!isDuplicateRecord){
                            newTduRecord.Account__c = opp.AccountId;
                            newTduRecord.Opportunity__c = opp.Id;
                            tduRecord.add(newTduRecord); 
                        }
                        listOfSensor.add(newTduRecord);
                    } 
                    else{
                        noSetOfRecord.add(str);
                    }
                }
                if(opp.StageName == 'Shipped To Customer'){
                    oppOne.id = opp.id;
                    oppOne.AccountId = opp.AccountId;
                    oppOne.Shipment_Account__c = null;
                    oppOne.Return_To_HQ__c = null;
                    listOfOpp.add(oppOne);
                    System.debug(listOfOpp);
                }else if(opp.StageName == 'Return To HQ'){
                    oppOne.id = opp.id;
                    oppOne.AccountId = null;
                    oppOne.Shipment_Account__c = opp.AccountId;
                    oppOne.Automobile_Tag_Details_1__c = null;
                    oppOne.Automobile_Tag_Details_2__c = null;
                    oppOne.Automobile_Tag_Details_3__c = null;
                    listOfOpp.add(oppOne);
                    System.debug(listOfOpp);
                }else if(opp.StageName == 'Return To Customer'){
                    oppOne.id = opp.id;
                    oppOne.AccountId = opp.AccountId;
                    oppOne.Shipment_Account__c = null;
                    oppOne.Return_To_HQ__c = null;
                    listOfOpp.add(oppOne);
                    System.debug(listOfOpp);
                }
            }
        }
        
        
        // Now Inserting all the records
        if(!sensorRecord.isEmpty()){
            insert sensorRecord;
        }
        if(!presenceRecord.isEmpty()){
            insert presenceRecord;
        }
        if(!tagRecord.isEmpty()){
            insert tagRecord;
        }
        if(!tduRecord.isEmpty()){
            insert tduRecord;
        }
        if(!listOfSensor.isEmpty()){
            update listOfSensor;
        }
        if(!listOfOpp.isEmpty()){
            update listOfOpp;
        }
        sendMailToOwner(newOppo, mapOfOppOwner);
    }
    public static void sendMailToOwner(List<Opportunity> newOppo, Map<Id, Opportunity> mapOfOppOwner){

        mapOfOppOwner = new Map<Id, Opportunity>([SELECT Id, Name, Owner.Email FROM Opportunity]);
        Map<Id, Sobject> mapSobject = new Map<Id, Sobject>();
        Map<Id, Automobile_Presence_Sensor__c> mapAutomobilePresenceSensor = new Map<Id, Automobile_Presence_Sensor__c>([SELECT Id, Name, Account__r.Name, Opportunity__c FROM Automobile_Presence_Sensor__c]);
        mapSobject.putAll(mapAutomobilePresenceSensor);
        Map<Id, Automobile_Sensor__c>   mapAutomobileSensor = new Map<Id, Automobile_Sensor__c>([SELECT Id, Name, Account__r.Name, Opportunity__c FROM Automobile_Sensor__c]);
        mapSobject.putAll(mapAutomobileSensor);
        Map<Id, Automobile_Tag__c>   mapAutomobileTag = new Map<Id, Automobile_Tag__c>([SELECT Id, Name, Account__r.Name, Opportunity__c FROM Automobile_Tag__c]);
        mapSobject.putAll(mapAutomobileTag);
        Map<Id, Automobile_TDU__c>   mapAutomobileTDU= new Map<Id, Automobile_TDU__c>([SELECT Id, Name, Account__r.Name, Opportunity__c FROM Automobile_TDU__c]);
        mapSobject.putAll(mapAutomobileTDU);

       
        //get all email in the list
        List<Messaging.SingleEmailMessage> eMails = new List<Messaging.SingleEmailMessage>();
        for(Id insertId : mapOfOppOwner.keySet()){
        Messaging.SingleEmailMessage email =  new Messaging.SingleEmailMessage();
        email.setToAddresses(new List<String>{mapOfOppOwner.get(insertId).Owner.Email});
        //email.setToAddresses(new List<String>{'nikhil.kumawat@fexle.com'});
        System.debug(mapOfOppOwner.get(insertId).Owner.Email);
        
        String subject = newOppo[0].Name+' '+System.today();
        email.setSubject(subject);
        email.setSenderDisplayName('NikhilBhola');
        //<br> - Defines a single line break ,width:100% - To create a full-width table, use width: 100%
        //<table border="1"> - You can get a quick border around your table by using the HTML border attribute
        String mailBody='Sensor shipment process is completed. Details to get all the success and failure details.<br/><br/>Successful:<br/><table style="width:100%" border="1">';            
        //<tr> - Defines a row in a table, <th> - Used for creates header of a group of cell in HTML table
        String tableRow='<tr><th>Automobile Type</th><th>Name</th><th>Message</th></tr>';

        for(Automobile_Sensor__c recAutomobile : mapAutomobileSensor.values()){
            if(recAutomobile.Opportunity__c  == newOppo[0].Id){
                //<td> - Defines a cell in a table or Used for creates standard data cell in HTML table
                tableRow = tableRow + '<tr><td>Sensor</td><td>'+recAutomobile.Name+'</td><td>Sensor inserted under installation account : '+recAutomobile.Account__r.Name+'</td></tr>';
            }        
        }
        for(Automobile_Presence_Sensor__c recAutomobile : mapAutomobilePresenceSensor.values()){
            if(recAutomobile.Opportunity__c  == newOppo[0].Id){
                tableRow = tableRow + '<tr><td>Presence Sensor</td><td>'+recAutomobile.Name+'</td><td>Presence Sensor inserted under installation account : '+recAutomobile.Account__r.Name+'</td></tr>';
            }
        }
        for(Automobile_TDU__c recAutomobile : mapAutomobileTDU.values()){
            if(recAutomobile.Opportunity__c  == newOppo[0].Id){
                tableRow = tableRow + '<tr><td>TUD</td><td>'+recAutomobile.Name+'</td><td> TUD Sensor inserted under installation account : '+recAutomobile.Account__r.Name+'</td></tr>';
            }        
        }
        for(Automobile_Tag__c recAutomobile : mapAutomobileTag.values()){
            if(recAutomobile.Opportunity__c  == newOppo[0].Id){
                tableRow = tableRow + '<tr><td>Tag</td><td>'+recAutomobile.Name+'</td><td> Tag Sensor inserted under installation account : '+recAutomobile.Account__r.Name+'</td></tr>';
            } 
        }
        mailBody = mailBody+tableRow+'</table>'+'<br/><br/>';

        List<String> listUnsuccessfulSensor = new List<String>();
        if(newOppo[0].Automobile_Tag_Details_1__c!=null){
            listUnsuccessfulSensor.addAll(newOppo[0].Automobile_Tag_Details_1__c.split('\n'));
        }
        if(newOppo[0].Automobile_Tag_Details_2__c!=null){
            listUnsuccessfulSensor.addAll(newOppo[0].Automobile_Tag_Details_2__c.split('\n'));
        }
        if(newOppo[0].Automobile_Tag_Details_3__c!=null){
            listUnsuccessfulSensor.addAll(newOppo[0].Automobile_Tag_Details_3__c.split('\n'));   
        }
        if(newOppo[0].Return_To_HQ__c!=null){
            listUnsuccessfulSensor.addAll(newOppo[0].Return_To_HQ__c.split('\n'));
        }
        for(Sobject sobjectFromMap : mapSobject.values()){
            if(listUnsuccessfulSensor.contains((String)sobjectFromMap.get('Name'))){
                listUnsuccessfulSensor.remove(listUnsuccessfulSensor.indexOf((String)sobjectFromMap.get('Name')));    
            }
        }

        if(listUnsuccessfulSensor!=null){
            mailBody = mailBody+'Unsuccessful : <br/><table style="width:100%" border="1">';
            tableRow = '<tr><th>Automobile Type</th><th>Name</th><th>Message</th></tr>';

            for(String unsuccessfulSensor : listUnsuccessfulSensor){
                tableRow = tableRow + '<tr><td>Sensor</td><td>'+unsuccessfulSensor+'</td><td>Sensor not inserted .</td></tr>';
            }

            mailBody = mailBody+tableRow+'</table>';
        }
        email.setHtmlBody(mailBody);
        eMails.add(email);
    }

        if(!eMails.isEmpty()){
            Messaging.sendEmail(eMails);
        }
    }
}
/*
00:11:CE:00:123
00:11:CE:D12
00:11:CE:E12
324-ABC-ABZ
*/