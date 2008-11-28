require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe GroupsController do
  describe "handling GET /groups" do

    before(:each) do
      @group = mock_model(Group)
      Group.stub!(:find).and_return([@group])
    end

    def do_get
      get :index
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end

    it "should find all groups" do
      Group.should_receive(:find).with(:all).and_return([@group])
      do_get
    end

    it "should assign the found groups for the view" do
      do_get
      assigns[:groups].should == [@group]
    end
  end

  describe "handling GET /groups.xml" do

    before(:each) do
      @group = mock_model(Group, :to_xml => "XML")
      Group.stub!(:find).and_return(@group)
    end

    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render any elements found as XML" do
      @group.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end

  end

  describe "handling GET /groups.json" do

    before(:each) do
      @group = mock_model(Group, :to_json => "JSON")
      Group.stub!( :find ).and_return(@group)
    end

    def do_get
      @request.env["HTTP_ACCEPT"] = "application/json"
      get :index
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render any elements found as JSON" do
      @group.should_receive(:to_json).and_return("JSON")
      do_get
      response.body.should == "JSON"
    end

  end

  describe "handling GET /groups/testing" do

    before(:each) do
      @group = mock_model(Group)
      Group.stub!(:find_by_permalink!).and_return(@group)
    end

    def do_get
      get :show, :id => "testing"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render show template" do
      do_get
      response.should render_template('show')
    end

    it "should find the group requested" do
      Group.should_receive(:find_by_permalink!).with("testing").and_return(@group)
      do_get
    end

    it "should assign the found group for the view" do
      do_get
      assigns[:group].should equal(@group)
    end

  end

  describe "handling GET /groups/testing.xml" do

    before(:each) do
      @group = mock_model(Group, :to_xml => "XML")
      Group.stub!(:find_by_permalink!).and_return(@group)
    end

    def do_get
      request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "testing"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find the group requested" do
      Group.should_receive(:find_by_permalink!).with("testing").and_return(@group)
      do_get
      response.should be_success
      @group.should_not be_nil
    end

    it "should render found group as XML" do
      Group.should_receive(:find_by_permalink!).with("testing").and_return(@group)
      do_get
      response.body.should == "XML"
    end

  end

  describe "handling GET /groups/not_found.xml 404" do

    def do_get
      request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "not_found"
    end

    it "should 404 if given group that doesn't exist" do
      do_get
      response.code.should == "404"
    end

  end

  describe "handling GET /groups/testing.json" do

    before(:each) do
      @group = mock_model(Group, :to_json => "JSON")
      Group.stub!(:find_by_permalink!).and_return(@group)
    end

    def do_get
      request.env["HTTP_ACCEPT"] = "application/json"
      get :show, :id => "testing"
    end

    it "should be successful" do
      do_get
      response.code.should == "200"
    end

    it "should find the group requested" do
      Group.should_receive(:find_by_permalink!).with("testing").and_return(@group)
      do_get
      response.code.should == "200"
      @group.should_not be_nil
    end

    it "should render found group as XML" do
      Group.should_receive(:find_by_permalink!).with("testing").and_return(@group)
      do_get
      response.body.should == "JSON"
    end

  end

  describe "handling GET /groups/not_found.json 404" do

    def do_get
      request.env["HTTP_ACCEPT"] = "application/json"
      get :show, :id => "not_found"
    end

    it "should 404 if given group that doesn't exist" do
      do_get
      response.code.should == "404"
    end

  end

  describe "handling GET /groups/new" do

    before(:each) do
      @group = mock_model(Group)
      Group.stub!(:new).and_return(@group)
    end

    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render new template" do
      do_get
      response.should render_template('new')
    end

    it "should create an new group" do
      Group.should_receive(:new).and_return(@group)
      do_get
    end

    it "should not save the new group" do
      @group.should_not_receive(:save)
      do_get
    end

    it "should assign the new group for the view" do
      do_get
      assigns[:group].should equal(@group)
    end
  end

  describe "handling GET /groups/testing/edit" do

    before(:each) do
      @group = mock_model(Group)
      Group.stub!(:find).and_return(@group)
    end

    def do_get
      get :edit, :id => "testing"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end

    it "should find the group requested" do
      Group.should_receive(:find).and_return(@group)
      do_get
    end

    it "should assign the found Groups for the view" do
      do_get
      assigns[:group].should equal(@group)
    end
  end

  describe "handling POST /groups" do

    before(:each) do
      @group = mock_model(Group, :to_param => "testing")
      Group.stub!(:new).and_return(@group)
      @group.stub!(:permalink).and_return('permalink')
    end

    describe "with successful save" do

      def do_post
        @group.should_receive(:save).and_return(true)
        post :create, :group => {}
      end

      it "should create a new group" do
        Group.should_receive(:new).with({}).and_return(@group)
        do_post
      end

      it "should redirect to the new group" do
        do_post
        response.should redirect_to(group_url("testing"))
      end

    end

    describe "with failed save" do

      def do_post
        @group.should_receive(:save).and_return(false)
        post :create, :group => {}
      end

      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end

    end

    describe "with XML data" do

      def do_post
        group = File.read("#{RAILS_ROOT}/spec/fixtures/group.xml")
        @group.should_receive(:save).and_return(true)
        post :create, :group => group, :content_type => 'application/xml'
      end

      it "should save Group when posted with XML data" do
        do_post
      end

      it "should return location of created resource" do
        @group.stub!(:permalink).and_return('permalink')
        do_post
        response.headers["Location"].should == group_url('testing')
      end

    end

  end

  describe "handling PUT /groups/1" do

    before(:each) do
      @group = mock_model(Group, :to_param => "testing")
      Group.stub!(:find).and_return(@group)
    end

    describe "with successful update" do

      def do_put
        @group.should_receive(:update_attributes).and_return(true)
        put :update, :id => "testing"
      end

      it "should find the group requested" do
        Group.should_receive(:find_by_permalink!).with("testing").and_return(@group)
        do_put
      end

      it "should update the found group" do
        do_put
        assigns(:group).should equal(@group)
      end

      it "should assign the found group for the view" do
        do_put
        assigns(:group).should equal(@group)
      end

      it "should redirect to the group" do
        do_put
        response.should redirect_to(group_url("testing"))
      end

    end

    describe "with failed update" do

      def do_put
        @group.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /groups/testing" do

    before(:each) do
      @group = mock_model(Group, :destroy => true)
      Group.stub!(:find).and_return(@group)
    end

    def do_delete
      delete :destroy, :id => "testing"
    end

    it "should find the group requested" do
      Group.should_receive(:find_by_permalink!).with("testing").and_return(@group)
      do_delete
    end

    it "should call destroy on the found group" do
      @group.should_receive(:destroy).and_return(true)
      do_delete
    end

    it "should redirect to the groups list" do
      do_delete
      response.should redirect_to(groups_url)
    end
  end
end
