// ==========================================================================
// Project:   TestApp - mainPage
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp SCUI */

TestApp.mainPage = SC.Page.design({

	mainPane: SC.MainPane.design({
		childViews: 'dateEmpty dateToday'.w(),

		dateEmpty: SCUI.DatePickerView.design({
			layout: { top: 50, left: 20, width: 150, height: 20 }
		}),
		
		dateToday: SCUI.DatePickerView.design({
			layout: { top: 50, left: 190, width: 150, height: 20 },
			date: SC.DateTime.create()
		}),

	})

});
