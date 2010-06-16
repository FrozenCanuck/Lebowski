// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals BasicApp */

BasicApp.mainPage = SC.Page.design({

  mainPane: SC.MainPane.design({
    layout: { left: 0, right: 0, height: 100, centerY: 0 },
    childViews: 'label increment decrement reset'.w(),
    
    label: SC.LabelView.design({
      layerId: 'counter-label',
      layout: { left: 0, right: 0, height: 23, centerX: 0, top: 0 },
      valueBinding: SC.Binding.transform(function(value) {
        return "Counter: %@".fmt(value);
      }).oneWay('BasicApp.counterController.counter'),
      textAlign: SC.ALIGN_CENTER
    }),
    
    increment: SC.ButtonView.design({
      layerId: 'increment-button',
      layout: { width: 80, height: 23, centerY: 0, centerX: -45 },
      title: 'Inc',
      target: BasicApp.counterController,
      action: 'incrementCounter'
    }),
    
    decrement: SC.ButtonView.design({
      layerId: 'decrement-button',
      layout: { width: 80, height: 23, centerY: 0, centerX: 45 },
      title: 'Dec',
      target: BasicApp.counterController,
      action: 'decrementCounter'
    }),
    
    reset: SC.ButtonView.design({
      layerId: 'reset-button',
      layout: { width: 100, height: 23, bottom: 0, centerX: 0 },
      title: 'Reset',
      target: BasicApp.counterController,
      action: 'resetCounter'
    })
    
  })
  
});