public with sharing class TodoController {
    @AuraEnabled(cacheable=true)
    public static List<Todo__c> getTodoList() {
        return [
            SELECT
                Id,
                Title__c,
                Description__c,
                Priority__c,
                IsDone__c,
                Date_of_completion__c,
                Category__c
            FROM Todo__c
            WITH SECURITY_ENFORCED
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Todo__c> findTodos(String searchKey) {
        String key = '%' + searchKey + '%';
        return [
            SELECT Id,
            Title__c,
            Description__c,
            Priority__c,
            IsDone__c,
            Date_of_completion__c,
            Category__c
            FROM Todo__c
            WHERE Title__c LIKE :key 
            WITH SECURITY_ENFORCED
            ORDER BY Title__c
            LIMIT 20
        ];
    }

    @AuraEnabled(cacheable=true)
    public static Todo__c getSingleTodo() {
        return [ SELECT
            Id,
            Title__c,
            Description__c,
            Priority__c,
            IsDone__c,
            Date_of_completion__c,
            Category__c
            FROM Todo__c
            WITH SECURITY_ENFORCED
            LIMIT 1
        ];
    }

    @AuraEnabled(cacheable=true)
    public static Todo__c getSingleTodoById(String idStr) {
        return [ SELECT
            Id,
            Title__c,
            Description__c,
            Priority__c,
            IsDone__c,
            Date_of_completion__c,
            Category__c
            FROM Todo__c WHERE Id =: idStr
            WITH SECURITY_ENFORCED
            LIMIT 1
        ];
    }

    @AuraEnabled
    public static void updateTodos(List<Todo__c> todoForUpdate) {
        if (!Schema.sObjectType.Contact.isUpdateable()) {
            throw new SecurityException(
                'Insufficient permissions to update TODOs'
            );
        }
        update todoForUpdate;
    }
}