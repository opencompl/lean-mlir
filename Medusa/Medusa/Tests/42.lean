import Medusa

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize (x <<< 10) <<< 14 = x <<< 24 --- #42 -- from Hydra paper
