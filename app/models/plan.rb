# == Schema Information
#
# Table name: plans
#
#  id   :integer          not null, primary key
#  name :string(255)      not null
#  rate :integer          default(0), not null
#

class Plan < ActiveRecord::Base
  
end
