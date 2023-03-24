public class AccountHandler {
    
    public static account insertNewAccount(string name){
        Account a = new Account();
        a.Name = name;
        
        try{          
            insert a;
            
        }
        catch(DmlException e){
            System.debug('Error Message: '+ e.getMessage());
            return null;
        }
        return a;
    }
}