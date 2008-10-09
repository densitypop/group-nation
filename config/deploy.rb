set :application, "groupnation"
set :repository,  "git://git.densitypop.net/groupnation.git"
set :scm, :git
set :git_enable_submodules, 1
if RAILS_ENV == "staging"
  set :domain, "groupnation.densitypop.net"
  set :spinner_user, nil
  set :runner, 'joe'
  set :deploy_to, "/web/#{application}"
  
  role :app, "densitypop.net"
  role :web, "densitypop.net"
  role :db,  "densitypop.net", :primary => :true
end
