// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.buttonViewsPage = SC.Page.design({
  
  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    childViews: 'basicButton disabledButton'.w(),
    
    basicButton: SC.View.design({
      layout: { top: 0, left: 0, right: 0, height: 25 },
      childViews: 'label button clickCounterLabel resetButton'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 100, height: 20 },
        value: 'Basic Button:'
      }),
      
      button: SC.ButtonView.design({
        layerId: 'click-me-button',
        layout: { left: 110, centerY: 0, width: 100, height: 23 },
        title: 'Click Me',
        target: TestApp.buttonControlsController,
        action: 'incrementCounter'
      }),
      
      clickCounterLabel: SC.LabelView.design({
        layerId: 'click-counter-label',
        layout: { left: 220, centerY: 0, width: 100, height: 20 },
        value: 'clicks: 0',
        valueBinding: SC.Binding.transform(function(value) {
          if (SC.none(value)) {
            return 'clicks: 0';
          } else {
            return 'clicks: %@'.fmt(value);
          }
        }).from('TestApp.buttonControlsController.counter')
      }),
      
      resetButton: SC.ButtonView.design({
        layerId: 'reset-click-count-button',
        layout: { left: 330, centerY: 0, width: 100, height: 23 },
        title: 'Reset',
        target: TestApp.buttonControlsController,
        action: 'resetCounter'
      })
    }),
    
    disabledButton: SC.View.design({
      layout: { top: 30, left: 0, right: 0, height: 25 },
      childViews: 'label button'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 100, height: 20 },
        value: 'Disabled Button:'
      }),
      
      button: SC.ButtonView.design({
        layerId: 'disabled-button',
        layout: { left: 110, centerY: 0, width: 100, height: 23 },
        title: 'Disabled',
        isEnabled: false
      })
    })
  })
  
});