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
	   respond_to do |format|
       format.json   { render :json => {:category => @csvreports, 
                 :message => "success"} }
       end
	  else
	   respond_to do |format|
	   @csvreports = 'invalid'
       format.json   { render :json => {:category => @csvreports, 
                 :message => "failure"} }
	   end
	  end
 else  
	respond_to do |format|
	@csvreports = 'invalid'
    format.json   { render :json => {:category => @csvreports, 
                 :message => "failure"}  }  
    end	  
 end
 p "-------------#{@csvreports}-------"
end

def new
 if params[:login] && params[:credential]
      login = params[:login]
      password = params[:credential]
      user = User.find_by_email(login)
      if user && user.valid_password?(password)
      @csvreports = Csvupload.order("created_at DESC").limit(10)
	   respond_to do |format|
       format.json   { render :json => {:category => @csvreports, 
                 :message => "success"} }
       end
	  else
	   respond_to do |format|
	   @csvreports = 'invalid'
       format.json   { render :json => {:category => @csvreports, 
                 :message => "failure"}  }
	   end
	  end
 else  
	respond_to do |format|
	@csvreports = 'invalid'
    format.json   { render :json => {:category => @csvreports, 
                 :message => "failure"}  }  
    end	  
 end
 p "-------------#{@csvreports}-------"
end








 
end
