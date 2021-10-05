require './spec/spec_helper'

RSpec.describe 'Auth API', type: :request do
  describe 'POST /auth' do
    context 'valid auth token' do
      let(:user) { create(:user) }

      it 'returns corresponding user' do
        header 'Authorization', auth_header(user)
        post '/auth'

        expect(last_response.status).to eq(200)
        expect(response_body['meta']).to eq('user_id' => user.id)
      end
    end

    context 'invalid auth token' do
      it 'returns an error' do
        header 'Authorization', 'auth.token'
        post '/auth'

        expect(last_response.status).to eq(403)
      end
    end

    context 'missing auth token' do
      it 'returns an error' do
        post '/auth'

        expect(last_response.status).to eq(403)
      end
    end
  end
end
