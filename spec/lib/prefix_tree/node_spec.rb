# frozen_string_literal: true

RSpec.describe PrefixTree::Node do

  describe '#add_values' do
    context 'simple prefix case' do
      let(:node) { described_class.new(value: '100', terminal: true) }
      subject { node }
      before do
        node.add_child('10').terminal = true
        node.print
      end
      it { is_expected.to satisfy { |s| s.value == '10' } }
      it { is_expected.to satisfy { |s| s.children[0].value == '0' } }
      describe 'the values' do
        subject { node.values }
        it { is_expected.to match_array(['10', '100']) }
      end
    end

    context 'extension case' do
      let(:node) { described_class.new(value: '100', terminal: true) }
      subject { node }
      before do
        node.add_child('1234').terminal = true
        node.print
      end
      it { is_expected.to satisfy { |s| s.value == '1' } }
      it { is_expected.to satisfy { |s| s.children[1].value == '234' } }
    end

    context 'nested prefix replacement' do
      let(:node) { described_class.new(value: '100', terminal: true) }
      subject { node }
      before do
        node.add_child('1034').terminal = true
        node.add_child('103').terminal = true
        node.print
      end
      it { is_expected.to satisfy { |s| s.value == '10' } }
    end

    context 'pivot to null root' do
      let(:node) { described_class.new(value: '100') }
      subject { node }
      before do
        node.add_child('174').terminal = true
      end
      it { is_expected.to satisfy { |s| s.value == '1' } }
    end

  end

  describe '#values' do
    let(:node) { described_class.new }
    before do
      node.value = '10005'
    end

    subject { node.values } 
    context 'when no children' do
      let(:node) { described_class.new(terminal: true) }
      it { is_expected.to eq ['10005'] } 
    end

    context 'with 2 children' do
      before do
        node.children << described_class.new(value: '7', terminal: true)
        node.children << described_class.new(value: '6', terminal: true)
      end
      it { is_expected.to eq ['100057', '100056'] }
    end
  end
end
