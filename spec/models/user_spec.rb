RSpec.describe User, type: :model do
  subject(:user) { described_class.new(name: 'Alice', email: 'alice@example.com', password: 'Abcd1234') }

  it 'バリデーションが有効' do
    expect(user).to be_valid
  end

  describe 'バリデーションエラー' do
    describe '名前' do
      it '入力なし' do
        user.name = nil
        expect(user).to be_invalid
      end

      it '文字数が多い' do
        user.name = 'a' * 21
        expect(user).to be_invalid
      end
    end
  end
end
