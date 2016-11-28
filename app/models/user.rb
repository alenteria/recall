class User < ApplicationRecord
  include Concerns::FullNameSplitter
  attr_accessor :source, :skip_phone

  AVAILABILITIES = ['online', 'offline']

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable,
        :confirmable, :lockable, :timeoutable, :omniauthable, 
        omniauth_providers: [:facebook]

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"

  # == Associations =============================================
  has_many :tickets, foreign_key: 'agent_id'
  has_many :requests, foreign_key: 'agent_id'

  # == Validations ==============================================

  validates :first_name,
    presence: true

  validates :last_name,
    presence: true

  validates :full_name,
    presence: true

  validate :complete_name_validity

  validates :email,
    presence: true

  validates :password,
    presence: true

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :mobile,
    presence: true,
    phony_plausible: true,
    unless: Proc.new{|u| u.source.to_s.in?(['facebook']) || u.skip_phone }

  phony_normalize :mobile, default_country_code: 'PH'

  # == Class Methods ============================================
  class << self
    def from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.source = auth.provider
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.full_name = auth.info.name
        if (url = auth.info.image).present?
          user.avatar = url.gsub!("­http","htt­ps")
        end
        user.skip_confirmation!
      end
    end

    def reset_password_by_token(attributes={}, skip_phone: true)
      attributes  = attributes.with_indifferent_access
      original_token       = attributes[:reset_password_token]
      reset_password_token = Devise.token_generator.digest(self, :reset_password_token, original_token)

      recoverable = find_or_initialize_with_error_by(:reset_password_token, reset_password_token)
      recoverable.skip_phone = skip_phone

      if recoverable.persisted?
        if recoverable.reset_password_period_valid?
          recoverable.reset_password(attributes[:password], attributes[:password_confirmation])
        else
          recoverable.errors.add(:reset_password_token, :expired)
        end
      end

      recoverable.reset_password_token = original_token if recoverable.reset_password_token.present?
      recoverable
    end
  end

  # == Instance Methods ===========================================
  def get_avatar_url
    return avatar.url if avatar.present?
    hash = Digest::MD5.hexdigest(email)
    "https://www.gravatar.com/avatar/#{hash}"
  end

  def get_availability
    availability || 'offline'
  end

  private
    def complete_name_validity
      self.errors.add(:full_name, 'Last name can\'t be blank') if self.last_name.blank? && self.full_name.present?
      self.errors.add(:full_name, 'first name can\'t be blank') if self.first_name.blank? && self.full_name.present?
    end
end
