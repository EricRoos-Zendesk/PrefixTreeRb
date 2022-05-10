# frozen_string_literal: true

RSpec.describe PrefixTree::Tree  do
  let(:tree) { described_class.new }
  it { is_expected.to_not be nil }
  context 'snippets from randoms that failed once' do
    subject { tree.values }
    context 'case 1' do
      let(:values) do
        %w[
          9616881
          41556
          7192297
          61805
          9436622
          9248138
          9288068
          4155603
          4218295
          1288377
        ]
      end
      before do
        values.each do |val|
          tree.add(val.to_s)
          #tree.print
        end
      end
      it { is_expected.to match_array(values.map(&:to_s)) } 
    end
  end

  context 'random tests' do
    let(:tree) { described_class.new }
    subject { tree.values }

    let(:set) do
      Set.new
    end
    before do
      set.clear
      1_000_000.times do
        set.add((rand * 100000000).to_i)
      end
      puts "done seeding"
      set.each do |num|
        puts "adding #{num.to_s}"
        tree.add(num.to_s)
        #tree.print
      end
      puts "done adding to tree"
      #puts "final vals #{tree.values}"
    end
    1.times do
      it 'has every element in the array' do
        found_vals = subject
        expect(found_vals.size).to eq(set.size)
        found_vals.each do |val|
          puts "Verifying #{val}"
          expect(set.include?(val.to_i)).to eq true
        end
      end
    end
  end
end
