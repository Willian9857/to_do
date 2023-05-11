require 'rails_helper'

describe Api::V1::ToDosController, type: :controller do
  let(:to_do) { ToDo.create(body: 'xablau', title: 'qualquer') }

  before do
    request.env['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Basic.encode_credentials(ENV.fetch('AUTH_USER'), ENV.fetch('AUTH_PASSWORD'))
  end

  describe '#index' do
    it 'quando o usúario não está autenticado' do
      request.env['HTTP_AUTHORIZATION'] = nil

      get :index

      expect(response).to have_http_status(:unauthorized)
    end

    it 'quando o usúario está autenticado' do
      get :index, format: :json

      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    let(:params) {
      {
        body: 'xablau',
        title: 'qualquer'
      }
    }

    context 'quando está autenticado' do
      it 'e cria o to-do corretamente' do
        post(:create, params: params)
        expect(response).to have_http_status(:created)
      end

      it 'e não cria o to-do corretamente' do
        params[:body] = nil

        post(:create, params: params)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#update' do
    context 'quanto está autenticado' do
      it 'e atualiza corretamente' do
        params = {
          id: to_do.id,
          body: 'teste',
          title: 'novo titulo'
        }

        expect {
          put(:update, params: params)
        }.to change { to_do.reload.body }.to eq('teste')
      end

      it 'e não atualiza corretamente' do
        params = {
          id: to_do.id,
          body: '',
          title: 'novo titulo'
        }

        expect {
          put(:update, params: params)
        }.not_to change { to_do.reload.body }
      end
    end
  end

  describe '#destroy' do
    context 'quanto está autenticado' do
      it 'exclui corretamente' do
        to_do

        expect {
          delete :destroy, params: { id: to_do.id }
        }.to change(ToDo, :count).by(-1)
      end

      it 'e passa um id incorreto' do
        delete :destroy, params: { id: 2 }

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
