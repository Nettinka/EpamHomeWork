@isTest
public class ChangeContactsQueuebleTest {
    @isTest static void doTest(){
        List<Account> accList = TestDataFactoryClass.ACCOUNT.createDummyListOfAccounts(3, 'name', false);
        insert accList;
        List<Contact> contList = 
        TestDataFactoryClass.CONTACT.createDummyListOfContact(2, 'LastName', accList[0].Id, true, false, false, false);
        insert contList;

        Map<Id,Account> accMap = new Map<Id,Account>([SELECT Id, Name FROM Account]);

        Test.startTest();
        ChangeContactsQueueble job = new ChangeContactsQueueble(new List<Id>(accMap.keySet()));
        System.enqueueJob(job);
        Test.stopTest();

        System.assertEquals(2, [SELECT COUNT() FROM Contact WHERE Processed_By_Queue__c = true]);
    }
}
