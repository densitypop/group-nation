class InternetEnabledPersonForgery < NameForgery
  LAST_NAMES = dictionaries[:last_names]
  MALE_FIRST_NAMES = dictionaries[:male_first_names]
  FEMALE_FIRST_NAMES = dictionaries[:female_first_names]

  def self.last_name
    @@current_last_name ||= LAST_NAMES.random
  end

  def self.first_name
    @@current_first_name ||= [MALE_FIRST_NAMES, FEMALE_FIRST_NAMES].random.random
  end

  def self.user_name
    first_name unless defined?(@@current_first_name)
    last_name unless defined?(@@current_last_name)
    (@@current_first_name[0,1] + @@current_last_name).downcase
  end

  def self.email_address
    user_name + '@' + InternetForgery.domain_name
  end

  def self.reset
    @@current_last_name = @@current_first_name = nil
  end

end
