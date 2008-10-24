require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/groups/edit.html.haml" do
  include GroupsHelper
  
  before do
    @group = mock_model(Group)
    @group.stub!(:name).and_return("MyString")
    @group.stub!(:person_id).and_return("1")
    @group.stub!(:city).and_return("MyString")
    @group.stub!(:state).and_return("MyString")
    @group.stub!(:zip).and_return("MyString")
    @group.stub!(:active).and_return(false)
    assigns[:group] = @group

    template.should_receive(:object_url).twice.and_return(group_path(@group)) 
    template.should_receive(:collection_url).and_return(groups_path) 
  end

  it "should render edit form" do
    render "/groups/edit.html.haml"
    
    response.should have_tag("form[action=#{group_path(@group)}][method=post]") do
      with_tag('input#group_name[name=?]', "group[name]")
      with_tag('input#group_city[name=?]', "group[city]")
      with_tag('input#group_state[name=?]', "group[state]")
      with_tag('input#group_zip[name=?]', "group[zip]")
      with_tag('input#group_active[name=?]', "group[active]")
    end
  end
end


