// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.selectButtonViewsPage = SC.Page.design({

  basicSelectButtonView: SC.outlet('mainView.basic'),
  
  advancedSelectButtonView: SC.outlet('mainView.advanced'),
  
  reset: SC.outlet('mainView.reset'),

	mainView: SC.View.design({
		childViews: 'basic advanced reset'.w(),

		basic: SC.SelectButtonView.design({
			layout: { top: 50, left: 20, width: 150 },
			objects: ['One','Two', 'Three', 'Four', 'Five'],
			disableSort: YES,
			value: 'One'
		}),
		
		advanced: SC.SelectButtonView.design({
			layout: { top: 50, left: 200, width: 150 },
			objects: [ 
			  { name: 'One', val: 1, isEnabled: true }, 
			  { name: 'Two', val: 2, isEnabled: false }, 
				{ name: 'Three', val: 3, isEnabled: false }, 
				{ name: 'Four', val: 4, isEnabled: true }, 
				{ name: 'Five', val: 5, isEnabled: true } 
			],
			nameKey: 'name',
			valueKey: 'val',
			checkboxEnabled: NO,
			disableSort: YES,
			value: 1
		}),
		
		reset: SC.ButtonView.design({
		  layout: { top: 50, left: 400, width: 80 },
		  title: 'Reset',
		  target: 'TestApp.selectButtonControlsController',
		  action: 'reset'
		})

	})
  
});