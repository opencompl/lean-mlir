import Medusa

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
#generalize (x ||| 33#8) ^^^ 12#8 ||| 7#8 = x &&& BitVec.ofInt 8 (-40) ^^^ 47#8 --- or_xor_or_thm. #9
