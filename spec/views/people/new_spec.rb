require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/people/new.html.haml" do
  include PeopleHelper
  
  before(:each) do
    @person = mock_model(Person)
    @person.stub!(:new_record?).and_return(true)
    @person.stub!(:first_name).and_return("MyString")
    @person.stub!(:last_name).and_return("MyString")
    @person.stub!(:email).and_return("MyString")
    assigns[:person] = @person


    template.stub!(:object_url).and_return(person_path(@person)) 
    template.stub!(:collection_url).and_return(people_path) 
  end

  it "should render new form" do
    render "/people/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", people_path) do
      with_tag("input#person_first_name[name=?]", "person[first_name]")
      with_tag("input#person_last_name[name=?]", "person[last_name]")
      with_tag("input#person_email[name=?]", "person[email]")
    end
  end
end


