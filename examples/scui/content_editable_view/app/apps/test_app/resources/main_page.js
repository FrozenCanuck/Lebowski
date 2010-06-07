// ==========================================================================
// Project:   TestApp - mainPage
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp SCUI */

function getButton(controller, selection, title, left, top) {
	return SC.ButtonView.design({
		layout: { left: left, top: top, width: 90, height: 24 },
		title: title,
		buttonBehavior: SC.TOGGLE_BEHAVIOR,
		toggleOnValue: YES,
		toggleOffValue: NO,
		valueBinding: 'TestApp.' + controller + '*content.' + selection
    })
}

TestApp.mainPage = SC.Page.design({

	mainPane: SC.MainPane.design({
		childViews: 'basic boldBasic underlineBasic italicBasic resizable boldResizable underlineResizable italicResizable'.w(),

		basic: SCUI.ContentEditableView.design({
			layout: { top: 50, left: 20, width: 300, height: 125 },
			value: 'Basic content editable view'		
		}),

		resizable: SCUI.ContentEditableView.design({
			layout: { top: 50, left: 600, width: 300, height: 125 },
			value: 'A content editable view that grows or shrinks depending on the size of the content',
			hasFixedDimensions: NO,
			allowScrolling: NO
		}),

		boldBasic: getButton('basicController', 'selectionIsBold', 'Bold', 325, 50),

		underlineBasic: getButton('basicController', 'selectionIsUnderlined', 'Underline', 325, 75),
		
		italicBasic: getButton('basicController', 'selectionIsItalicized', 'Italic', 325, 100),
		
		boldResizable: getButton('resizableController', 'selectionIsBold', 'Bold', 905, 50),
	
		underlineResizable: getButton('resizableController', 'selectionIsUnderlined', 'Underline', 905, 75),
	
		italicResizable: getButton('resizableController', 'selectionIsItalicized', 'Italic', 905, 100)
		
	})
});
