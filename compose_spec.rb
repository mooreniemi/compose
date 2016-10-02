`make`

require './compose'

RSpec.describe 'Proc#compose (*)' do
  let(:double) do
    proc {|a| a * 2 }
  end
  let(:triple) do
    proc {|a| a * 3 }
  end
  let(:negate) do
    proc {|a| -a }
  end
  it 'lives on Proc' do
    expect(double.respond_to?(:compose)).to eq(true)
    expect(double.respond_to?(:*)).to eq(true)
  end
  it 'creates new Proc from 2 Procs' do
    expect(double * triple).to be_a Proc
  end
  it 'compose Proc can be evaluated' do
    expect((double * triple).(2)).to eq(triple.(double.(2)))
  end
  it 'compose on & on' do
    expect((double * triple * negate).(2)).to eq(-12)
  end
end
