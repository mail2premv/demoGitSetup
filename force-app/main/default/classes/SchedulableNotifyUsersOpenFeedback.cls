/* Schedulable class to be used for nagging functionality for users who have open feedback to complete
 * 
 * @author Daulton Sink - dsink@salesforce.com
 * v. 0.0.1
 */ 

global class SchedulableNotifyUsersOpenFeedback implements Schedulable {
	
    //execute just enqueues the batchable buisness logic is contained within that class.
    global void execute(System.SchedulableContext ctx){
        BatchableNotifyUsersOpenFeedback BUF = new BatchableNotifyUsersOpenFeedback();
       	Database.executeBatch(BUF);
    }

}