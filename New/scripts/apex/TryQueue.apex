Map<Id,Account> mapAcc = new Map<Id,Account>([SELECT Id, Name FROM Account LIMIT 150]);
List<Id> idsAcc = new List<Id>(mapAcc.keySet());

UpdateContactWithouTrigQueueClass q = new UpdateContactWithouTrigQueueClass(mapAcc.values());
System.enqueueJob(q);