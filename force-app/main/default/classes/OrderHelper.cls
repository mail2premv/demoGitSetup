public without sharing class OrderHelper {
    /**
        * @name AfterUpdate
        * @description 
        * @param List<Order> newList
        * @param List<Order> oldList
        * @return void
    **/
    public static void AfterUpdate(List<Order> newList, List<Order> oldList){
        Set<Id> orderIds = new Set<Id>();
        for ( Integer i=0; i< newList.size(); i++ ){
            if ( newList[i].Status == Constants.ACTIVATED_ORDER_STATUS && oldList[i].Status == Constants.DRAFT_ORDER_STATUS ){
                orderIds.add(newList[i].Id);
            }
        }
        RollUpOrderItems(orderIds);
    }
    
    /**
        * @name RollUpOrderItems
        * @description Given a set of Activated Order ids, query the child Order Items and related Products to calculate Inventory levels
        * @param Set<Id> activatedOrderIds
        * @return void
    **/
    public static void RollUpOrderItems(Set<Id> activatedOrderIds){
        //ToDo: Declare a Map named "productMap" of Ids to Product2 records
        Map<Id, Product2> productMap = new Map<Id, Product2>(); 
        for(OrderItem orderLine : [SELECT Id, Product2Id, Product2.Quantity_Ordered__c, Quantity, Order.ActivatedDate
                                   FROM OrderItem WHERE OrderId IN : activatedOrderIds]){ 
                                  if(!productMap.containsKey(orderLine.Product2Id))
                                      productMap.put(orderLine.Product2Id, new Product2(Id =orderLine.Product2Id, Quantity_Ordered__c=0)); 
        }
        
        for(AggregateResult ag : [SELECT Sum(Quantity), Product2Id FROM OrderItem WHERE Product2Id IN : productMap.keySet() Group By Product2Id]){
            Id product2Id = (Id)ag.get('Product2Id');
            Product2 prod = productMap.get(product2Id);
            prod.Quantity_Ordered__c = (Decimal)ag.get('expr0');
            productMap.put(product2Id , prod);
        }
        
        /*for(OrderItem orderLine : [SELECT Id, Product2Id, Product2.Quantity_Ordered__c, Quantity, Order.ActivatedDate
                                   FROM OrderItem WHERE OrderId IN : activatedOrderIds]){ 
                                       if(orderLine.Order.ActivatedDate != null){ 
                                           if(!productMap.containsKey(orderLine.Product2Id)){ 
                                               Product2 prod = new Product2(); 
                                               prod.Id = orderLine.Product2Id; 
                                               Decimal prevQuantity = 0; 
                                               if(orderLine.Product2.Quantity_Ordered__c !=null) 
                                                   prevQuantity = orderLine.Product2.Quantity_Ordered__c; 
                                               prod.Quantity_Ordered__c = prevQuantity + orderLine.Quantity; 
                                               productMap.put( orderLine.Product2Id , prod); 
                                           }else{ 
                                               Product2 existingProd = productMap.get(orderLine.Product2Id); 
                                               existingProd.Quantity_Ordered__c = existingProd.Quantity_Ordered__c + orderLine.Quantity; 
                                               productMap.put(orderLine.Product2Id, existingProd); 
                                           } 
                                       }else if(orderLine.Order.ActivatedDate == null){ 
                                           if(!productMap.containsKey(orderLine.Product2Id)){ 
                                               Product2 prod = new Product2(); 
                                               prod.Id = orderLine.Product2Id; 
                                               Decimal prevQuantity = 0; 
                                               if(orderLine.Product2.Quantity_Ordered__c !=null) 
                                                   prevQuantity = orderLine.Product2.Quantity_Ordered__c; 
                                               prod.Quantity_Ordered__c = prevQuantity - orderLine.Quantity; 
                                               productMap.put( orderLine.Product2Id , prod); 
                                           }else{ 
                                               Product2 existingProd = productMap.get(orderLine.Product2Id); 
                                               existingProd.Quantity_Ordered__c = existingProd.Quantity_Ordered__c - orderLine.Quantity; 
                                               productMap.put(orderLine.Product2Id, existingProd); 
                                           } 
                                       } 
                                   } */
        try { 
            if(productMap.values() != null && productMap.values().size() > 0){ 
                update productMap.values(); 
            } 
        }catch ( Exception e ){ 
            System.debug('#### Exception Executed : '+e.getStackTraceString()); 
        } 
    }
    
}