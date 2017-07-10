require 'oystercard'

describe Oystercard do
  subject(:card) { described_class.new }
  ARBITRARY_TOP_UP = 10
  ARBITRARY_FARE = 2

  describe '#initialize' do
    it 'creates a card with a zero balance' do
      expect(card.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'does not allow card to hold more than the limit' do
      expect { card.top_up(described_class::MAXIMUM_BALANCE + 1) }
        .to raise_error("Maximum limit £#{described_class::MAXIMUM_BALANCE} exceeded")
    end

    it 'tops up the card with the given amount' do
      card.top_up(ARBITRARY_TOP_UP)
      expect(card.balance).to eq ARBITRARY_TOP_UP
    end
  end

  describe '#deduct' do
    before do
      card.top_up(ARBITRARY_TOP_UP)
    end
    it 'deducts the fare from the card balance' do
      card.deduct(ARBITRARY_FARE)
      expect(card.balance).to eq(ARBITRARY_TOP_UP - ARBITRARY_FARE)
    end
  end

  describe '#touch_in' do
    before { card.touch_in }
    it { should be_in_journey }
  end

  describe '#touch_out' do
    before { card.touch_out }
    it { should_not be_in_journey }
  end

  describe '#in_journey?' do
    it 'returns false for a new card' do
       should_not be_in_journey
    end
  end
end
