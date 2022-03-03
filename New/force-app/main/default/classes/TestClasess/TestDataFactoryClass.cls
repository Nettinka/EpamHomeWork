@isTest
public class TestDataFactoryClass {

public static TestAccountFactory ACCOUNT = new TestAccountFactory();
public static TestContactFactory CONTACT = new TestContactFactory();
public static TestUserFactory USER = new TestUserFactory();
public static TestCaseFactory CASES = new TestCaseFactory();

    public class TestAccountFactory{
        public Account createDummyAccount(String name, Boolean needInsert){
            Account acc = new Account(Name = name);
            if(needInsert) insert acc;
            return acc;
        }

        public List<Account> createDummyListOfAccounts(Integer count, String name, Boolean needInsert){
            List<Account> accList = new List<Account>();
            for(Integer i = 0; i < count; i++){                
                accList.add(createDummyAccount(name + ' ' + String.valueOf(i), needInsert));
            }
            if(needInsert) insert accList;
            return accList;
        }
    }
    public class TestContactFactory{
        public Contact createDummyContact(String LastName, String accId, Boolean isSynced, Boolean processedByFuture, Boolean processByQueueble, Boolean needInsert){
            Contact cont = new Contact();
            cont.LastName = LastName;
            cont.AccountId = accId;
            if(processedByFuture != null){cont.Is_Synced__c = isSynced;}
            if(processByQueueble != null){cont.Processed_By_Future__c = processedByFuture;}
            if(needInsert) insert cont;
            return cont;
        }

        public List<Contact> createDummyListOfContact(Integer count, String LastName, String accId, Boolean isSynced, Boolean processedByFuture, Boolean processByQueueble, Boolean needInsert){
            List<Contact> contList = new List<Contact>();
            for(Integer i = 0; i < count; i++){                
                contList.add(createDummyContact(LastName + ' ' + String.valueOf(i), accId, isSynced, processedByFuture, processByQueueble, needInsert));
            }
            if(needInsert) insert contList;
            return contList;
        }
    }

    public class TestUserFactory{
        public User createDummyUser(String lastname, String emails, String usernameUser, String aliasUser, Boolean needToInsert){
            Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        
     	    User usr = new User(LastName = lastname,
                           FirstName='First',
                           Alias = aliasUser,
                           Email = emails,
                           Username = usernameUser,
                           ProfileId = profileId.id,
                           TimeZoneSidKey = 'GMT',
                           LanguageLocaleKey = 'en_US',
                           EmailEncodingKey = 'UTF-8',
                           LocaleSidKey = 'en_US'
                           );
            if(needToInsert) insert usr;
            return usr;
        }

        public List<User> createDummyListOfUsers(Integer count, String lastname, Boolean needToInsert){
            List<User> userList = new List<User>();
            for(Integer i = 0; i < count; i++){
                User us = createDummyUser(lastname + String.valueOf(i), lastname + String.valueOf(i) + '@test.com', lastname + String.valueOf(i) + '@test.com',lastname + String.valueOf(i), needToInsert);
                userList.add(us);
            }
            if(needToInsert) insert userList;
            return userList;
        }
    }

    public class TestCaseFactory{
        public Case createDummyCase(String reason, Boolean needInsert){
            Case cs = new Case();
            cs.Reason = reason;
            return cs;

        }

        public List<Case> createDummyListOfCase(Integer count, String reason, Boolean needInsert){
            List<Case> listCs = new List<Case>();
            for(Integer i = 0; i <= count; i++){
                Case cs = createDummyCase(reason, needInsert);
                listCs.add(cs);
            }
            if(needInsert) insert listCs;
            return listCs;
        }
    }
}