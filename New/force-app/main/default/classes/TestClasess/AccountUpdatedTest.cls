@isTest
public class AccountUpdatedTest {
    @isTest 
    static void checkTaskTest(){
        List<Account> accountList = TestDataFactoryClass.ACCOUNT.createDummyListOfAccounts(3, 'Test', false);
        
        List<User> userList = TestDataFactoryClass.USER.createDummyListOfUsers(3, 'Vasilev', false);
        insert accountList;
        insert userList;
        Task t = new Task(OwnerId = userList[1].Id,
                        WhatId = accountList[1].Id);
                        insert t;
        Map<Id,Account> mapAcc = new Map<Id,Account>([SELECT Id, Name FROM Account]);
        Map<Id,Task> mapTsk = new Map<Id,Task>([SELECT Id, WhatId, OwnerId FROM Task]);

        Test.startTest();
        AccountUpdated.checkTask(new List<Id>(mapAcc.keySet()));
        Test.stopTest();

        Map<Id,Task> mapNewTsk = new Map<Id,Task>([SELECT Id, WhatId, OwnerId FROM Task]);
        List<Id> idTasks = new List<Id>(mapNewTsk.keySet());

        System.assertEquals(mapTsk.get(idTasks[0]).OwnerId, mapNewTsk.get(idTasks[0]).OwnerId, 'Owner was changed');
    }
}