@isTest
public with sharing class UpdateContactFutureCLassTest {
    @isTest static void doTest(){
        Account acc = TestDataFactoryClass.ACCOUNT.createDummyAccount('name', false);
        acc.BillingCity = 'Toronto';
        insert acc;
        List<Contact> contactList = TestDataFactoryClass.CONTACT.createDummyListOfContact(3, 'LastName', acc.Id, true, false, false, false);
		insert contactList;
        
        Test.startTest();
        UpdateContactWItoutTriggerFutureCLass.updateContacts();
        Test.stopTest();
        
        System.assertEquals(3, [SELECT COUNT() FROM Contact WHERE Processed_By_Future__c = true]);
    }
}

