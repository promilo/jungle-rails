class User < ActiveRecord::Base
  before_save :downcase_strip
  has_many :reviews

  has_secure_password

  validates :email, :uniqueness => {:case_sensitive => false}, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password,  length: {minimum: 6}

  def downcase_strip
    self.email.downcase.strip
  end


  def self.authenticate_with_credentials(email,password)
    down_case_email = email.downcase.strip
    user = User.find_by email: down_case_email
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

end
