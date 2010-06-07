// ==========================================================================
// Project:   TestApp - mainPage
// ==========================================================================
/*globals TestApp SCUI */

TestApp.mainPage = SC.Page.design({

  mainPane: SC.MainPane.design({
    childViews: 'initEmpty initHint initSet textArea objectsEmpty manyObjects'.w(),
    
	initEmpty: SCUI.ComboBoxView.design({
		layout: { top: 50, left: 20, width: 150 },
		objects: TestApp.objectsController.getFruitObjects(),
		valueKey: 'val',
		nameKey: 'name'
	}),
	
	initHint: SCUI.ComboBoxView.design({
		layout: { top: 50, left: 190, width: 150 },
		objects: TestApp.objectsController.getFruitObjects(),
		valueKey: 'val',
		nameKey: 'name',
		hint: 'Fruit'
	}),
	
	initSet: SCUI.ComboBoxView.design({
		layout: { top: 50, left: 360, width: 150 },
		objects: TestApp.objectsController.getFruitObjects(),
		valueKey: 'val',
		nameKey: 'name',
		disableSort: YES,
		value: 'strawberry'
	}),
	
	textArea: SCUI.ComboBoxView.design({
		layout: { top: 50, left: 530, width: 150 },
		objects: TestApp.objectsController.getFruitObjects(),
        valueKey: 'val',
		nameKey: 'name',
		isTextArea: YES
	}),
	
	objectsEmpty: SCUI.ComboBoxView.design({
		layout: { top: 50, left: 700, width: 150 }
	}),
	
	manyObjects: SCUI.ComboBoxView.design({
		layout: { top: 50, left: 870, width: 150 },
		objects: TestApp.objectsController.getAlphaObjects(),
		valueKey: 'value',
		nameKey: 'value'
	})

  })

});
