import SSA.Experimental.Bits.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 32}
#generalize ((x <<< 8) >>> 16) <<< 8 = x &&& 0x00FFFF00 -- PASSED #6

#eval (2 <<< 2) ^^^ 4
#eval 2 ^^^ 2
#eval ((152 >>> 2) >>> 4) <<< 2
#eval 152 &&& (((BitVec.ofInt 32 (-1) <<< 2) >>> 4) <<< 2)
