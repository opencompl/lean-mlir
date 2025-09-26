
import Medusa

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true


variable {x y : BitVec 8}
#generalize (x ^^^ 33#8 ||| 7#8) ^^^ 12#8 = x &&& BitVec.ofInt 8 (-8) ^^^ 43#8 --- PASSED xor_or_xor_thm; #2
