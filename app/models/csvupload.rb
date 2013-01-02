class Csvupload < ActiveRecord::Base
   attr_accessible :csvfile ,:category
   has_attached_file :csvfile, :url => "/assets/file/:id/:basename.:extension",
                             :path => ":rails_root/public/assets/file/:id/:basename.:extension"
end
