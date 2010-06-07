// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.mainPage = SC.Page.design({

  mainPane: SC.MainPane.design({
    childViews: 'customRenderedView'.w(),
    
    customRenderedView: TestApp.CustomRenderedView.design({
      layout: { centerX: 0, centerY: 0, width: 500, height: 300 }
    })
  })

});
