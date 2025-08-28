import Blase.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
#generalize x <<< 1#8 ^^^ (y <<< 1#8 ^^^ BitVec.ofInt 8 (-68)) = (y ^^^ x) <<< 1#8 ^^^ BitVec.ofInt 8 (-68) ---PASSED gbinophandhshifts_proof/shl_xor_xor_bad_mask_distribute_thm; #26
