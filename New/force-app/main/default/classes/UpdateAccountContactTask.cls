global class UpdateAccountContactTask implements Schedulable {
    global void execute(SchedulableContext ctx) {
        ChangeTasksBatch ctb = new ChangeTasksBatch();
        Id batch1Id = Database.executeBatch(ctb);

        ChageContactFromAccountBatch ccfab = new ChageContactFromAccountBatch();
        Id batch2Id = Database.executeBatch(ccfab);
    }
}

//test ok

/*
UpdateAccountContactTask reminder = new UpdateAccountContactTask();
String sch = '0 0,30 * * * *';
String jobID = System.schedule('Update Accounts Contacts Tasks', sch, reminder);
*/