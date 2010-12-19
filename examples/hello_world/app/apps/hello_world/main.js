// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals HelloWorldApp */

HelloWorldApp.main = function main() {

  HelloWorldApp.setPath('helloWorldController.caption', '_click a button'.loc());

  HelloWorldApp.getPath('mainPage.mainPane').append() ;

} ;

function main() { 
  HelloWorldApp.main();
}
