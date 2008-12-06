namespace :db do

  namespace :load do

    task :all => :groups

    task :groups  => [:environment, :people] do
      DataLoader.load_groups
    end

    task :people => :environment do
      DataLoader.load_people
    end

  end

end

