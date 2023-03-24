({
    renderNewButton: function (component) {
            var action = component.get('c.getUITheme');
            action.setCallback(this, function (response) {
                if (response.getState() === 'SUCCESS') {
                    if (response.getReturnValue() == 'Theme4d' && $A.get('e.force:createRecord')) {
                        component.set('v.showNewButton', true);
                    }
                }
            });
            $A.enqueueAction(action);
        }
})