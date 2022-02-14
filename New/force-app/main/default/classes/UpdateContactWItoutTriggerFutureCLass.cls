global without sharing class UpdateContactWItoutTriggerFutureCLass {
    @future
    static void updateContacts(){   
        List<Contact> contactsToUpdate = new List<Contact>();
        Map<Id,List<Contact>> accountContactMap = new Map<Id,List<Contact>>();

        List<Account> lstAccount = [SELECT Id, Name, (SELECT Id, Name, Is_Synced__c, Processed_By_Future__c FROM Contacts) FROM Account Limit 150];

        Map<Id,Account> accMap = new Map<Id,Account>(lstAccount);

        for(Account acc : lstAccount)
        {
            accountContactMap.put(acc.id, acc.Contacts);
        }

        for(Id key : accountContactMap.keySet()){
            List<Contact> contacts = accountContactMap.get(key);
            if(accMap.get(key).BillingAddress != null){
                for(Contact con : contacts){
                    con.Is_Synced__c = false;
                    con.Processed_By_Future__c = true;
                    contactsToUpdate.add(con);
                }
            }
        }

        update contactsToUpdate;
    }
}
