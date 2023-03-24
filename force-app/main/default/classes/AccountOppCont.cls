public class AccountOppCont {

    public Boolean isShow2 { get; set; }

    public Boolean isShow { get; set; }

    public Account acc;
    public Contact con;
    public Opportunity opp;
    
    //Property Method - GetterSetter Mehtod
    public Account accProp{get;set;}
    public Contact conProp{get;set;}
    public Opportunity oppProp{get;set;}
    
    private string typeOption = ApexPages.CurrentPage().getParameters().get('type');
   
    //Constructor Method; Note: Constructor Name should be same as class name
    public AccountOppCont (){    //Default Constructor
        acc= new Account();
        con = new Contact();
        opp = new Opportunity();
        
        accProp = new Account();
        conProp = new Contact();
        oppProp = new Opportunity();
        
        if(typeOption=='Method1'){
            isShow = true;
            isShow2 = false;
        }
        else if(typeOption=='Method2'){
            isShow2 = true;
            isShow = false;
        }

    }
    public AccountOppCont (string accnt, integer i){//parameter constructor
    
    }
    
    //getter method is used for passing the values from Apex class to Visualforce page
    //Syntax: <AccessModifier> <ObjectName> get<VariableName>(){}
    public Account getA(){
        //acc= new Account();
        return acc;
   }
   
   public Contact getC(){
       //con = new Contact();
       return con;
   }

   public Opportunity getO(){
       //opp = new Opportunity();
       return opp;
   }    

    //for navigating from one page to another
    //Note: PageReference method can be replaced with void method for no return type - it will not retutn anything
    public pageReference p;
    public PageReference AccNext() {
        return page.Contact;
    }
    public PageReference ConNext() {
        return page.Oppty;
    }
    public PageReference OppNext(){
        return page.AccountOppReview;    
    }
    public PageReference Review(){
        p = new PageReference('/apex/AccountDetail');
        if(typeOption=='Method1'){
        insert acc;
        con.AccountId = acc.id;
        insert con;
        opp.AccountId=acc.id;
        insert opp;
        
        //Send Email
        SendEmail.send(con.Email);
        
        p.getParameters().put('id',acc.id);
        }
        
        if(typeOption=='Method2'){
        insert accProp;
        conProp.AccountId = acc.id;
        insert conProp;
        oppProp.AccountId=acc.id;
        insert oppProp;
        
        //Send Email
        SendEmail.send(conProp.Email);
        
        p.getParameters().put('id',acc.id);
        }
                
        return p; 
    }  
}