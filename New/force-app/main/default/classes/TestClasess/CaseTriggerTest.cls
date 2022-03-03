@isTest
public class CaseTriggerTest {
    @isTest
    static void onInsertTest() {
        List<Case> listCase = TestDataFactoryClass.CASES.createDummyListOfCase(1, 'Feedback', false);
        
        Test.startTest();
        insert listCase;
        Test.stopTest();

        List<Task> tasks = [SELECT Id, Subject, WhatId FROM Task];
        System.assertEquals('You got a new feedback', tasks[0].Subject);
        System.assertEquals(listCase[0].id, tasks[0].WhatId);
    }

    @isTest
    static void onUpdateTest() {
        List<Case> listCase = TestDataFactoryClass.CASES.createDummyListOfCase(1, 'Breakdown', false);
        insert listCase;
        Map<Id,Case> oldMap = new Map<Id,Case>(listCase);
        List<Task> oldTask = [SELECT Id, Subject, WhatId FROM Task];

        listCase[0].Reason = 'Feedback';

        Test.startTest();
        update listCase;
        Test.stopTest();

        List<Task> tlist = [SELECT Id, Subject, WhatId FROM Task];

        System.assertNotEquals(oldTask.size(), tlist.size());
        System.assertEquals('You got a new feedback', tlist[0].Subject);
    }
}