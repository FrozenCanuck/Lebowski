// ==========================================================================
// Project:   TestApp - mainPage
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp */

TestApp.radioViewsPage = SC.Page.design({
  
  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    childViews: 'horizontalRadioView verticalRadioView mixedStateRadioView disabledRadioView'.w(),
    
    horizontalRadioView: SC.View.design({
      layout: { top: 0, left: 0, right: 0, height: 25 },
      childViews: 'label radio'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Horizontal Radio View:'
      }),
      
      radio: SC.RadioView.design({
        layerId: 'horizontal-radio',
        layout: { left: 160, centerY: 0, width: 200, height: 23 },
        items: 'square circle triangle'.w(),
        layoutDirection: SC.LAYOUT_HORIZONTAL
      })
    }),
    
    verticalRadioView: SC.View.design({
      layout: { top: 30, left: 0, right: 0, height: 60 },
      childViews: 'label radio'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, top: 0, width: 150, height: 20 },
        value: 'Vertical Radio View:'
      }),
      
      radio: SC.RadioView.design({
        layerId: 'vertical-radio',
        layout: { left: 160, centerY: 0, width: 100, height: 60 },
        items: 'cat dog pig'.w(),
        value: 'cat',
        layoutDirection: SC.LAYOUT_VERTICAL
      })
    }),
    
    mixedStateRadioView: SC.View.design({
      layout: { top: 100, left: 0, right: 0, height: 25 },
      childViews: 'label radio resetButton'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Mixed State Radio View:'
      }),
      
      radio: SC.RadioView.design({
        layerId: 'mixed-state-radio',
        layout: { left: 160, centerY: 0, width: 200, height: 23 },
        itemTitleKey: 'title',
        itemValueKey: 'value',
        items: [
          { title: 'cat', value: 1 },
          { title: 'dog', value: 2 },
          { title: 'pig', value: 3 }
        ],
        layoutDirection: SC.LAYOUT_HORIZONTAL,
        value: [1]
      }),
      
      resetButton: SC.ButtonView.design({
        layerId: 'reset-mixed-state-radio-button',
        layout: { left: 320, centerY: 0, width: 100, height: 23 },
        title: 'Reset',
        target: TestApp.radioControlsController,
        action: 'resetMixedRadioView'
      })
    }),
    
    disabledRadioView: SC.View.design({
      layout: { top: 130, left: 0, right: 0, height: 25 },
      childViews: 'label radio'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Disabled Radio View:'
      }),
      
      radio: SC.RadioView.design({
        layerId: 'disabled-radio',
        layout: { left: 160, centerY: 0, width: 200, height: 23 },
        items: 'square circle triangle'.w(),
        layoutDirection: SC.LAYOUT_HORIZONTAL,
        value: 'circle',
        isEnabled: false
      })
    })
  })
  
});