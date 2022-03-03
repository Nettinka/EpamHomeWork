global without sharing class AccountUpdateHelper {
    
    public static void chageContacts(List<Account> accounts, Map<Id, Account> oldAcc){
        List<Id> changedAccId = new List<Id>();
        for(Account acc : accounts){
            if(acc.BillingAddress != oldAcc.get(acc.Id).BillingAddress){
                changedAccId.add(acc.Id);
            }
        }
        setNewValueOnContacts(changedAccId); //commit for testing ChageContactFromAccountBatch
        ChangeContactsQueueble cTFA = new ChangeContactsQueueble(changedAccId);
        ID jobID = System.enqueueJob(cTFA);
    }

    
    @future(callout=true)  //commit for testing ChageContactFromAccountBatch
    public static void setNewValueOnContacts(List<Id> accId){
        List<Contact> contacts = [SELECT Id, AccountId, Is_Synced__c, Processed_By_Future__c FROM Contact WHERE AccountId IN : accId];
        for(Contact con : contacts){
            con.Is_Synced__c = false;
            con.Processed_By_Future__c = true;
        }
        if(contacts.size() > 0){update contacts;} //commit for testing ChageContactFromAccountBatch
    }
    
    //FATAL_ERROR caused by: System.AsyncException: Future method cannot be called from a future or batch method: AccountUpdateHelper.setNewValueOnContacts(List<Id>) 

}

//test ok