@isTest
public with sharing class UpdateContactWithouTrigQueueClassTest {
    @isTest static void doTest(){
        Account acc = TestDataFactoryClass.ACCOUNT.createDummyAccount('name', false);
        acc.BillingCity = 'Toronto';
        insert acc;
        List<Contact> contactList = TestDataFactoryClass.CONTACT.createDummyListOfContact(3, 'LastName', acc.Id, true, false, false, false);
		insert contactList;
        UpdateContactWithouTrigQueueClass job = new UpdateContactWithouTrigQueueClass(new List<Account>([SELECT Id, Name, BillingCity, BillingAddress FROM Account]));
        Test.startTest();
        System.enqueueJob(job);
        Test.stopTest();
        
        System.assertEquals(3, [SELECT COUNT() FROM Contact WHERE Processed_By_Queue__c = true]);
    }
}