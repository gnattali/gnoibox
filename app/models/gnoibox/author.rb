module Gnoibox
  class Author < ActiveRecord::Base
    include ColumnHoldable

    self.table_name= :gnoibox_authors

    validates :name, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true

    mount_uploader :image, MainImageUploader

    # Include default devise modules. Others available are:
    # :confirmable, :registerable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable,
           :recoverable, :rememberable, :trackable, :validatable
    
  end
end
