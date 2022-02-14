global class ChageContactFromAccountBatch implements Database.Batchable<Contact>{
    
    global Iterable<Contact> start(Database.BatchableContext bc) { // Class ChageContactFromAccountBatch must implement the method: System.Iterable<Contact> Database.Batchable<Contact>.start(Database.BatchableContext) (1:14)
        return new CustomContactcInterable();
    }

    global void execute(Database.BatchableContext bc, List<Contact> scope){
        List<Account> accsToUpdate = new List<Account>();
        List<Contact> contactsToUpdate = new List<Contact>();
        
        List<Id> accId = new List<Id>();
        for(Contact con : scope){
            accId.add(con.AccountId);
        }
        Map<Id,List<Contact>> accountContactMap = new Map<Id,List<Contact>>();

        List<Account> lstAccount = [SELECT Id, Name, (SELECT Id, Name, Is_Synced__c FROM Contacts) FROM Account WHERE Id IN:accId];

        Map<Id,Account> accMap = new Map<Id,Account>(lstAccount);

        for(Account acc : lstAccount)
        {
            accountContactMap.put(acc.id, acc.Contacts);
        }

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

        update accsToUpdate;
        update contactsToUpdate;
    }

    global void finish(Database.BatchableContext bc){
        System.debug('Batch Ok ' + bc.getJobId());
    }
}
