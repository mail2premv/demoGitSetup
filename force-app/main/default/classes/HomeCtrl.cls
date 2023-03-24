public class HomeCtrl {

    public String option { get; set; }
    
    public List<SelectOption> opt{get;set;}
    
    public HomeCtrl(){
        opt = new List<SelectOption>();
        opt.add(new SelectOption('Method3','Methid3'));
        opt.add(new SelectOption('Method4','Methid4'));
    }

    public PageReference Proceed() {
        pageReference p = new PageReference('/apex/AccountOpp');
        p.getParameters().put('type',option);
        return p;
    }

}