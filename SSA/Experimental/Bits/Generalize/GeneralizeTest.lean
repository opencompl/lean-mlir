import SSA.Experimental.Bits.Generalize.Generalize

set_option trace.profiler true
set_option trace.Generalize true

set_option maxHeartbeats 1000000000000
set_option maxRecDepth 1000000


variable {x y z: BitVec 32}
#generalize ((x ^^^ 1234#32) >>> 8#32 ^^^ 1#32) + (x ^^^ 1234#32) = (x >>> 8#32 ^^^ 5#32) + (x ^^^ 1234#32) -- PASSED gxor2_proof/test5_thm; #18

variable {x y z: BitVec 64}
#generalize 0#64 - x + (0#64 - x &&& 1#64) = 0#64 - (x &&& BitVec.ofInt 64 (-2)) --- gand2_proof#test10_thm #46

variable {x y : BitVec 8}
#eval (1#8 ^^^ 1) ||| 0
#eval (1#8 ^^^ 1) ||| 0x3e#8
#generalize (0#8 - x ||| y) + y = (y ||| 0#8 - x) + y --- PASSED add_or_sub_comb_i8_negative_y_sub_thm; #1
#generalize (0#8 - x ||| y) + x = (y ||| 0#8 - x) + x -- PASSED add_or_sub_comb_i8_negative_y_or_thm; #7
#generalize (0#8 - x ^^^ x) + x = (x ^^^ 0#8 - x) + x -- PASSED add_or_sub_comb_i8_negative_xor_instead_or_thm; #20
#generalize (0#8 - x ||| x) + y = (x ||| 0#8 - x) + y -- PASSED  add_or_sub_comb_i8_negative_y_add_thm; #21
#generalize (x ^^^ -1#8 ||| 7#8) ^^^ 12#8 = x &&& BitVec.ofInt 8 (-8) ^^^ BitVec.ofInt 8 (-13) --  PASSED not_or_xor_thm; #5
#generalize (x ^^^ 33#8 ||| 7#8) ^^^ 12#8 = x &&& BitVec.ofInt 8 (-8) ^^^ 43#8 --- PASSED xor_or_xor_thm; #2
#generalize  x ^^^ 33#8 ||| 7#8 = x &&& BitVec.ofInt 8 (-8) ^^^ 39#8 --- PASSED xor_or2_thm; #3
#generalize x ^^^ 32#8 ||| 7#8 = x &&& BitVec.ofInt 8 (-8) ^^^ 39#8  ---PASSED; #4
#generalize x <<< 4#8 &&& (y <<< 5#8 &&& 88#8) = x <<< 4#8 &&& (y <<< 5#8 &&& 64#8) --- PASSED gbinophandhshifts_proof/ shl_and_and_fail_thm; #23
#generalize x >>> 5#8 ||| (y >>> 5#8 ||| BitVec.ofInt 8 (-58)) = (y ||| x) >>> 5#8 ||| BitVec.ofInt 8 (-58) --- PASSED gbinophandhshifts_proof/lshr_or_or_fail_thm; #36
#generalize x <<< 1#8 &&& y <<< 1#8 + 123#8 = (x &&& y + 61#8) <<< 1#8 ---PASSED gbinophandhshifts_proof/shl_add_and_thm; #28
#generalize x <<< 2#8 + (y <<< 2#8 + 48#8) = (y + x) <<< 2#8 + 48#8 ---  PASSED gbinophandhshifts_proof/shl_add_add_thm; #24
#generalize x <<< 1#8 ^^^ (y <<< 1#8 ^^^ 88#8) = (y ^^^ x) <<< 1#8 ^^^ 88#8 --- PASSED gbinophandhshifts_proof/shl_xor_xor_good_mask_thm; #25
#generalize x <<< 1#8 + (y <<< 1#8 &&& 119#8) = (x + (y &&& 59#8)) <<< 1#8 --- PASSED gbinophandhshifts_proof/shl_and_add_thm; #27
#generalize x <<< 1#8 ^^^ (y <<< 1#8 ^^^ BitVec.ofInt 8 (-68)) = (y ^^^ x) <<< 1#8 ^^^ BitVec.ofInt 8 (-68) ---PASSED gbinophandhshifts_proof/shl_xor_xor_bad_mask_distribute_thm; #26
#generalize x <<< 1#8 ^^^ y <<< 1#8 &&& 20#8 = (x ^^^ y &&& 10#8) <<< 1#8  --- PASSED gbinophandhshifts_proof/shl_and_xor_thm; #31
#generalize x <<< 7#8 ||| BitVec.ofInt 8 (-128) = BitVec.ofInt 8 (-128) -- PASSED gandhorand_proof/or_test2_thm; #35
#generalize x &&& 3#8 &&& 4#8 = 0#8 --PASSED gand_proof/test8_thm; #34
#generalize x ^^^ 5#8 ||| x ^^^ 5#8 ^^^ y = x ^^^ 5#8 ||| y -- PASSED gorhxor_proof/xor_common_op_commute2_thm; #33
#generalize x <<< 4#8 &&& (y <<< 4#8 &&& 88#8) = (y &&& x) <<< 4#8 &&& 80#8 ---PASSED  gbinophandhshifts_proof/shl_and_and_th; #37
#generalize (x <<< 3) <<< 4 = x <<< 7
#generalize (x >>> 5#8 ||| BitVec.ofInt 8 (-58)) &&& y >>> 5#8 = (y &&& (x ||| BitVec.ofInt 8 (-64))) >>> 5#8 --- gbinophandhshifts_proof/lshr_or_and_thm; #38
#generalize (x ||| 33#8) ^^^ 12#8 ||| 7#8 = x &&& BitVec.ofInt 8 (-40) ^^^ 47#8 --- or_xor_or_thm. #9


