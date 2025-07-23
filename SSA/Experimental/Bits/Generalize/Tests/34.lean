import SSA.Experimental.Bits.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
#generalize x &&& 3#8 &&& 4#8 = 0#8 --PASSED gand_proof/test8_thm; #34
