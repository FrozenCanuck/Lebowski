// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals HelloWorldApp */

HelloWorldApp.helloWorldController = SC.Object.create({

  caption: null,

  doHello: function() {
    this.set('caption', '_hello'.loc());
  },
  
  doWorld: function() {
    this.set('caption', '_world'.loc());
  }

}) ;
