import Blase.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize (x &&& 31#32 ^^^ 31#32) + 42#32 = 73#32 - (x &&& 31#32) -- gsubhxor_proof#xor_add_thm; #44
