@isTest
global class AccountHttpCalloutMock implements HttpCalloutMock{

    public static final String BODY = '{"Name" : "Foo", "Description" : "Test"}';
    global HttpResponse respond(HttpRequest req){
        HttpResponse resp = new HttpResponse();
        resp.setHeader('Content-Type', 'application/json');
        resp.setBody(BODY);
        resp.setStatusCode(200);

        return resp;
    }
}
