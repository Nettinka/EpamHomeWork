@isTest
public class SetRequestTest {

    
    @isTest
    static void createReqTest(){
        String endPointBase = 'https://epam-2cc-dev-ed.my.salesforce.com/services/apexrest/Accounts/';
        String token = '12345';
        String accId = '54321';

        HttpRequest reqGet = new HttpRequest();
        HttpRequest reqPostId = new HttpRequest();

        reqPostId.setHeader('Authorization', 'Bearer ' + token);
        reqPostId.setHeader('Content-Type', 'application/json');
        reqPostId.setMethod('POST');
        reqPostId.setEndpoint(endPointBase + accId);
        reqGet.setHeader('Authorization', 'Bearer ' + token);
        reqGet.setHeader('Content-Type', 'application/json');
        reqGet.setMethod('GET');
        reqGet.setEndpoint(endPointBase);
        
        Test.startTest();
        SetRequest sr = new SetRequest('GET', token);
        HttpRequest testreq = sr.createReq();

        SetRequest sr2 = new SetRequest('POST', token, accId);
        HttpRequest testreqpost = sr2.createReq();
        Test.stopTest();

        System.assertEquals(reqGet.getEndpoint(), testreq.getEndpoint());
        System.assertEquals(reqGet.getMethod(), testreq.getMethod());

        System.assertEquals(reqPostId.getEndpoint(), testreqpost.getEndpoint());
        System.assertEquals(reqPostId.getMethod(), reqPostId.getMethod());
       
    }
}