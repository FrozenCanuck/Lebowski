require '../../../../lib/lebowski/spec'
require '../../../../lib/lebowski/scui'
require 'human_view'
require 'pet_view'

Spec::Matchers.define :have_node_item_view_support do |sig|
  match do |obj|
    obj.respond_to? :has_node_item_view_support
  end
end

include Lebowski::Foundation
include Lebowski::SCUI::Views
include LinkItDemo::Views

ProxyFactory.proxy HumanView
ProxyFactory.proxy PetView

App = Application.new :app_root_path => "/family_tree", :app_name => "LinkItDemo", :browser => :firefox

App.start
App.define 'canvas', 'mainPage.mainPane.canvas', CanvasView
App.define 'families', 'mainPage.mainPane.master', ListView
App.define 'footer', 'mainPage.mainPane.footer', View
App.define 'palette', 'mainPage.mainPane.palette', View

describe "VIEW: canvas" do
  describe "TEST: setting up" do
    before(:all) do
      @canvas = App['canvas']
      @families = App['families']
      @add_fam = App['footer.addFamilyButton']
      @add_male = App['palette.addMale']
      @add_female = App['palette.addFemale']
      @add_pet = App['palette.addPet']
    end

    it "will add a new family and select it" do
      @add_fam.click
      new_fam = @families.item_views[0]
      new_fam.click
    end
    
    it "will verify that the canvas is empty" do
      @canvas.should be_empty
    end

    it "will add a male, a female, and a pet" do
      @add_male.click
      @add_female.click
      @add_pet.click
    end
  end
    
  describe "TEST: clicking and dragging" do
    before(:all) do
      @canvas = App['canvas']
      @node_0 = @canvas.nodes[0]
      @node_1 = @canvas.nodes[1]
      @node_2 = @canvas.nodes[2]
    end

    it "will verify that there are 3 nodes on the canvas" do
      @canvas.should_not be_empty
      @canvas.nodes.count.should be 3

      @node_0.should be_a_kind_of HumanView
      @node_0.should have_node_item_view_support
      @node_1.should be_a_kind_of HumanView
      @node_1.should have_node_item_view_support
      @node_2.should be_a_kind_of PetView
      @node_2.should have_node_item_view_support
    end
    
    it "will click each of the nodes, one by one" do
      @node_0.click
      @node_0.should be_selected
      
      @node_1.click
      @node_1.should be_selected
      
      @node_2.click
      @node_2.should be_selected
    end
    
    it "will find the female node by a filter and click it" do
      @canvas.nodes.find_first({ :isMale => false }).click
      @canvas.nodes.find_first({ :isMale => false }).should be_selected    
    end
    
    it "will drag the first node to coordinates (400, 150)" do
      @node_0.drag_in_canvas(400, 150)
    end
    
    it "will drag the second node above the first node (by the index)" do 
      @node_1.drag_above 0
      @node_1.should be_positioned_above 0
    end
    
    it "will drag the third node below the first node (by the index)" do
      @node_2.drag_below 0
      @node_2.should be_positioned_below 0
    end
    
    it "will drag the third node before the first node (by the index)" do
      @node_2.drag_left_of 0
      @node_2.should be_positioned_left_of 0
    end
    
    it "will drag the second node after the first node (by the index)" do
      @node_1.drag_right_of 0
      @node_1.should be_positioned_right_of 0
    end
    
    it "will drag the second node above the first node (by the node)" do 
      @node_1.drag_above @node_0
      @node_1.should be_positioned_above @node_0
    end
    
    it "will drag the third node below the first node (by the node)" do
      @node_2.drag_below @node_0
      @node_2.should be_positioned_below @node_0
    end
    
    it "will drag the third node before the first node (by the node)" do
      @node_2.drag_left_of @node_0
      @node_2.should be_positioned_left_of @node_0
    end
    
    it "will drag the second node after the first node (by the node)" do
      @node_1.drag_right_of @node_0
      @node_1.should be_positioned_right_of @node_0
    end  
      
  end
  
  describe "TEST: linking" do
    before(:all) do
      @canvas = App['canvas']
      @add_male = App['palette.addMale']
      @add_female = App['palette.addFemale']
      @node_0 = @canvas.nodes[0]
      @node_1 = @canvas.nodes[1]
      @node_2 = @canvas.nodes[2]      
    end
    
    it "will verify that the nodes are not linked" do
      @node_0.should_not be_linked_to @node_1
      @node_1.should_not be_linked_to @node_0
      @node_0.should_not be_linked_to @node_2
      @node_2.should_not be_linked_to @node_0
      @node_1.should_not be_linked_to @node_2
      @node_2.should_not be_linked_to @node_1
  
      @node_0.should_not be_linked_to 1
      @node_1.should_not be_linked_to 0
      @node_0.should_not be_linked_to 2
      @node_2.should_not be_linked_to 0
      @node_1.should_not be_linked_to 2
      @node_2.should_not be_linked_to 1
    end
  
    it "will link the female spouse terminal to the male spouse terminal" do      
      @node_0.terminal_by_name('sig').link_to @node_1.terminal_by_name('sig'), 6, 6
    end
  
    it "will verify that only the male and female nodes are linked together" do
      @node_0.should be_linked_to @node_1
      @node_1.should be_linked_to @node_0
      
      @node_0.should_not be_linked_to @node_2
      @node_2.should_not be_linked_to @node_0
      @node_1.should_not be_linked_to @node_2
      @node_2.should_not be_linked_to @node_1
    end
    
    it "will verify that only the two spouse terminals are linked together" do
      @node_0.terminal_by_name('sig').should be_linked_to @node_1.terminal_by_name('sig')
      @node_1.terminal_by_name('sig').should be_linked_to @node_0.terminal_by_name('sig')
      
      @node_0.terminal_by_name('sig').should_not be_linked_to @node_1.terminal_by_name('dad')
      @node_0.terminal_by_name('sig').should_not be_linked_to @node_1.terminal_by_name('mom')
      @node_0.terminal_by_name('sig').should_not be_linked_to @node_1.terminal_by_name('animals')
      @node_0.terminal_by_name('sig').should_not be_linked_to @node_1.terminal_by_name('kids')
    end
    
    it "will link the pet terminal to the male terminal" do
      @node_2.terminal_by_name('myOwner').link_to @node_0.terminal_by_name('animals'), 6, 6
    end
    
    it "will verify that the male node is linked to the pet node by the 'animals' and 'myOwner' terminals" do
      @node_2.should be_linked_to @node_0
      @node_0.should be_linked_to @node_2
      
      @node_2.terminal_by_name('myOwner').should be_linked_to @node_0.terminal_by_name('animals')
      @node_0.terminal_by_name('animals').should be_linked_to @node_2.terminal_by_name('myOwner')
    end
    
    it "will add another male and female" do
      @add_male.click
      @add_female.click
    end
  end
  
  describe "TEST: linking additional nodes" do
    before(:all) do
      @canvas = App['canvas']
      @node_0 = @canvas.nodes[0]
      @node_1 = @canvas.nodes[1]
      @node_2 = @canvas.nodes[2]
      @node_3 = @canvas.nodes[3]
      @node_4 = @canvas.nodes[4]
    end
      
    it "will verify that there are 5 nodes on the canvas" do
      @canvas.nodes.count.should be 5
    end
      
    it "will position the new nodes under the existing ones" do
      @node_2.drag_below 0
      @node_2.should be_positioned_below 0
      
      @node_3.drag_below 1
      @node_3.should be_positioned_below 1
    end
     
     it "will verify that the original male and female are not linked to the new nodes by the 'kids' terminal" do
       @node_0.should_not be_linked_to @node_2
       @node_0.terminal_by_name('kids').should_not be_linked_to @node_2.terminal_by_name('dad')
  
       @node_0.should_not be_linked_to @node_3
       @node_0.terminal_by_name('kids').should_not be_linked_to @node_3.terminal_by_name('dad')
  
       @node_1.should_not be_linked_to @node_2
       @node_1.terminal_by_name('kids').should_not be_linked_to @node_2.terminal_by_name('mom')
  
       @node_1.should_not be_linked_to @node_3
       @node_1.terminal_by_name('kids').should_not be_linked_to @node_3.terminal_by_name('mom')
     end
      
    it "will link the original male and female to the new nodes by the 'kids' terminal" do
      @node_0.terminal_by_name('kids').link_to @node_2.terminal_by_name('dad'), 6, 6      
      @node_0.terminal_by_name('kids').link_to @node_3.terminal_by_name('dad'), 6, 6      
      @node_1.terminal_by_name('kids').link_to @node_2.terminal_by_name('mom'), 6, 6
      @node_1.terminal_by_name('kids').link_to @node_3.terminal_by_name('mom'), 6, 6
    end
    
    it "will verify that the original male and female are linked to the new nodes by the 'kids' terminal" do
      @node_0.should be_linked_to @node_2
      @node_0.terminal_by_name('kids').should be_linked_to @node_2.terminal_by_name('dad')
      
      @node_0.should be_linked_to @node_3
      @node_0.terminal_by_name('kids').should be_linked_to @node_3.terminal_by_name('dad')
      
      @node_1.should be_linked_to @node_2
      @node_1.terminal_by_name('kids').should be_linked_to @node_2.terminal_by_name('mom')
      
      @node_1.should be_linked_to @node_3
      @node_1.terminal_by_name('kids').should be_linked_to @node_3.terminal_by_name('mom')
    end
  end
end