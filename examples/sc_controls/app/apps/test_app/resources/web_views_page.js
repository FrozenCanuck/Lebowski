// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.webViewsPage = SC.Page.design({
  
  mainView: SC.View.design({
    layout: { top: 20, bottom: 20, left: 20, right: 20 },
    childViews: 'firstWebView secondWebView counter'.w(),
    
    firstWebView: SC.View.design({
      layout: { width: 250, height: 150, left: 0, top: 0 },
      childViews: 'label webView'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, right: 0, top: 0, height: 25 },
        value: 'First Web View',
        textAlign: SC.ALIGN_CENTER,
        backgroundColor: 'green'
      }),
      
      webView: SC.WebView.design({
        layout: { left: 0, right: 0, bottom: 0, top: 30 },
        layerId: 'first-web-view',
        value: '/basic'        
      })
    }),
    
    secondWebView: SC.View.design({
      layout: { width: 250, height: 150, left: 260, top: 0 },
      childViews: 'label webView'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, right: 0, top: 0, height: 25 },
        value: 'Second Web View',
        textAlign: SC.ALIGN_CENTER,
        backgroundColor: 'green'
      }),
      
      webView: SC.WebView.design({
        layout: { left: 0, right: 0, bottom: 0, top: 30 },
        layerId: 'second-web-view',
        value: '/basic'        
      })
    }),
    
    counter: SC.View.design({
      layout: { left: 520, top: 0, right: 0, height: 150 },
      childViews: 'label incButton resetButton'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, right: 0, top: 0, height: 23 },
        valueBinding: SC.Binding.transform(function(value) {
          return "Counter: %@".fmt(value);
        }).oneWay('TestApp.webViewControlsController.counter'),
        textAlign: SC.ALIGN_CENTER
      }),
      
      incButton: SC.ButtonView.design({
        layout: { centerX: -55, width: 100, height: 23, top: 50 },
        title: "Increment",
        action: "incrementCounter",
        target: TestApp.webViewControlsController
      }),
      
      resetButton: SC.ButtonView.design({
        layout: { centerX: 55, width: 100, height: 23, top: 50 },
        title: "Reset",
        action: "resetCounter",
        target: TestApp.webViewControlsController
      })
    })

  })
  
});