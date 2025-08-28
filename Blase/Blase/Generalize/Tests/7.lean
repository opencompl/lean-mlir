import Blase.Fast.Generalize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true

variable {x y : BitVec 8}
#generalize (0#8 - x ||| y) + x = (y ||| 0#8 - x) + x -- PASSED add_or_sub_comb_i8_negative_y_or_thm; #7
