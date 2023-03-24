({
	doInit : function(cmp, event, helper) {
		var action = cmp.get("c.getCasesDB");//controller method; DB suffix for any databse related actions
        console.log('calling doInit');
    
        action.setCallback(this, function(response){ //anonymous call back function for the action, as all of this happens asynchronously 
          var state = response.getState(); //Once complete function will get back a response 
          if(cmp.isValid() && state === "SUCCESS"){
            console.log('getting cases');   
            cmp.set("v.cases", response.getReturnValue());
          }                
        });
        $A.enqueueAction(action);//kick all of this off the enqueuing the action
        
	}
})