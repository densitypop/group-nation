require 'forgery'

class DataLoader

  def self.load_people

    f = InternetEnabledPersonForgery

    50.times do
      Person.create :first_name =>  f.first_name,
                      :last_name => f.last_name,
                      :email => f.email_address
      f.reset
    end

  end

  def self.load_groups

    f = GroupForgery

    20.times do
      Group.create :name => f.name,
                    :city => f.city,
                    :state => f.state,
                    :zip => f.zip,
                    :active => group_active_state,
                    :organizer => group_organizer
    end

  end

private

  def self.group_active_state
    false if Group.find_all_by_active(false).length < 5
    true
  end

  def self.group_organizer
    begin
      p = Person.first :order => 'rand()'
    end while Group.find_all_by_organizer_id(p.id).length > 3
    p
  end

end
