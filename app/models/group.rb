class Group < ActiveRecord::Base

  #------------------------------
  # Validations
  #------------------------------
  attr_accessible :title, :password, :password_confirmation
  #attr_accessor :owner

  has_secure_password

  validates :title, 
    presence: true,
    length: {maximum: 50}

  validates :password, presence: { on: :create }, 
                       length: { minimum: 5 }, :if => :password_digest_changed?


  #------------------------------
  # Associations
  #------------------------------
  # Users
  has_and_belongs_to_many :users
  belongs_to :owner, class_name: "User"

  before_create :generate_gid

  def generate_gid
    # A unique external identifier used for the 'Join by ID' feature
    # Note that the (external) GID is distinct from the (internal) ID
    # We combine the primary ID + timestamp intro a string for uniqueness
    # and then slice a subset of the MD5 hash of that string
    digest_string = self.id.to_s << Time.now.to_i.to_s 
    self.gid = Digest::MD5.hexdigest(digest_string)[0..5]
  end

  def initialize_owner(user)
    self.owner = user
    #self.users << user
    user.owned << self # user.groups automatically covered
  end

end
