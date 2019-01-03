class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :omniauthable


  devise :omniauthable, omniauth_providers: [:google_oauth2]
  has_person_name

  has_many :notifications, foreign_key: :recipient_id
  has_many :services

  has_many :access_grants, class_name: "Doorkeeper::AccessGrant", foreign_key: :resource_owner_id, dependent: :destroy

  has_many :access_tokens, class_name: "Doorkeeper::AccessToken", foreign_key: :resource_owner_id, dependent: :destroy

    # Either create a User record or update it based on the provider (Google) and the UID   
    def self.from_omniauth(response_hash)
      user_data = response_hash.info
      credentials = response_hash.credentials
      uid = response_hash.uid

      user = User.where(uid: uid).first
      binding.pry
      # Uncomment the section below if you want users to be created if they don't exist
      # set pwd to uid so to verify user in future
      unless user
          user = User.create(
             name: user_data[:name],
             uid: uid,
             token: credentials[:token],
             expires_at: credentials[:expires_at],
             expires: credentials[:expires],
             provider: "google"
          )
      end
      user
    end

  end
