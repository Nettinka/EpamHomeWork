global without sharing class ChangeContactsQueueble implements Queueable{
    
    private List<Id> idList;

    public ChangeContactsQueueble(List<Id> changedAccId){
        this.idList = changedAccId;
    }
    public void execute(QueueableContext context){
        List<Contact> contacts = [SELECT Id, Processed_By_Queue__c, Is_Synced__c, AccountId FROM Contact WHERE AccountId IN : idList];
        for(Contact con : contacts){
            con.Processed_By_Queue__c = true;
            con.Is_Synced__c = false;
        }
        update contacts;
    }
}