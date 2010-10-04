describe "Container View Tests" do
    
  before(:all) do
    App['controlsList'].item_views.find_first({ :name => 'SC.ContainerView' }).select
    @empty_button = App['#container-view-empty-button', ButtonView]
    @show_view1_button = App['#container-view-show-view1-button', ButtonView]
    @show_view2_button = App['#container-view-show-view2-button', ButtonView]
    @container = App['#basic-container', ContainerView]
    @view1 = App['containerViewsPage.view1', View]
    @view2 = App['containerViewsPage.view2', View]
  end
  
  it "will confirm views' initial property settings" do
    @container.should have_content_view that_is_empty
    @container.should have_now_showing that_is_empty
    @container.should be_empty
    @container.should_not be_showing @view1
    @container.should_not be_showing @view2
  end
  
  it "will show view1 in the container and confirm" do
    @show_view1_button.click
    
    @container.should_not have_content_view that_is_empty
    @container.should_not have_now_showing that_is_empty
    @container.should_not be_empty
    @container.should_not be_showing @view2
    @container.should be_showing @view1
  end
  
  it "will show view2 in the container and confirm" do
    @show_view2_button.click
    
    @container.should_not have_content_view that_is_empty
    @container.should_not have_now_showing that_is_empty
    @container.should_not be_empty
    @container.should_not be_showing @view1
    @container.should be_showing @view2
  end
  
  it "will empty the container and confirm" do
    @empty_button.click
    
    @container.should have_content_view that_is_empty
    @container.should have_now_showing that_is_empty
    @container.should be_empty
    @container.should_not be_showing @view1
    @container.should_not be_showing @view2
  end
  
end