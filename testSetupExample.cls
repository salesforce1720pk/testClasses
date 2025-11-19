@isTest
public class accountTestClass {

    // Runs once before all test methods
    @testSetup
    static void setupData() {

        // Create Account
        Account acc = new Account(
            Name = 'Test Account'
        );
        insert acc;

        // Create Contact
        Contact con = new Contact(
            LastName = 'Test Contact',
            AccountId = acc.Id
        );
        insert con;

        // Create Case
        Case cs = new Case(
            Status = 'New',
            Origin = 'Email',
            AccountId = acc.Id
        );
        insert cs;
    }

    // First test method
    @isTest
    static void testAccountDescription() {

        // Re-query data created by @testSetup
        Account acc = [
            SELECT Id, Name FROM Account WHERE Name = 'Test Account' LIMIT 1
        ];

        System.assertEquals('Test Account', acc.Name);
    }

    // Second test method
    @isTest
    static void testContactExists() {

        Contact con = [
            SELECT Id, LastName FROM Contact WHERE LastName = 'Test Contact' LIMIT 1
        ];

        System.assertEquals('Test Contact', con.LastName);
    }

    // Third test method - ensures case exists
    @isTest
    static void testCaseExists() {

        Case cs = [
            SELECT Id, Status FROM Case WHERE Status = 'New' LIMIT 1
        ];

        System.assertEquals('New', cs.Status);
    }
}
