// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals FramedApp */

FramedApp = SC.Object.create(
  /** @scope TestApp.prototype */ {

  NAMESPACE: 'FramedApp',
  VERSION: '0.1.0',

  store: SC.Store.create().from(SC.Record.fixtures)

}) ;