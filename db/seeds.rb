Admin.create!(
  email: 'admin@example.invalid',
  password: 'admin123'
)


# テストユーザー1
Customer.find_or_create_by!(email: 'test1@example.com') do |customer|
  customer.password = 'password123'
  customer.last_name = "山田"
  customer.first_name = "太郎"
  customer.last_name_kana = "ヤマダ"
  customer.first_name_kana = "タロウ"
  customer.postal_code = "100-0001"
  customer.address = "東京都中央区1番地"
  customer.telephone_number = "03-1234-5678"
end

# テストユーザー2
Customer.find_or_create_by!(email: 'test2@example.com') do |customer|
  customer.password = 'password123'
  customer.last_name = "佐藤"
  customer.first_name = "花子"
  customer.last_name_kana = "サトウ"
  customer.first_name_kana = "ハナコ"
  customer.postal_code = "100-0002"
  customer.address = "東京都中央区2番地"
  customer.telephone_number = "03-1234-5679"
end

# db/seeds.rb

# 施術メニューのサンプルデータ
service_menus = [
  { course_name: '60分リラックスコース', price_incl_tax: 6600,
    description: '全身を満遍なくもみほぐします。',
    image_path: Rails.root.join('app/assets/images/relaxation_momihogushi.jpg')
  },

   {
    course_name: '90分ヘッド&全身スッキリコース',
    price_incl_tax: 9900,
    description: '頭をしっかりほぐした後、身体をしっかり。',
    image_path: Rails.root.join('app/assets/images/relaxation_atama.jpg') # 画像のパスを変更
  },
  # ... その他の施術メニュー
]

service_menus.each do |menu|
  ServiceMenu.find_or_create_by!(course_name: menu[:course_name]) do |service_menu|
    service_menu.price_incl_tax = menu[:price_incl_tax]
    service_menu.description = menu[:description]

    # もし画像のパスが指定されている場合、その画像をアタッチする
    if menu[:image_path]
      service_menu.image.attach(io: File.open(menu[:image_path]), filename: File.basename(menu[:image_path]))
    end
  end
end

# 口コミのテストデータ（4件）
test_customer_1 = Customer.find_by!(email: 'test1@example.com')

4.times do |i|
  Review.find_or_create_by!(comment: "リラックスできました#{i}") do |review|
    review.rating = rand(1..5)
    review.customer_id = test_customer_1.id
    review.anonymous_name = "山田タロウ#{i}"
    review.admin_comment = "ご来店ありがとうございました！リラックスできて良かったです#{i}"
  end
end


# セラピストのテストデータ
therapists_data = [
  {
    therapist_name: '佐藤 恵美',
    experience_years: 5,
    introduction: '心を込めて施術いたします。',
    image_path: Rails.root.join('app/assets/images/no_image.jpg')
  },
  {
    therapist_name: '鈴木 一郎',
    experience_years: 7,
    introduction: '皆様の癒しのお手伝いをします。',
    image_path: Rails.root.join('app/assets/images/no_image.jpg')
  },
  # その他のセラピストデータ...
]

therapists_data.each do |data|
  therapist = Therapist.find_or_create_by!(therapist_name: data[:therapist_name]) do |therapist|
    therapist.experience_years = data[:experience_years]
    therapist.introduction = data[:introduction]
  end

  # 画像のアタッチ（もし指定されていれば）
  if data[:image_path] && !therapist.image.attached?
    therapist.image.attach(io: File.open(data[:image_path]), filename: File.basename(data[:image_path]))
  end
end

# すでに作成されているデータを利用して予約データを作成します

# 既存のServiceMenuから1つ取得
first_service_menu = ServiceMenu.first

# 既存のCustomerから1つ取得
first_customer = Customer.first

therapist = Therapist.first  # 最初のセラピストを取得


# 予約テストデータの作成
ReservationDetail.find_or_create_by!(service_menu_id: first_service_menu.id, customer_id: first_customer.id, visit_datetime: Time.now + 7.days) do |detail|
  detail.therapist_id = therapist.id
  detail.customer_name = "#{first_customer.last_name} #{first_customer.first_name}"
  detail.course_name = first_service_menu.course_name
  detail.unit_price = first_service_menu.price_incl_tax
  detail.subtotal = first_service_menu.price_incl_tax # こちらを変更
end


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
