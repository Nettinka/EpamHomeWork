global without sharing class AccountUpdated {
    @InvocableMethod
    global static void checkTask(List<Id> accId) {
        List<Account> accountList = [SELECT Id, Name FROM Account WHERE Id IN : accId];
        List<User> randomUsers = [Select Id, Name From User Where IsActive = true Limit 1];
        List<Task> accountsTasks = [Select Id, WhatId, OwnerId From Task Where WhatId IN : accId];
        List<Task> taskForUpdating = new List<Task>();
        for(Account acc : accountList){
            List<Task> taskForAddingForUser = new List<Task>();
            for(Task t : accountsTasks){
                if(t.WhatId == acc.Id){
                    taskForAddingForUser.add(t);
                }
            }
            if (taskForAddingForUser.size() >= 3){
                for (Task tas : taskForAddingForUser){
                    tas.OwnerId = randomUsers.get(0).Id;
                    taskForUpdating.add(tas);
                }
            }
        }

        update taskForUpdating;
    }

    
}
