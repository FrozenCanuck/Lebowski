// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.checkboxViewsPage = SC.Page.design({
  
  basicCheckboxView: SC.outlet('mainView.basicCheckbox.checkbox'),
  
  disabledCheckboxView: SC.outlet('mainView.disabledCheckbox.checkbox'),
  
  mixedStateCheckboxView: SC.outlet('mainView.mixedStateCheckbox.checkbox'),
  
  resetButton: SC.outlet('mainView.resetButton'),
  
  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    childViews: 'basicCheckbox disabledCheckbox mixedStateCheckbox resetButton'.w(),
          
    resetButton: SC.ButtonView.design({
      layout: { top: 0, left: 110, width: 100, height: 23 },
      title: 'Reset',
      target: TestApp.checkboxControlsController,
      action: 'reset'
    }),
    
    basicCheckbox: SC.View.design({
      layout: { top: 0, left: 0, right: 0, height: 25 },
      childViews: 'checkbox'.w(),
      
      checkbox: SC.CheckboxView.design({
        layout: { left: 0, centerY: 0, width: 100, height: 23 },
        title: 'Checkbox'
      })
    }),
    
    disabledCheckbox: SC.View.design({
      layout: { top: 30, left: 0, right: 0, height: 25 },
      childViews: 'checkbox'.w(),
    
      checkbox: SC.CheckboxView.design({
        layout: { left: 0, centerY: 0, width: 100, height: 23 },
        title: 'Disabled',
        value: YES,
        isEnabled: NO
      })
    }),
    
    mixedStateCheckbox: SC.View.design({
      layout: { top: 60, left: 0, right: 0, height: 25 },
      childViews: 'checkbox'.w(),
    
      checkbox: SC.CheckboxView.design({
        layout: { left: 0, centerY: 0, width: 100, height: 23 },
        title: 'Mixed State',
        value: [YES, NO]
      })
    })
  })
  
});