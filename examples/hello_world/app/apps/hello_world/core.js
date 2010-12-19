// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals HelloWorldApp */

HelloWorldApp = SC.Application.create({

  NAMESPACE: 'HelloWorldApp',
  VERSION: '1.0.0',

  store: SC.Store.create().from(SC.Record.fixtures)

}) ;
