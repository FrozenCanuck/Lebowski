// ==========================================================================
// Project:   Lebowski Framework - The SproutCore Test Automation Framework
// License:   Licensed under MIT license (see License.txt)
// ==========================================================================
/*globals TestApp */

TestApp.alertPanesController = SC.ObjectController.create({
  
  status: '--',
  
  showAlertWarn: function() {
    var alertTitle = "Warn";
    SC.AlertPane.warn({
      message: alertTitle,
      description: "A warning alert",
      buttons: [
        { title: "OK" },
        { title: "Cancel" }
      ],
      delegate: this
    });
    this.set('status', 'opened alert pane - %@'.fmt(alertTitle));
  },
  
  showAlertError: function() {
    var alertTitle = "Error";
    
    SC.AlertPane.error({
      message: alertTitle,
      description: "A error alert",
      buttons: [
        { title: "OK" },
        { title: "Cancel" }
      ],
      delegate: this
    });
    
    this.set('status', 'opened alert pane - %@'.fmt(alertTitle));
  },
  
  showAlertInfo: function() {
    var alertTitle = "Info";
    
    SC.AlertPane.info({
      message: alertTitle,
      description: "A info alert",
      buttons: [
        { title: "OK" },
        { title: "Cancel" }
      ],
      delegate: this
    });
    
    this.set('status', 'opened alert pane - %@'.fmt(alertTitle));
  },
  
  showAlertPlain: function() {
    var alertTitle = "Plain";
    
    SC.AlertPane.plain({
      message: alertTitle,
      description: "A plain alert",
      buttons: [
        { title: "Yes" },
        { title: "No" }
      ],
      delegate: this
    });
    
    this.set('status', 'opened alert pane - %@'.fmt(alertTitle));
  },
  
  showAlertExtraButton: function() {
    var alertTitle = "Extra Button";
    
    SC.AlertPane.plain({
      message: alertTitle,
      description: "An alert with an extra button",
      buttons: [
        { title: "Yes" },
        { title: "No" },
        { title: "Extra" }
      ],
      delegate: this
    });
    
    this.set('status', 'opened alert pane - %@'.fmt(alertTitle));
  },
  
  showAlertOneButton: function() {
    var alertTitle = "One Button";
    
    SC.AlertPane.plain({
      message: alertTitle,
      description: "An alert with one button",
      buttons: [
        { title: "OK" }
      ],
      delegate: this
    });
    
    this.set('status', 'opened alert pane - %@'.fmt(alertTitle));
  },
  
  alertPaneDidDismiss: function(pane, status) {
    var buttonTitle = '';
    
    switch(status) {
      case SC.BUTTON1_STATUS:
        buttonTitle = pane.get('button1').get('title');
        break;
        
      case SC.BUTTON2_STATUS:
        buttonTitle = pane.get('button2').get('title');
        break;
        
      case SC.BUTTON3_STATUS:
        buttonTitle = pane.get('button3').get('title');
        break;
    }
    
    this.set('status', '%@ button clicked'.fmt(buttonTitle));
  }
  
});