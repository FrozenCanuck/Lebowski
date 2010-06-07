// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */


TestApp = SC.Application.create(
  /** @scope TestApp.prototype */ {

  NAMESPACE: 'TestApp',
  VERSION: '1.0.0',

  store: SC.Store.create().from(SC.Record.fixtures),
  
  isLoaded: NO  

}) ;
