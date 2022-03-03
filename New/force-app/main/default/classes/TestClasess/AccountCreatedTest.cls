@isTest
global class AccountCreatedTest {
    @isTest
    static void creatTaskTest(){
        List<Account> accList = TestDataFactoryClass.ACCOUNT.createDummyListOfAccounts(1, 'Test', false);
        insert accList;
        Map<Id,Account> accIds = new Map<Id,Account>([SELECT Id, Name FROM Account]);
        List<Id> ids = new List<Id>(accIds.keySet());
        Test.startTest();
        AccountCreated.creatTask(ids);
        Test.stopTest();
        List<Task> tasks = [SELECT Id, WhatId FROM Task];

        System.assertNotEquals(tasks.size(), 3);
        
    }
}