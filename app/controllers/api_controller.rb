class ApiController < ApplicationController
#login  Success send the types for the user
#categorylist
#
def login
    if params[:login] && params[:credential]
	puts "---------------#{params[:login]}-------------#{params[:credential]}"
      login = params[:login]
      password = params[:credential]
      user = User.find_by_email(login)
      if user && user.valid_password?(password)
	    p "----#{user.email}"
        @mobile=user
        @category =[]
        case @mobile.position
            when 'admin'
			User::ADMIN_CATEG.map{|categ| (@category << categ) }
			when 'ceo'
			User::CEO_CATEG.map{|categ| (@category << categ) }
			when 'manager'
			User::MANAGER_CATEG.map{|categ| (@category << categ) }
			else
			User::STAFF_CATEG.map{|categ| (@category << categ) }
		end
       respond_to do |format|
       format.json   { render :json => {:category => @category, 
                 :message => "success"} }
	   
       end
	  else
	   respond_to do |format|
	   @category = 'Null'
       format.json   { render :json => {:category => @category, 
                 :message => "failure"} }
       end
	  end
	else  
	 respond_to do |format|
	 @category = 'Null'
     format.json   { render :json => {:category => @category, 
                 :message => "failure"} } 
     end
	end
	p "-----------#{@category}-------"
end

def category
 if params[:login] && params[:credential] && params[:category]
      login = params[:login]
      password = params[:credential]
      user = User.find_by_email(login)
      if user && user.valid_password?(password)
      @csvreports = Csvupload.where("category = ?", params[:category])
	  @favour = Favourate.where(:type_fav => params[:category],:user_fav => (user.id).to_s).map(&:file_fav)
	    if @favour != []
		@list = []
	    @favour.map{|x| @list << Csvupload.where(:id => x)}
		@list.flatten!
		@diff = @csvreports - @list
		@csvreport = @list.map{|x| x.csvfile_content_type = 'favourite'}
		@csvreports = @diff.concat(@list)
		end
		@reportfinal = @csvreports.map{|x| x.category = x.csvfile.url}
		 respond_to do |format|
       format.json   { render :json => @csvreports }
       end
	  else
	   respond_to do |format|
	   @csvreports = 'invalid'
       format.json   { render :json => @csvreports  }
	   end
	  end
 else  
	respond_to do |format|
	@csvreports = 'invalid'
    format.json   { render :json => @csvreports  }  
    end	  
 end
 p "-------------#{@csvreports}-------"
end

def new
 if params[:login] && params[:credential] && params[:category]
      login = params[:login]
      password = params[:credential]
      user = User.find_by_email(login)
      if user && user.valid_password?(password)
      @csvreports = Csvupload.where("category = ?", params[:category]).order("created_at DESC").limit(5)
	  @favour = Favourate.where(:type_fav => params[:category],:user_fav => (user.id).to_s).map(&:file_fav)
	    if @favour
		@list = []
	    @favour.map{|x| @list << Csvupload.where(:id => x)}
		@list.flatten!
		@diff = @csvreports - @list
		@csvreport = @list.map{|x| x.csvfile_content_type = 'favourite'}
		@csvreports = @diff.concat(@list)
		end
		@reportfinal = @csvreports.map{|x| x.category = x.csvfile.url}
		 respond_to do |format|
       format.json   { render :json => @csvreports }
       end
	  else
	   respond_to do |format|
	   @csvreports = 'invalid'
       format.json   { render :json => @csvreports  }
	   end
	  end
 else  
	respond_to do |format|
	@csvreports = 'invalid'
    format.json   { render :json => @csvreports  }  
    end	  
 end
 p "-------------#{@csvreports}-------"
end

def favourite
 if params[:login] && params[:credential] && params[:file] && params[:type]
      login = params[:login]
      password = params[:credential]
      user = User.find_by_email(login)
      if user && user.valid_password?(password)
	   check = Favourate.where(:user_fav =>(user.id).to_s,:file_fav => params[:file].to_s,:type_fav => params[:type].to_s)
	   p "kk--#{params[:type]}---kkk  fff#{check.inspect}"
	   if check == []
	    @favourite = Favourate.create(:user_fav =>user.id,:file_fav => params[:file],:type_fav => params[:type])
	    respond_to do |format|
        format.json   { render :json => "success" }
        end
	   else
	    respond_to do |format|
        format.json   { render :json => "already exit or type is invalid" }
        end
	   end
	  else
	   respond_to do |format|
	   @csvreports = 'invalid'
       format.json   { render :json => @csvreports  }
	   end
	  end
 else  
	respond_to do |format|
	@csvreports = 'invalid'
    format.json   { render :json => @csvreports  }  
    end	  
 end
 
end


def favourite_list
 if params[:login] && params[:credential] && params[:type]
      login = params[:login]
      password = params[:credential]
      user = User.find_by_email(login)
      if user && user.valid_password?(password)
	   @fileid = Favourate.where(:type_fav => params[:type],:user_fav => (user.id).to_s).map(&:file_fav)
	   p "------#{@fileid.inspect}---"
	   if @fileid == []
	    respond_to do |format|
        format.json   { render :json => "no favourite" }
        end
	   else
	    @list = []
	    @fileid.map{|x| @list << Csvupload.where(:id => x)}
	    respond_to do |format|
        format.json   { render :json => @list.flatten! }
        end
	   end
	  else
	   respond_to do |format|
	   @csvreports = 'invalid'
       format.json   { render :json => @csvreports  }
	   end
	  end
 else  
	respond_to do |format|
	@csvreports = 'invalid'
    format.json   { render :json => @csvreports  }  
    end	  
 end
 
end


 
end
