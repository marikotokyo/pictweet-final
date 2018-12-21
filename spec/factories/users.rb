#specファイルの中で特定のメソッドにより簡単にインスタンスを生成したり、DBに保存したりできるようになる
FactoryGirl.define do

  factory :user do
    nickname              "abe"
    email                 "kkk@gmail.com"
    password              "00000000"
    password_confirmation "00000000"
  end

end
