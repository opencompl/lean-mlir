import SSA.Projects.CIRCT.Stream.Basic
import SSA.Projects.CIRCT.Stream.Lemmas
import SSA.Projects.CIRCT.Register.Basic
import SSA.Projects.CIRCT.Register.Lemmas

namespace HWComponents

open HandshakeStream

def hw_constant (b : Bool) : BitVec 1 :=
  if b then 1#1 else 0#1

def comb_xor : BitVec 1 → BitVec 1 → BitVec 1 := BitVec.xor
def comb_and : BitVec 1 → BitVec 1 → BitVec 1 := BitVec.and
def comb_add : BitVec 32 → BitVec 32 → BitVec 32 := BitVec.add
def comb_or : BitVec 1 → BitVec 1 → BitVec 1 := BitVec.or

namespace TRY1

axiom esi_unwrap_vr : Stream (BitVec 32) → BitVec 1 → Stream (BitVec 32) × BitVec 1
axiom esi_wrap_vr : Stream (BitVec 32) → BitVec 1 → Stream (BitVec 32) × BitVec 1

/-
   This first implementation with all the "correct" types does not work because of the feedback between ready, valid and
   ESI stream construction.

   Instead, ESI streams need to be reasoned about at the meta-level.
 -/

#guard_msgs (drop error) in
def hw_fork_fails (_in0 : Stream (BitVec 32)) : Stream (BitVec 32) × Stream (BitVec 32) :=
  let _true := hw_constant true
  let _false := hw_constant false
  let _2 := comb_xor _emitted_0 _true
  let _3 := comb_and _2 _valid
  let _4 := comb_and _ready _3
  let _5 := comb_or _4 _emitted_0  -- done0
  let _8 := comb_xor emitted_1 _true
  let _9 := comb_and _8 _valid
  let _10 := comb_and _ready_1 _9
  let _11 := comb_or _10 _emitted_1 -- done1
  let _12 := comb_and _5 _11  -- allDone
  let (_rawOutput, _valid) := esi_unwrap_vr _in0 _12
  let (_chanOutput, _ready) := esi_wrap_vr _rawOutput _3
  let (_chanOutput_0, _ready_1) := esi_wrap_vr _rawOutput _9
  let _0 := comb_xor _12 _true
  let _1 := comb_and _5 _0
  let _6 := comb_xor _12 _true
  let _7 := comb_and _11 _6
  let _emitted_0 := seq_compreg _1
  let _emitted_1 := seq_compreg _7
  (_chanOutput, _chanOutput_0)

end TRY1

namespace TRY2

/-
   Criteria: we assume that there are infinite buffers at the input and output.
   + This implies that ready == 1.
   + This also implies that the input stream can be delayed infinitely long.

   Under this assumption, we do not really need the registers, because we will instantly emit a value, and the registers
   will be constant true.

  This spec is not the same as the hw implementation, unless we have a guarantee that
  a `rdy` signal is received (no deadlock).
 -/

def hw_fork (_in0 : Stream (BitVec 32)) : Stream (BitVec 32) × Stream (BitVec 32) :=
  (_in0, _in0)

end TRY2

namespace TRY3

