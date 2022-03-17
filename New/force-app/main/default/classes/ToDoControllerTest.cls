@isTest
class ToDoControllerTest {
    @TestSetup
    static void makeData(){
        List<Todo__c>tdList = new List<Todo__c>();
        for(Integer i = 0; i < 10; i++){
            Todo__c one = new Todo__c(Title__c = 't ' + String.valueOf(i),
            Description__c = 'new',
            Priority__c = 'Low',
            IsDone__c = false,
            Date_of_completion__c = Date.newInstance(2022, 15, 3));
            tdList.add(one);
        }
        insert tdList;
    }
    @isTest
    static void getTodoListTest(){
        
        Test.startTest();
        List<Todo__c> res = TodoController.getTodoList();
        Test.stopTest();

        System.assertEquals(10, res.size());
    }
}