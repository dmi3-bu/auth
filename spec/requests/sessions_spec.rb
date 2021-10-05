require './spec/spec_helper'

RSpec.describe 'Sessions API', type: :request do
  describe 'POST /login' do
    context 'missing parameters' do
      it 'returns an error' do
        status, _headers, _body =
          json_request('/login', 'POST', params: { email: 'bob@example.com', password: '' })

        expect(status).to eq(422)
      end
    end

    context 'invalid parameters' do
      it 'returns an error' do
        status, _headers, body =
          json_request('/login', 'POST', params: { email: 'bob@example.com', password: 'invalid'})

        expect(status).to eq(401)
        expect(JSON(body.first)['errors']).to include('detail' => 'Session cannot be created')
      end
    end

    context 'valid parameters' do
      let(:token) { 'jwt_token' }

      before do
        create(:user, email: 'bob@example.com', password: 'givemeatoken')

        allow(JWT).to receive(:encode).and_return(token)
      end

      it 'returns created status' do
        status, _headers, body =
          json_request('/login', 'POST', params: { email: 'bob@example.com', password: 'givemeatoken'})

        expect(status).to eq(201)
        expect(JSON(body.first)['meta']).to eq('token' => token)
      end
    end
  end
end
