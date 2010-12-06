// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp Core */

TestApp.segmentedViewsController = SC.Object.create({
  
  reset: function() {
    var page = TestApp.segmentedViewsPage, view;
    
    page.get('basic1SegmentedView').set('value', null);
    page.get('basic2SegmentedView').set('value', null);
    page.get('allowEmptySelectionSegmentedView').set('value', null);
    page.get('allowMultipleSelectionSegmentedView').set('value', 'cat');
    page.get('allowEmptyMultipleSelectionSegmentedView').set('value', 'cat');
  }
  
});