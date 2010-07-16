// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.mainPage = SC.Page.design({
  
  mainPane: SC.MainPane.design({
    layout: { left: 0, right: 0, top: 0, bottom: 0, centerY: 0 },
    childViews: 'resetButton openWindow web1 web2 localControls'.w(),
    
    resetButton: SC.ButtonView.design({
      layerId: 'reset-button',
      layout: { left: 10, top: 10, width: 100, height: 24 },
      title: 'Reset',
      target: 'TestApp.mainController',
      action: 'reset'
    }),
    
    openWindow: SC.View.design({
      layerId: 'open-window',
      layout: { left: 10, width: 200, height: 100, centerY: 0 },
      childViews: 'openButton nameLabel nameTextField titleLabel titleTextField'.w(),
      
      openButton: SC.ButtonView.design({
        layout: { left: 0, right: 0, top: 0, height: 24 },
        title: 'Open Window',
        target: TestApp.openWindowController,
        action: 'openWindow',
        isEnabledBinding: SC.Binding.not().oneWay('TestApp.openWindowController.openingWindow')
      }),
      
      nameLabel: SC.LabelView.design({
        layout: { left: 0, width: 50, height: 24, top: 30 },
        value: 'Name:'
      }),
      
      nameTextField: SC.TextFieldView.design({
        layout: { left: 50, right: 0, height: 24, top: 30 },
        valueBinding: 'TestApp.openWindowController.windowNameValue'
      }),
      
      titleLabel: SC.LabelView.design({
        layout: { left: 0, width: 50, height: 24, top: 60 },
        value: 'Title:'
      }),
      
      titleTextField: SC.TextFieldView.design({
        layout: { left: 50, right: 0, height: 24, top: 60 },
        valueBinding: 'TestApp.openWindowController.windowTitleValue'
      })
    }),
    
    web1: SC.WebView.design({
      layerId: 'web-view1',
      layout: { left: 220, width: 200, height: 100, centerY: 0 },
      value: '/basic'
    }),
    
    web2: SC.WebView.design({
      layerId: 'web-view2',
      layout: { left: 430, width: 200, height: 100, centerY: 0 },
      value: '/basic'
    }),
    
    localControls: SC.View.design({
      layerId: 'local-controls',
      layout: { left: 640, width: 200, height: 100, centerY: 0 },
      childViews: 'button label textField'.w(),
      
      textField: SC.TextFieldView.design({
        layout: { left: 0, right: 85, height: 24, top: 0 },
        valueBinding: 'TestApp.localControlsController.value'
      }),
      
      button: SC.ButtonView.design({
        layout: { right: 0, width: 80, height: 24, top: 0 },
        title: 'Update',
        target: TestApp.localControlsController,
        action: 'update'
      }),
      
      label: SC.LabelView.design({
        layout: { right: 0, left: 0, height: 24, top: 30 },
        backgroundColor: 'green',
        valueBinding: 'TestApp.localControlsController.labelText'
      })
    })
  })
  
});