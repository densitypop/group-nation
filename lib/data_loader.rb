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

end
