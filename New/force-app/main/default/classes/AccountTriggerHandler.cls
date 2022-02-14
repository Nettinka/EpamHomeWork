public with sharing class AccountTriggerHandler {
    public static void onInsertAccount(List<Account> accounts){
        AccountUpdateHelper.onInsertAccount(accounts);
    }

    public static void onUpdateAccount(List<Account> accounts, Map<Id, Account> oldAcc){
        List<Id> accId = new List<Id>();
        for(Account acc : accounts){
            accId.add(acc.Id);
        }
        AccountUpdateHelper.chageContacts(accounts, oldAcc);
        

    }
}