class Admins::ApplicationController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin/application'
end