// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp Core*/

TestApp.main = function main() {

  TestApp.getPath('mainPage.mainPane').append() ;

  TestApp.configureControlsList();
  TestApp.configureEmployeeLists();

};

TestApp.configureControlsList = function() {
  var view = null,
      pane = null,
      i = 0;
  
  var controlsListRoot = SC.Object.create({
    treeItemIsExpanded: YES,
    treeItemChildren: []
  });
  
  var viewsItemRoot = SC.Object.create({ name: 'Views', treeItemChildren: [], treeItemIsExpanded: YES });
  var panesItemRoot = SC.Object.create({ name: 'Panes', treeItemChildren: [], treeItemIsExpanded: YES });

  controlsListRoot.treeItemChildren.pushObject(viewsItemRoot);
  controlsListRoot.treeItemChildren.pushObject(panesItemRoot);

  var views = [
    SC.Object.create({ name: 'SC.LabelView', page: 'labelViewsPage' }),
    SC.Object.create({ name: 'SC.ButtonView', page: 'buttonViewsPage' }), 
    SC.Object.create({ name: 'SC.ContainerView', page: 'containerViewsPage' }),
    SC.Object.create({ name: 'SC.TextFieldView', page: 'textFieldViewsPage' }), 
    SC.Object.create({ name: 'SC.CheckboxView', page: 'checkboxViewsPage' }), 
    SC.Object.create({ name: 'SC.RadioView', page: 'radioViewsPage' }), 
    SC.Object.create({ name: 'SC.SelectFieldView', page: 'selectFieldViewsPage' }), 
    SC.Object.create({ name: 'SC.SegmentedView', page: 'segmentedViewsPage' }), 
    SC.Object.create({ name: 'SC.DisclosureView', page: 'disclosureViewsPage' }), 
    SC.Object.create({ name: 'SC.ListView', page: 'listViewsPage' }),
    SC.Object.create({ name: 'SC.WebView', page: 'webViewsPage' })
  ];
  
  for (i = 0; i < views.length; i++) {
    viewsItemRoot.treeItemChildren.pushObject(views[i]);
  }
  
  var panes = [
    SC.Object.create({ name: 'SC.AlertPane', page: 'alertPanesPage' }),
    SC.Object.create({ name: 'SC.PanelPane', page: 'panelPanesPage' }),
    SC.Object.create({ name: 'SC.PickerPane', page: 'pickerPanesPage' }),
    SC.Object.create({ name: 'SC.SheetPane', page: 'sheetPanesPage' }),
    SC.Object.create({ name: 'SC.MenuPane', page: 'menuPanesPage' }),
    SC.Object.create({ name: 'SC.PalettePane', page: 'palettePanesPage' })
  ];
  
  for (i = 0; i < panes.length; i++) {
    panesItemRoot.treeItemChildren.pushObject(panes[i]);
  }

  TestApp.controlsListController.set('content', controlsListRoot);
};

TestApp.configureEmployeeLists = function() {
  var employees = TestApp.store.find(Core.Employee);
  var controller = TestApp.getPath('firstEmployeeListController');
  controller.set('content', employees.toArray());
  
  controller = TestApp.getPath('groupEmployeesController');
  controller.set('content', employees.toArray());
};

function main() { 
  TestApp.main(); 
  TestApp.isLoaded = YES;
}
