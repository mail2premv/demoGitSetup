@RestResource(UrlMapping='/v2/AccountService/*') // ClassLevel Annotation
global class AccountSpecificData{
    
    @HttpGet //Method Level Annotation
    global static List<Account> ShowingSpecificAccount(){
    
        RestRequest req=RestContext.Request; //Request Container
        RestResponse res = RestContext.Response;//Response Container
        List<Account> acc = [Select id, Name,AccountNumber, NumberofEmployees, Rating FROM Account WHERE ID=:req.params.get('accid')];
        return acc;
    }
    
    @HttpPost
    global static string CreateAccount(Account account){

        RestRequest req=RestContext.Request; //Request Container
        RestResponse res = RestContext.Response;//Response Container
        string response;
        try  {
        
        insert account;
        response ='success';
        }
        catch(Exception e) {
         response=e.getMessage();
        }
        return response;
    }

}

/*

Lightning weight process - for Mobile Application Json - Javascript 
Bulk Process go with xml
*/