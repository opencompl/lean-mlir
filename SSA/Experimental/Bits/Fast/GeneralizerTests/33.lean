import SSA.Experimental.Bits.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
#generalize x ^^^ 5#8 ||| x ^^^ 5#8 ^^^ y = x ^^^ 5#8 ||| y -- PASSED gorhxor_proof/xor_common_op_commute2_thm; #33
