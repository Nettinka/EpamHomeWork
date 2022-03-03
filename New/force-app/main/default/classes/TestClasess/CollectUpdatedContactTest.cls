@isTest
public class CollectUpdatedContactTest {
    @isTest static void doTest(){
        List<Account> accList = TestDataFactoryClass.ACCOUNT.createDummyListOfAccounts(2, 'name', false);
        insert accList;

        List<Contact> qCont = TestDataFactoryClass.CONTACT.createDummyListOfContact(2, 'Name', accList[0].id, true, false, false, false);
        insert qCont;

        List<Contact> fCont = TestDataFactoryClass.CONTACT.createDummyListOfContact(6, 'Name', accList[0].id, true, false, false, false);
        insert fCont;

        Test.startTest();
        CollectUpdatedContact collect1 = new CollectUpdatedContact(qCont, 'Queue');
        List<Contact> listCon1 = collect1.collectContact();
        update listCon1;

        CollectUpdatedContact collect2 = new CollectUpdatedContact(fCont, 'Future');
        List<Contact> listCon2 = collect2.collectContact();
        update listCon2;
        Test.stopTest();

        System.assertEquals(2, [SELECT COUNT() From Contact WHERE Processed_By_Queue__c = true], 'Wrong count with Processed_By_Queue__c status');
        System.assertEquals(6, [SELECT COUNT() From Contact WHERE Processed_By_Future__c = true], 'Wrong count with Processed_By_Future__c status');
    }
}
