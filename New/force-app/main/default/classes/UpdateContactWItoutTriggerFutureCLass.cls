global without sharing class UpdateContactWItoutTriggerFutureCLass {
    @future
    public static void updateContacts(){   
        List<Contact> contactsToUpdate = new List<Contact>();
        Map<Id,List<Contact>> accountContactMap = new Map<Id,List<Contact>>();

        List<Account> lstAccount = [SELECT Id, Name, BillingAddress, (SELECT Id, Name, Is_Synced__c, Processed_By_Future__c FROM Contacts) FROM Account Limit 150];

        Map<Id,Account> accMap = new Map<Id,Account>(lstAccount);

        for(Account acc : lstAccount)
        {
            accountContactMap.put(acc.id, acc.Contacts);
        }

        for(Id key : accountContactMap.keySet()){
            List<Contact> contacts = accountContactMap.get(key);
            if(accMap.get(key).BillingAddress != null){
                CollectUpdatedContact col = new CollectUpdatedContact(contacts, 'Future');
                contactsToUpdate.addAll(col.collectContact());               
            }
        }

        update contactsToUpdate;
    }
}

//test ok