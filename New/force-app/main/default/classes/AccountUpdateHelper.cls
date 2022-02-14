global without sharing class AccountUpdateHelper {
    
    public static void chageContacts(List<Account> accounts, Map<Id, Account> oldAcc){
        List<Id> changedAccId = new List<Id>();
        for(Account acc : accounts){
            if(acc.BillingAddress != oldAcc.get(acc.Id).BillingAddress){
                changedAccId.add(acc.Id);
            }
        }
        setNewValueOnContacts(changedAccId);
        ChangeContactsQueueble cTFA = new ChangeContactsQueueble(changedAccId);
        ID jobID = System.enqueueJob(cTFA);
    }

    
    public static void onInsertAccount(List<Account> newAcc){
        List<Id> changedAccId = new List<Id>();
        for(Account acc : newAcc){ 
                changedAccId.add(acc.Id);
        }
        CreateTaskForAccountAsync.createTask(changedAccId);
    }

    @future(callout=true)
    public static void setNewValueOnContacts(List<Id> accId){
        List<Contact> contacts = [SELECT Id, AccountId, Is_Synced__c, Processed_By_Future__c FROM Contact WHERE AccountId IN : accId];
        for(Contact con : contacts){
            con.Is_Synced__c = false;
            con.Processed_By_Future__c = true;
        }
        update contacts;
    }

}