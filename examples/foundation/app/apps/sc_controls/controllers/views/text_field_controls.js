// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp Core */

TestApp.textFieldControlsController = SC.Object.create({
  
  value: '',
  
  reset: function() {
    var page = TestApp.textFieldViewsPage;
    page.setPath('basicTextField.value', null);
    page.setPath('hintedTextField.value', null);
    page.setPath('passwordTextField.value', "1234");
    page.setPath('textAreaTextField.value', null);
    page.setPath('typeKeyEvents.value', null);
    this.set('value', "");
  }
  
});