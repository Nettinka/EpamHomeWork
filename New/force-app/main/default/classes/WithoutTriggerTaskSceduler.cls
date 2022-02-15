global without sharing class WithoutTriggerTaskSceduler implements Schedulable {
    global void execute(SchedulableContext ctx) {
        UpdateContactMailingAdressIterableBatch iterBat = new UpdateContactMailingAdressIterableBatch();
        Id batch1Id = Database.executeBatch(iterBat);

        UpdateContactMailingAdressBatch queLocBat = new UpdateContactMailingAdressBatch();
        Id batch2Id = Database.executeBatch(queLocBat);
    }
}

/*
WithoutTriggerTaskSceduler reminder = new WithoutTriggerTaskSceduler();
String sch = '0 0,30 * * * *';
String jobID = System.schedule('Update Accounts Contacts Tasks', sch, reminder);
*/