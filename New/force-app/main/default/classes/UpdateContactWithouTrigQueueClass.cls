public with sharing class UpdateContactWithouTriggerQueuebleJobClass implements Queueable{
    List<Account> accountsList;
    
    public UpdateContactWithouTriggerQueuebleJobClass(List<Account> accs) {
        this.accountsList = accs;
    }
    public void execute(QueueableContext context) {
        List<Account> onlyFullAdressAcc = new List<Account>();
        Map<Id,List<Contact>> accountContactMap = new Map<Id,List<Contact>>();
        for(Account acc : onlyFullAdressAcc){
            if(acc.BillingAddress != null){
                onlyFullAdressAcc.add(acc);
            }
        }
        Map<Id,Account> accMap = new Map<Id,Account>(onlyFullAdressAcc);

        List<Account> lstAccount = [SELECT Id, Name, (SELECT Id, Name, Is_Synced__c, Processed_By_Future__c FROM Contacts)FROM Account WHERE Id IN : accMap.keySet()];

        for(Account acc : lstAccount)
        {
            accountContactMap.put(acc.id, acc.Contacts);
        }

    }

}
