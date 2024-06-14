class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { student: 0, lecturer: 1 }
  attr_accessor :registration_key

  validate :validate_registration_key, on: :create


  private

  def validate_registration_key
    if registration_key.present?
      if role == 'lecturer' && registration_key != ENV['LECTURER_KEY']
        errors.add(:registration_key, 'is invalid for lecturer')
      elsif role == 'student' && registration_key != ENV['STUDENT_KEY']
        errors.add(:registration_key, 'is invalid for student')
      end
    else
      errors.add(:registration_key, 'can\'t be blank')
    end
  end
end
