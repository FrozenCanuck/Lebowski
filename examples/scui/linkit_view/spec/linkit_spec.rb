require '../../../../lib/lebowski/spec'
require '../../../../lib/lebowski/scui'

include Lebowski::Foundation
include Lebowski::SCUI::Views

App = Application.new :app_root_path => "/family_tree", :app_name => "LinkItDemo", :browser => :firefox

App.start
App.define 'canvas', 'mainPage.mainPane.canvas', CanvasView
App.define 'families', 'mainPage.mainPane.master', ListView
App.define 'footer', 'mainPage.mainPane.footer', View
App.define 'palette', 'mainPage.mainPane.palette', View

describe "VIEW: canvas" do

  describe "TEST: basic" do
    before(:all) do
      @view = App['canvas']
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
      @view.should be_empty
    end

    it "will add a male, a female, and a pet" do
      @add_male.click
      @add_female.click
      @add_pet.click
    end
    
    it "will verify that the canvas is not empty" do
      @view.should_not be_empty
    end
      
    it "will click each of the nodes, one by one" do
      @view.nodes[0].click
      @view.nodes[1].click
      @view.nodes[2].click           
    end
    
    it "will find the female node by a filter and click it" do
      @view.nodes.find_first({ :isMale => false }).click    
    end
    
    it "will drag the third node to the first node (by the index)" do
      @view.nodes[2].drag_to_node 0
    end
    
    it "will drag the first node to coordinates (400, 150)" do
      @view.nodes[0].drag_to_coordinates(400, 150)
    end
     
    it "will drag the second node above the first node (by the index)" do 
      @view.nodes[1].drag_above_node 0
    end
    
    it "will drag the third node below the first node (by the index)" do
      @view.nodes[2].drag_below_node 0
    end
    
    it "will drag the third node before the first node (by the index)" do
      @view.nodes[2].drag_before_node 0
    end
    
    it "will drag the second node after the first node (by the index)" do
      @view.nodes[1].drag_after_node 0
    end
    
    it "will drag the third node to the first node (by the node)" do
      @view.nodes[2].drag_to_node @view.nodes[0]
    end
    
    it "will drag the second node above the first node (by the node)" do 
      @view.nodes[1].drag_above_node @view.nodes[0]
    end

    it "will drag the third node below the first node (by the node)" do
      @view.nodes[2].drag_below_node @view.nodes[0]
    end

    it "will drag the third node before the first node (by the node)" do
      @view.nodes[2].drag_before_node @view.nodes[0]
    end

    it "will drag the second node after the first node (by the node)" do
      @view.nodes[1].drag_after_node @view.nodes[0]
    end
    
    it "will link the female spouse terminal to the male spouse terminal" do      
      @view.nodes[0].terminal_by_name('sig').link_to @view.nodes[1].terminal_by_name('sig'), 6, 6
    end
    
    it "will link the pet terminal to the male animal terminal" do
      @view.nodes[2].terminal_by_name('myOwner').link_to @view.nodes[0].terminal_by_name('animals'), 6, 6
    end
    
    it "will add another male and female terminal and position them under the existing ones" do
      @add_male.click
      @add_female.click
      
      @view.nodes[2].drag_below_node 0
      @view.nodes[3].drag_below_node 1
    end
      
    it "will link the parents to the children" do
      @view.nodes[0].terminal_by_name('kids').link_to @view.nodes[2].terminal_by_name('dad'), 6, 6
      @view.nodes[0].terminal_by_name('kids').link_to @view.nodes[3].terminal_by_name('dad'), 6, 6
      @view.nodes[1].terminal_by_name('kids').link_to @view.nodes[2].terminal_by_name('mom'), 6, 6
      @view.nodes[1].terminal_by_name('kids').link_to @view.nodes[3].terminal_by_name('mom'), 6, 6
    end
  end
end