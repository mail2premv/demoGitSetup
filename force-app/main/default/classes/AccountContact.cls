@RestResource(UrlMapping='/v4/AccountService/*') // ClassLevel Annotation
global class AccountContact{

    @HttpPost
    global static string CreateAccountContact(String AccountName, String AccountRating, String FirstName, String LastName){
        Account a = new Account();
        a.name=AccountName;
        a.rating= AccountRating;
        insert a;
        
        Contact c=new Contact();
        c.FirstName=FirstName;
        c.LastName=LastName;
        c.AccountId=a.id;
        insert c;
        return 'Success';
}

}