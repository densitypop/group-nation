class GroupsController < ResourceController::Base
  index do
    wants.xml { render :xml => @groups, :status => :ok }
    wants.json { render :json => @groups, :status => :ok }
  end

  show do
    wants.xml { render :xml => @group, :status => :ok }
    wants.json { render :json => @group, :status => :ok }
    failure.wants.json { render :nothing => true, :status => 404 }
    failure.wants.xml { render :nothing => true, :status => 404 }
  end

  create.after { headers["Location"] = group_url(@group.permalink) }

private
  def object
    @object ||= end_of_association_chain.find_by_permalink!(param)
  end

end
