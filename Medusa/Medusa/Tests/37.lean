import Medusa

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
#generalize x <<< 4#8 &&& (y <<< 4#8 &&& 88#8) = (y &&& x) <<< 4#8 &&& 80#8 ---PASSED  gbinophandhshifts_proof/shl_and_and_th; #37
