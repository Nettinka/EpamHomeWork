@isTest
public class AccountIntegrationWebServiceTest {
    static final String BASE_URI = 'https://epam-2cc-dev-ed.my.salesforce.com/services/apexrest/Accounts/';
    @isTest static void getTest(){
        Id recordId = createTestRecord('name', 'description');
        RestRequest req = new RestRequest();
        req.requestURI = BASE_URI + recordId;
        req.httpMethod = 'GET';
        RestContext.request = req;

        Test.startTest();
        Account resultAcc = AccountIntegrationWebService.getAccountById();
        Test.stopTest();

        System.assert(resultAcc!=null);
        System.assertEquals('name', resultAcc.Name);
    }

    @isTest static void postTest(){
        Account newAcc = new Account(Name = 'Test Account', Description = 'description');
        RestRequest req = new RestRequest();
        req.requestURI = BASE_URI;
        req.httpMethod = 'POST';       
        Blob jsonAccountString = Blob.valueOf(JSON.serialize(newAcc));
        req.requestBody = jsonAccountString;
        RestContext.request = req;

        Test.startTest();
        Id resultAcc = AccountIntegrationWebService.saveAccountRecord();
        Test.stopTest();

        System.assertEquals(1, [SELECT COUNT() FROM Account WHERE Name = 'Test Account'], 'Wrong count of created accounts');
    }

    @isTest static void deleteTest(){
        Id recordId = createTestRecord('Test', 'description acc');
        RestRequest req = new RestRequest();
        req.requestURI = BASE_URI + recordId;
        req.httpMethod = 'DELETE';
        RestContext.request = req;

        Test.startTest();
        String result = AccountIntegrationWebService.deleteAccountRecord();
        Test.stopTest();

        System.assert(result!=null);
        System.assertEquals('Delete is successful', result);
    }

    @isTest static void putTest(){
        Id recordId = createTestRecord('Test1', 'description acc');
        Account acc = [SELECT Id, Name, Description FROM Account Where Name = 'Test1'];
        acc.Description = 'Put desc';
        RestRequest req = new RestRequest();
        req.requestURI = BASE_URI + recordId;
        req.httpMethod = 'PUT';
        Blob jsonAccountString = Blob.valueOf(JSON.serialize(acc));
        req.requestBody = jsonAccountString;
        RestContext.request = req;

        Test.startTest();
        Account resultAcc = AccountIntegrationWebService.upsertAccountRecord();
        Test.stopTest();

        System.assert(resultAcc!=null);
        System.assertEquals('Put desc', resultAcc.Description);
        System.assertEquals('Test1', resultAcc.Name);
    }

    @isTest static void patchTest(){
        Id recordId = createTestRecord('Test', 'description acc');
        Account acc = [SELECT Id, Name, Description FROM Account Where Name = 'Test'];
        acc.Description = 'Patch desc';
        RestRequest req = new RestRequest();
        req.requestURI = BASE_URI + recordId;
        req.httpMethod = 'PATCH';
        Blob jsonAccountString = Blob.valueOf(JSON.serialize(acc));
        req.requestBody = jsonAccountString;
        RestContext.request = req;

        Test.startTest();
        Account resultAcc = AccountIntegrationWebService.updateAccountFields();
        Test.stopTest();

        System.assert(resultAcc!=null);
        System.assertEquals('Patch desc', resultAcc.Description);
        System.assertEquals('Test', resultAcc.Name);
    }

    static Id createTestRecord(String name, String description){
        Account acc = new Account(Name = name, Description = description);
        insert acc;
        return acc.id;
    }
}
