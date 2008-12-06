require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "The data loader" do

  it "should load 50 random people" do

    Person.should_receive(:create).exactly(50).times
    DataLoader.load_people

  end

end
