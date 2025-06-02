import SSA.Experimental.Bits.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize (x * x ^^^ y * y) &&& (x * x ||| y * y ^^^ -1#32) = x * x &&& (y * y ^^^ -1#32) -- and_orn_xor_commute8_thm; #22
