# grid_spec.rb - specs for method grid(rows, cols)

require '../lib/support/grid'
require 'minitest/autorun'


describe 'enumerated_grid 4,4' do
  let(:grid4x4) { enumerated_grid(4,4) }

  specify { grid4x4.must_equal  [
    [1,2,3,4],
    [5,6,7,8],
    [9,10,11,12],
    [13,14,15,16]
] }
end


describe 'grid 2x4' do
  let(:grid2x4) { grid 2,4 }

  specify { grid2x4.must_equal [[nil,nil,nil,nil], [nil,nil,nil,nil]] }
end

describe 'grid 2x2 with block' do
  subject {
    num = 0
    grid(2, 2) { num += 1 }
  }

  specify { subject.must_equal [[1,2], [3,4]] }
end
