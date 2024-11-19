RSpec.describe Address, type: :model do
  let(:user) { create(:user) }
  subject(:address) { described_class.new(user:, zip_code: '145-0071', prefecture: '東京都', city: '大田区', street: '田園調布2-62') }

  describe 'バリデーション' do
    it 'バリデーションが有効' do
      expect(address).to be_valid
    end

    describe '郵便番号' do
      it 'バリデーションエラー(入力なし)' do
        address.zip_code = nil
        expect(address).to be_invalid
      end

      it 'バリデーションエラー(文字数)' do
        address.zip_code = '1450-0071'
        expect(address).to be_invalid
      end

      it 'バリデーションエラー(ハイフンなし)' do
        address.zip_code = '1450071'
        expect(address).to be_invalid
      end

      it 'バリデーションエラー(形式)' do
        address.zip_code = '14-50071'
        expect(address).to be_invalid
      end
    end

    describe '都道府県' do
      it 'バリデーションエラー(入力なし)' do
        address.prefecture = nil
        expect(address).to be_invalid
      end

      it 'バリデーションエラー(文字数)' do
        address.prefecture = '鹿児島県県'
        expect(address).to be_invalid
      end

      it 'バリデーションエラー(最後の文字が都道府県のいずれでもない)' do
        address.prefecture = '東京'
        expect(address).to be_invalid
      end
    end

    describe '市区町村' do
      it 'バリデーションエラー(入力なし)' do
        address.city = nil
        expect(address).to be_invalid
      end

      it 'バリデーションエラー(文字数)' do
        address.city = 'a' * 51
        expect(address).to be_invalid
      end
    end

    describe 'それ以後の住所' do
      it 'バリデーションエラー(入力なし)' do
        address.street = nil
        expect(address).to be_invalid
      end

      it 'バリデーションエラー(文字数)' do
        address.street = 'a' * 101
        expect(address).to be_invalid
      end
    end

    it '建物名が不正' do
      address.building = 'a' * 101
      expect(address).to be_invalid
    end
  end
end
