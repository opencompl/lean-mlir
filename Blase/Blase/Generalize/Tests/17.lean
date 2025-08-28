import Blase.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 232}
#generalize x >>> 231#232 >>> 1#232 = 0#232 -- PASSED - lshr_lshr_thm; #17
