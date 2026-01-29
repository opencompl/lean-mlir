import SSA.Projects.CIRCT.Register.Basic
import SSA.Projects.CIRCT.Stream.Basic

open HandshakeStream

def n_type (n : Nat) : Type := Stream' (Option (BitVec n))


def opt_type (n : Nat) : Type := Option (BitVec n)
def convertVecToStream : HVector n_type l -> Stream' (HVector opt_type l) := sorry
def convertStreamToVec : Stream' (HVector opt_type l) -> (HVector n_type l) := sorry


def output_const (input : HVector n_type [1]) : HVector n_type [1, 1] :=
  let hv := het_register_wrapper
              (ls := [1]) (lout := [1, 1])
              (inputs := convertVecToStream input)
              (init_regs := HVector.cons (some (1 : BitVec 1)) HVector.nil)
              (update_fun :=
                fun (inp, regs) =>
                  let e := (regs.get ⟨0, by simp⟩)
                  let i := (inp.get ⟨0, by simp⟩)
                  let updatedreg : HVector opt_type [1] := HVector.cons (inp.get ⟨0, by simp⟩) (HVector.nil)
                  match e, i with
                  | some e', some i' =>
                      let e'' := e'[0]
                      let i'' := i'[0]
                      let b := e''.and i''
                      let output : HVector opt_type [1, 1] := HVector.cons (some b) (HVector.cons (some true) HVector.nil)
                      ⟨updatedreg, output⟩
                  | _, _ =>
                    let output : HVector opt_type [1, 1] := HVector.cons (some false) (HVector.cons (some true) HVector.nil)
                    ⟨updatedreg, output⟩
              )
  convertStreamToVec hv

  -- it has a reg, which keeps the previous "ready" value of the sink
  -- it then outputs true, in the first spot of the HVector n_type [1, 1], if the value of the reg and the current input are true
  -- To output, you also have to set the second spot of HVector to true.

def sink (input : HVector n_type [1, 1]) : HVector n_type [1] := sorry
  -- register which flips between [true, true, false].
  -- the "ready" output should reflect the state of the register.
  -- it doesn't have to do anything with the inputs.

-- def complete_module := sorry -- implemented with `fix_wrapper`

-- Lift fix_wrapper to HVector
