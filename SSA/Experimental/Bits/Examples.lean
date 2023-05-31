import SSA.Experimental.Bits.Decide
import SSA.Experimental.Bits.IR

open EDSL in

set_option maxHeartbeats 2000000 in
example : (Term.not (Term.not (Term.var 1))).eval = (Term.var 1).eval := by decide
