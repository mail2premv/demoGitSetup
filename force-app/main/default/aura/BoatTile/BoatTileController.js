/*({
	onBoatClick : function(component, event, helper) {
		var BoatSelectEvent = component.getEvent('BoatSelect');
        var boat = component.get('v.boat');
        BoatSelectEvent.setParams({
            "boatId" : boat.Id
        });
        BoatSelectEvent.fire(); 
        
        //var BoatSelectedEvt = component.getEvent('boatselected');
        var BoatSelectedEvt = $A.get('e.c:BoatSelected');
        BoatSelectedEvt.setParams({
            "boat" : boat
        });        
        BoatSelectedEvt.fire();
	}
})*/
({
	onBoatClick : function(component, event, helper) {
        var boat = component.get('v.boat');
        //this is how you fire an application event
        var createEvent = $A.get("e.c:PlotMapMarker");
        createEvent.setParams({'sObjectId' : boat.id});
        createEvent.fire();
	}
})