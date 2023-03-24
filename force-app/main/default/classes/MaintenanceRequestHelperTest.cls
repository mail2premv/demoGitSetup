@isTest
private class MaintenanceRequestHelperTest {
	//bulk test scenario
    @isTest static void testBulkScenario(){
        List<Case> bulkCases = new List<Case>();
        List<Vehicle__c> bulkVehicle = new List<Vehicle__c>();
        List<Product2> bulkEquipment = new List<Product2>();
        List<Work_Part__c> bulkWorkPart = new List<Work_part__c>();
                      
        for(integer i=0; i<300; i++){
            bulkVehicle.add(new Vehicle__c(Name='Test Vehicle-'+i));
            bulkEquipment.add(new Product2(Name='Test Equipment-'+i, Replacement_Part__c = True, 
                                           Current_Inventory__c =(i*5)+100, Maintenance_Cycle__c=i*5, Lifespan_Months__c=i*10,
                                           Cost__c = i*100, Warehouse_SKU__c='9999'+i
                                          ));            
        }
        insert bulkVehicle;
        insert bulkEquipment;
        
        for(integer i=0; i<300; i++){
            bulkCases.add(new Case(Subject='Test Case -'+i, Type='Repair', Status='New', Origin='Web',
                                  Equipment__c=bulkEquipment[i].Id, Vehicle__c = bulkVehicle[i].Id,Date_Reported__c=Date.today(),
                                  Date_Due__c = Date.today()));
        }
        
        insert bulkCases;
        integer counter =0;
        for(Case tCase: bulkCases){
            if(counter/2==0){
                Work_Part__c workPart = new Work_Part__c(Maintenance_Request__c=tCase.Id, 
                                                         Equipment__c=bulkEquipment[counter].Id);
                bulkWorkPart.add(workPart);
            }
            counter++;
        }
        insert bulkWorkPart;
        
        // test the trigger
        for(Case tCase: bulkCases){
            tCase.Status ='Closed';
        }
        update bulkCases;
        
        // check it out
        System.assertEquals(300, [Select Id from Case where type='Routine Maintenance' and Status!='Closed' and Vehicle__c in :bulkVehicle].size());
        System.assertEquals(0, [Select Id from Case where type='Repair' and Status!='Closed' and Vehicle__c in :bulkVehicle].size());
    }
}