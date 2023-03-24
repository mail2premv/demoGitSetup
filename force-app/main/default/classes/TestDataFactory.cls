/**
 * @name TestDataFactory
 * @description Contains methods to construct and/or validate commonly used records
**/
public with sharing class TestDataFactory {

    /**
     * @name ConstructCollaborationGroup
     * @description
    **/
    //ToDo: Ensure this method returns a single Chatter CollaborationGroup
    //    whose Name starts with 'TEST' followed by the INVENTORY_ANNOUNCEMENTS constant
    //    and configured so anyone can join, see and post updates.
    //    
    public static CollaborationGroup ConstructCollaborationGroup(){
        CollaborationGroup ChatterGroup = new CollaborationGroup(
              Name = 'TEST'+Constants.INVENTORY_ANNOUNCEMENTS,  
              CollaborationType = 'Public',
              //CanHaveGuests = false,
              IsArchived = false,
              IsAutoArchiveDisabled = true
        );
        //insert ChatterGroup;
        return ChatterGroup;
    }

    /**
     * @name CreateProducts
     * @description Constructs a list of Product2 records for unit tests
    **/
    //ToDo: Ensure this method returns a list, of size cnt, of uniquely named Product2 records
    //  with all the required fields populated
    //  and IsActive = true
    //  an Initial Inventory set to 10
    //  and iterating through the product family picklist values throughout the list.
    //  
    public static List<Product2> ConstructProducts(Integer cnt){
        List<Product2> prodList = new List<Product2>();
        for(Integer I=0; I < cnt; I++){
            Product2 prod = new Product2();
            prod.Name = 'Snacks ' +I;
            prod.isActive = true;
            prod.Initial_Inventory__c = 10;
           /* For(Schema.PickListEntry PLE : Constants.PRODUCT_FAMILY){
                prod.Family = PLE.getValue();
            }*/
            if(i>= 4) {
                Prod.Family =  constants.PRODUCT_FAMILY[0].getValue();
                
            }
            else{
                prod.Family = constants.PRODUCT_FAMILY[i].getValue();
                }
                
            prodList.add(prod);
        }
       // insert prodList;
        return prodList;
    }

    /**
     * @name CreatePricebookEntries
     * @description Constructs a list of PricebookEntry records for unit tests
    **/
    //ToDo: Ensure this method returns a corresponding list of PricebookEntries records
    //  related to the provided Products
    //  with all the required fields populated
    //  and IsActive = true
    //  and belonging to the standard Pricebook
    public static List<PricebookEntry> ConstructPricebookEntries(List<Product2> prods){
        // Get standard price book ID.
        // This is available irrespective of the state of SeeAllData.
        Id pricebookId = Constants.STANDARD_PRICEBOOK_ID;//Test.getStandardPricebookId();
        
        List<PricebookEntry> PrcBkEntr = new List<PricebookEntry>();
        for (Integer i = 0; i<prods.size(); i++){
            PricebookEntry P = new PricebookEntry (Product2Id = prods[i].Id, UnitPrice = 2, IsActive = true, Pricebook2Id = pricebookId);
              PrcBkEntr.add(P);
            }
        //insert PrcBkEntr;
        return PrcBkEntr;
    }

    /**
     * @name CreateAccounts
     * @description Constructs a list of Account records for unit tests
    **/
    //ToDo: Ensure this method returns a list of size cnt of uniquely named Account records
    //  with all of the required fields populated.
   
    public static List<Account> ConstructAccounts(Integer cnt){
        //Creating BULK account Records
        List<Account> accts = new List<Account>();
        for (Integer i=0;I<cnt;i++){
            Account a = new Account(Name='TestAccount'+i);
            System.debug('InsertedAccounts######'+a.Name);
            accts.add(a);
        }
       // insert accts;
        return accts;    
    } 

    /**
     * @name CreateContacts
     * @description Constructs a list of Contacxt records for unit tests
    **/
    //ToDo: Ensure this method returns a list, of size cnt, of uniquely named Contact records
    //  related to the provided Accounts
    //  with all of the required fields populated.
    public static List<Contact> ConstructContacts(Integer cnt, List<Account> accts){
        List<Contact> Con = new List<Contact>();
        for(Integer i=0; i<cnt; i++){
            Contact C = new Contact(LastName = 'LastName'+i, AccountId = accts[i].id);
            System.debug('InsertedContacts######'+c.LastName);
            Con.add(c);
        }
       // insert con;
        return Con;
    }

    /**
     * @name CreateOrders
     * @description Constructs a list of Order records for unit tests
    **/
    //ToDo: Ensure this method returns a list of size cnt of uniquely named Order records
    //  related to the provided Accounts
    //  with all of the required fields populated.
    public static List<Order> ConstructOrders(Integer cnt, List<Account> accts){
           List<Order> Ord = new List<Order>();
        for(Integer i=0; i<cnt; i++){
            Order O = new Order(Name = 'Order ' + (i + 1),AccountId = accts[i].id, EffectiveDate = Date.today(), status = 'Draft',Pricebook2Id = Constants.STANDARD_PRICEBOOK_ID);
            System.debug('InsertedOrders######'+O.Id);
            Ord.add(o);
        }
        return Ord;
    } 
    

    /**
     * @name CreateOrderItems
     * @description Constructs a list of OrderItem records for unit tests
    **/
    //ToDo: Ensure this method returns a list of size cnt of OrderItem records
    //  related to the provided Pricebook Entries
    //  and related to the provided Orders
    //  with all of the required fields populated.
    //  Hint: Use the DEFAULT_ROWS constant for Quantity as it will be used in the next challenge
    public static List<OrderItem> ConstructOrderItems(integer cnt, list<pricebookentry> pbes, list<order> ords){
         List<OrderItem> OrdrItm = new List<OrderItem>();
        for (Integer i = 0; i< cnt; i++){
            OrderItem Ord = new OrderItem (OrderId = ords[i].Id,  PricebookEntryId = pbes[i].id, Quantity = Constants.DEFAULT_ROWS,UnitPrice = 1);
            OrdrItm.add(Ord);
        }
        //Insert OrdrItm;
        return OrdrItm;
    }

    /**
     * @name SetupTestData
     * @description Inserts accounts, contacts, Products, PricebookEntries, Orders, and OrderItems.
    **/
    //ToDo: Ensure this method calls each of the construct methods
    //  and inserts the results for use as test data.
    //  
    //public static void InsertTestData(Integer cnt){
         public static Map<String, List<Object>> InsertTestData(Integer cnt){   
        insert constructCollaborationGroup();
        
        List<Product2> prodList = ConstructProducts(cnt);
        insert prodList ;
        
        List<PriceBookEntry> pbeEntry = ConstructPricebookEntries(prodList);
        insert pbeEntry ;
        
        List<Account> accountList = ConstructAccounts(cnt);
        insert accountList;
        
        List<Contact> contactList = ConstructContacts(cnt, accountList);
        insert contactList ;

       	List<Order> order = ConstructOrders(cnt, accountList);
        insert order ;
		
          List<OrderItem> itemList = ConstructOrderItems(cnt, pbeEntry , order);
        insert itemList ;
             
       Map<String, List<Object>> returnMap = new Map<String, List<Object>>();
        returnMap.put('accounts', accountList);
        returnMap.put('contacts', contactList);
        returnMap.put('products', prodList );
        returnMap.put('pricebookentries', pbeEntry);
        returnMap.put('orders', order);
        returnMap.put('orderitems', itemList);
        
        return returnMap;
    }
    public static void VerifyQuantityOrdered(Product2 originalProduct, Product2 updatedProduct, Integer qtyOrdered){
        System.assertEquals(
            originalProduct.Quantity_Ordered__c + qtyOrdered,
            updatedProduct.Quantity_Ordered__c,
            'error on Quantity_Ordered__c update'
            );
        
    }

}