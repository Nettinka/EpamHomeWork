global without sharing class ChangeTasksBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Is_Synced__c, Account_Owner__c FROM Task WHERE Is_Synced__c = false]);
    }

    public void execute(Database.BatchableContext bc, List<Task> tasks){
        List<Account> accounts = new List<Account>();
        List<Task> taskForUpdate = new List<Task>();
        List<Id> accId = new List<Id>();
        for(Task tas : tasks){
            accId.add(tas.WhatId);
        }
        accounts = [SELECT Id, Updated_By_Task__c FROM Account WHERE Id IN : accId];
        Map<Id,Account> accMap = new Map<Id,Account>(accounts);
       // Map<Id, Account> accounts = new Map<Id, Account>([SELECT Id, Updated_By_Task__c FROM Account WHERE Id IN(SELECT Id FROM Task WHERE Id IN : tasks)]);

        for (Task t : tasks){
            t.Account_Owner__c = accMap.get(t.WhatId).Name;
            t.Is_Synced__c = true;
            accMap.get(t.WhatId).Updated_By_Task__c = true;
            taskForUpdate.add(t);
        }

        List<Account> accForUpdate = accMap.values();
        update taskForUpdate;
        update accForUpdate;

    }

    public void finish(Database.BatchableContext bc){
        System.debug('Batch Ok ' + bc.getJobId());
    }
}