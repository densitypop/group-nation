require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "The data loader" do

  it "should load 50 random people" do
    Person.should_receive(:create).exactly(50).times
    DataLoader.load_people 50
  end

  it "should load 20 random groups" do
    Group.should_receive(:create).exactly(20).times
    DataLoader.load_people 50
    DataLoader.load_groups 20
  end

  describe "after loading groups" do

    before(:each) do
      DataLoader.load_people 50
      DataLoader.load_groups 20
    end

    it "should have 5 inactive groups" do
      Group.find_all_by_active(false).length.should == 5
    end

    it "should not have an organizer with more than 3 groups" do
      Person.all.each { |p| p.groups.length.should_not be_greater_than(3) }
    end

  end

end
