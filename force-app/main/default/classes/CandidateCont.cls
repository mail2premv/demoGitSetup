public class CandidateCont {
    public Account acc;
    
    //getter method is used for passing values from apex class to visualforce page
    public Account getA()
    {
        acc=new Account();
        return acc;
    }
}