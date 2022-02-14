trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            AccountTriggerHandler.onInsertAccount(Trigger.new);
        }
        else if(trigger.isUpdate){
            AccountTriggerHandler.onUpdateAccount(Trigger.new, Trigger.oldMap);
        }
    }
}