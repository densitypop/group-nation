require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/groups/show.html.haml" do
  include GroupsHelper
  
  before(:each) do
    @group = mock_model(Group)
    @group.stub!(:name).and_return("MyString")
    @group.stub!(:person_id).and_return("1")
    @group.stub!(:city).and_return("MyString")
    @group.stub!(:state).and_return("MyString")
    @group.stub!(:zip).and_return("MyString")
    @group.stub!(:active).and_return(false)

    assigns[:group] = @group

    template.stub!(:edit_object_url).and_return(edit_group_path(@group)) 
    template.stub!(:collection_url).and_return(groups_path) 
  end

  it "should render attributes in <p>" do
    render "/groups/show.html.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/als/)
  end
end

