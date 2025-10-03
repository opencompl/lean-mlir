import Medusa

variable {x y : BitVec 8}
#generalize (0#8 - x ||| y) + y = (y ||| 0#8 - x) + y -- PASSED add_or_sub_comb_i8_negative_y_sub_thm; #1

