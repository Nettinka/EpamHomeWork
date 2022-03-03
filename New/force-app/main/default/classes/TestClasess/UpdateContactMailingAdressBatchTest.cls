@isTest
public class UpdateContactMailingAdressBatchTest {
    @isTest static void doTest(){
        Account acc = TestDataFactoryClass.ACCOUNT.createDummyAccount('name', false);
        acc.BillingCity = 'Toronto';
        acc.BillingStreet = 'Central Park';
        acc.Updated_By_Contact__c = false;
        insert acc;
        List<Contact> contactList = TestDataFactoryClass.CONTACT.createDummyListOfContact(3, 'Contact', acc.Id, false, false, false, false);
        for(Contact c : contactList){
            c.MailingCity = 'Apple';
            c.MailingStreet = 'Pork';
        }
        insert contactList;

        Test.startTest();
        UpdateContactMailingAdressBatch job = new UpdateContactMailingAdressBatch();
        Id batchId = Database.executeBatch(job);
        Test.stopTest();

        System.assertEquals(3, [SELECT count() FROM contact WHERE MailingCity = 'Toronto']);
        System.assertEquals(1, [SELECT count() FROM Account WHERE Updated_By_Contact__c = true]);
    }
}