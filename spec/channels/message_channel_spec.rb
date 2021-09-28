require 'rails_helper'

RSpec.describe MessageChannel, type: :channel do
  
  describe "コメントの送信" do
    context "コメントが送信できる" do
      it "コメントがsubscriberに送信される" do
        stub_connection
        subscribe
        expect(subscription).to be_confirmed
      end
    end
  end
end
