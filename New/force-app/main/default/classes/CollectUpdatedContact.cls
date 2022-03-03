public without sharing class CollectUpdatedContact {
    private List<Contact> contactsForIterate;
    private String status;
    
    public CollectUpdatedContact(List<Contact> contacts, String statusStr) {
        this.contactsForIterate = contacts;
        this.status = statusStr;
    }

    public List<Contact> collectContact(){
        List<Contact> contactsToUpdate = new List<Contact>();
        for(Contact con : contactsForIterate){
            con.Is_Synced__c = false;
            if(status.equals('Queue')){
                con.Processed_By_Queue__c = true;    
            } else if((status.equals('Future'))){
                con.Processed_By_Future__c = true;
            }
            contactsToUpdate.add(con);
        }
        return contactsToUpdate;
    }
}

//test ok