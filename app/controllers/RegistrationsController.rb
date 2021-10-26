class RegistrationsController < Devise::RegistrationsController
 
   def new
    build_resource
    respond_to do |format|
       format.js
       format.html
   end
  end

   def create
   build_resource(sign_up_params)
   
    if resource.save
       respond_with resource, location: after_sign_up_path_for(resource) 
     else
       render "error"
    end
  end
    
end
