@isTest
public with sharing class WithoutTriggerTaskScedulerTest {
    @isTest static void doTest(){
        String CRON_EXP = '0 0 0 15 3 ? 2022';
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new WithoutTriggerTaskSceduler());
        Test.stopTest();
        List<AsyncApexJob> jobsScheduled = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob where JobType = 'ScheduledApex'];
    	System.assertEquals(1, jobsScheduled.size(), 'expecting one scheduled job');
        
        List<AsyncApexJob> jobsApexBatch = [select Id, ApexClassID, ApexClass.Name, Status, JobType from AsyncApexJob where JobType = 'BatchApex'];
    	System.assertEquals(2, jobsApexBatch.size(), 'expecting two apex batch job');
    }
}
