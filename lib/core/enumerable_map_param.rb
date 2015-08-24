# enumerable_map_param.rb - module MapParam

# extend objects to get reduce like initial map method
module EnumerableMapParam
  def map_param initial, &blk
    self.map {|e| initial, e = yield initial, e; e }
  end

  # yield block only if lambda is true
  def map_select(prc, &blk)
    self.map {|e| (prc.call(e) ? yield(e) : e) }
  end
end
