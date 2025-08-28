import Blase.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 67}
#generalize (x ||| y >>> 66#67) &&& 2#67 = x &&& 2#67 -- gapinthandhorhand_proof#test4_thm #22
