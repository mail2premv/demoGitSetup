({
    doInit: function (component, event, helper) {
        //event availability check
        var createRecordEvent = $A.get('e.force:createRecord');
        if(createRecordEvent){
            component.set('v.showNewButton', true);
        } else {
            component.set('v.showNewButton', false);
        }
    },
    onFormSubmit : function(component, event, helper){
        var boatTypeId = component.get("v.selectedType");
        console.log("Search button pressed " + boatTypeId);
        var formSubmit = component.getEvent("FormSubmit");
        formSubmit.setParams({"formData":
                            {"boatTypeId" : boatTypeId}
        });
        formSubmit.fire();
    },
     createBoat: function (component) 
     {
            console.log('inside controller');
            var createRecordEvent = $A.get('e.force:createRecord');
            if (createRecordEvent) 
            {
                    var typeName = component.find('typeSelect').get('v.value');
                    var typeMap = component.get('v.searchOptionToIdMap');
                    var typeId = null;
                    if (typeName && typeMap && typeMap[typeName]) 
                    {
                            typeId = typeMap[typeName];
                    }
                    createRecordEvent.setParams({
                        'entityApiName': 'Boat__c',
                        'defaultFieldValues': {
                            'BoatType__c': typeId
                        }
                    });
                    createRecordEvent.fire();
            }
       }
})