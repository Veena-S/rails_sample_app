# User < ApplicationRecord < ActiveRecord::Base < Object
class User < ApplicationRecord
  # All email are converted to small case before saving it to the database
  # Befor the point where the object is saved, before_save callback is used to
  # downcase the email attribute
  # before_save { self.email = email.downcase }
  before_save{ email.downcase!} # Updates the email attribute directly
  validates :name,  presence: true, length: { maximum: 50 }
  # Only those email addresses matching the regular expression are considered to be valid
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # since the uniqueness validation is case sensitive add an option to nullify it
  # When email is downcased, there is no need of the attribute {case_sensitive: false}
  # since case-sensitive matching works fine if all of the emails are lower-case.
  validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: true

  # Rails method "has_secure_password " will add the following functionality:
  # 1. The ability to save a securely hashed "password_digest" attribute to the database
  # 2. A pair of virtual attributes ("password" and "password_confirmation"),
  #  including presence validations upon object creation and a validation requiring that they match
  # 3. An "authenticate" method that returns the user when the password is correct (and false otherwise)
  has_secure_password # Rails method
  validates :password, presence: true, length: { minimum: 6 }


  # To login as a previously registered user, use fixtures
  # Fixtures are a way of organizing data to be loaded into the test database
  # https://www.learnenough.com/ruby-on-rails-6th-edition-tutorial/basic_login#sec-testing_layout_changes

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    # the password digest is created using bcrypt. So, fixture password should be created
    # using the same method
    # string - string to be hashed
    # cost - cost parameter that determines the computational cost to calculate the hash
    BCrypt::Password.create(string, cost: cost)
  end

end
