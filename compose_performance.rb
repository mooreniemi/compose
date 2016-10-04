require './compose'
require 'graph/function'

Graph::Function.as_gif
Graph::Function.configure do |config|
  config.step = (0..100_000).step(1000).to_a
  config.trials = 100
end
tiny_int_generator = proc {|size| Array.new(size) { rand(-9...9) } }
comparison = Graph::Function::Comparison.new(tiny_int_generator)

module Composition
  refine Proc do
    def ruby_compose
      proc do |i,x|
        self.(i.(x))
      end.curry
    end
  end
end
using Composition

DOUBLE = proc {|a| a * 2 }
TRIPLE = proc {|a| a * 3 }
NEGATE = proc {|a| -a }

def multi_map(a)
  a.map(&DOUBLE).map(&TRIPLE).map(&NEGATE)
end

def c_compose(a)
  a.map(&(DOUBLE * TRIPLE * NEGATE))
end

def ruby_compose(a)
  a.map(&DOUBLE.ruby_compose(&TRIPLE).ruby_compose(&NEGATE))
end

comparison.of(method(:multi_map), method(:c_compose), method(:ruby_compose))

require 'stackprof'
StackProf.run(mode: :object, out: 'compose.dump', interval: 1) do
  tiny_int_generator.(100_000).map(&(DOUBLE * TRIPLE * NEGATE))
end
StackProf.run(mode: :object, out: 'multi_map.dump', interval: 1) do
  tiny_int_generator.(100_000).map(&DOUBLE).map(&TRIPLE).map(&NEGATE)
end
