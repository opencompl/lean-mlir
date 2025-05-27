import SSA.Experimental.Bits.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
#generalize (0#8 - x ||| y) + y = (y ||| 0#8 - x) + y --- PASSED add_or_sub_comb_i8_negative_y_sub_thm
#generalize (0#8 - x ||| y) + x = (y ||| 0#8 - x) + x -- PASSED add_or_sub_comb_i8_negative_y_or_thm
#generalize (0#8 - x ^^^ x) + x = (x ^^^ 0#8 - x) + x -- PASSED add_or_sub_comb_i8_negative_xor_instead_or_thm
#generalize (0#8 - x ||| x) + y = (x ||| 0#8 - x) + y -- PASSED  add_or_sub_comb_i8_negative_y_add_thm
#generalize (x ^^^ -1#8 ||| 7#8) ^^^ 12#8 = x &&& BitVec.ofInt 8 (-8) ^^^ BitVec.ofInt 8 (-13) --  PASSED not_or_xor_thm
#generalize (x ^^^ 33#8 ||| 7#8) ^^^ 12#8 = x &&& BitVec.ofInt 8 (-8) ^^^ 43#8 --- PASSED xor_or_xor_thm
#generalize  x ^^^ 33#8 ||| 7#8 = x &&& BitVec.ofInt 8 (-8) ^^^ 39#8 --- PASSED xor_or2_thm
#generalize x ^^^ 32#8 ||| 7#8 = x &&& BitVec.ofInt 8 (-8) ^^^ 39#8  ---PASSED
#generalize x <<< 4#8 &&& (y <<< 5#8 &&& 88#8) = x <<< 4#8 &&& (y <<< 5#8 &&& 64#8) --- PASSED gbinophandhshifts_proof/ shl_and_and_fail_thm
#generalize x >>> 5#8 ||| (y >>> 5#8 ||| BitVec.ofInt 8 (-58)) = (y ||| x) >>> 5#8 ||| BitVec.ofInt 8 (-58) --- PASSED gbinophandhshifts_proof/lshr_or_or_fail_thm
#generalize x <<< 1#8 &&& y <<< 1#8 + 123#8 = (x &&& y + 61#8) <<< 1#8 ---PASSED gbinophandhshifts_proof/shl_add_and_thm
#generalize x <<< 2#8 + (y <<< 2#8 + 48#8) = (y + x) <<< 2#8 + 48#8 ---  PASSED gbinophandhshifts_proof/shl_add_add_thm
#generalize x <<< 1#8 ^^^ (y <<< 1#8 ^^^ 88#8) = (y ^^^ x) <<< 1#8 ^^^ 88#8 --- PASSED gbinophandhshifts_proof/shl_xor_xor_good_mask_thm
#generalize x <<< 1#8 + (y <<< 1#8 &&& 119#8) = (x + (y &&& 59#8)) <<< 1#8 --- PASSED gbinophandhshifts_proof/shl_and_add_thm
#generalize x <<< 1#8 ^^^ (y <<< 1#8 ^^^ BitVec.ofInt 8 (-68)) = (y ^^^ x) <<< 1#8 ^^^ BitVec.ofInt 8 (-68) ---PASSED gbinophandhshifts_proof/shl_xor_xor_bad_mask_distribute_thm
#generalize x <<< 1#8 ^^^ y <<< 1#8 &&& 20#8 = (x ^^^ y &&& 10#8) <<< 1#8  --- PASSED gbinophandhshifts_proof/shl_and_xor_thm
#generalize x <<< 7#8 ||| BitVec.ofInt 8 (-128) = BitVec.ofInt 8 (-128) -- PASSED gandhorand_proof/or_test2_thm
#generalize x &&& 3#8 &&& 4#8 = 0#8 --PASSED gand_proof/test8_thm
#generalize x ^^^ 5#8 ||| x ^^^ 5#8 ^^^ y = x ^^^ 5#8 ||| y -- PASSED gorhxor_proof/xor_common_op_commute2_thm
#generalize x <<< 4#8 &&& (y <<< 4#8 &&& 88#8) = (y &&& x) <<< 4#8 &&& 80#8 ---PASSED  gbinophandhshifts_proof/shl_and_and_th
#generalize (x <<< 3) <<< 4 = x <<< 7

