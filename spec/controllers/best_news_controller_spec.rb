# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BestNewsController, type: :controller do
  let(:success) { ServiceResult.new('Success', true, { data: 'data' }) }
  let(:fail) { ServiceResult.new('Fail', false, nil) }
  describe 'GET #index' do
    it 'should return 200' do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe 'GET #news' do
    context 'when extract list successfully' do
      before do
        allow(ExtractNewsListService).to receive(:execute).and_return(success)
      end
      it 'should call ExtractNewsListService' do
        expect(ExtractNewsListService).to receive(:execute).with('https://news.ycombinator.com/best?p=1')
        get :news, params: { page: 1 }
        expect(response.status).to eq 200
      end
      it 'should return success json' do
        get :news, params: { page: 1 }
        expect(response.body).to eq({ success: true, data: success.data }.to_json)
      end
    end
    context 'when extract list fail' do
      before do
        allow(ExtractNewsListService).to receive(:execute).and_return(raise)
      end
      it 'should return success json' do
        get :news, params: { page: 1 }
        expect(response.body).to eq({ success: false }.to_json)
      end
    end
  end
  describe 'GET #preview' do
    context 'when extract preview successfully' do
      before do
        allow(ExtractPreviewService).to receive(:execute).and_return(success)
      end
      it 'should call ExtractPrevewService' do
        expect(ExtractPreviewService).to receive(:execute).with('http://test.com')
        get :preview, params: { url: 'http://test.com' }
        expect(response.status).to eq 200
      end
      it 'should return success json' do
        get :preview, params: { url: 'http://test.com' }
        expect(response.body).to eq({ success: true, data: success.data }.to_json)
      end
    end
    context 'when extract preview false' do
      before do
        allow(ExtractPreviewService).to receive(:execute).and_return(raise)
      end
      it 'should return success json' do
        get :preview, params: { url: 'http://test.com' }
        expect(response.body).to eq({ success: false }.to_json)
      end
    end
  end
  describe 'GET #detail' do
    context 'when extract detail successfully' do
      before do
        allow(ExtractDetailService).to receive(:execute).and_return(success)
      end
      it 'should call ExtractPrevewService' do
        expect(ExtractDetailService).to receive(:execute).with('http://test.com')
        get :detail, params: { url: 'http://test.com' }
        expect(response.status).to eq 200
      end
      it 'should return success json' do
        get :detail, params: { url: 'http://test.com' }
        expect(response.body).to eq({ success: true, data: success.data }.to_json)
      end
    end
    context 'when extract preview false' do
      before do
        allow(ExtractDetailService).to receive(:execute).and_return(raise)
      end
      it 'should return success json' do
        get :detail, params: { url: 'http://test.com' }
        expect(response.body).to eq({ success: false }.to_json)
      end
    end
  end
end
