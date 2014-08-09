class RegistrationsController < Devise::RegistrationsController
  
  def new
    @plan = params[:plan]
    super
  end
  
  def after_sign_up_path_for(resource)
    CreateCustomerWorker.perform_async(current_user.id, params[:user][:plan])
    root_path
  end
  
  
end