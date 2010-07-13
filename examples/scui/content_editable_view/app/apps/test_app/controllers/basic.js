// ==========================================================================
// Project:   TestApp.basicController
// Copyright: ©2010 My Company, Inc.
// ==========================================================================
/*globals TestApp */

/** @class

  (Document Your Controller Here)

  @extends SC.ObjectController
*/
TestApp.basicContentEditorController = SC.ObjectController.create({

  contentBinding: 'TestApp.mainPage.contentEditor',
  
  imageSource: null,
  
  htmlSource: null,
  	
	reset: function() {
	  var content = this.get('content');
	  content.set('value', TestApp.DEFAULT_CONTENT_EDITABLE_VALUE);
	  content.set('selection', '');
	},
	
	insertImage: function() {
	  var src = this.get('imageSource');
	  
	  if (SC.empty(src)) return;
	  
	  var content = this.get('content');
	  
	  content.insertImage(src);
	  
	  this.set('imageSource', '');
	},
	
	insertHtml: function() {
	  var src = this.get('htmlSource');
	  
	  if (SC.empty(src)) return;
	  
	  var content = this.get('content');
	  
	  content.insertHTML(src, false);
	  
	  this.set('htmlSource', '');
	},
	
	enableSelectionAsHyperlink: function(key, value) {
	
	  var content = this.get('content');
	
	  if (value !== undefined) {
	    if (value === YES) {
	      content.createLink('http://google.com');
	    } else {
	      content.removeLink();
	    }
	  }
	  
	  if (!content) return NO;
    return !SC.empty(content.get('selectedHyperlink'));
	
	}.property('selectedHyperlink')

}) ;
