@isTest
public with sharing class AccountServiceTest {
    static final String TEST_BODY = '{"Name" : "Foo", "Description" : "Test"}';
    @isTest static void callGetTest(){
        StaticResourceCalloutMock mockCallout = new StaticResourceCalloutMock();
        mockCallout.setStaticResource('mockResource');
        mockCallout.setStatusCode(200);
        mockCallout.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mockCallout);
        
        Test.startTest();
        HTTPResponse res = AccountService.callGet('0017Q000006s7AcQAI');
        Test.stopTest();
            
        Account data = (Account)JSON.deserialize(res.getBody(), Account.class);

        System.assertNotEquals(null, res, 'Null response');
        System.assertEquals(200, res.getStatusCode());
        System.assertEquals('application/json', res.getHeader('Content-Type'));
        System.assertEquals('Burlington Textiles Corp of America', data.Name, 'Wrong Account returned');
    }
    @isTest static void callPostTest(){
        Test.setMock(HttpCalloutMock.class, new AccountHttpCalloutMock());
        Account acc = (Account)JSON.deserialize(TEST_BODY, Account.class);
        insert acc;
        
        Test.startTest();
        HTTPResponse res = AccountService.callPost(acc);
        Test.stopTest();
    
        System.assertNotEquals(null, res, 'Null response');
        System.assertEquals(res.getBody(), AccountHttpCalloutMock.BODY);
        System.assertEquals(200, res.getStatusCode());
        System.assertEquals('application/json', res.getHeader('Content-Type'));
    }

    @isTest static void callDeleteTest(){
        StaticResourceCalloutMock mockCallout = new StaticResourceCalloutMock();
        mockCallout.setStaticResource('mockResource');
        mockCallout.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mockCallout);
        
        Test.startTest();
        HTTPResponse res = AccountService.callDelete('0017Q000006s7AcQAI');
        Test.stopTest();
            
        Account data = (Account)JSON.deserialize(res.getBody(), Account.class);

        System.assertNotEquals(null, res, 'Null response');
        System.assertEquals(200, res.getStatusCode());
        System.assertEquals('application/json', res.getHeader('Content-Type'));
        System.assertEquals('Burlington Textiles Corp of America', data.Name, 'Wrong Account returned');
    }

    @isTest static void callPatchTest(){
        Account acc = (Account)JSON.deserialize(TEST_BODY, Account.class);
        insert acc;
        StaticResourceCalloutMock mockCallout = new StaticResourceCalloutMock();
        mockCallout.setStaticResource('mockResource');
        mockCallout.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mockCallout);
        
        Test.startTest();
        HTTPResponse res = AccountService.callPatch(acc);
        Test.stopTest();
            
        Account data = (Account)JSON.deserialize(res.getBody(), Account.class);

        System.assertNotEquals(null, res, 'Null response');
        System.assertEquals(200, res.getStatusCode());
        System.assertEquals('application/json', res.getHeader('Content-Type'));
        
    }

    @isTest static void callPutTest(){
        Account acc = (Account)JSON.deserialize(TEST_BODY, Account.class);
        insert acc;
        StaticResourceCalloutMock mockCallout = new StaticResourceCalloutMock();
        mockCallout.setStaticResource('mockResource');
        mockCallout.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mockCallout);
        
        Test.startTest();
        HTTPResponse res = AccountService.callPut(acc);
        Test.stopTest();
            
        Account data = (Account)JSON.deserialize(res.getBody(), Account.class);

        System.assertNotEquals(null, res, 'Null response');
        System.assertEquals(200, res.getStatusCode());
        System.assertEquals('application/json', res.getHeader('Content-Type'));
        
    }
}

//test ok