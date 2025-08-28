import Blase.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
#generalize ((x ||| BitVec.ofInt 8 (-2)) ^^^ 13#8 ||| 1#8) ^^^ 12#8 = -1#8 -- Timeout gorhxor_proof/test23_thm #32
