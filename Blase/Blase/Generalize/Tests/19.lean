import Blase.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize x + (x ||| (0 - x )) = x &&& (x + BitVec.ofInt 32 (-1)) -- #19
