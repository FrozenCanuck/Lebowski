// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals Core */

sc_require('core');
sc_require('models/employee');

Core.Employee._nextGuid = 1;

Core.Employee.computeNextGuid = function() {
  var guid = this._nextGuid;
  this._nextGuid = this._nextGuid + 1;
  return guid;
};

Core.Employee.FIXTURES = [

  {
    guid: Core.Employee.computeNextGuid(),
    firstName: "Bob",
    lastName: "Izzo",
    title: "Architect",
    company: "Microsoft"
  },
  
  {
    guid: Core.Employee.computeNextGuid(),
    firstName: "Joe",
    lastName: "McDonnel",
    title: "Manager",
    company: "Google"
  },
  
  {
    guid: Core.Employee.computeNextGuid(),
    firstName: "Mike",
    lastName: "Smith",
    title: "Developer",
    company: "Apple"
  },
  
  {
    guid: Core.Employee.computeNextGuid(),
    firstName: "Susan",
    lastName: "Doe",
    title: "Senior VP",
    company: "Amazon.com"
  },
  
  {
    guid: Core.Employee.computeNextGuid(),
    firstName: "Fred",
    lastName: "Gupta",
    title: "Developer",
    company: "Google"
  },
  
  {
    guid: Core.Employee.computeNextGuid(),
    firstName: "Zoey",
    lastName: "Foxx",
    title: "Admin Assistant",
    company: "Microsoft"
  },
  
  {
    guid: Core.Employee.computeNextGuid(),
    firstName: "Lily",
    lastName: "Allen",
    title: "Senior Manager",
    company: "Intel"
  },
  
  {
    guid: Core.Employee.computeNextGuid(),
    firstName: "Trey",
    lastName: "Paul",
    title: "Sales VP",
    company: "Google"
  },
  
  {
    guid: Core.Employee.computeNextGuid(),
    firstName: "Jim",
    lastName: "Jones",
    title: "Director of Finance",
    company: "Verizon"
  },
  
  {
    guid: Core.Employee.computeNextGuid(),
    firstName: "Benny",
    lastName: "Hill",
    title: "CMO",
    company: "Amazon.com"
  },
  
  {
    guid: Core.Employee.computeNextGuid(),
    firstName: "Sean",
    lastName: "Caillat",
    title: "CEO",
    company: "Widgets Inc."
  },
  
  {
    guid: Core.Employee.computeNextGuid(),
    firstName: "Justin",
    lastName: "Holmes",
    title: "Intern",
    company: "Verizon"
  },
  
  {
    guid: Core.Employee.computeNextGuid(),
    firstName: "Norah",
    lastName: "Jackson",
    title: "Janitor",
    company: "Widgets Inc."
  },
  
  {
    guid: Core.Employee.computeNextGuid(),
    firstName: "Amy",
    lastName: "Grant",
    title: "PR Director",
    company: "Google"
  },
  
  {
    guid: Core.Employee.computeNextGuid(),
    firstName: "Raymond",
    lastName: "Stone",
    title: "Senior Sales Rep",
    company: "Intel"
  }

];