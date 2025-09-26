import Medusa

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
#generalize 40#8 <<< x >>> 3#8 ||| BitVec.ofInt 8 (-32) = 5#8 <<< x ||| BitVec.ofInt 8 (-32) -- gshiftshift_proof#shl_lshr_demand1_thm; #45