-- -- Failing
#generalize (x >>> 5#8 ||| BitVec.ofInt 8 (-58)) &&& y >>> 5#8 = (y &&& (x ||| BitVec.ofInt 8 (-64))) >>> 5#8 --- gbinophandhshifts_proof/lshr_or_and_thm
#generalize (x ||| 33#8) ^^^ 12#8 ||| 7#8 = x &&& BitVec.ofInt 8 (-40) ^^^ 47#8 --- or_xor_or_thm. Can't generate precondition
#generalize 28#8 >>> x <<< 3#8 ||| 7#8 = BitVec.ofInt 8 (-32) >>> x ||| 7#8 -- lshr_shl_demand1_thm. Can't generate precondition
-- #generalize ((x ||| BitVec.ofInt 8 (-2)) ^^^ 13#8 ||| 1#8) ^^^ 12#8 = -1#8 -- PASSED but can take up to two hours to run due to the large amount of precondition sketches generated; gorhxor_proof/test23_thm


variable {x y : BitVec 9}
#generalize (x ^^^ y) &&& 42#9 ||| x &&& BitVec.ofInt 9 (-43) = y &&& 42#9 ^^^ x -- PASSED or_and_xor_not_constant_commute1_thm

variable {x y z: BitVec 32}
#generalize (x ^^^ y) &&& 1#32 ||| y &&& BitVec.ofInt 32 (-2) = x &&& 1#32 ^^^ y --- PASSED or_and_xor_not_constant_commute0_thm
#generalize ((x <<< 8) >>> 16) <<< 8 = x &&& 0x00FFFF00 -- PASSED
#generalize (42#32 - x) <<< 3#32 = 336#32 - x <<< 3#32 -- PASSED gshlhsub_proof/shl_const_op1_sub_const_op0_thm
#generalize ((x >>> 4#32 &&& 8#32) + y) <<< 4#32 = (x &&& 128#32) + y <<< 4#32 --#PASSED gshlhbo_proof/shl_add_and_lshr_thm
#generalize (x + (y >>> 5#32 &&& 127#32)) <<< 5#32 = (y &&& 4064#32) + x <<< 5#32 --- PASSED gshlhbo_proof/lshr_add_and_shl_thm
#generalize x <<< 6#32 <<< 28#32 = 0#32   -- PASSED ; shl_shl_thm
#generalize 8#32 - x &&& 7#32 = 0#32 - x &&& 7#32 -- PASSED g2008h07h08hSubAnd_proof#a_thm
#generalize x &&& 1#32 ||| 1#32 = 1#32 -- PASSED gandhorand_proof/or_test1_thm
#generalize (x ||| y <<< 1#32) &&& 1#32 = x &&& 1#32 --- PASSED gandhorand_proof/test3_thm
#generalize x + (x ||| (0 - x )) = x &&& (x + BitVec.ofInt 32 (-1))
#generalize (x + 5) - (y + 1)  =  x - y + 4
#generalize (x + 5) + (y + 1)  =  x + y + 6
#generalize (x <<< 3) <<< 4 = x <<< 7


-- Failing
-- #generalize BitVec.sshiftRight' (x &&& ((BitVec.ofInt 32 (-1)) <<< (32 - y))) (BitVec.ofInt 32 32 - y) = BitVec.sshiftRight' x (BitVec.ofInt 32 32 - y) -- Precondition synthesis failure #41801
-- #generalize ((x ^^^ 1234#32) >>> 8#32 ^^^ 1#32) + (x ^^^ 1234#32) = (x >>> 8#32 ^^^ 5#32) + (x ^^^ 1234#32) -- gxor2_proof/test5_thm -- Timeout

#generalize (x &&& 7#32 ||| y &&& 8#32) &&& 7#32 = x &&& 7#32 ---  gandhorand_proof/test1_thm
#generalize (x ||| y >>> 31#32) &&& 2#32 = x &&& 2#32 ---  gandhorand_proof/test4_thm
#generalize (x &&& 12#32 ^^^ 15#32) &&& 1#32 = 1#32 -- gand_proof/test10_thm
#generalize (x * x ^^^ y * y) &&& (x * x ||| y * y ^^^ -1#32) = x * x &&& (y * y ^^^ -1#32) -- and_orn_xor_commute8_thm

-- #generalize ((x ^^^ 1234#32) >>> 8#32 ^^^ 1#32) + (x ^^^ 1234#32) = (x >>> 8#32 ^^^ 5#32) + (x ^^^ 1234#32) -- gxor2_proof/test5_thm -- Timeout
-- #generalize BitVec.sshiftRight' (x &&& ((BitVec.ofInt 32 (-1)) <<< (32 - y))) (BitVec.ofInt 32 32 - y) = BitVec.sshiftRight' x (BitVec.ofInt 32 32 - y)

variable {x y z: BitVec 64}
#generalize x * x + (x * x ||| 0#64 - x * x) = x * x + -1#64 &&& x * x -- Passing but trivial result add_or_sub_comb_i64_commuted4_thm

variable {x y z: BitVec 232}
#generalize x >>> 231#232 >>> 1#232 = 0#232 -- PASSED - lshr_lshr_thm
