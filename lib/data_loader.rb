require 'forgery'

class DataLoader

  def create_person

    f = InternetEnabledPersonForgery

    Person.create :first_name =>  f.first_name,
                    :last_name => f.last_name,
                    :email => f.email_address
    f.reset

  end

  def create_group

    f = GroupForgery

    Group.create :name => f.name,
                  :city => f.city,
                  :state => f.state,
                  :zip => f.zip,
                  :active => group_active_state,
                  :organizer => group_organizer

  end


  def self.method_missing(method, *args)

    if method.to_s =~ /^load_/
      model_name = method.to_s.gsub(/^load_/, '').singularize
      model_class = model_name.classify.constantize

      model_class.delete_all

      number_of_objects = args[0]

      number_of_objects.times do
        self.new.send "create_#{model_name}"
      end

    end

  end

private

  def group_active_state
    return false if Group.find_all_by_active(false).length < 5
    true
  end

  def group_organizer
    p = nil
    begin
      p = Person.first :order => 'rand()'
    end while Group.find_all_by_organizer_id(p.id).length > 3
    p
  end

end
