# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExtractPreviewService, type: :service do
  subject { ExtractPreviewService.execute(url) }

  describe '#self.execute' do
    context 'when url is valid' do
      let(:url) { 'http://test.com' }
      before do
        path = Rails.root.join('spec', 'fixtures', html_file)
        doc = Nokogiri::HTML(File.open(path))
        allow_any_instance_of(ExtractPreviewService).to receive(:doc).and_return(doc)
      end
      context 'when page is full of information' do
        let(:html_file) { 'page_with_img_desc.html' }
        it do
          expect(subject.success?).to eq true
          expect(subject.data.link).to eq url
          expect(subject.data.image).to eq "#{url}/image"
          expect(subject.data.excerpt).to eq 'description'
        end
      end
      context 'when page miss description tag' do
        context 'when page has og:description' do
          let(:html_file) { 'page_no_desc_but_og_desc.html' }
          it do
            expect(subject.success?).to eq true
            expect(subject.data.image).to eq 'http://img_host.com/image'
            expect(subject.data.excerpt).to eq 'og:description'
          end
        end
        context 'when page has no og:description' do
          let(:html_file) { 'page_no_desc_at_all.html' }
          it do
            expect(subject.success?).to eq true
            expect(subject.data.excerpt).to eq nil
          end
        end
      end
      context 'when page missing image' do
        let(:html_file) { 'page_without_img.html' }
        it do
          expect(subject.success?).to eq true
          expect(subject.data.image).to eq ActionController::Base.helpers.asset_path('default-hacker-news.png')
        end
      end
    end
  end
end
