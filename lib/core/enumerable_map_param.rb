# enumerable_map_param.rb - module MapParam

# extend objects to get reduce like initial map method
module MapParam
  def map_param initial, &blk
    self.map {|e| initial, e = yield initial, e; e }
  end
end
