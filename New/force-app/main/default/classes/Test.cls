public with sharing class Test {
    public Test() {
        System.debug('test');
    }

    public Boolean boo(){
        Integer i = 0;
        Integer k = 6;
        
        return true;
    }
    /* 1. Create apex class that can be lunched from Flow or Process Builder (for Account).

2. Apex class should make next logic: When new Account is created, create new Task object with Subject “Negotiations with {Account.Name}”, link created Account with this Task.

3. If Account is updated and Account has more than 3 Tasks => assign all Tasks to one User (random active User)

4. Create example Flow or Process Builder to show Apex call.

5. Collect all code in remote git repository for review */
}
