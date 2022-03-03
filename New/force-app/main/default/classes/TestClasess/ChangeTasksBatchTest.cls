@isTest
public with sharing class ChangeTasksBatchTest {
    @isTest static void doTest(){
        Account acc = TestDataFactoryClass.ACCOUNT.createDummyAccount('Fedya', true);
        Task t = new Task(WhatId = acc.Id,
        Is_Synced__c = false);
        insert t;

        Test.startTest();
        ChangeTasksBatch job = new ChangeTasksBatch();
        Id batchId = Database.executeBatch(job);
        Test.stopTest();
        
        List<Task> tskList = [SELECT Id, Account_Owner__c, Is_Synced__c, WhatId FROM Task];

        System.assertEquals(acc.Name, tskList[0].Account_Owner__c);
        System.assertEquals(true, tskList[0].Is_Synced__c);
    }
}