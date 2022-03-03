@isTest
public class AccountTriggerTest {
    @isTest 
    static void onInsertAccountTest(){
        List<Account> accs = TestDataFactoryClass.ACCOUNT.createDummyListOfAccounts(3, 'Test', false);

        Test.startTest();
        insert accs;
        Test.stopTest();

        List<Task> tasks = [SELECT Id, Is_Synced__c, WhatId, Subject FROM Task];  
        System.assertEquals(false, tasks[0].Is_Synced__c, 'Wrong Is_Synced__c status');
        
    }

    @isTest
    static void onUpdateAccountTest(){
        List<Contact> contactForInsert = new List<Contact>();
        List<Account> accs = TestDataFactoryClass.ACCOUNT.createDummyListOfAccounts(3, 'Test', false);
        for(Account ass : accs){
            ass.BillingCity = 'Old city';
        }
        insert accs;
        //Map<Id,Account> oldMap = new Map<Id,Account>([select id, BillingAddress FROM Account]);
        
        List<Account> accsForContact = [SELECT Id, BillingCity, Name FROM ACCOUNT];
        for(Account a : accsForContact){
            contactForInsert.add(TestDataFactoryClass.CONTACT.createDummyContact(a.Name + ' contact', a.Id, true, false, false, false));
            a.BillingCity = 'New City';
        }
        insert contactForInsert;
        Test.startTest();
        update accs;
        Test.stopTest();

        List<AsyncApexJob> jobInfo = [SELECT Id, Status, NumberOfErrors FROM AsyncApexJob];
        System.assertNotEquals(null, jobInfo.size());
        

    }
}