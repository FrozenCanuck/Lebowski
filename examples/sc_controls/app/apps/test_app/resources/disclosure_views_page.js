// ==========================================================================
// Project:   TestApp - mainPage
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp */

TestApp.disclosureViewsPage = SC.Page.design({
  
  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    childViews: 'basicDisclosure disabledDisclosure mixedStateDisclosure'.w(),
    
    basicDisclosure: SC.DisclosureView.design({
      layerId: 'basic-disclosure',
      layout: { left: 0, top: 0, width: 150, height: 25 },
      title: 'Disclosure',
      value: YES,
      backgroundColor: 'blue'
    }),
    
    disabledDisclosure: SC.DisclosureView.design({
      layerId: 'disabled-disclosure',
      layout: { left: 0, top: 30, width: 150, height: 25 },
      title: 'Disabled',
      backgroundColor: 'blue',
      isEnabled: false
    }),
    
    mixedStateDisclosure: SC.View.design({
      layout: { top: 60, left: 0, right: 0, height: 25 },
      childViews: 'disclosure resetButton'.w(),

      disclosure: SC.DisclosureView.design({
        layerId: 'mixed-state-disclosure',
        layout: { left: 0, top: 0, width: 150, height: 25 },
        title: 'Mixed State',
        backgroundColor: 'blue',
        value: [YES, NO]
      }),

      resetButton: SC.ButtonView.design({
        layerId: 'reset-mixed-state-disclosure-button',
        layout: { left: 160, centerY: 0, width: 100, height: 23 },
        title: 'Reset',
        target: TestApp.disclosureControlsController,
        action: 'resetMixedStateDisclosure'
      })
    })
  })
  
});