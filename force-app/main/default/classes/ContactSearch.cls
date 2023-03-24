public class ContactSearch {

    public static List<contact> searchForContacts( string lastname, string postalcode){
        List<Contact> con = [SELECT Name from Contact WHERE LastName=:lastname AND MailingPostalCode=: postalcode];
            return con;
        
    }
}