# md_gen_page_proc_spec.rb - specs for md_gen_page_proc

require_relative 'spec_helper'

describe MdGen do
  let(:gen) { MdGen.new }

  subject { gen.eval_string "page {|i,j| para 'hi'}" }

  specify {subject[0][0].must_equal :page }
  specify {subject[0][1].must_be_instance_of Proc  }
end
