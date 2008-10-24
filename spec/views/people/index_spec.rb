require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/people/index.html.haml" do
  include PeopleHelper
  
  before(:each) do
    person_98 = mock_model(Person)
    person_98.should_receive(:first_name).and_return("MyString")
    person_98.should_receive(:last_name).and_return("MyString")
    person_98.should_receive(:email).and_return("MyString")
    person_99 = mock_model(Person)
    person_99.should_receive(:first_name).and_return("MyString")
    person_99.should_receive(:last_name).and_return("MyString")
    person_99.should_receive(:email).and_return("MyString")

    assigns[:people] = [person_98, person_99]

    template.stub!(:object_url).and_return(person_path(@person)) 
    template.stub!(:new_object_url).and_return(new_person_path) 
    template.stub!(:edit_object_url).and_return(edit_person_path(@person)) 
  end

  it "should render list of people" do
    render "/people/index.html.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end

