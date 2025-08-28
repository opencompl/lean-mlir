import Blase.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize (x ^^^ y) &&& 1#32 ||| y &&& BitVec.ofInt 32 (-2) = x &&& 1#32 ^^^ y --- PASSED or_and_xor_not_constant_commute0_thm #8
