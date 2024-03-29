class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reservations
  has_many :reservation_details
  has_many :reviews

  validate :validate_guest_information, if: -> { guest? && persisted? }
  validates :last_name, presence: true, unless: :guest?
  validates :first_name, presence: true, unless: :guest?
  validates :last_name_kana, presence: true, unless: :guest?
  validates :first_name_kana, presence: true, unless: :guest?
  validates :postal_code, presence: true, unless: :guest?
  validates :address, presence: true, unless: :guest?
  validates :telephone_number, presence: true, unless: :guest?

  def self.guest
  customer = Customer.create!(
    email: "guest_#{Time.now.to_i}@example.com", # 一意のメールアドレスを生成
    password: SecureRandom.urlsafe_base64,
    last_name: 'ゲスト名を入力',
    first_name: 'ゲスト名を入力',
    last_name_kana: 'ゲストカナを入力',
    first_name_kana: 'ゲストカナを入力',
    postal_code: '郵便番号を入力',
    address: '住所を入力',
    telephone_number: '電話番号を入力',
    is_deleted: false,
    is_guest: true
  )
  customer
  end


  def reset_guest_attributes
    if guest?
      update_columns(
        last_name: 'ゲスト名を入力',
        first_name: 'ゲスト名を入力',
        last_name_kana: 'ゲストカナを入力',
        first_name_kana: 'ゲストカナを入力',
        postal_code: '郵便番号を入力',
        address: '住所を入力',
        telephone_number: '電話番号を入力'
      )
    end
  end

  def guest?
    is_guest
  end

private


  def validate_guest_information
  if last_name == 'ゲスト名を入力' || last_name.blank? ||
     first_name == 'ゲスト名を入力' || first_name.blank? ||
     last_name_kana == 'ゲストカナを入力' || last_name_kana.blank? || # この行を追加
     first_name_kana == 'ゲストカナを入力' || first_name_kana.blank? || # この行を追加
     postal_code == '郵便番号を入力' || postal_code.blank? ||
     address == '住所を入力' || address.blank? ||
     telephone_number == '電話番号を入力' || telephone_number.blank?
    errors.add(:base, "ゲストとしての情報を正しく更新してください。")
  end
  end




end
