import Blase.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 64}
#generalize 0#64 - x + (0#64 - x &&& 1#64) = 0#64 - (x &&& BitVec.ofInt 64 (-2)) --- gand2_proof#test10_thm #46
