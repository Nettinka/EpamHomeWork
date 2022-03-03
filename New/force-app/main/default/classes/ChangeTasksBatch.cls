global without sharing class ChangeTasksBatch implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Is_Synced__c, Account_Owner__c, WhatId FROM Task WHERE Is_Synced__c = false]);
    }

    public void execute(Database.BatchableContext bc, List<Task> tasks){
        List<Account> accounts = new List<Account>();
        List<Task> taskForUpdate = new List<Task>();
        List<Id> accId = new List<Id>();
        if(tasks.size() > 0){
            for(Task tas : tasks){
                accId.add(tas.WhatId);
            }
        }
        
        accounts = [SELECT Id, Name, Updated_By_Task__c FROM Account WHERE Id IN : accId];
        Map<Id,Account> accMap = new Map<Id,Account>(accounts);

        if(accounts.size() > 0){
            for (Task t : tasks){
                t.Account_Owner__c = accMap.get(t.WhatId).Name;
                t.Is_Synced__c = true;
                accMap.get(t.WhatId).Updated_By_Task__c = true;
                taskForUpdate.add(t);
            }
        }
        
        List<Account> accForUpdate = accMap.values();
        if(taskForUpdate.size() > 0){update taskForUpdate;}
        if(accForUpdate.size() > 0){update accForUpdate;}

    }

    public void finish(Database.BatchableContext bc){
        System.debug('Batch Ok ' + bc.getJobId());
    }
}

//test ok