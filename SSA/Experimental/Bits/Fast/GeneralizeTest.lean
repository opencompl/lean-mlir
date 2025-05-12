import SSA.Experimental.Bits.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
-- #generalize (0#8 - x ||| y) + y = (y ||| 0#8 - x) + y --- PASSED add_or_sub_comb_i8_negative_y_sub_thm
-- #generalize (x ^^^ -1#8 ||| 7#8) ^^^ 12#8 = x &&& BitVec.ofInt 8 (-8) ^^^ BitVec.ofInt 8 (-13) --  PASSED not_or_xor_thm
-- #generalize (x ^^^ 33#8 ||| 7#8) ^^^ 12#8 = x &&& BitVec.ofInt 8 (-8) ^^^ 43#8 --- PASSED xor_or_xor_thm
-- #generalize  x ^^^ 33#8 ||| 7#8 = x &&& BitVec.ofInt 8 (-8) ^^^ 39#8 --- PASSED xor_or2_thm
-- #generalize (x <<< 3) <<< 4 = x <<< 7

-- #generalize x ^^^ 32#8 ||| 7#8 = x &&& BitVec.ofInt 8 (-8) ^^^ 39#8 --- xor_or_thm. Can't generate precondition
-- #generalize (x ||| 33#8) ^^^ 12#8 ||| 7#8 = x &&& BitVec.ofInt 8 (-40) ^^^ 47#8 --- or_xor_or_thm. Can't generate precondition
-- #generalize 28#8 >>> x <<< 3#8 ||| 7#8 = BitVec.ofInt 8 (-32) >>> x ||| 7#8 -- lshr_shl_demand1_thm. Can't generate precondition

variable {x y z: BitVec 32}
-- #generalize (x ^^^ y) &&& 1#32 ||| y &&& BitVec.ofInt 32 (-2) = x &&& 1#32 ^^^ y --- PASSED or_and_xor_not_constant_commute0_thm
-- #generalize ((x <<< 8) >>> 16) <<< 8 = x &&& 0x00FFFF00 -- PASSED
-- #generalize (42#32 - x) <<< 3#32 = 336#32 - x <<< 3#32 -- PASSED gshlhsub_proof/shl_const_op1_sub_const_op0_thm
-- #generalize ((x >>> 4#32 &&& 8#32) + y) <<< 4#32 = (x &&& 128#32) + y <<< 4#32 --#PASSED gshlhbo_proof/shl_add_and_lshr_thm
-- #generalize (x + (y >>> 5#32 &&& 127#32)) <<< 5#32 = (y &&& 4064#32) + x <<< 5#32 --- PASSED gshlhbo_proof/lshr_add_and_shl_thm
-- #generalize x <<< 6#32 <<< 28#32 = 0#32   -- PASSED but takes seven minutes to run due to model counting; shl_shl_thm
 #generalize x + (x ||| (0 - x )) = x &&& (x + BitVec.ofInt 32 (-1))
-- #generalize (x + 5) - (y + 1)  =  x - y + 4
-- #generalize (x + 5) + (y + 1)  =  x + y + 6
-- #generalize (x <<< 3) <<< 4 = x <<< 7


-- Failing

-- #generalize 8#32 - x &&& 7#32 = 0#32 - x &&& 7#32 -- Precondition synthesis failure g2008h07h08hSubAnd_proof#a_thm --Can't generate preconditions
-- #generalize BitVec.sshiftRight' (x &&& ((BitVec.ofInt 32 (-1)) <<< (32 - y))) (BitVec.ofInt 32 32 - y) = BitVec.sshiftRight' x (BitVec.ofInt 32 32 - y) -- Precondition synthesis failure #41801

-- #generalize ((x ^^^ 1234#32) >>> 8#32 ^^^ 1#32) + (x ^^^ 1234#32) = (x >>> 8#32 ^^^ 5#32) + (x ^^^ 1234#32) -- gxor2_proof/test5_thm -- Timeout


 variable {x y z: BitVec 232}
 #generalize x >>> 231#232 >>> 1#232 = 0#232 -- PASSED - lshr_lshr_thm
