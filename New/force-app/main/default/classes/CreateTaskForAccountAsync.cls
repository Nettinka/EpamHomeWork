global without sharing class CreateTaskForAccountAsync {
    @future(callout=true)
    public static void createTask(List<Id> newAcc){
        List<Account> accounts = [SELECT Id, Name, BillingAddress FROM Account WHERE Id IN : newAcc];
        List<Task> tasks = new List<Task>();
        for (Account acc : accounts){
            tasks.add(new Task(Is_Synced__c = false, WhatId = acc.Id, Subject = 'new acc was created from future method'));
        }
        insert tasks;
    }
}