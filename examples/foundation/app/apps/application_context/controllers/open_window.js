// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.openWindowController = SC.Object.create({
  
  windowNameValue: '',
  
  windowTitleValue: '',
  
  openingWindow: NO,
  
  openWindow: function() {
    var that = this;
    var win = window.open('/basic', this.get('windowNameValue'), 'width=400,height=300,status=no');
    var title = this.get('windowTitleValue');
    this.set('openingWindow', YES);
    win.onload = function() {
      win.document.title = title;
      SC.run(function() { that.set('openingWindow', NO); });
    };
  }
  
});