class User < ActiveRecord::Base
 
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable
  # Setup accessible (or protected) attributes for your model
  
  attr_accessible :email, :password, :password_confirmation, :remember_me, :position, :confirmed_at
  
  validates_presence_of :email ,:message =>"User name can't be blank",:unless => 'email == "admin"'
  validates_uniqueness_of :email,:message=>'User name already exists' ,:allow_blank=>true,:unless => 'email == "admin"'
  validates_length_of :email , :minimum=>6 ,:allowblank=> true,:unless => 'email == "admin"'
 # validates_format_of :email, :with =>%r{^(?:[_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-zA-Z0-9\-\.]+)*(\.[a-z]{2,4})$}i,:message=>"Please enter a Valid Email", :allow_blank=>true,:unless => 'email == "admin"'
 validates_presence_of     :password, :message=>"Please enter password", :on => :create
 validates_confirmation_of :password, :on => :create
 validates_length_of :password , :minimum=>6 ,:allowblank=> true
 validates_presence_of     :position, :message=>"Please select the Position"
  # attr_accessible :title, :body
  
  
  ADMIN_CATEG = %w(Weekly Sales Employee Projects Profit&Loss Expenses Bussiness_Prospect Technology_Prospect Resource_Demand).freeze
  CEO_CATEG = %w(Weekly Sales Employee Projects Profit&Loss Expenses Bussiness_Prospect).freeze
  MANAGER_CATEG = %w(Profit&Loss Expenses Bussiness_Prospect Technology_Prospect).freeze
  STAFF_CATEG = %w(Expenses Bussiness_Prospect Technology_Prospect Resource_Demand).freeze
end
