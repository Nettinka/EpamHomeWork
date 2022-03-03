public class AccountService {
    
    private static String getAuthToken() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        
        RestServiceSettings__c restServ = RestServiceSettings__c.getOrgDefaults();
        String consumerKey = restServ.client_id__c;
        String consumerSecret = restServ.client_secret__c;
        req.setMethod('POST');
        
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token'
            +'?grant_type=password'
            +'&client_id='+ '3MVG9t0sl2P.pByr.Tl7ZFYytR6M8kcMpKiGzk_6Axu0DPHsy244z8NnBx4rwywUdQ7ToXEA5bH0YF.8dKTQf' 
            +'&client_secret='+consumerSecret
            +'&username='+restServ.username__c
            +'&password='+restServ.password__c + 'YyaUvXq8CUuCxCQgfJMwUXZOy');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                
        HTTPResponse resp = http.send(req);
        
        ResponceWraper data = (ResponceWraper)JSON.deserialize(resp.getBody(), ResponceWraper.class);

        return data.access_token;       
    }
    
    public static HttpResponse callGet(String accId){
        Http http = new Http();
             
        RestServiceSettings__c restServ = RestServiceSettings__c.getOrgDefaults();
        String token = getAuthToken();
        
        SetRequest setReq = new SetRequest('GET', token, accId);
        HttpRequest req = setReq.createReq(); 
                
        System.debug('Calling get account service');
        
        HTTPResponse res = http.send(req);
        System.debug('status ' + res.getStatus());  
        Account resAcc = (Account)JSON.deserialize(res.getBody(), Account.class);
        System.debug(resAcc.Name);
        return res;
    }
    
    public static HttpResponse callPost(Account accSource){
                      
        RestServiceSettings__c restServ = RestServiceSettings__c.getOrgDefaults();
        String token = getAuthToken();
        
        Account acc = [Select Id, Name, Phone, AccountNumber, Rating, Industry From Account Where Id =: accSource.id]; 
        Http http = new Http();       
        String JSONString = JSON.serialize(acc);
        
        SetRequest setReq = new SetRequest('POST', token);
        HttpRequest req = setReq.createReq();        
        req.setBody(JSONString);
        
        System.debug('Calling post account service');
        
        HTTPResponse res = http.send(req);
        //String targetId = (String)JSON.deserializeUntyped(res.getBody());
        Map<String, Object> resMap = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
        acc.Id_Accounts_on_Target_Org__c = (String)resMap.get('Id');
        update acc;  
        return res;            
    }
    
    public static HttpResponse callDelete(String accId){
            
        RestServiceSettings__c restServ = RestServiceSettings__c.getOrgDefaults();
        String token = getAuthToken();

        Http http = new Http();
        SetRequest setReq = new SetRequest('DELETE', token, accId);
        HttpRequest req = setReq.createReq();
            
        System.debug('Calling delete account service');
        
        HTTPResponse res = http.send(req);
        System.debug('status ' + res.getStatus());         
        System.debug('status ' + res.getBody());
        return res; 
    }
    
    public static HttpResponse callPut(Account accSource){
                      
        RestServiceSettings__c restServ = RestServiceSettings__c.getOrgDefaults();
        String token = getAuthToken();
        
        Account acc = [Select Id, Name, Phone, AccountNumber, Rating, Industry, Id_Accounts_on_Target_Org__c From Account Where Id =: accSource.id];
        
        Http http = new Http();        
        String JSONString = JSON.serialize(acc);
        SetRequest setReq = new SetRequest('PUT', token);
        HttpRequest req = setReq.createReq();        
        req.setBody(JSONString);
        
        System.debug('Calling Put account service');
        
        HTTPResponse res = http.send(req);
        
        Map<String, Object> resMap = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
        
        if(acc.Id_Accounts_on_Target_Org__c != (String)resMap.get('Id')){ 
            acc.Id_Accounts_on_Target_Org__c = (String)resMap.get('Id');
        	update acc;
        }
        System.debug(res.getBody());
        return res; 
    }
    
    public static HttpResponse callPatch(Account accSource){
                      
        RestServiceSettings__c restServ = RestServiceSettings__c.getOrgDefaults();
        String token = getAuthToken();
        
        Account acc = [Select Id, Name, Phone, AccountNumber, Rating, Industry, Id_Accounts_on_Target_Org__c From Account Where Id =: accSource.id];
        
        Http http = new Http();
        
        String JSONString = JSON.serialize(acc);
        SetRequest setReq = new SetRequest('PATCH', token, acc.Id_Accounts_on_Target_Org__c);
        HttpRequest req = setReq.createReq();              
        req.setBody(JSONString);
               
        System.debug('Calling Patch account service');
        
        HTTPResponse res = http.send(req);
        System.debug('Status ' + res.getStatus());
        System.debug('Body ' + res.getBody());
        return res; 
    }
    
    
    public class ResponceWraper {
        public String access_token {get;set;}
        public String id {get;set;}
        public String token_type {get;set;}
    }

}