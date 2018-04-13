class User < ActiveRecord::Base

	has_secure_password
	has_many :teams
	has_many :players, through: :teams

	validates :email, presence: true, 'valid_email_2/email': true

end
