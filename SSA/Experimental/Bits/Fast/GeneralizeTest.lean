import SSA.Experimental.Bits.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

#eval (0 ^^^ 33 ||| 7) ^^^ 12
#eval (0 ^^^ 33) ||| 7

variable {x y : BitVec 8}
#generalize (0#8 - x ||| y) + y = (y ||| 0#8 - x) + y --- PASSED add_or_sub_comb_i8_negative_y_sub_thm
#generalize (x ^^^ -1#8 ||| 7#8) ^^^ 12#8 = x &&& BitVec.ofInt 8 (-8) ^^^ BitVec.ofInt 8 (-13) --  PASSED not_or_xor_thm
#generalize (x ^^^ 33#8 ||| 7#8) ^^^ 12#8 = x &&& BitVec.ofInt 8 (-8) ^^^ 43#8 --- PASSED xor_or_xor_thm
#generalize  x ^^^ 33#8 ||| 7#8 = x &&& BitVec.ofInt 8 (-8) ^^^ 39#8 --- PASSED xor_or2_thm


#generalize x ^^^ 32#8 ||| 7#8 = x &&& BitVec.ofInt 8 (-8) ^^^ 39#8 --- xor_or_thm
#generalize (x ||| 33#8) ^^^ 12#8 ||| 7#8 = x &&& BitVec.ofInt 8 (-40) ^^^ 47#8 --- or_xor_or_thm
#generalize 28#8 >>> x <<< 3#8 ||| 7#8 = BitVec.ofInt 8 (-32) >>> x ||| 7#8 -- lshr_shl_demand1_thm

variable {x : BitVec 16}
#generalize BitVec.ofInt 16 (-32624) <<< x >>> 4#16 &&& 4094#16 = 2057#16 <<< x &&& 4094#16 -- shl_lshr_demand6_thm

variable {x y z: BitVec 32}
#generalize ((x <<< 8) >>> 16) <<< 8 = x &&& 0x00FFFF00 -- PASSED

#generalize (x &&& 32#32) + 145#32 ^^^ 153#32 = x &&& 32#32 ||| 8#32 -- gxor2_proof/test2_thm
#generalize (x + (-1)) >>> 1 = x >>> 1 -- #61223;
#generalize (x + 5) - (y + 1)  =  x - y + 4
#generalize (x + 5) + (y + 1)  =  x + y + 6
#generalize (x <<< 3) <<< 4 = x <<< 7
#generalize BitVec.zeroExtend 32 ((BitVec.truncate 16 x) <<< 8) = (x <<< 8) &&& 0xFF00#32
#generalize (x &&& 1 ||| (x  &&& 1 ||| (0#32 - x))) = x &&& (x - 1#32) -- #57351
#generalize (x &&& ((BitVec.ofInt 32 (-1)) <<< (32 - y))) >>> (32 - y) = x >>> (32 - y) -- SLOW and failing#41801


#generalize (x ||| 145#32) &&& 177#32 ^^^ 153#32 = x &&& 32#32 ||| 8#32 --- gxor2_proof/test3_thm
-- #generalize x * 42#32 ^^^ (y * 42#32 ^^^ z * 42#32) ||| z * 42#32 ^^^ x * 42#32 = z * 42#32 ^^^ x * 42#32 ||| y * 42#32 ---  or_xor_tree_1111_thm
#generalize x * 42#32 ^^^ (y * 42#32 ^^^ z * 42#32) ||| x * 42#32 ^^^ z * 42#32 = x * 42#32 ^^^ z * 42#32 ||| y * 42#32 -- or_xor_tree_1110_thm

-- #generalize ((x ^^^ 1234#32) >>> 8#32 ^^^ 1#32) + (x ^^^ 1234#32) = (x >>> 8#32 ^^^ 5#32) + (x ^^^ 1234#32) -- gxor2_proof/test5_thm
-- #generalize (x ^^^ y) &&& 1#32 ||| y &&& BitVec.ofInt 32 (-2) = x &&& 1#32 ^^^ y --- PASSED or_and_xor_not_constant_commute0_thm
#generalize x <<< 6#32 <<< 28#32 = 0#32   --shl_shl_thm
#generalize 1#32 <<< (31#32 - x) = BitVec.ofInt (32) (-2147483648) >>> x --  shl_sub_i32_thm
#generalize BitVec.truncate 24 (x >>> 12#32) <<< 3#24 = BitVec.truncate 24 (x >>> 9#32) &&& BitVec.ofInt 24 -- shl_trunc_bigger_ashr_thm
#generalize BitVec.truncate 8 (x >>> 5#32) <<< 3#8 = BitVec.truncate 8 (x >>> 2#32) &&& BitVec.ofInt 8 (-8) --- shl_trunc_bigger_lshr_thm
#generalize  ~~~(BitVec.zeroExtend 128 (BitVec.allOnes 64) <<< 64) = 0x0000000000000000ffffffffffffffff#128
