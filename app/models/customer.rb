class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :reservations
         
  def self.guest
  find_or_create_by!(email: 'guest@example.com') do |customer|
    customer.password = SecureRandom.urlsafe_base64
    customer.last_name = 'ゲスト'
    customer.first_name = 'ユーザー'
    customer.last_name_kana = 'ゲスト'
    customer.first_name_kana = 'ユーザー'
    customer.postal_code = '1234567'
    customer.address = 'ゲストアドレス'
    customer.telephone_number = '1234567890'
    customer.is_deleted = false
    # 他の必要なカラムもここに追加
  end
  end

  def guest?
    email == 'guest@example.com'
  end
  
end
