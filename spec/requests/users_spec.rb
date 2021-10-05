require './spec/spec_helper'

RSpec.describe 'Users API', type: :request do
  describe 'POST /signup' do
    context 'missing parameters' do
      it 'returns an error' do
        status, _headers, _body =
          json_request('/signup', 'POST', params: { name: 'bob', email: 'bob@example.com', password: '' })

        expect(status).to eq(422)
      end
    end

    context 'invalid parameters' do
      it 'returns an error' do
        status, _headers, body =
          json_request('/signup', 'POST', params: { name: 'b.o.b', email: 'bob@example.com', password: 'givemeatoken'})

        expect(status).to eq(422)
        expect(JSON(body.first)['errors']).to include(
          {
            'detail' => 'is invalid',
            'source' => {
              'pointer' => '/data/attributes/name'
            }
          }
        )
      end
    end

    context 'valid parameters' do
      it 'returns created status' do
        status, _headers, _body =
          json_request('/signup', 'POST', params: { name: 'bob', email: 'bob@example.com', password: 'givemeatoken' })

        expect(status).to eq(201)
      end
    end
  end
end
