# lebowski 0.3.1 January 23, 2011

* Fixed mouse down and right mouse down user actions
* Fixed double click user action
* Fixed mouse event simulation bug. Event's which property now assigned the correct value

# lebowski 0.3.0 December 6, 2010

* Updated to now work with Ruby 1.9.2 and RSpec v2
* Fixes drag and drop user actions
* Fixes clicking on segmented view's buttons
* Fixes mouse user actions so that, by default, DOM elements are clicked in the center instead of relative (0, 0)
* Fixes RSpec extension That operator's contains? method
* Added user actions mouse_wheel_delta_x and mouse_wheel_delta_y
* View proxy now includes scrollable_parent_view method
* Updated framework to build gem with Jeweler. Rubyforge and Hoe are no longer used 
* Note: If creating an instance of the Selenium client driver that you want to pass to Lebowski's 
        MainApplication, you must now supply the client with a timeout value or else you will immediately get a 
        timeout error (e.g. set :timeout_in_seconds => 60)

# lebowski 0.2.1 October 6, 2010

* Fixed MainApplication object's define_root_object method
* Added functionality to check if a SproutCore bundle has been loaded
* Updated framework to handle cases when an object crossed application context boundaries
* replace select_field method with select_button on the SelectFieldTabView proxy

# lebowski 0.2.0 August 20, 2010

* Now use MainApplication to start a main SproutCore application
* Improved application support in order to communicate with SproutCore apps loaded in iframes and pop-up windows
* Changed how paths are defined. No longer use define. Now use define_path
* Changed how path proxies are defined. No longer use proxy. Now use define_proxy
* Now performs lazy loading of proxies that are accessed through defined paths and defined proxies
* Added proxy for SC.SelectButtonView
* Added proxy for SC.WebView
* Added proxy for SCUI.SelectFieldTab
* Added proxy for SCUI.ColorWell
* Added proxy for SCUI.ContentEditableView
* Added functionality to the PositionedElement mixin
* Updated the drag and drop user action so that you can specify mouse offsets
* Updated what values can be passed to the main application browser parameter. Can now supply string values and :chrome

# lebowski 0.1.1 June 7, 2010

* Open source beta release