/-
   Criteria: we assume that valid signals are given by the stream, and that ready signals are given by nondeterministic
   booleans.
   If ready signals have to obey a property, it might be that once they are set, they cannot be unset.  This is until a
   value is emitted.

   Now registers are meaningful, however, the question becomes:
   1. How do we compose two of these functions. (...some time later: I guess we can)
   2. How do we model the nondeterministic signals (...some time later: we don't have to, we just expose them as streams)
 -/

def hw_fork (_ready _ready_1 _valid : Stream' (BitVec 1)) (_in0 : Stream' (BitVec 32))
    : Stream' ( BitVec 1  -- ready (_12)
              × BitVec 1  -- valid_0 (_3)
              × BitVec 1  -- valid_1 (_9)
              × BitVec 32 -- rawOutput
              × BitVec 32 -- rawOutput
      )
  :=
  Stream'.corec' (α := Nat × BitVec 1 × BitVec 1) (fun (i, _emitted_0, _emitted_1) =>
    let _true := hw_constant true
    let _false := hw_constant false
    let _2 := comb_xor _emitted_0 _true
    let _3 := comb_and _2 (_valid i)
    let _4 := comb_and (_ready i) _3
    let _5 := comb_or _4 _emitted_0   -- done0
    let _8 := comb_xor _emitted_1 _true
    let _9 := comb_and _8 (_valid i)
    let _10 := comb_and (_ready_1 i) _9
    let _11 := comb_or _10 _emitted_1 -- done1
    let _12 := comb_and _5 _11        -- allDone
    let _rawOutput := _in0 i
    let _0 := comb_xor _12 _true
    let _1 := comb_and _5 _0
    let _6 := comb_xor _12 _true
    let _7 := comb_and _11 _6
    ((_12, _3, _9, _rawOutput, _rawOutput), (i+1, _1, _7))
  ) (0, 0#1, 0#1)

/-
 - %0 = comb.and %in0_valid, %in1_valid : i1
 - %1 = comb.and %out0_ready, %0 : i1
 - %2 = comb.add %in0, %in1 : i64
 - hw.output %1, %1, %2, %0 : i1, i1, i64, i1
 -/
def hw_add
    (_in0_valid _in1_valid _out0_ready : Stream' (BitVec 1))
    (_in0 _in1 : Stream' (BitVec 32))
    : Stream' ( BitVec 1  -- %in0_ready
              × BitVec 1  -- %in1_ready
              × BitVec 1  -- %out0_valid
              × BitVec 32 -- %out0
      )
  :=
  Stream'.corec' (α := Nat) (fun i =>
    let _0 := comb_and (_in0_valid i) (_in1_valid i)
    let _1 := comb_and (_out0_ready i) _0
    let _2 := comb_add (_in0 i) (_in1 i)
    ((_1, _1, _0, _2), i+1)
  ) 0

def split_stream : Stream' (a × b × c × d) → Stream' a × Stream' b × Stream' c × Stream' d := fun g =>
  (fun i => (g i).1, fun i => (g i).2.1, fun i => (g i).2.2.1, fun i => (g i).2.2.2)

def split_stream2 : Stream' (a × b × c × d × e) → Stream' a × Stream' b × Stream' c × Stream' d × Stream' e := fun g =>
  (fun i => (g i).1, fun i => (g i).2.1, fun i => (g i).2.2.1, fun i => (g i).2.2.2.1, fun i => (g i).2.2.2.2)

def combine_stream : Stream' a × Stream' b × Stream' c × Stream' d × Stream' e × Stream' f × Stream' g → Stream' (a × b × c × d × e × f × g) := fun gr i =>
  (gr.1 i, gr.2.1 i, gr.2.2.1 i, gr.2.2.2.1 i, gr.2.2.2.2.1 i, gr.2.2.2.2.2.1 i, gr.2.2.2.2.2.2 i)


/--
We have a working circuit, except that we took out the feedback into and output and an input.

`fork_i_rdy -> add_out_rdy`
-/
def hw_add_fork af_a_valid af_b_valid af_a af_b af_o_rdy af_p_rdy add_out_rdy :=
  let add_a_valid := af_a_valid
  let add_b_valid := af_b_valid
  let add_a := af_a
  let add_b := af_b
  let (add_a_rdy, add_b_rdy, add_out_valid, add_out) := split_stream <| hw_add add_a_valid add_b_valid add_out_rdy add_a add_b
  let fork_i_valid := add_out_valid
  let fork_i := add_out
  let fork_o_rdy := af_o_rdy
  let fork_p_rdy := af_p_rdy
  let (fork_i_rdy, fork_o_valid, fork_p_valid, fork_o, fork_p) := split_stream2 <| hw_fork fork_o_rdy fork_p_rdy fork_i_valid fork_i
  combine_stream <| (fork_o_valid, fork_p_valid, fork_o, fork_p, add_a_rdy, add_b_rdy, fork_i_rdy)

/--
The assumption is that you always converge in 2 steps, so this should faithfully implement add -> fork
-/
def hw_add_fork_fix af_a_valid af_b_valid af_a af_b af_o_rdy af_p_rdy :=
  let x := hw_add_fork af_a_valid af_b_valid af_a af_b af_o_rdy af_p_rdy (Stream'.const 0)
  let x := hw_add_fork af_a_valid af_b_valid af_a af_b af_o_rdy af_p_rdy (fun i => (x i).2.2.2.2.2.2)
  fun i => ((x i).1, (x i).2.1, (x i).2.2.1, (x i).2.2.2.1, (x i).2.2.2.2.1, (x i).2.2.2.2.2.1, (x i).2.2.2.2.2.2.1)

def cyc {α} (l : List α) (h := by simp) := Stream'.cycle l h

/-
We can stabilise with two iterations:

+ We set `add_out_rdy` to some arbitrary value.
+ We check the value of `fork_i_rdy`.
+ We set `add_out_rdy` to that value, and check if `add_out_rdy` now equals `fork_i_rdy`.
-/

#eval Stream'.take 3 <| hw_add_fork_fix (cyc [0, 0, 1]) (cyc [0, 1, 1]) (cyc [11, 12, 13]) (cyc [21, 22, 23]) (cyc [1]) (cyc [1])
#eval Stream'.take 3 <| hw_add_fork_fix (cyc [0, 0, 1]) (cyc [0, 1, 1]) (cyc [11, 12, 13]) (cyc [21, 22, 23]) (cyc [0, 0, 1]) (cyc [0, 0, 1])
/- #eval Stream'.take 1 <| hw_add_fork_fix (cyc [1]) (cyc [1]) (cyc [10]) (cyc [20]) (cyc [1]) (cyc [1])
 - #eval Stream'.take 1 <| hw_add_fork_fix (cyc [1]) (cyc [1]) (cyc [10]) (cyc [20]) (cyc [1]) (cyc [1])
 - #eval Stream'.take 1 <| hw_add_fork_fix (cyc [1]) (cyc [1]) (cyc [10]) (cyc [20]) (cyc [1]) (cyc [1]) -/

end TRY3

/-! We need two proofs:
  · handshake fork ~ delayed fork (for some non deterministic delay)
  · delayed fork ~ normal fork
-/

/-- At the handshake level: (manual) delayed fork ~ normal fork: the outputs of the fork are bisimilar
  for any delay (up to any numbers of `none` inserted, anywhere). -/
theorem fork_refines {a x y x' y'} :
  (x, y) = TRY2.hw_fork a →
  x ~ x' →
  y ~ y' →
  x ~ x' ∧ y ~ y' := by grind

/-- Stream := Stream' (Option α) -/
def toStream {α} (rdy : Stream' (BitVec 1)) (vld : Stream' (BitVec 1)) (data : Stream' α) : Stream α := fun i =>
  if rdy i == 1#1 && vld i == 1#1 then
    .some (data i)
  else
    .none

/- the standard implementation of the fork refines the handshake fork (`TRY2.hw_fork`) -/

/-- weaker def where we do not assume that rdy is by default 0#1 -/
def globallyValidUntilReady (vld rdy : Stream' (BitVec 1)) : Prop :=
    ∀ (i : Nat),
        (vld i = 1#1) →
      ∃ (k : Nat),
        rdy (i + k) = 1#1 ∧ vld (i + k) = 1#1 ∧
        ∀ (j : Nat) (_hj : j < k),
          vld (i + j) = 1#1

/-- This def is stronger than the one above -/
def globallyValidUntilReady' (vld rdy : Stream' (BitVec 1)) : Prop :=
    ∀ (i : Nat),
        (vld i = 1#1) →
      ∃ (k : Nat),
        rdy (i + k) = 1#1 ∧ vld (i + k) = 1#1 ∧
        ∀ (j : Nat) (_hj : j < k),
          vld (i + j) = 1#1 ∧ rdy (i + j) = 0#1
          -- we should add sth like vld (i + k + 1) = 0#1?

def globallyValidAndData (vld : Stream' (BitVec 1)) (data : Stream' (BitVec w)) : Prop :=
    ∀ (i : Nat),
        (vld i = 1#1 ∧ vld (i + 1) = 1#1) →
        data i = data (i + 1)

def relation : Stream (BitVec w) → Stream (BitVec w) → Prop := fun x y =>
    ∃ (rd1 vld1 : Stream' (BitVec 1)) (data1 : Stream' (BitVec w))
      (rd2 vld2 : Stream' (BitVec 1)) (data2 : Stream' (BitVec w)),
    x = toStream rd1 vld1 data1 ∧
    globallyValidUntilReady rd1 vld1 ∧
    globallyValidAndData vld1 data1 ∧
    y = toStream rd2 vld2 data2 ∧
    globallyValidUntilReady rd2 vld2 ∧
    globallyValidAndData vld2 data2
    /- we need to say something about `x` and `y`. -/

/-- G(F(val = 1))-/
def globallyFinallyReady (x : Stream' (BitVec 1)) :=
  ∀ (i : Nat),
    ∃ (k : Nat),
      x (i + k) = 1#1

/-
  our implementation of `fork` should not allow this, assuming that the input is
  well-formed (including its ready signals!).

  val1 =  1 1 1
  data1 = 2 3 4
  rd1 =   1 1 1
  out1:   2 3 4

  val2 =  1 1 1
  data2 = 2 3 4
  rd2 =   0 1 1
  out2:   - 3 4

-/


/-- the standard implementation of the fork refines the handshake fork (`TRY2.hw_fork`) -/
theorem hw_fork_refines1:
    /- Given a handshake fork taking `a` as input and returning `(a, a)`, we take
      its lowering (with input a bisimilar ready-valid wrapped stream) -/
    (rdy, vld1, vld2, o1, o2) = TRY3.split_stream2 (TRY3.hw_fork rd1 rd2 vld i) →
    /- We want to make sure that stalling is correctly modeled for `a` (input).
      We constrain the input and prove that if the input behaves properly,
      the output will. -/
    globallyValidUntilReady vld rdy →
    globallyValidAndData vld data →
    /- we assume no deadlock -/
    globallyFinallyReady rd1 →
    globallyFinallyReady rd2 →
    /- if we know that the hshake input stream is bisimilar to the ready-valid input of the hw fork (`a ~ rdy vld i`), meaning that the two outputs are also bisimilar by transitivity-/
    /- we want to prove that the outputs of the handshake fork are respectively
      bisimilar to the ready-valid wrapping of the output of the hardware fork -/
    (toStream rd1 vld1 o1) ~ (toStream rdy vld data) := by
  intros hardware_hw
  unfold Bisim

  sorry

/-- the standard implementation of the fork refines the handshake fork (`TRY2.hw_fork`) -/
theorem hw_fork_refines2:
    /- Given a handshake fork taking `a` as input and returning `(a, a)`, we take
      its lowering (with input a bisimilar ready-valid wrapped stream) -/
    (rdy, vld1, vld2, o1, o2) = TRY3.split_stream2 (TRY3.hw_fork rd1 rd2 vld i) →
    /- We want to make sure that stalling is correctly modeled for `a` (input).
      We constrain the input and prove that if the input behaves properly,
      the output will. -/
    globallyValidUntilReady vld rdy →
    globallyValidAndData vld data →
    /- we assume no deadlock -/
    globallyFinallyReady rd1 →
    globallyFinallyReady rd2 →
    /- if we know that the hshake input stream is bisimilar to the ready-valid input of the hw fork (`a ~ rdy vld i`), meaning that the two outputs are also bisimilar by transitivity-/
    /- we want to prove that the outputs of the handshake fork are respectively
      bisimilar to the ready-valid wrapping of the output of the hardware fork -/
    (toStream rd2 vld2 o2) ~ (toStream rdy vld data) := by
  intros hardware_hw globValReady globValData globFinReady1 globFinReady2
  unfold Bisim
  simp
  unfold globallyValidUntilReady at globValReady
  unfold globallyValidAndData at globValData
  unfold globallyFinallyReady at globFinReady1 globFinReady2
  unfold TRY3.split_stream2 at hardware_hw
  simp at hardware_hw
  obtain ⟨hready, hvld1, hvld2, ho1, ho2⟩ := hardware_hw
  exists 0, 0
  simp
  and_intros
  · apply Bisim.coinduct (pred := Eq)
    · intros x y hxy
      rw [hxy]
      exists 0, 0
      simp
    · specialize globFinReady1 0

      sorry
  ·
    sorry

theorem trans' {a b : Stream α} : a ~ b → a ~ c → b ~ c := by
  intros hab hbc
  sorry


theorem hw_fork_refines':
    /- Given a handshake fork -/
    (x, y) = TRY2.hw_fork a →
    /- we get the output of the corresponding lowered fork -/
    (rdy, vld1, vld2, o1, o2) = TRY3.split_stream2 (a := BitVec 1) (TRY3.hw_fork rd1 rd2 vld data) →
    /- if we know that the hshake input stream is bisimilar to the ready-valid input of the hw fork -/
    a ~ (toStream rdy vld data) →
    /- We want to make sure that stalling is correctly modeled for `a` (input).
      We constrain the input and prove that if the input behaves properly,
      the output will. -/
    globallyValidUntilReady vld rdy →
    globallyValidAndData vld data →
    /- we assume no deadlock -/
    globallyFinallyReady rd1 →
    globallyFinallyReady rd2 →
    /- we want to prove that the outputs of the handshake fork are respectively
      bisimilar to the ready-valid wrapping of the output of the hardware fork -/
    x ~ (toStream rd1 vld1 o1) ∧ y ~ (toStream rd2 vld2 o2) := by
  intros handshake_fork hardware_fork inputs_bisim valready_ valdata_a finready1 finready2
  · unfold TRY2.hw_fork at handshake_fork
    have heq : x = a := by
      simp at handshake_fork
      exact handshake_fork.1
    have heq' : y = a := by
      simp at handshake_fork
      exact handshake_fork.2
    rw [heq, heq']
    and_intros
    · apply trans'
      symm; assumption
      symm; apply hw_fork_refines1
      all_goals assumption
    · apply trans'
      symm; assumption
      symm; apply hw_fork_refines2
      all_goals assumption

end HWComponents
