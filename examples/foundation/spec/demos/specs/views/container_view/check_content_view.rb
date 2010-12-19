describe "Container View Test" do
    
  before(:all) do
    show_control :container_view
    @app = App.get_instance
    page = @app['containerViewsPage']
    @empty_button = page['emptyButton', ButtonView]
    @show_view1_button = page['showView1Button', ButtonView]
    @show_view2_button = page['showView2Button', ButtonView]
    @container = page['containerView', ContainerView]
    @view1 = page['view1', View]
    @view2 = page['view2', View]
  end
  
  before(:each) do
    @empty_button.click
  end
      
  it "will check container view's content view" do
    
    @show_view1_button.click
    
    @container.should_not have_content_view that_is_empty
    @container.should_not have_now_showing that_is_empty
    @container.should_not be_empty
    @container.should_not be_showing @view2
    @container.should be_showing @view1

    @show_view2_button.click
    
    @container.should_not have_content_view that_is_empty
    @container.should_not have_now_showing that_is_empty
    @container.should_not be_empty
    @container.should_not be_showing @view1
    @container.should be_showing @view2
    
    @empty_button.click
    
    @container.should have_content_view that_is_empty
    @container.should have_now_showing that_is_empty
    @container.should be_empty
    @container.should_not be_showing @view1
    @container.should_not be_showing @view2

  end
  
end