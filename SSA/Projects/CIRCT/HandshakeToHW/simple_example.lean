import SSA.Projects.CIRCT.Register.Basic
import SSA.Projects.CIRCT.Stream.Basic

open HandshakeStream

def n_type (n : Nat) : Type := Stream' (Option (BitVec n))


def opt_type (n : Nat) : Type := Option (BitVec n)
def convertVecToStream : HVector n_type l -> Stream' (HVector opt_type l) := sorry
def convertStreamToVec : Stream' (HVector opt_type l) -> (HVector n_type l) := sorry

/--
  A module with a register that keeps the stores the "ready" value and outputs a couple where:
  · the first element is true if the value of the register and the current input are true
  · the second element is true
-/
def output_const (input : HVector n_type [1]) : HVector n_type [1, 1] :=
  let hv := het_register_wrapper
              (ls := [1]) (lout := [1, 1])
              (inputs := convertVecToStream input)
              (init_regs := HVector.cons (some true) HVector.nil)
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
                    ⟨updatedreg, output⟩)
  convertStreamToVec hv



/--
  A module with a register that flips between [true, false].
  The "ready" output should reflect the state of the register.
  It doesn't have to do anything with the inputs.
-/
def sink (input : HVector n_type [1, 1]) : HVector n_type [1] :=
    let values := [true, true, false]
    let hv := het_register_wrapper
              (ls := [1]) (lout := [1])
              (inputs := convertVecToStream input)
              (init_regs := HVector.cons (some true) HVector.nil)
              (update_fun :=
                fun (inp, regs) =>
                  let e := (regs.get ⟨0, by simp⟩)
                  match e with
                  | some e' =>
                    if e'[0] = true then
                      /- TODO: Luisa could not find a way to make it flip [true, true, false] -/
                      let output : HVector opt_type [1] := HVector.cons (some true) HVector.nil
                      let updatedreg : HVector opt_type [1] := HVector.cons (some false) HVector.nil
                      ⟨updatedreg, output⟩
                    else
                      let output : HVector opt_type [1] := HVector.cons (some false) HVector.nil
                      let updatedreg : HVector opt_type [1] := HVector.cons (some true) HVector.nil
                      ⟨updatedreg, output⟩
                  | none =>
                    let output : HVector opt_type [1] := HVector.cons none HVector.nil
                    let updatedreg : HVector opt_type [1] := HVector.cons none HVector.nil
                    ⟨updatedreg, output⟩)
    convertStreamToVec hv

def het_fix_wrapper (s : HVector n_type l) (f : HVector opt_type l → HVector opt_type l) :
    Option (HVector n_type l) := sorry


def complete_module (input : HVector n_type [1]) :=
  let const_module := output_const input
  let sink_module := sink const_module
  het_fix_wrapper sink_module id
