import Medusa

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
#generalize x <<< 7#8 ||| BitVec.ofInt 8 (-128) = BitVec.ofInt 8 (-128) -- PASSED gandhorand_proof/or_test2_thm; #35