variable {x y : BitVec 9}
#generalize (x ^^^ y) &&& 42#9 ||| x &&& BitVec.ofInt 9 (-43) = y &&& 42#9 ^^^ x -- PASSED or_and_xor_not_constant_commute1_thm; #29

variable {x y z: BitVec 32}
#generalize (x ^^^ y) &&& 1#32 ||| y &&& BitVec.ofInt 32 (-2) = x &&& 1#32 ^^^ y --- PASSED or_and_xor_not_constant_commute0_thm #8
#generalize ((x <<< 8) >>> 16) <<< 8 = x &&& 0x00FFFF00 -- PASSED #6
#generalize (42#32 - x) <<< 3#32 = 336#32 - x <<< 3#32 -- PASSED gshlhsub_proof/shl_const_op1_sub_const_op0_thm; #11
#generalize ((x >>> 4#32 &&& 8#32) + y) <<< 4#32 = (x &&& 128#32) + y <<< 4#32 --#PASSED gshlhbo_proof/shl_add_and_lshr_thm; #12
#generalize (x + (y >>> 5#32 &&& 127#32)) <<< 5#32 = (y &&& 4064#32) + x <<< 5#32 --- PASSED gshlhbo_proof/lshr_add_and_shl_thm; #14
#generalize x + (x ||| (0 - x )) = x &&& (x + BitVec.ofInt 32 (-1)) -- #19
#generalize x <<< 6#32 <<< 28#32 = 0#32   -- PASSED ; shl_shl_thm #10
#generalize 8#32 - x &&& 7#32 = 0#32 - x &&& 7#32 -- PASSED g2008h07h08hSubAnd_proof#a_thm #16
#generalize x &&& 1#32 ||| 1#32 = 1#32 -- PASSED gandhorand_proof/or_test1_thm
#generalize (x ||| y <<< 1#32) &&& 1#32 = x &&& 1#32 --- PASSED gandhorand_proof/test3_thm; #30
#generalize (x + 5) - (y + 1)  =  x - y + 4
#generalize (x + 5) + (y + 1)  =  x + y + 6
#generalize (x <<< 10) <<< 14 = x <<< 24 --- #42

#generalize (x &&& 7#32 ||| y &&& 8#32) &&& 7#32 = x &&& 7#32 ---  gandhorand_proof/test1_thm; #39
#generalize (x ||| y >>> 31#32) &&& 2#32 = x &&& 2#32 ---  gandhorand_proof/test4_thm; #40
#generalize (x &&& 12#32 ^^^ 15#32) &&& 1#32 = 1#32 -- gand_proof/test10_thm; #41
#generalize ((x ^^^ 1234#32) >>> 8#32 ^^^ 1#32) + (x ^^^ 1234#32) = (x >>> 8#32 ^^^ 5#32) + (x ^^^ 1234#32) -- PASSED gxor2_proof/test5_thm; #18
#generalize 63#32 - (x &&& 31#32) = x &&& 31#32 ^^^ 63#32 -- gsubhxor_proof#low_mask_nsw_nuw_thm; #43
#generalize (x &&& 31#32 ^^^ 31#32) + 42#32 = 73#32 - (x &&& 31#32) -- gsubhxor_proof#xor_add_thm; #44
#generalize x <<< 3#32 &&& 15#32 ||| x <<< 5#32 &&& 60#32 = x <<< 3#32 &&& 8#32 ||| x <<< 5#32 &&& 32#32 -- gorhshiftedhmasks_proof#or_and_shifts1_thm; #50

variable {x y : BitVec 67}
#generalize (x ||| y >>> 66#67) &&& 2#67 = x &&& 2#67 -- gapinthandhorhand_proof#test4_thm #22

variable {x y z: BitVec 232}
#generalize x >>> 231#232 >>> 1#232 = 0#232 -- PASSED - gshifthshift_proof#lshr_lshr_thm; #17

-- Failing
variable {x y z: BitVec 8}
-- #generalize 28#8 >>> x <<< 3#8 ||| 7#8 = BitVec.ofInt 8 (-32) >>> x ||| 7#8 -- lshr_shl_demand1_thm. Can't generate precondition; #15
-- #generalize ((x ||| BitVec.ofInt 8 (-2)) ^^^ 13#8 ||| 1#8) ^^^ 12#8 = -1#8 -- Timeout gorhxor_proof/test23_thm #32
-- #generalize 40#8 <<< x >>> 3#8 ||| BitVec.ofInt 8 (-32) = 5#8 <<< x ||| BitVec.ofInt 8 (-32) -- gshiftshift_proof#shl_lshr_demand1_thm; #45



variable {x y z: BitVec 32}
#generalize 1#32 <<< (31#32 - x) = BitVec.ofInt 32 (-2147483648) >>> x ---- gshlhsub#shl_sub_i32_thm #47
#generalize BitVec.sshiftRight' (x &&& ((BitVec.ofInt 32 (-1)) <<< (32 - y))) (BitVec.ofInt 32 32 - y) = BitVec.sshiftRight' x (BitVec.ofInt 32 32 - y)  --#13
#generalize (x ||| 145#32) &&& 177#32 ^^^ 153#32 = x &&& 32#32 ||| 8#32 -- gxor2_proof#test3_thm; #48
#generalize (x &&& 7#32) <<< 3#32 ||| x <<< 2#32 &&& 28#32 = x <<< 3#32 &&& 56#32 ||| x <<< 2#32 &&& 28#32 -- gorhshiftedhmasks#or_and_shift_shift_and_thm #49
