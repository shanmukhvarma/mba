class MembersController < ApplicationController
layout 'homepage'
before_action :authenticated
before_action :pass_check, only: :create

  def index
    
  end

  def signup

    @title = "Create Account"
    @user = Member.new
    @school_name=School.all
    @state = Ustate.all
 
  end
  
  def create
    
    @user = Member.new(req_params)
    # req_params
     # binding.pry
     @user.undergraduate_school = params[:undergraduate_school]  
     @user.state = params[:state]  
     unless params[:school].empty?
       @user.undergraduate_school = params[:school]  
     end
    @user.year = params[:date][:year]
    @user.password = params[:password]
    @user.token =SecureRandom.urlsafe_base64
      
    if @user.save
      
       UserMailer.sendemail(@user).deliver!
       
       unless params[:member][:friend].blank?
       UserMailer.friend(@user).deliver!
     end
      flash[:success] = 'Your Account Has Been Created Successfully! Login To Your Email To Activate Your Account!!'
      redirect_to root_url
    else
      redirect_to members_signup_path, :flash => {:model_errors => @user.errors.messages}
    end
  end
  def verifiemail
  @result=Member.find_by_token(params[:token]).update(:active => 'true')
  if @result
   redirect_to profile_login_path, :notice => 'Your email is verified sucessfully please login here'
  end
  end

  # def collage
  #    @state=School.where("state_id=?",params[:stateid])
     

  # end
  private
  def req_params
    params.require(:member).permit( :name,:username, :email, :state, :undergraduate_school, :zipcode, :image, :hometown, :password_hash, :gpa, :gmat_score, :question, :friend, :status, :exp)
  end
  def email_exist
    unless Member.find_by_email(req_params['email']).nil?
      flash[:error] = 'Email already exists'
      redirect_to members_signup_path
    end
  end
  def pass_check
    unless params[:password] == params[:password_confirmation]
      flash[:error] = "Password doesnt match confirmation"
      redirect_to members_signup_path
    end
  end
  
end