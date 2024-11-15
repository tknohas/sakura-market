RSpec.describe Product, type: :model do
  subject { described_class.new(name: 'にんじん', price: 1_000, description: '商品説明です。', published_at: nil, position: 1) }

  describe 'バリデーション' do
    it 'バリデーションが有効' do
      expect(subject).to be_valid
    end

    describe 'バリデーションエラー' do
      describe '商品名' do
        it '入力なし' do
          subject.name = nil
          expect(subject).to be_invalid
        end

        it '文字数が多い' do
          subject.name = 'a' * 51
          expect(subject).to be_invalid
        end
      end

      describe '価格' do
        it '入力なし' do
          subject.price = nil
          expect(subject).to be_invalid
        end

        it '負の値を入力' do
          subject.price = -1
          expect(subject).to be_invalid
        end

        it '数値以外を入力' do
          subject.price = 'あ'
          expect(subject).to be_invalid
        end
      end

      describe '商品説明' do
        it '入力なし' do
          subject.name = nil
          expect(subject).to be_invalid
        end

        it '文字数が多い' do
          subject.name = 'a' * 501
          expect(subject).to be_invalid
        end
      end

      describe '表示順' do
        it '負の値を入力' do
          subject.price = -1
          expect(subject).to be_invalid
        end

        it '数値以外を入力' do
          subject.price = 'あ'
          expect(subject).to be_invalid
        end
      end
    end
  end
end
