require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/groups/index.html.haml" do
  include GroupsHelper
  
  before(:each) do
    group_98 = mock_model(Group)
    group_98.should_receive(:name).and_return("MyString")
    group_98.should_receive(:person_id).and_return("1")
    group_98.should_receive(:city).and_return("MyString")
    group_98.should_receive(:state).and_return("MyString")
    group_98.should_receive(:zip).and_return("MyString")
    group_98.should_receive(:active).and_return(false)
    group_99 = mock_model(Group)
    group_99.should_receive(:name).and_return("MyString")
    group_99.should_receive(:person_id).and_return("1")
    group_99.should_receive(:city).and_return("MyString")
    group_99.should_receive(:state).and_return("MyString")
    group_99.should_receive(:zip).and_return("MyString")
    group_99.should_receive(:active).and_return(false)

    assigns[:groups] = [group_98, group_99]

    template.stub!(:object_url).and_return(group_path(@group)) 
    template.stub!(:new_object_url).and_return(new_group_path) 
    template.stub!(:edit_object_url).and_return(edit_group_path(@group)) 
  end

  it "should render list of groups" do
    render "/groups/index.html.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", false, 2)
  end
end

