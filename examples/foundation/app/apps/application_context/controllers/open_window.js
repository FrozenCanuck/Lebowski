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
  
  openBasicAppWindow: function() {
    this._openAppInWindow('basic', 'width=400,height=300,status=no');
  },
  
  openFramedAppWindow: function() {
    this._openAppInWindow('frames', 'width=450,height=300,status=no');
  },
  
  _openAppInWindow: function(app, settings) {
    var that = this;
    var url = "http://localhost:4020/%@#%@".fmt(app, this.get('windowLocationAnchorValue'));
    var win = window.open(url, this.get('windowNameValue'), settings);
    window.currentWindow = win;
    var title = this.get('windowTitleValue');
    win.onload = function() {
      win.document.title = title;
    };
  }
  
});