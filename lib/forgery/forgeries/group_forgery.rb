class GroupForgery < Forgery

  def self.name
    "#{dictionaries[:cities].random.titleize} #{dictionaries[:coding_languages].random} Brigade"
  end

  def self.city
    dictionaries[:cities].random
  end

  def self.state
    dictionaries[:states].random
  end

  def self.zip
    dictionaries[:zipcodes].random
  end

end
