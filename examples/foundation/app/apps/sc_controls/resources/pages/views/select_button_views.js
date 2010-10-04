// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.selectButtonViewsPage = SC.Page.design({

	mainView: SC.View.design({
		childViews: 'basicButton withoutCheckbox'.w(),

		basicButton: SC.SelectButtonView.design({
			layout: { top: 50, left: 20, width:150 },
			layerId: 'basic-button',
			objects: ['One','Two', 'Three', 'Four', 'Five'],
			disableSort: YES
		}),
		
		withoutCheckbox: SC.SelectButtonView.design({
			layout: { top: 50, left: 200, width:150 },
			layerId: 'without-checkbox',
			objects: [ { name: 'One', val: 1, isEnabled: true }, { name: 'Two', val: 2, isEnabled: false }, 
				{ name: 'Three', val: 3, isEnabled: false }, { name: 'Four', val: 4, isEnabled: true }, { name: 'Five', val: 5, isEnabled: true } ],
			nameKey: 'name',
			valueKey: 'val',
			checkboxEnabled: NO,
			disableSort: YES
		})

	})
  
});