class Csvupload < ActiveRecord::Base
   attr_accessible :csvfile ,:category
   has_attached_file :csvfile, :url => "app/assets/fold/:id/:basename.:extension",
                             :path => ":rails_root/app/assets/fold/:id/:basename.:extension"
end
