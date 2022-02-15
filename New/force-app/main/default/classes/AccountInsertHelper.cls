global without sharing class AccountInsertHelper {
    public static void onInsertAccount(List<Account> newAcc){
        List<Id> changedAccId = new List<Id>();
        for(Account acc : newAcc){ 
                changedAccId.add(acc.Id);
        }
        CreateTaskForAccountAsync.createTask(changedAccId);
    }
}
