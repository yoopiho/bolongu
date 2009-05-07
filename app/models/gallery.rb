class Gallery < ActiveRecord::Base

  include Notifiable
  include Commentable

  belongs_to :account
  has_many :gallery_photos, :dependent => :destroy
  
  default_scope :order => 'created_at DESC'
  
  def cover
    gallery_photos.first(:conditions => { :cover => true }) or gallery_photos.first
  end
end
