# lebowski 0.2.0 2010-08-20

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

# lebowski 0.1.1 2010-06-07

* Open source beta release