class Group < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :organizer
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip

  validates_format_of :zip, :with => /\d{5}/

  belongs_to :organizer, :class_name => :person

  has_permalink :name

end
