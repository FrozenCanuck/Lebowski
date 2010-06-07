// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals HelloWorldApp */

HelloWorldApp.mainPage = SC.Page.design({

  mainPane: SC.MainPane.design({
    childViews: 'groupView'.w(),
    
    groupView: SC.View.design({
      layerId: 'group',
      layout: { centerX: 0, centerY: 0, width: 250, height: 100 },
      childViews: 'label helloButton worldButton'.w(),
      
      label: SC.LabelView.design({
        layerId: 'label',
        layout: { top: 0, left: 0, right: 0, height: 25 },
        textAlign: SC.ALIGN_CENTER,
        tagName: 'h1',
        valueBinding: 'HelloWorldApp.helloWorldController.caption',
        backgroundColor: 'green'
      }),
      
      helloButton: SC.ButtonView.design({
        layerId: 'hello-button',
        layout: { bottom: 0, left: 0, height: 25, width: 100 },
        title: '_hello'.loc(),
        target: HelloWorldApp.helloWorldController,
        action: 'doHello'
      }),
      
      worldButton: SC.ButtonView.design({
        layerId: 'world-button',
        layout: { bottom: 0, right: 0, height: 25, width: 100 },
        title: '_world'.loc(),
        target: HelloWorldApp.helloWorldController,
        action: 'doWorld'
      })
      
    })
    
  })

});
