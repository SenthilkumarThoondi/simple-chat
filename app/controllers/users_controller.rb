# frozen_string_literal: true

# this controller for user
class UsersController < ApplicationController
  before_action :authenticate_user!

  def show; end
end
