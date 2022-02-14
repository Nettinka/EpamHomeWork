public with sharing class CustomContactcInterable implements Iterable<Contact>{
    public Iterator<Contact> iterator(){
        List<Contact> cont = 
        [SELECT Id, Name, 
        Is_Synced__c 
        FROM Contact 
        WHERE Is_Synced__c = false]; 
        
        return new CustomContactcInterator(cont);
    }
}