#specファイルは対応するクラス名_spec.rbという名前で作成する
require 'rails_helper' #rails_helper.rb内の記述を読み込むことで共通の設定を有効にしている。この1行目の記述は、全てのspecファイルに書き込む。
#factory_girlを利用した生成
describe User do
  describe '#create' do
    #nicknameとemail、passwordとpassword_confirmationが存在すれば登録できること

    it "is valid with a nickname, email, password, password_confirmation" do
      user = build(:user)
      expect(user).to be_valid
    end

    #nicknameが空では登録できないこと
    it "is invalid without a nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    #emailが空では登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    #passwordが空では登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    #.passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    #重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email address" do
      user = create(:user) #先に登録したユーザーと同じemailの値を持つユーザーのインスタンスを作成
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    #nicknameが7文字以上であれば登録できないこと more than には7が含まれない
    it "is invalid with a nickname that has more than 6 characters " do
      user = build(:user, nickname: "aaaaaaa")
      user.valid?
      expect(user.errors[:nickname][0]).to include("is too long")
    end

    #nicknameが6文字以下では登録できること less thanには6が含まれない
    it "is valid with a nickname that has less than 7 characters " do
      user = build(:user, nickname: "aaaaaa")
      expect(user).to be_valid
    end

    #passwordが6文字以上であれば登録できること more thanには6が含まれない
    it "is invalid with a password that has more than 5 characters " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user).to be_valid
    end

    #passwordが5文字以下であれば登録できないこと less thanには5が含まれない
    it "is invalid with a password that has less than 6 characters " do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short")
    end
  end

end
