import SSA.Projects.CIRCT.Register.Basic
import SSA.Projects.CIRCT.Stream.Basic


def n_type (n : Nat) : Type := Stream' (Option (BitVec n))

def output_const (input : HVector n_type [1]) : HVector n_type [1, 1] := sorry -- implemented via `reg_wrapper`
  -- it has a reg, which keeps the previous "ready" value of the sink
  -- it then outputs true, in the first spot of the HVector n_type [1, 1], if the value of the reg and the current input are true
  -- To output, you also have to set the second spot of HVector to true.

def sink (input : HVector n_type [1, 1]) : HVector n_type [1] := sorry
  -- register which flips between [true, true, false].
  -- the "ready" output should reflect the state of the register.
  -- it doesn't have to do anything with the inputs.

-- def complete_module := sorry -- implemented with `fix_wrapper`

-- Lift fix_wrapper to HVector
