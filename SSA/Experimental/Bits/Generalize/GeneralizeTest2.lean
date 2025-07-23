
---- Failing Tests
import SSA.Experimental.Bits.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true


variable {x y : BitVec 32}

#generalize (x &&& 32#32) + 145#32 ^^^ 153#32 = x &&& 32#32 ||| 8#32 -- gxor2_proof#test2_thm
#generalize (x * 65537#32) >>> 16#32 = x -- glshr_proof#mul_splat_fold_thm
#generalize 1#32 <<< (31#32 - x) = BitVec.ofInt 32 (-2147483648) >>> x -- gshlhsub_proof#shl_sub_i32_thm
#generalize (x &&& 7#32) <<< 3#32 ||| x <<< 2#32 &&& 28#32 = x <<< 3#32 &&& 56#32 ||| x <<< 2#32 &&& 28#32 -- gorhshiftedhmasks_proof#or_and_shift_shift_and_thm


variable {x y : BitVec 64}
#generalize 1#64 <<< (63#64 - x) = BitVec.ofInt 64 (-9223372036854775808) >>> x --  gshlhsub_proof#shl_sub_i64_thm
