describe "Objects Crossing Application Context Boundaries" do
  
  before(:all) do
    @web_view1 = App['webView1']
  end
  
  it "will confirm the object crossing application context boundaries is a button view" do
    
    App.wait_until do |app|
      app.sc_path_defined?('webView1ContentWindow')
    end
    
    frame = @web_view1.frame
    
    frame.exec_in_context 'BasicApp' do |app|
      app.should have_object 'crossedAppContextBoundaryContent'
      view = app['crossedAppContextBoundaryContent', ButtonView]
      view.should have_sc_class 'SC.ButtonView'
      view.should have_value that_is_equal_to 'test'
      view.should have_foo that_is_equal_to 'bar'
    end
    
  end
  
end