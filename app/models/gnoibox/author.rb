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

    scope :admin, ->{where(role: :admin)}
    scope :not_writer, ->{where.not(role: :writer)}

    def self.role_options
      [['管理者', :admin], ['ライター', :writer]]
    end

    def name
      read_attribute(:name) || email
    end
    
    def role_text
      (Hash[Author.role_options].invert)[role.try(:to_sym)]
    end
    
  end
end
