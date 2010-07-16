// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.WebView = SC.View.extend(SC.Control, {
  
  classNames: 'frame-view',
  
  displayProperties: ['value'],
  
  render: function(context, firstTime) {
    var src = this.get('value');
    if (firstTime) {
      context.push('<iframe src="' + src + 
      '" style="position: absolute; width: 100%; height: 100%; border: 0px; margin: 0px; padding: 0p;"></iframe>');
    } else {
      var iframe = this.$('iframe');
      // clear out the previous src, to force a reload
      iframe.attr('src', 'javascript:;');
      iframe.attr('src', src);
    }
  }
  
});