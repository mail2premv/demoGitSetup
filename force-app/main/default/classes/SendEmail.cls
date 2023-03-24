public class SendEmail {
    public static void send(string email){
        
        pageReference p = page.MyTestPage;
        Blob attBody = p.getContentAsPDF();
        Messaging.EmailFileAttachment efa = new  Messaging.EmailFileAttachment();
        efa.setFileName('Confirmation.PDF');
        efa.setBody(attBody);
        
        List<Messaging.EmailFileAttachment> lefa = new List<Messaging.EmailFileAttachment>();
        lefa.add(efa);      
        
        Messaging.SingleEmailMessage sem=new Messaging.SingleEmailMessage();
        
        sem.setSubject('Confirmation Status');
        sem.setPlainTextBody('Find the attached file below...');
        List<String> addresess=new List<String>();
        addresess.add(email);
        sem.setToAddresses(addresess);
        sem.setFileAttachments(lefa);
        
        List<Messaging.SingleEmailMessage> lsem=new List<Messaging.SingleEmailMessage>();
        lsem.add(sem);
        
        Messaging.sendEmail(lsem);       
    }
}