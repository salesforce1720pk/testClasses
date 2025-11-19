### Test Data Factory
``` apex
@isTest
public class TestDataFactory {

    // Create Account
    public static Account createAccount() {
        Account acc = new Account(
            Name = 'Test Account',
            Rating = 'Warm'
        );
        insert acc;
        return acc;
    }

    // Create Contact
    public static Contact createContact(Id accountId) {
        Contact con = new Contact(
            LastName = 'Test Contact',
            AccountId = accountId
        );
        insert con;
        return con;
    }

    // Create Case
    public static Case createCase(Id accountId) {
        Case cs = new Case(
            Status = 'New',
            Origin = 'Email',
            AccountId = accountId
        );
        insert cs;
        return cs;
    }
}

```

### Use in Test Class
```apex
@isTest
public class CaseTriggerTest {

    @isTest
    static void testCaseTriggerLogic() {

        // Create Account using factory
        Account acc = TestDataFactory.createAccount();

        // Create Case using factory
        Case cs = TestDataFactory.createCase(acc.Id);

        // Query updated Account
        Account acc2 = [
            SELECT Id, Description
            FROM Account
            WHERE Id = :acc.Id
        ];

        // Assert trigger behavior
        System.assertEquals(cs.CaseNumber, acc2.Description);
    }
}
```
