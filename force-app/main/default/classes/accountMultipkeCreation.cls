@RestResource(UrlMapping='/v5/AccountService/*') // ClassLevel Annotation
global class accountMultipkeCreation{

@HttpPost
global static string CreateAccount(List<Account> a){
         string response;
         try{
             insert a;
             response='SUCCESS';
         }
         catch(Exception e){
          response =e.getMessage();
         
         }
 
return response;
}
/*
global calss AccountWrapper{
    public List<Account> accList;
    public string statusCode;
        public string statusMsg;

}*/
}