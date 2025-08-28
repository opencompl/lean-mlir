import Blase.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 9}
#generalize (x ^^^ y) &&& 42#9 ||| x &&& BitVec.ofInt 9 (-43) = y &&& 42#9 ^^^ x -- PASSED or_and_xor_not_constant_commute1_thm; #29
