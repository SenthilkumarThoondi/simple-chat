# frozen_string_literal: true

# this model is parent for all models
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
