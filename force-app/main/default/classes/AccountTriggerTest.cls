@isTest
public class AccountTriggerTest {
@isTest static void TestCreate200Records(){
        
        // Test Setup data
        // Create 200 new Accounts
        List<Account> accts = new List<Account>();
        for(Integer i=0; i < 200; i++) {
            Account acct = new Account(Name='Test Account ' + i, BillingState = 'CA');
            accts.add(acct);
        }
            Test.startTest();
           insert accts;
            Test.stopTest();
            List<Account> verifyAccts = [SELECT id FROM Account WHERE ShippingState = 'CA' ];
           System.assertEquals(200, verifyAccts.size());
            
    

        
}
}