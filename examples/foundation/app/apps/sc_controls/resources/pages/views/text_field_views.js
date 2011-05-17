// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.textFieldViewsPage = SC.Page.design({
  
  basicTextField: SC.outlet('mainView.basicTextField.textField'),
  
  hintedTextField: SC.outlet('mainView.hintedTextField.textField'),
  
  passwordTextField: SC.outlet('mainView.passwordTextField.textField'),
  
  textAreaTextField: SC.outlet('mainView.textAreaTextField.textField'),
  
  disabledTextField: SC.outlet('mainView.disabledTextField.textField'),
  
  typeKeyEvents: SC.outlet('mainView.typeKeyEvents.customTextField'),
  
  resetButton: SC.outlet('mainView.resetButton'),
  
  mainView: SC.View.design({
    layout: { top: 20, bottom: 0, left: 20, right: 20 },
    
    childViews: [
      'basicTextField',
      'hintedTextField',
      'passwordTextField',
      'textAreaTextField',
      'disabledTextField',
      'typeKeyEvents',
      'resetButton'
    ],
    
    resetButton: SC.ButtonView.design({
      layout: { top: 0, left: 270, height: 23, width: 80 },
      title: 'Reset',
      target: 'TestApp.textFieldControlsController',
      action: 'reset'
    }),
    
    basicTextField: SC.View.design({
      layout: { top: 0, left: 0, right: 0, height: 25 },
      childViews: 'label textField'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Basic Text Field:'
      }),
      
      textField: SC.TextFieldView.design({
        layerId: 'basic-text-field',
        layout: { left: 160, centerY: 0, width: 100, height: 23 }
      })
    }),
    
    hintedTextField: SC.View.design({
      layout: { top: 30, left: 0, right: 0, height: 25 },
      childViews: 'label textField'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Hinted Text Field:'
      }),
      
      textField: SC.TextFieldView.design({
        layerId: 'hinted-text-field',
        layout: { left: 160, centerY: 0, width: 100, height: 23 },
        hint: 'Hint'
      })
    }),
    
    passwordTextField: SC.View.design({
      layout: { top: 60, left: 0, right: 0, height: 25 },
      childViews: 'label textField'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Password Text Field:'
      }),
      
      textField: SC.TextFieldView.design({
        layerId: 'password-text-field',
        layout: { left: 160, centerY: 0, width: 100, height: 23 },
        isPassword: YES,
        value: '1234'
      })
    }),
    
    textAreaTextField: SC.View.design({
      layout: { top: 90, left: 0, right: 0, height: 50 },
      childViews: 'label textField'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, top: 0, width: 150, height: 20 },
        value: 'Text Area Text Field:'
      }),
      
      textField: SC.TextFieldView.design({
        layerId: 'text-area-text-field',
        layout: { left: 160, top: 0, width: 100, height: 50 },
        isTextArea: YES
      })
    }),
    
    disabledTextField: SC.View.design({
      layout: { top: 150, left: 0, right: 0, height: 25 },
      childViews: 'label textField'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Disabled Text Field:'
      }),
      
      textField: SC.TextFieldView.design({
        layerId: 'disabled-text-field',
        layout: { left: 160, centerY: 0, width: 100, height: 23 },
        isEnabled: false,
        value: 'disabled'
      })
    }),
    
    typeKeyEvents: SC.View.design({
      layout: { top: 180, left: 0, right: 0, height: 25 },
      childViews: 'label customTextField keysLabel'.w(),
      
      label: SC.LabelView.design({
        layout: { left: 0, centerY: 0, width: 150, height: 20 },
        value: 'Key Events:'
      }),
      
      customTextField: SC.TextFieldView.design({
        layerId: 'custom-text-field',
        layout: { left: 160, centerY: 0, width: 100, height: 25 },
        
        charCode: null,
        
        key: '',
        keyBinding: 'TestApp.textFieldControlsController.value',
        
        keyDown: function(evt) {
          
          this.set('charCode', null);
          
          if (!SC.none(SC.FUNCTION_KEYS[evt.keyCode])) {
            this.set('key', 'key down = %@'.fmt(SC.FUNCTION_KEYS[evt.keyCode]));
          } else if (!SC.none(SC.MODIFIER_KEYS[evt.keyCode])) {
            this.set('key', 'key down = %@'.fmt(SC.MODIFIER_KEYS[evt.keyCode]));
          } else if (evt.charCode > 0) {
            this.set('charCode', evt.charCode);
            this.set('key', 'key down = %@'.fmt(String.fromCharCode(evt.charCode)));
          }
          
          return sc_super();
        },
        
        keyUp: function(evt) {

          if (this.get('charCode') !== null) {
            this.set('key', 'key up = %@'.fmt(String.fromCharCode(this.get('charCode'))));
          } else if (!SC.none(SC.FUNCTION_KEYS[evt.keyCode])) {
            this.set('key', 'key up = %@'.fmt(SC.FUNCTION_KEYS[evt.keyCode]));
          } else if (!SC.none(SC.MODIFIER_KEYS[evt.keyCode])) {
            this.set('key', 'key up = %@'.fmt(SC.MODIFIER_KEYS[evt.keyCode]));
          }
          
          return sc_super();
        }
      }),
      
      keysLabel: SC.LabelView.design({
        layerId: 'key-event-label',
        backgroundColor: 'green',
        layout: { left: 270, centerY: 0, width: 200, height: 25 },
        valueBinding: SC.Binding.oneWay('TestApp.textFieldControlsController.value')
      })
      
    })
  })
  
});