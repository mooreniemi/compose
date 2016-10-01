`make`

require './compose'

RSpec.describe 'Proc#compose' do
  let(:double) do
    proc {|a| a * 2 }
  end
  it 'lives on Proc' do
    expect(double.respond_to?(:compose)).to eq(true)
  end
end
