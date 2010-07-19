// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.openWindowController = SC.Object.create({
  
  windowNameValue: '',
  
  windowTitleValue: '',
  
  windowLocationAnchorValue: '',
  
  openingWindow: NO,
  
  openWindow: function() {
    var that = this;
    var url = "http://localhost:4020/basic#%@".fmt(this.get('windowLocationAnchorValue'));
    var win = window.open(url, this.get('windowNameValue'), 'width=400,height=300,status=no');
    window.currentWindow = win;
    var title = this.get('windowTitleValue');
    win.onload = function() {
      win.document.title = title;
    };
  }
  
});