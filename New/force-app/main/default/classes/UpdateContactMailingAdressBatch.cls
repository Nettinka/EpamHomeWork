global without sharing class UpdateContactMailingAdressBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Is_Synced__c, MailingAddress FROM Contact WHERE Is_Synced__c = false]);
    }

    public void execute(Database.BatchableContext bc, List<Contact> contacts){
        List<Account> accsToUpdate = new List<Account>();
        List<Contact> contactsToUpdate = new List<Contact>();
        Map<Id,List<Contact>> accountContactMap = new Map<Id,List<Contact>>();
        
        List<Id> accId = new List<Id>();
        for(Contact con : contacts){
            accId.add(con.AccountId);
        }
        List<Account> lstAccount = [SELECT Id, Name, (SELECT Id, Name, Is_Synced__c FROM Contacts) FROM Account WHERE Id IN:accId];
        
        Map<Id,Account> accMap = new Map<Id,Account>(lstAccount);

        for(Account acc : lstAccount)
        {
            accountContactMap.put(acc.id, acc.Contacts);
        }
        for(Id key : accountContactMap.keySet()){
            List<Contact> conts = accountContactMap.get(key);
            accMap.get(key).Updated_By_Contact__c = true;
            accsToUpdate.add(accMap.get(key));
            for(Contact c : conts){
                c.MailingStreet     = accMap.get(key).BillingStreet;
                c.MailingCity       = accMap.get(key).BillingCity;
                c.MailingState      = accMap.get(key).BillingState;
                c.MailingPostalCode = accMap.get(key).BillingPostalCode;
                c.MailingCountry    = accMap.get(key).BillingCountry;
                c.Is_Synced__c = true;
                contactsToUpdate.add(c);
            }    
        }

        update accsToUpdate;
        update contactsToUpdate;
    }

    public void finish(Database.BatchableContext bc){
        System.debug('Batch Ok ' + bc.getJobId());
    }
}
