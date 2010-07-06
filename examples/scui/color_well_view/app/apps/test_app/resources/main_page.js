// ==========================================================================
// Project:   TestApp - mainPage
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp SCUI */

TestApp.mainPage = SC.Page.design({

  mainPane: SC.MainPane.design({
    childViews: 'colorView'.w(),

	colorView: SCUI.ColorWell.design({
      layout: { left: 5, top: 50, width: 80, height: 22 },
      classnames: ['color-well']
    })	
  })

});
