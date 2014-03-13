class Merchant < ActiveRecord::Base
  has_many :offers, dependent: :destroy
  validates :advertiser_id, uniqueness: true
end
