require 'bcrypt'

#users.show line 4
#<!-- <p class="pic"><%= image_tag user_profile_pic(@user) %></p> -->

class User < ApplicationRecord
  include BCrypt
  attr_accessor :topic1, :topic2, :topic3

  #user will get method to check if it has an attached file
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

  #validates that the file chosen is an image
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  #validates file size, name, and edit time
  # validates_attachment_file_size:
  # validates_attachment_file_name:
  # validates_attachment_updated_at:




  has_many :slots, foreign_key: :mentor_id
  has_many :appointments_with_mentors, class_name: "Appointment", foreign_key: :mentee_id
  has_many :mentoring_appointments, through: :slots, source: :appointment

  validates :first_name, :last_name, presence: true
  validates :email, length: { maximum: 50 }, presence: true, uniqueness: true
  validates :password, length: { maximum: 50 }
  validates :phone, numericality: { only_integer: true }, presence: true, uniqueness: true

  has_secure_password
end
