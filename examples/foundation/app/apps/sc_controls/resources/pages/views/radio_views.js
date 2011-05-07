// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.radioViewsPage = SC.Page.design({
  
  horizontalRadioView: SC.outlet('mainView.horizontalRadioView.radio'),
  
  verticalRadioView: SC.outlet('mainView.verticalRadioView.radio'),
  
  mixedStateRadioView: SC.outlet('mainView.mixedStateRadioView.radio'),
  
  disabledRadioView: SC.outlet('mainView.disabledRadioView.radio'),
  
  resetButton: SC.outlet('mainView.resetButton'),
  
  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    childViews: 'horizontalRadioView verticalRadioView mixedStateRadioView disabledRadioView resetButton'.w(),
    
    resetButton: SC.ButtonView.design({
      layout: { top: 0, left: 400, height: 23, width: 80 },
      title: 'Reset',
      target: 'TestApp.radioControlsController',
      action: 'reset'
    }),
    
    horizontalRadioView: SC.View.design({
      layout: { top: 0, left: 0, right: 0, height: 25 },
      childViews: 'label radio'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Horizontal Radio View:'
      }),
      
      radio: SC.RadioView.design({
        layerId: 'horizontal-radio',
        layout: { left: 160, centerY: 0, width: 300, height: 23 },
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
      childViews: 'label radio'.w(),
      
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
        layout: { left: 160, centerY: 0, width: 300, height: 23 },
        items: 'square circle triangle'.w(),
        layoutDirection: SC.LAYOUT_HORIZONTAL,
        value: 'circle',
        isEnabled: false
      })
    })
  })
  
});