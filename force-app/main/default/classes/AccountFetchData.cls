@RestResource(UrlMapping='/v1/AccountService/*') // ClassLevel Annotation
global class AccountFetchData{
    
    @HttpGet //Method Level Annotation
    global static List<Account> ShowingAccount(){
        List<Account> acc = [Select Name,AccountNumber, NumberofEmployees, Rating FROM Account];
        return acc;
    }
    //One class can have only one notation
    
    
    @HttpDelete
    global static String DeleteAccount(){
        RestRequest req = RestContext.Request;// from Thrid Party
        RestResponse res =  RestContext.Response;// Response to third party
        List<Account> acc = [Select Name,AccountNumber, NumberofEmployees, Rating FROM Account WHERE id=:req.params.get('accid')];
        string response;
        try{
            delete acc;
            response ='Deleted Successfully';
        }
        
        catch(Exception e){
          response=e.getMessage();
        
        }
         return response;
    }
    
    @HttpPost
    global static String CreateAccount (String accountname, String accountrating){
    
        RestRequest req = RestContext.Request;// from Thrid Party
        RestResponse res =  RestContext.Response;// Response to third party
        Account a = new Account();
        a.name = accountname;
        a.rating = accountrating;
        String response;
        
        try{
            insert a;
            response='Success';
        }
        
        catch(Exception e){
            response=e.getMessage();
        }
        return response;
    }
    

}