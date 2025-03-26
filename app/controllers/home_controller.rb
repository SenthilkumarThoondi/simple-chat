# frozen_string_literal: true

# this controller for home page
class HomeController < ApplicationController
  before_action :authenticate_user!

  def index; end
end
