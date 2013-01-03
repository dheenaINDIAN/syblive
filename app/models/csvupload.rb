class Csvupload < ActiveRecord::Base
   attr_accessible :csvfile ,:category
   has_attached_file :csvfile,
    :storage => :dropbox,
    :dropbox_credentials => "#{Rails.root}/config/dropbox.yml",
    :dropbox_options => {
      :path => proc { |style| "#{id}/#{csvfile.original_filename}" }
    }
end
