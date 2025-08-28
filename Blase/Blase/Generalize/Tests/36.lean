import Blase.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
#generalize x >>> 5#8 ||| (y >>> 5#8 ||| BitVec.ofInt 8 (-58)) = (y ||| x) >>> 5#8 ||| BitVec.ofInt 8 (-58) --- PASSED gbinophandhshifts_proof/lshr_or_or_fail_thm; #36
