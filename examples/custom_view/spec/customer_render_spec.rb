require '../../../lib/lebowski/spec'

describe "Custom Rendered View" do
  
  before(:all) do
    if $app.nil?
      # a before(:all) will run each time in sub-example groups (read: a describe block)
      # Because of this behavior, we need to prevent the applicaiton from being created
      # each time. Therefore, the application is a global instance variable so we can
      # perform a check on it to see if it has been created. Note that although it is
      # global it is exclusive this spec. 
      $app = Lebowski::Foundation::Application.new \
          :app_root_path => "/test_app",
          :app_name => "TestApp"

      $app.start

      # make global for the same reason we made the application global
      $view = $app.view('mainPage.mainPane.customRenderedView')
    end
  end

  it "should exist in the application" do
    $view.should exist_in_app
    $view.should be_a_view
    $view.should be_visible_in_window
  end
  
  describe "Core query of view's layer (root DOM element)" do
    
    before(:all) do
      @cq = $view.core_query()
    end
    
    it "should exist and have a handle" do
      @cq.should_not be_nil
      @cq.should have_handle
    end
    
    it "should have an absolute property path equal to the view's absolute property path" do
      @cq.should have_abs_path $view.abs_path
    end
    
    it "should have one element" do
      @cq.should have_size 1
      elem = @cq.element(0)
      elem.should_not be_nil
    end
      
    it "should have an element with classes custom-rendered-view and sc-view" do
      elem = @cq.element(0)
      elem.should have_classes %w{ sc-view custom-rendered-view }
      elem.should_not have_classes %w{ custom-rendered view }
    end
    
    it "should have an element with tag DIV" do
      elem = @cq.element(0)
      elem.should have_tag /div/i
    end
    
    it "should not have a handle when done" do
      @cq.done
      @cq.should_not have_handle
    end
    
  end
  
  describe "Core query from view where selector is 'a.stooges'" do
    
    before(:all) do
      @cq = $view.core_query('a.stooges')
    end
    
    it "should exist and have a handle" do
      @cq.should_not be_nil
      @cq.should have_handle
      @cq.should have_selector 'a.stooges'
    end
    
    it "should have three elements" do
      @cq.should have_size 3
    end
    
    it "should have elements that all have tag A" do
      @cq.check { |elem| 
        true if elem.tag =~ /a/i 
      }.should be_true
      
      pass_check = @cq.check :all do |elem|
        true if elem.tag =~ /a/i
      end
      pass_check.should be_true
    end
    
    it "should not have any elements with tag IMG" do
      @cq.check { |elem| 
        true if elem.tag =~ /img/i 
      }.should be_false
      
      pass_check = @cq.check :all do |elem|
        true if elem.tag =~ /img/i 
      end
      pass_check.should be_false
      
      pass_check = @cq.check :none do |elem| 
        true if elem.tag =~ /img/i 
      end
      pass_check.should be_true
    end
    
    it "should have an element with class 'moe'" do
      pass_check = @cq.check :any do |elem| 
        true if elem.has_class? 'moe' 
      end
      pass_check.should be_true
      
      elems = @cq.fetch do |elem|
        elem if elem.has_class? 'moe'
      end

      elems.should have_length 1

      elems[0].should have_class 'moe'
      
      elems[0].should have_classes %w{ moe stooges }
      elems[0].should_not have_classes %w{ moe stooge }
      
      elems[0].should have_tag /a/i
      elems[0].should_not have_tag /img/i
      
      elems[0].should have_text /moe/i
      elems[0].should_not have_text /larry/i
      
      elems[0].should have_attribute('href', 'http://moe.net')
      elems[0].should_not have_attribute('href', 'http://larry.com')
      
      elems[0].should have_href 'http://moe.net'      
      elems[0].should_not have_href 'http://larry.com'      
    end
    
    it "should not have a handle when done" do
      @cq.done
      @cq.should_not have_handle
    end
    
  end
  
  describe "when 'hello world' paragraph element in view is single clicked'" do

    before(:all) do
      @cq_main_box2 = $view.core_query('.main-box2')
      @cq_p = $view.core_query('.main-box2 p')
    end
    
    it "should have core queries set up" do
      @cq_main_box2.should_not be_nil
      @cq_main_box2.should have_handle
      @cq_main_box2.should have_selector '.main-box2'
      @cq_main_box2.should have_size 1
      elem = @cq_main_box2[0]
      elem.should have_class 'main-box2'
      elem.should_not have_class 'active'
      
      @cq_p.should_not be_nil
      @cq_p.should have_handle
      @cq_p.should have_selector '.main-box2 p'
      @cq_p.should have_size 1
      elem = @cq_p[0]
      elem.should have_text /hello world/i
    end
    
    it "should have '.main-box2' element with 'active' class after first click" do
      elem = @cq_p[0]
      elem.click
      elem = @cq_main_box2[0]
      elem.should have_class 'active'
    end
    
    it "should have '.main-box2' element with no 'active' class after second click" do
      elem = @cq_p[0]
      elem.click
      elem = @cq_main_box2[0]
      elem.should_not have_class 'active'
    end
    
    it "should not have a handles when done" do
      @cq_main_box2.done
      @cq_main_box2.should_not have_handle
      @cq_p.done
      @cq_p.should_not have_handle
    end
    
  end
  
  describe "when IMG elements and '.main-box3' element in view are double clicked'" do

    before(:all) do
      @cq_main_box3 = $view.core_query('.main-box3')
      @cq_img_alert = $view.core_query('.main-box3 img.alert')
      @cq_img_info = $view.core_query('.main-box3 img.info')
    end
    
    it "should have core queries set up" do
      @cq_main_box3.should_not be_nil
      @cq_main_box3.should have_handle
      @cq_main_box3.should have_selector '.main-box3'
      @cq_main_box3.should have_size 1
      elem = @cq_main_box3[0]
      elem.should have_class 'main-box3'
      elem.should_not have_class 'black'
      elem.should_not have_class 'white'
      
      @cq_img_alert.should_not be_nil
      @cq_img_alert.should have_handle
      @cq_img_alert.should have_selector '.main-box3 img.alert'
      @cq_img_alert.should have_size 1
      
      @cq_img_info.should_not be_nil
      @cq_img_info.should have_handle
      @cq_img_info.should have_selector '.main-box3 img.info'
      @cq_img_info.should have_size 1
    end
    
    it "should have '.main-box3' element with 'black' class after double clicking alert image" do
      elem = @cq_img_alert[0]
      elem.double_click
      elem = @cq_main_box3[0]
      elem.should have_class 'black'
      elem.should_not have_class 'white'
    end
    
    it "should have '.main-box3' element with 'white' class after double clicking info image" do
      elem = @cq_img_info[0]
      elem.double_click
      elem = @cq_main_box3[0]
      elem.should have_class 'white'
      elem.should_not have_class 'black'
    end
    
    it "should have '.main-box3' element with no 'black' or 'white' classes after double clicking '.main-box3" do
      elem = @cq_main_box3[0]
      elem.double_click
      elem = @cq_main_box3[0]
      elem.should_not have_classes %{ white black }
    end
    
    it "should not have a handles when done" do
      @cq_main_box3.done
      @cq_main_box3.should_not have_handle
      @cq_img_alert.done
      @cq_img_alert.should_not have_handle
      @cq_img_info.done
      @cq_img_info.should_not have_handle
    end
    
  end
  
end