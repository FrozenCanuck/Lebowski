// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals BasicApp */

BasicApp = SC.Application.create(
  /** @scope TestApp.prototype */ {

  NAMESPACE: 'BasicApp',
  VERSION: '0.1.0',

  store: SC.Store.create().from(SC.Record.fixtures),

  isLoaded: NO

}) ;