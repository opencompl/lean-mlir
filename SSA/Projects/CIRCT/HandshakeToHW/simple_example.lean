import SSA.Projects.CIRCT.Register.Basic
import SSA.Projects.CIRCT.Stream.Basic

open HandshakeStream

def streams_to_vec' {α : Type u} {n : Nat} (xv : Vector (Stream' α) n) : Stream' (Vector α n) :=
  /- `map` applies `fun (s : Stream' α) => s i` to every element in `xv` -/
  fun (i : Nat) => xv.map (fun (s : Stream' α) => s i)

-- /--
--   Map the `i`-th element of stream `s` in `xv` to the output heterogeneous vector, using `Stream'`.
-- -/
-- def streams'_to_hvec {α : Type u} {n : Nat} (xv : HVector f lin) : Stream' (HVector f lin) :=
--   /- `map` applies `fun (s : Stream' α) => s i` to every element in `xv` -/
--   fun (f, lin) => xv.map (fun (s : Stream' α) => s i)

/--
  Map each element at the `k`-th position of `xv` to the `k`-th stream of the output, using `Stream'`.
-/
def vec_to_streams' {α : Type u} {n : Nat} (xv : Stream' (Vector α n)) : Vector (Stream' α) n :=
  /- `.ofFn` creates a vector with `n` elements (for each `k` from `0` to `n - 1`),
      where each element is a stream `fun (i : Nat) => ...` containing the `k`-th element of the
      `i`-th element of stream `xv`.
  -/
  Vector.ofFn (fun (k : Fin n) => fun (i : Nat) => (xv i).get k)



def n_type (n : Nat) : Type := Stream' (Option (BitVec n))


def opt_type (n : Nat) : Type := Option (BitVec n)


def convertVecToStream {l : List Nat} (xv : HVector n_type l) : Stream' (HVector opt_type l) :=
  fun (i : Nat) =>
    xv.map (fun {n : Nat} (s : n_type n) => s i)

def convertStreamToVec {l : List Nat} (xv : Stream' (HVector opt_type l)) : HVector n_type l :=
  HVector.ofFn n_type l (fun (k : Fin l.length) => fun (i : Nat) => (xv i).get k)

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


def het_fix_wrapper (fuel : Nat) (s : Stream' (HVector opt_type l)) (f : Stream' (HVector opt_type l) → Stream' (HVector opt_type l)) :
    Stream' (HVector opt_type l) :=
  match fuel with
  | 0 => s
  | n+1 => het_fix_wrapper n (f s) f

def het_fix_wrapper_single (fuel : Nat) (s : HVector opt_type l) (f : HVector opt_type l → HVector opt_type l) : (HVector opt_type l) :=
  match fuel with
  | 0 => s
  | n+1 => het_fix_wrapper_single n (f s) f

def compute_module' (input : Stream' (HVector opt_type [1])) : Stream' (HVector opt_type [1]) :=
  let inputStream := convertStreamToVec input
  let const_outs := output_const inputStream
  convertVecToStream <| sink const_outs

/- def compute_module_single' (input : Stream' (HVector opt_type [1])) : Stream' (HVector opt_type [1]) :=
  let inputStream := convertStreamToVec input
  let const_outs := output_const inputStream
  let sink_outs := sink const_outs
  convertVecToStream <| (Stream'.map (het_fix_wrapper_single 100 (f := ??)) sink_outs) -/

def complete_module :=
  het_fix_wrapper 10 (fun _ => .cons .none <| .nil) compute_module'


instance : ToString (Stream' (HVector opt_type [1])) where
  toString s :=
    Id.run do
      let mut result := ""
      for i in [0:4] do
        let elm := s.get i
        let elm' := elm.get ⟨0, by simp⟩
        let l := elm'.toList
        for j in [0:l.length] do
          result := result ++ toString l[j]! ++ "\n"
      return result

#eval complete_module
