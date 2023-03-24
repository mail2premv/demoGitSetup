global class BatchableNotifyUsersOpenFeedback implements Database.Batchable<Id> {
    private List<Id> lstManagerIds;
    
    //Constructor is used to specify a user id list used in the case that the batchable is called when a new feedback__c record is created
     
   // global BatchableNotifyUsersOpenFeedback(List<Id> lstManagerIds){
  ////      this.lstManagerIds = lstMangerIds1;
  //  }
    
    //Constructor is used in the case that the batchable is called from a schedulable to 'nag' users with open feedback
    //global BatchableNotifyUsersOpenFeedback(){}
    
    //batch class uses an email template to send the emails so all that needs to be provided is User.Id
     //* start returns a list of user Ids with open feedback.
    global List<Id> start(Database.BatchableContext  ctx){
        if(this.lstManagerIds == null){
            List<Case> lstTermCases = [SELECT ContactId 
                                       //Termination_Worker__c 
                                       FROM Case ];
                                       //WHERE ClosedDate != null];
                                       //PP Termination_Worker__c != null];
                                       //AND CreatedDate > ];
            Set<Id> setContractorsBeingTermed = new Set<Id>();
            for(case c: lstTermCases){
                //PP setContractorsBeingTermed.add(c.Termination_Worker__c);
                setContractorsBeingTermed.add(c.Id);
            }
            System.debug('--Case Details---'+ setContractorsBeingTermed);
            List<Id> lstManagersToContact = new List<Id>();
            for(Contact con: [SELECT ReportsToId FROM Contact WHERE Id IN :setContractorsBeingTermed]){
                lstManagersToContact.add(con.ReportsToId);
            }
            System.debug('--Manager to contact Id---'+ lstManagersToContact);
            return lstManagersToContact;
        }else{
            System.debug('--Manager  Id---'+ this.lstManagerIds);
            return this.lstManagerIds;
        }
        
    }
    
    //Execute in this case creates a new email message for each userId in scope and then sends these messages   
    global void execute(Database.BatchableContext ctx, List<String> scope){
        EmailTemplate et = [SELECT Id, Subject FROM EmailTemplate WHERE DeveloperName = 'notify_hiring_manager_open_feedback'];
        List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
        System.debug('scope: ' + scope);
        // add seperate single email message to list for each user in queue the template will take care of the rest
        for(String idUserId: scope){System.debug('idUserId: ' + idUserId);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTargetObjectId(idUserId);
            mail.setTemplateId(et.Id);
            mail.setSaveAsActivity(false);
            allmsg.add(mail);
        }
        // try catch for sending the emails to users
        try {
    		List<Messaging.SendEmailResult> lstResult = Messaging.sendEmail(allmsg, false);
            System.debug('***Sent emails to users results are following***');
            System.debug(lstResult);
        } catch (Exception e) {
            System.debug('***While sending an email to users from the BatchableNotifyUsersOpenFeedback class an error occurred***');
            System.debug(e.getMessage());
        }
    }
    
    global void finish(Database.BatchableContext ctx){
        //finish method to email an owner to notify which hiring mangers have open feedback
        //would need to have a user who acts as owner
       /*String strOwnerName = Label.FeedbackTrackingOwnerName;
        User usrOwner = [SELECT Name, Email FROM User WHERE Name = :strOwnerName];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new List<String>{usrOwner.Email});
        mail.setSubject('Hiring managers with outstanding feedback');
        mail.setHtmlBody(
            '<messaging:htmlEmailBody >' +
    			'<p>' +
        			'Hello ' + usrOwner.Email + ':<br/>' +
        			'This is an automated email to inform you that several hiring managers have not input feedback for their' +
            		'recently released contractors. Below you can find the names of the contractors as well as their email addresses.' +
				'</p>' + 
            	'<ul>'+
					'<li>dummyData</li>' + //make a list of anchors with emails as the href and the content as User.Name - User.Eaill
				'</ul>' +
			    'Thank you, <br />' + 
    			'HR Team' +
			'</messaging:htmlEmailBody>'
        );
        mail.setSaveAsActivity(false);
        // try catch for sending the emails to owner
        try {
            List<Messaging.SendEmailResult> lstResult = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{mail}, false);
            System.debug('***Sent emails to owner results are following***');
            System.debug(lstResult);
        } catch (Exception e) {
            System.debug('***While sending an email to owner from the BatchableNotifyUsersOpenFeedback class an error occurred***');
            System.debug(e.getMessage());
        }*/
    }

}