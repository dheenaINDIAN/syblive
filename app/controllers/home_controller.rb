class HomeController < ApplicationController
  before_filter :authenticate_user!
  
  require 'csv'
 
  def index
  if current_user.position  == 'admin'
  redirect_to admin_page_path
  else
  redirect_to home_dashboard_path
  end
  end
  def dashboard
  @cate =[]
  p "-----------#{current_user.position}-----"
  case current_user.position
   when 'admin'
   User::ADMIN_CATEG.map{|categ| (@cate << categ) }
   when 'ceo'
   User::CEO_CATEG.map{|categ| (@cate << categ) }
   when 'manager'
   User::MANAGER_CATEG.map{|categ| (@cate << categ) }
   else
   User::STAFF_CATEG.map{|categ| (@cate << categ) }
   
  end
  
  end
  def new_user
  @current_user= current_user.email
   @user = User.new  
  end
  def create_user
  @current_user= current_user.email
  p "--------#{params.inspect}-------"
  @user = User.new(params[:user])
  @user.position = params[:position]
  @user.confirmed_at = Time.now
  p "----dd----#{@user.inspect}-------"
   if !@user.save
      p "----@user.errors"
      render :action=> new_user_path
   else
      p "---s-----#{@create_user}"
	  flash[:notice] = 'User added and email send to the created user'
	  redirect_to admin_page_path
   end  
	 
  
  end
  def admin_page
    @current_user= current_user.email
  end
  def new_user_profile
    @user_profile = UserProfile.new
  end
  
  def create_user_profile
    #@user_profile = UserProfile.new(params[:user_profile])
   # if @user_profile.valid?
     # @user_profile.user_id = current_user.id
     # @user_profile.save
     # flash[:notice] = 'UserProfile was created successfully.'
      #redirect_to home_dashboard_path
    #else
      #render :action=>'new_user_profile'
   # end
  end
  
  def csvupload
  
      @csvupload = Csvupload.new
	  
	  p"================#{@opt.inspect}============="
  end
  
  def csv
  
    p"-------------#{params.inspect}---------"
	
    @csvupload= Csvupload.new( params[:csvupload] )
	p"================#{@csvupload.inspect}============="
    if @csvupload.save
	flash[:notice] = 'CSV file uploaded successfully.'
	redirect_to admin_page_path
	else
	flash[:error] = 'CSV file uploaded successfully.'
	redirect_to 'home/csvupload'
    end
  end
 
  def categorylist
  	 @category = params[:id]
	 @csvreports = Csvupload.where("category = ?", params[:id])
  end
  def chart
    @csvreports = Csvupload.where("id = ?", params[:id]).first

  case @csvreports.category
  when 'Weekly'
  @yaxis_unit = 'No of members'
  @yaxis_sub = 'mm'
  when "Sales"
  @yaxis_unit = 'No of Sales'
  @yaxis_sub = 'cm'
  when "Employee"
  @yaxis_unit = 'No of Employee'
  @yaxis_sub = 'M'
  when "Projects"
  @yaxis_unit = 'No of Projects'
  @yaxis_sub = 'mm'
  when "Profit&Loss"
  @yaxis_unit = 'No of Profit'
  @yaxis_sub = 'U'
  when "Expenses"
  @yaxis_unit = 'No of Expenses'
  @yaxis_sub  = 'F'
  when "Bussiness Propect"
  @yaxis_unit = 'No of Bussiness'
  @yaxis_sub = 'C'
  when "Technology Propect"
  @yaxis_unit = 'No of Technology'
  @yaxis_sub = 'S'
  else
  @yaxis_unit = 'No of Resources'
  @yaxis_sub = 'R'
  end
  p "---------#{@yaxis_sub}----https://dl.dropbox.com/0/view/j1g15ltz8e0lzz3/Apps/sybrantlive/original/4/sheet_test.csv------"
  @chart_name = (@csvreports.csvfile_file_name).split('.cs')
  p "---ch------#{@chart_name}----------"
  #url = "https://dl.dropbox.com/0/view/j1g15ltz8e0lzz3/Apps/sybrantlive/original/4/sheet_test.csv"
  url = @csvreports.csvfile.url 
  data = open("#{url}")
  @tabled= CSV.parse(data)
  a1 = @tabled[0]
  @tab_transpose = @tabled.transpose
  @c={}
  b1=[]
  k = @tabled[0].length - 1
  i = 1
   for i in 0..k
     @tab_transpose[i].shift
     b1 <<  @tab_transpose[i]
   end
   a1.shift
   b1.shift
   a1.each_with_index {|k,i|@c[k] = b1[i]}
   render :template => '/home/chart'
  end
end
