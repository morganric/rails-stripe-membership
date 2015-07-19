class Project < ActiveRecord::Base
acts_as_taggable 

belongs_to :user
mount_uploader :image, ImageUploader

validates_presence_of :title

belongs_to :category

 extend FriendlyId
  friendly_id :title, use: :slugged


end
