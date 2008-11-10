require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Group do
  before(:each) do
    @group = Group.new
  end

  it "should be valid" do
    @group.name = "Testing"
    p = Person.create( { :first_name => 'Joe', :last_name => 'Tester' } )
    p.save false
    @group.organizer = p
    @group.city = "Anytown"
    @group.state = "OH"
    @group.zip = 12345
    @group.should be_valid
  end
end
