// ==========================================================================
// Project:   TestApp - mainPage
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp SCUI */

function getButton(selection, title, left, top) {
	return SC.ButtonView.design({
		layout: { left: left, top: top, width: 90, height: 24 },
		title: title,
		buttonBehavior: SC.TOGGLE_BEHAVIOR,
		toggleOnValue: YES,
		toggleOffValue: NO,
		valueBinding: 'TestApp.mainPage.contentEditor.%@'.fmt(selection)
  });
}

TestApp.mainPage = SC.Page.design({

	mainPane: SC.MainPane.design({
		childViews: 'reset contentEditor editorControls'.w(),

    reset: SC.ButtonView.design({
      layerId: 'reset-button',
      layout: { left: 20, top: 10, width: 90, height: 24 },
      title: 'Reset',
      action: 'reset',
      target: TestApp.basicContentEditorController
    }),

		contentEditor: SCUI.ContentEditableView.design({
		  layerId: 'basic-content-editor',
			layout: { top: 50, left: 20, width: 400, height: 300 },
			value: 'Basic <b>content</b> <i>editable</i> <b>view</b>',
			autoCommit: YES		
		}),
		
		editorControls: SC.View.design({
		  layout: { left: 425, top: 50, right: 10, bottom: 10 },
      childViews: 'stylingControls hyperlinkControls imageControls htmlControls'.w(),
		
		  stylingControls: SC.View.design({
        layerId: 'styling-controls',
        layout: { left: 0, top: 0, width: 100, height: 125 },
        childViews: 'bold underline italic'.w(),

        bold: getButton('selectionIsBold', 'Bold', 0, 0),

    		underline: getButton('selectionIsUnderlined', 'Underline', 0, 25),

    		italic: getButton('selectionIsItalicized', 'Italic', 0, 50)
      }),

      hyperlinkControls: SC.View.design({
        layerId: 'hyperlink-controls',
        layout: { left: 100, top: 0, width: 300, height: 100 },
        childViews: 'label enableHyperlink urlLabel urlText'.w(),

        label: SC.LabelView.design({
          layout: { left: 0, top: 0, right: 0, height: 24 },
          value: 'Hyperlink:',
          textAlign: SC.ALIGN_LEFT
        }),

        enableHyperlink: SC.CheckboxView.design({
          layout: { left: 10, right: 0, top: 25, height: 24 },
          title: 'Enable as hyperlink',
          valueBinding: 'TestApp.basicContentEditorController.enableSelectionAsHyperlink'
        }),

        urlLabel: SC.LabelView.design({
          layout: { left: 10, width: 30, top: 50, height: 24 },
          value: 'URL:'
        }),

        urlText: SC.TextFieldView.design({
          layout: { left: 40, top: 50, right: 0, height: 24 },
          valueBinding: 'TestApp.mainPage.contentEditor.hyperlinkValue',
          isEnabledBinding: SC.Binding.oneWay('TestApp.basicContentEditorController.enableSelectionAsHyperlink')
        })
      }),

      imageControls: SC.View.design({
        layerId: 'image-controls',
        layout: { left: 100, top: 100, width: 300, height: 100 },
        childViews: 'label srcLabel srcText insertImage'.w(),

        label: SC.LabelView.design({
          layout: { left: 0, top: 0, right: 0, height: 24 },
          value: 'Image:',
          textAlign: SC.ALIGN_LEFT
        }),

        srcLabel: SC.LabelView.design({
          layout: { left: 10, width: 30, top: 25, height: 24 },
          value: 'Src:'
        }),

        srcText: SC.TextFieldView.design({
          layout: { left: 40, right: 0, top: 25, height: 24 },
          valueBinding: 'TestApp.basicContentEditorController.imageSource'
        }),

        insertImage: SC.ButtonView.design({
          layout: { right: 0, width: 100, top: 55, height: 24 },
          title: 'Insert Image',
          action: 'insertImage',
          target: TestApp.basicContentEditorController
        })
      }),
      
      htmlControls: SC.View.design({
        layerId: 'html-group',
        layout: { left: 100, top: 200, width: 300, height: 100 },
        childViews: 'label srcText insertSrc'.w(),

        label: SC.LabelView.design({
          layout: { left: 0, right: 0, top: 0, height: 24 },
          value: 'Custom HTML:'
        }),
        
        srcText: SC.TextFieldView.design({
          layout: { left: 10, right: 0, top: 25, bottom: 30 },
          isTextArea: YES,
          valueBinding: 'TestApp.basicContentEditorController.htmlSource'
        }),
        
        insertSrc: SC.ButtonView.design({
          layout: { right: 0, width: 100, bottom: 0, height: 24 },
          title: 'Insert HTML',
          action: 'insertHtml',
          target: TestApp.basicContentEditorController
        })
      })
		})
		
	}),
	
	contentEditor: SC.outlet('mainPane.contentEditor')
	
});
