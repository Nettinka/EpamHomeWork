public without sharing class CaseTriggerHandler {
    public static void onInsertCases(List<Case> newCaseList) {
        List<Task> taskForInsert = new List<Task>();
        for(Case cs : newCaseList){
            if(cs.Reason == 'Feedback') {
                Task t = new Task(
                    Subject = 'You got a new feedback',
                    WhatId = cs.Id
                );
                taskForInsert.add(t);
            }
        }
        insert taskForInsert;
    }

    public static void onUpdateCases(List<Case> newCaseList, Map<Id, Case> oldCasesMap) {
        List<Task> taskForInsert = new List<Task>();
        for(Case cs : newCaseList){
            if(cs.Reason == 'Feedback' && oldCasesMap.get(cs.Id).Reason != 'Feedback'){
                Task t = new Task(
                    Subject = 'You got a new feedback',
                    WhatId = cs.Id
                );
                taskForInsert.add(t);
            }
        }
        insert taskForInsert;
    }
}