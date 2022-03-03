global without sharing class SetRequest {
    private String method;
    private String accId;
    private String token;
	private String endPointBase = 'https://epam-2cc-dev-ed.my.salesforce.com/services/apexrest/Accounts/';
    
    public SetRequest(String method, String token){
        this.method = method;
        this.token = token;
    }
    
    public SetRequest(String method, String token, String accId){
        this.method = method;
        this.accId = accId;
        this.token = token;
    }
    
    public HttpRequest createReq(){
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + token);
        req.setHeader('Content-Type', 'application/json');
        switch on method {
            when 'GET'  {req.setMethod('GET');}
            when 'POST' {req.setMethod('POST');}
            when 'PATCH' {req.setMethod('PATCH');}
            when 'PUT' {req.setMethod('PUT');}
            when 'DELETE' {req.setMethod('DELETE');}
        }
        
        if(accId != null){
            req.setEndpoint(endPointBase + accId);
        } else {
            req.setEndpoint(endPointBase);
        }
        return req;
    }
}

//test ok