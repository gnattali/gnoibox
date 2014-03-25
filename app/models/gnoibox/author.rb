module Gnoibox
  class Author < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :registerable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable,
           :recoverable, :rememberable, :trackable, :validatable
    
  end
end
