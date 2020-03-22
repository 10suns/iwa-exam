# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExtractNewsListService, type: :service do
  subject { ExtractNewsListService.execute(url) }
  describe '#self.execute' do
    context 'when url is valid' do
      let(:url) { 'http://test.com' }
      before do
        path = Rails.root.join('spec', 'fixtures', 'best_news.html')
        doc = Nokogiri::HTML(File.open(path))
        allow_any_instance_of(ExtractNewsListService).to receive(:source).and_return(doc)
      end
      let(:article_1) { { link: 'https://link1.com/', title: 'Link 1' } }
      let(:article_2) { { link: 'https://news.ycombinator.com/item?id=22630426', title: 'Hacker news page' } }
      it 'should return news list' do
        expect(subject.success?).to eq true
        expect(subject.data[:articles].map(&:to_h)).to contain_exactly(article_1, article_2)
        expect(subject.data[:link_next_page]).to eq('https://news.ycombinator.com/best?p=4')
      end
    end
  end
end
