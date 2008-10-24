require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/people/show.html.haml" do
  include PeopleHelper
  
  before(:each) do
    @person = mock_model(Person)
    @person.stub!(:first_name).and_return("MyString")
    @person.stub!(:last_name).and_return("MyString")
    @person.stub!(:email).and_return("MyString")

    assigns[:person] = @person

    template.stub!(:edit_object_url).and_return(edit_person_path(@person)) 
    template.stub!(:collection_url).and_return(people_path) 
  end

  it "should render attributes in <p>" do
    render "/people/show.html.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

