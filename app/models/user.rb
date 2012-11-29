class User < ActiveRecord::Base
 has_one :account
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:confirmable

  # Setup accessible (or protected) attributes for your model
  
  attr_accessible :email, :password, :password_confirmation, :remember_me,:firstname,:lastname,:contactno
  validates_presence_of :firstname ,:message=>"Firstname can't be blank"
  validates_presence_of :lastname ,:message=>"Lastname can't be blank"
  validates_presence_of :contactno ,:message=>"Contact No can't be blank"
  validates_numericality_of :contactno ,:message => "Please enter valid number", :if => :contactno
  validates_presence_of :email ,:message =>"Email can't be blank"
  validates_uniqueness_of :email,:message=>'Email already exists' ,:allow_blank=>true
  validates_format_of :email, :with =>%r{^(?:[_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-zA-Z0-9\-\.]+)*(\.[a-z]{2,4})$}i,:message=>"Please enter a Valid Email", :allow_blank=>true
 validates_presence_of     :password, :message=>"Please enter password", :on => :create
 validates_confirmation_of :password, :on => :create
 validates_length_of :password , :minimum=>6 ,:allowblank=> true
  # attr_accessible :title, :body
end
