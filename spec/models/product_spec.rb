RSpec.describe Product, type: :model do
  subject(:product) { described_class.new(name: 'にんじん', price: 1_000, description: '商品説明です。', published_at: nil, position: 1) }

  it 'バリデーションが有効' do
    expect(product).to be_valid
  end

   describe 'バリデーションエラー' do
     describe '商品名' do
       it '入力なし' do
         product.name = nil
         expect(product).to be_invalid
       end

       it '文字数が多い' do
         product.name = 'a' * 51
         expect(product).to be_invalid
       end
     end

     describe '価格' do
       it '入力なし' do
         product.price = nil
         expect(product).to be_invalid
       end

       it '負の値を入力' do
         product.price = -1
         expect(product).to be_invalid
       end

       it '数値以外を入力' do
         product.price = 'あ'
         expect(product).to be_invalid
       end
     end

     describe '商品説明' do
       it '入力なし' do
         product.name = nil
         expect(product).to be_invalid
       end

       it '文字数が多い' do
         product.name = 'a' * 501
         expect(product).to be_invalid
       end
     end

     describe '表示順' do
       it '負の値を入力' do
         product.price = -1
         expect(product).to be_invalid
       end

       it '数値以外を入力' do
         product.price = 'あ'
         expect(product).to be_invalid
       end
     end
   end
end
