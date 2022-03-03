@isTest
public class ChageContactFromAccountBatchTest {
    @TestSetup
    static void makeData(){
        Account acc = TestDataFactoryClass.ACCOUNT.createDummyAccount('name', false);
        acc.BillingCity = 'Norilsk';
        acc.BillingStreet = 'Lenina str';
        acc.Updated_By_Contact__c = false;
        insert acc;
        List<Contact> listCon = TestDataFactoryClass.CONTACT.createDummyListOfContact(3, 'Cont', acc.Id, false, false, false, false);
        for(Contact con : listCon){
            con.MailingCity = 'Erevan';
        }
        insert listCon;
    }
    
    @isTest
    static void makeTest(){
        
        Test.startTest();
        ChageContactFromAccountBatch job = new ChageContactFromAccountBatch();
        Id batchId = Database.executeBatch(job);
        Test.stopTest();

        System.assertEquals(3, [SELECT count() FROM contact WHERE MailingCity = 'Norilsk']);
        System.assertEquals(1, [SELECT count() FROM Account WHERE Updated_By_Contact__c = true]);
    }
}