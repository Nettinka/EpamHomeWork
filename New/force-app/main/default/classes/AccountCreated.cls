global without sharing class AccountCreated {
    @InvocableMethod
    global static void creatTask(List<Id> accId) {
        List<Account> accountList = [SELECT Id, Name FROM Account WHERE Id IN : accId];
        List<Task> taskForinsert = new List<Task>();
        for(Account acc : accountList){
            Task t = new Task();
            t.Subject = 'Other';
            t.Description = 'Negotiations with ' + acc.Name;
            t.WhatId = acc.Id;
            taskForinsert.add(t);
        }
        insert taskForinsert;
    }
}
