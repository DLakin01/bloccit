class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  before_save { self.email = email.downcase if email.present? }

  # The following code uses the "||=" shorthand to check if the user
  # already has a role. If not, the user is assigned the role of "member"
  before_save { self.role ||= :member }

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  has_secure_password

  # Maps the given array of attribute types to the integers actually
  # present in our database. 0 = member, and 1 = admin.
  enum role: [:member, :moderator, :admin]
end
