public with sharing class OpenCasesApexController { //Orgs record sharing are enforced
    @AuraEnabled //Annotation for all server-side action used by lightning
    public static List<Case> getCasesDB(){ // Use static keyword. Non-static methods are not supported, and the method must be public or global access
        String [] caseFields = new String [] {'Id','OwnerId','Type','Status','Priority','IsClosed','Reason','Origin'};
        
        Map<String,Schema.SObjectField> caseMap = Schema.SObjectType.Case.fields.getMap();
        //for (String field : caseMap.keySet()){
        for (String field : caseFields){
            if(!caseMap.get(field).getDescribe().isAccessible()){
                System.debug('This field was not accessible: ' + caseMap.get(field));
                return null;
            }
        }
        
        return [SELECT Id FROM Case WHERE IsClosed=false];       	
               
    }
    
}