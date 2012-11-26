class Account < ActiveRecord::Base
  attr_accessible :account_name
  belongs_to :user
end
