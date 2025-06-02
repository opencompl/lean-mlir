import SSA.Experimental.Bits.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
#generalize 2#8 <<< (x ||| 3#8) = 16#8 <<< x --  gshiftadd_proof#shl_fold_or_disjoint_cnt_thm; #46
