class Company < ApplicationRecord
  has_rich_text :description
  EMAIL_REGEX = /\A[a-zA-Z0-9_.+-]+@(?:(?:[a-zA-Z0-9-]+\.)?[a-zA-Z]+\.)?(getmainstreet)\.com\z/
  validates :email, allow_blank: true, format: { with: EMAIL_REGEX, message: I18n.t('company.invalid_email') }
  validates :zip_code, presence: true
  validate :check_valid_zip_code

  before_save :save_city_state, if: :zip_code_changed?

  def check_valid_zip_code
    unless ZipCodes.identify(zip_code)
      errors.add :zip_code, "is invalid"
      return false
    end
    true
  end

  def save_city_state
  	zipcode_details = ZipCodes.identify(zip_code)
    self.city = zipcode_details[:city]
    self.state = zipcode_details[:state_code]
  end

  def full_address
    "#{city}, #{state}"
  end
end

