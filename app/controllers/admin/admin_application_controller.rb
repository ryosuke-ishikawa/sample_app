class Admin::AdminApplicationController < ApplicationController
    before_action :authenticate_admin_user!
end