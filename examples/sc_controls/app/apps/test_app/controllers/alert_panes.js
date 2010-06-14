// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.alertPanesController = SC.ObjectController.create({
  
  status: '--',
  
  showAlertWarn: function() {
    this.alertTitle = "Warn";
    SC.AlertPane.warn(this.alertTitle, "A warning alert", "", "OK", "Cancel", null, this);
    this.set('status', 'opened alert pane - %@'.fmt(this.alertTitle));
  },
  
  showAlertError: function() {
    this.alertTitle = "Error";
    SC.AlertPane.error(this.alertTitle, "An error alert", "", "OK", "Cancel", null, this);
    this.set('status', 'opened alert pane - %@'.fmt(this.alertTitle));
  },
  
  showAlertInfo: function() {
    this.alertTitle = "Info";
    SC.AlertPane.info(this.alertTitle, "An info alert", "", "OK", "Cancel", null, this);
    this.set('status', 'opened alert pane - %@'.fmt(this.alertTitle));
  },
  
  showAlertPlain: function() {
    this.alertTitle = "Plain";
    SC.AlertPane.plain(this.alertTitle, "A plain alert", "", "Yes", "No", null, this);
    this.set('status', 'opened alert pane - %@'.fmt(this.alertTitle));
  },
  
  showAlertExtraButton: function() {
    this.alertTitle = "Extra Button";
    SC.AlertPane.plain(this.alertTitle, "An alert with an extra button", "", "Foo", "Bar", "Extra", this);
    this.set('status', 'opened alert pane - %@'.fmt(this.alertTitle));
  },
  
  showAlertOneButton: function() {
    this.alertTitle = "One Button";
    SC.AlertPane.plain(this.alertTitle, "An alert with one button", "", "OK", null, null, this);
    this.set('status', 'opened alert pane - %@'.fmt(this.alertTitle));
  },
  
  alertPaneDidDismiss: function(pane, status) {
    var buttonTitle = '';
    
    switch(status) {
      case SC.BUTTON1_STATUS:
        buttonTitle = pane.buttonOne.get('title');
        break;
        
      case SC.BUTTON2_STATUS:
        buttonTitle = pane.buttonTwo.get('title');
        break;
        
      case SC.BUTTON3_STATUS:
        buttonTitle = pane.buttonThree.get('title');
        break;
    }
    
    this.set('status', '%@ button clicked'.fmt(buttonTitle));
  }
  
});