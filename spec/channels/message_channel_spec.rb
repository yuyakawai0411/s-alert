require 'rails_helper'

RSpec.describe MessageChannel, type: :channel do

  before do
    @user = FactoryBot.create(:user)
    @card = FactoryBot.create(:card)
    @comment = FactoryBot.build(:comment, user_id:@user.id, card_id:@card.id)
    # @comment = FactoryBot.attributes_for(:comment, user_id:@user.id, card_id:@card.id)
    sleep 0.1
    stub_connection
  end
  
  describe "コメントの送信" do
    
    context "コメントが送信できる" do
      
      it "コメントがsubscriberに送信される" do
        subscribe
        expect(subscription).to be_confirmed
        expect{
          # assert_broadcasts('message_channel', content: @comment, comment_user: @user.first_name)
          perform :post, content: @comment, comment_user: @user.first_name 
        }.to have_broadcasted_to('message_channel').with{ |data| expect(data['content']['text']).to eq @comment.text }
      end

      it "コメントがDBに保存される" do
        #   subscribe
        #   expect(subscription).to be_confirmed
        #   expect{
          #   perform :post, comment: FactoryBot.attributes_for(:comment, card_id:@card.id, user_id:@user.id) 
          # }.to change(Comment, :count).by(0)
        end
      
    end 

    context "コメントが送信できない" do
      it "コメントがDBに保存されない" do

      end
    end

  end
end
