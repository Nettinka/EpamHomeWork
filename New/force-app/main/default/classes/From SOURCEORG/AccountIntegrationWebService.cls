@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountIntegrationWebService {
	
    @HttpGet
    global static Account getAccountById() {
        RestRequest request = RestContext.request;
        
        String accId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/') + 1);
        List<Account> result =  [SELECT Id,Name,Phone,AccountNumber
                        FROM Account
                        WHERE Id = :accId];
        if(result.size() > 0){return result[0];}
        else{return null;}
    }
    
    @HttpPost
    global static String saveAccountRecord(){
        RestRequest req = RestContext.request;
        Blob jsonAccountString = req.requestBody;
        Account acc = (Account)JSON.deserialize(jsonAccountString.toString(), Account.class);
        acc.OrginalSource__c = 'External';
        acc.Id = null;
        try{
            insert acc;           
        } catch(Exception ex){
            return ex.getMessage();
        }
        return acc.Id;
    }
    
    @HttpDelete
    global static String deleteAccountRecord(){
    RestRequest request = RestContext.request;
        
        String accId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/') + 1);
        List<Account> accForDelete =  [SELECT Id
                        FROM Account
                        WHERE Id = :accId];
    	if (accForDelete.size() > 0) {
        	delete accForDelete;
        	return 'Delete is successful';
    	}    
    	return 'Account with such Id wasn\'t found';
    }
    
    @HttpPut
    global static Account upsertAccountRecord() {
        RestRequest request = RestContext.request;
        
        String accId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/') + 1);
        
        Blob jsonAccountString = request.requestBody;
        Account acc = (Account)JSON.deserialize(jsonAccountString.toString(), Account.class);
        Map<String, Object> obj = (Map<String, Object>)JSON.deserializeUntyped(jsonAccountString.toString());
        if(accId != null) {
            acc.Id = accId;
        }
        
        upsert acc;
        System.debug('Upsert succsess');
        return acc;
    }
    
    @HttpPatch
    global static Account updateAccountFields() {
        RestRequest request = RestContext.request;
        String accId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/') +1 );
        Blob jsonAccountString = request.requestBody;
        Account thisAcc = [SELECT Id FROM Account WHERE Id = :accId];
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(jsonAccountString.toString());
        System.debug(params.get(jsonAccountString.toString()));
        for(String fieldName : params.keySet()) { 
            System.debug(params.get(fieldName));
            if(fieldName.equals('Id_Accounts_on_Target_Org__c') || fieldName.equals('Id') || fieldName.equals('attributes')){
                continue;
            } else {
            	thisAcc.put(fieldName, params.get(fieldName));
            }
        }
        update thisAcc;
        return thisAcc;
    }    
}

//test ok