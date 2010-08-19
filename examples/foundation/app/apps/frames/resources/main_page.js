// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals FramedApp */

FramedApp.mainPage = SC.Page.design({

  mainPane: SC.MainPane.design({
    layout: { left: 0, right: 0, top: 0, buttom: 0 },
    childViews: 'group web1 web2'.w(),
    
    group: SC.View.design({
      layout: { width: 210, height: 100, left: 10, top: 10 },
      childViews: 'reset label textField update'.w(),
      
      reset: SC.ButtonView.design({
        layout: { right: 0, top: 0, height: 24, width: 100 },
        title: 'Reset',
        target: FramedApp.appController,
        action: 'reset'
      }),
      
      update: SC.ButtonView.design({
        layout: { left: 0, top: 0, height: 24, width: 100 },
        title: 'Update',
        target: FramedApp.appController,
        action: 'update'
      }),
      
      label: SC.LabelView.design({
        layout: { right: 0, top: 30, height: 24, width: 100 },
        backgroundColor: 'green',
        valueBinding: SC.Binding.oneWay('FramedApp.appController.labelValue')
      }),
      
      textField: SC.TextFieldView.design({
        layout: { left: 0, top: 30, height: 24, width: 100 },
        valueBinding: 'FramedApp.appController.textFieldValue'
      })
    }),
    
    web1: SC.WebView.design({
      layerId: 'web-view1',
      layout: { width: 200, height: 100, top: 110, left: 10 },
      value: '/basic'
    }),
    
    web2: SC.WebView.design({
      layerId: 'web-view2',
      layout: { width: 200, height: 100, top: 110, left: 220 },
      value: '/basic'
    })
    
  })
  
});