import Blase.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize 1#32 <<< (31#32 - x) = BitVec.ofInt 32 (-2147483648) >>> x ---- gshlhsub#shl_sub_i32_thm #47
