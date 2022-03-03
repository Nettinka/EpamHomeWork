global class ChageContactFromAccountBatch implements Database.Batchable<Contact>{
    
    global Iterable<Contact> start(Database.BatchableContext bc) { 
        List<Contact> listContacts= [SELECT Id, Is_Synced__c, MailingAddress, AccountId FROM Contact WHERE Is_Synced__c = false];
        return listContacts;
    }

    global void execute(Database.BatchableContext bc, List<Contact> scope){
        List<Account> accsToUpdate = new List<Account>();
        List<Contact> contactsToUpdate = new List<Contact>();
        Map<Id,List<Contact>> accountContactMap = new Map<Id,List<Contact>>();
        List<Id> accId = new List<Id>();
        
        if(scope.size() > 0){     
            for(Contact con : scope){
            accId.add(con.AccountId);
            }
        }
        
        
        List<Account> lstAccount = 
        [SELECT Id, Name, BillingCity, BillingStreet, BillingState, BillingPostalCode, BillingCountry, (SELECT Id, Name, Is_Synced__c, AccountId FROM Contacts) FROM Account WHERE Id IN:accId];
        Map<Id,Account> accMap = new Map<Id,Account>(lstAccount);

        if(lstAccount.size() > 0){
            for(Account acc : lstAccount)
            {
                accountContactMap.put(acc.id, acc.Contacts);
            }
        }
        if(accMap.size() > 0){
            for(Id key : accountContactMap.keySet()){
                List<Contact> contacts = accountContactMap.get(key);
                accMap.get(key).Updated_By_Contact__c = true;
                accsToUpdate.add(accMap.get(key));
                for(Contact c : contacts){
                    c.MailingStreet     = accMap.get(key).BillingStreet;
                    c.MailingCity       = accMap.get(key).BillingCity;
                    c.MailingState      = accMap.get(key).BillingState;
                    c.MailingPostalCode = accMap.get(key).BillingPostalCode;
                    c.MailingCountry    = accMap.get(key).BillingCountry;
                    c.Is_Synced__c = true;
                    contactsToUpdate.add(c);
                }           
            }
        }
        
        if(accsToUpdate.size() > 0){update accsToUpdate;}
        if(contactsToUpdate.size() > 0){update contactsToUpdate;}
    }

    global void finish(Database.BatchableContext bc){
        System.debug('Batch Ok ' + bc.getJobId());
    }
}

//test ok