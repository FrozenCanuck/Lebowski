// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp = SC.Application.create(
  /** @scope TestApp.prototype */ {

  NAMESPACE: 'TestApp',
  VERSION: '0.1.0',

  store: SC.Store.create().from(SC.Record.fixtures),

  isLoaded: NO

}) ;

// Apply a patch to the SC.TextFieldView for SproutCore v1.0.1046.
// 
// Patch fixes a strange bug where the text field will not respond to any events 
// whenever the text field is a text area. If we defer the action of adding 
// event listeners to the end of the run loop then the text field will respond 
// to events. Some weird run loop issue.
if (typeof SC.TextFieldView.prototype.didAppendToDocument === "function") {  
  SC.TextFieldView.prototype.didAppendToDocument = function() {
    if(this.get('isTextArea')){
      this.invokeLast(function() {
        this.setFieldValue(this.get('fieldValue'));
        SC.Event.add(this.$input(), 'change', this, this._field_fieldValueDidChange) ;
        this._addTextAreaEvents();
      });
    }
  };
}
