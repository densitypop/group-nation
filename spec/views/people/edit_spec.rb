require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/people/edit.html.haml" do
  include PeopleHelper
  
  before do
    @person = mock_model(Person)
    @person.stub!(:first_name).and_return("MyString")
    @person.stub!(:last_name).and_return("MyString")
    @person.stub!(:email).and_return("MyString")
    assigns[:person] = @person

    template.should_receive(:object_url).twice.and_return(person_path(@person)) 
    template.should_receive(:collection_url).and_return(people_path) 
  end

  it "should render edit form" do
    render "/people/edit.html.haml"
    
    response.should have_tag("form[action=#{person_path(@person)}][method=post]") do
      with_tag('input#person_first_name[name=?]', "person[first_name]")
      with_tag('input#person_last_name[name=?]', "person[last_name]")
      with_tag('input#person_email[name=?]', "person[email]")
    end
  end
end


