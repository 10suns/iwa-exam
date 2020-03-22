# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExtractPreviewService, type: :service do
  subject { ExtractDetailService.execute(url) }
  describe '#self.execute' do
    context 'when url is valid' do
      let(:url) { 'http://test.com' }
      before do
        path = Rails.root.join('spec', 'fixtures', html_file)
        doc = Nokogiri::HTML(File.open(path))
        readability = Readability::Document.new(File.open(path).read)
        allow_any_instance_of(ExtractDetailService).to receive(:doc).and_return(doc)
        allow_any_instance_of(ExtractDetailService).to receive(:readability).and_return(readability)
      end
      context 'when page is full of information' do
        let(:html_file) { 'page_with_img_desc.html' }
        it do
          expect(subject.success?).to eq true
          expect(subject.data[:title]).to eq 'Title'
          expect(subject.data[:image]).to eq 'http://test.com/image'
          expect(subject.data[:content]).to eq "<div><div>\n    <p>Test</p>\n  </div></div>"
        end
      end
    end
  end
end
