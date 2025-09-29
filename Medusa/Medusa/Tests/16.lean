import Medusa

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize 8#32 - x &&& 7#32 = 0#32 - x &&& 7#32 -- PASSED g2008h07h08hSubAnd_proof#a_thm #16
