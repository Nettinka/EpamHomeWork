trigger CaseTrigger on Case (before insert, before update, before delete, after insert, after update, after delete) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            CaseTriggerHandler.onInsertCases(Trigger.new);
        }
        else if(trigger.isUpdate){
            CaseTriggerHandler.onUpdateCases(Trigger.new, Trigger.oldMap);
        }
    }
}

//test ok