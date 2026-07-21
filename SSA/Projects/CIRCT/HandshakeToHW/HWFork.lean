import SSA.Projects.CIRCT.Stream.Basic
import SSA.Projects.CIRCT.Stream.Lemmas
import SSA.Projects.CIRCT.Register.Basic
import SSA.Projects.CIRCT.Register.Lemmas

namespace HWComponents

open HandshakeStream

/-
  RTL-level definitions of circuit components
-/
@[bv_normalize, grind]
def hw_constant (b : Bool) : BitVec 1 := if b then 1#1 else 0#1

@[bv_normalize, grind]
def comb_xor (x y : BitVec 1) : BitVec 1 := BitVec.xor x y

@[bv_normalize, grind]
def comb_and (x y : BitVec 1) : BitVec 1 := BitVec.and x y

@[bv_normalize, grind]
def comb_add (x y : BitVec w) : BitVec w := BitVec.add x y

@[bv_normalize, grind]
def comb_or (x y : BitVec 1) : BitVec 1 := BitVec.or x y

namespace TRY1

axiom esi_unwrap_vr : Stream (BitVec w) → BitVec 1 → Stream (BitVec w) × BitVec 1
axiom esi_wrap_vr : Stream (BitVec w) → BitVec 1 → Stream (BitVec w) × BitVec 1

/-
   This first implementation with all the "correct" types does not work because of the feedback between ready, valid and
   ESI stream construction.

   Instead, ESI streams need to be reasoned about at the meta-level.
 -/

#guard_msgs (drop error) in
def hw_fork_fails (_in0 : Stream (BitVec w)) : Stream (BitVec w) × Stream (BitVec w) :=
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

def hw_fork (_in0 : Stream (BitVec w)) : Stream (BitVec w) × Stream (BitVec w) :=
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

def hw_fork (_ready _ready_1 _valid : Stream' (BitVec 1)) (_in0 : Stream' (BitVec w))
    : Stream' ( BitVec 1  -- ready (_12)
              × BitVec 1  -- valid_0 (_3)
              × BitVec 1  -- valid_1 (_9)
              × BitVec w -- rawOutput
              × BitVec w -- rawOutput
      )
  :=
  Stream'.corec' (α := Nat × BitVec 1 × BitVec 1) (fun (i, e1, e2) =>
    let _true := hw_constant true
    let _false := hw_constant false
    let _2 := comb_xor e1 _true
    let val1 := comb_and _2 (_valid i)
    let fire1 := comb_and (_ready i) val1
    let done1 := comb_or fire1 e1   -- done0
    let _8 := comb_xor e2 _true
    let val2 := comb_and _8 (_valid i)
    let fire2 := comb_and (_ready_1 i) val2
    let done2 := comb_or fire2 e2 -- done1
    let allDone := comb_and done1 done2        -- allDone
    let out := _in0 i
    let _0 := comb_xor allDone _true
    let e1Next := comb_and done1 _0
    let _6 := comb_xor allDone _true
    let e2Next := comb_and done2 _6
    ((allDone, val1, val2, out, out), (i + 1, e1Next, e2Next))
  ) (0, 0#1, 0#1)


/-
 - %0 = comb.and %in0_valid, %in1_valid : i1
 - %1 = comb.and %out0_ready, %0 : i1
 - %2 = comb.add %in0, %in1 : i64
 - hw.output %1, %1, %2, %0 : i1, i1, i64, i1
 -/
def hw_add
    (_in0_valid _in1_valid _out0_ready : Stream' (BitVec 1))
    (_in0 _in1 : Stream' (BitVec w))
    : Stream' ( BitVec 1  -- %in0_ready
              × BitVec 1  -- %in1_ready
              × BitVec 1  -- %out0_valid
              × BitVec w -- %out0
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

/-
We have a working circuit, except that we took out the feedback into and output and an input.

`fork_i_rdy -> add_out_rdy`
-/
-- def hw_add_fork af_a_valid af_b_valid af_a af_b af_o_rdy af_p_rdy add_out_rdy :=
--   let add_a_valid := af_a_valid
--   let add_b_valid := af_b_valid
--   let add_a := af_a
--   let add_b := af_b
--   let (add_a_rdy, add_b_rdy, add_out_valid, add_out) := split_stream <| hw_add add_a_valid add_b_valid add_out_rdy add_a add_b
--   let fork_i_valid := add_out_valid
--   let fork_i := add_out
--   let fork_o_rdy := af_o_rdy
--   let fork_p_rdy := af_p_rdy
--   let (fork_i_rdy, fork_o_valid, fork_p_valid, fork_o, fork_p) := split_stream2 <| hw_fork fork_o_rdy fork_p_rdy fork_i_valid fork_i
--   combine_stream <| (fork_o_valid, fork_p_valid, fork_o, fork_p, add_a_rdy, add_b_rdy, fork_i_rdy)

/--
The assumption is that you always converge in 2 steps, so this should faithfully implement add -> fork
-/
-- def hw_add_fork_fix af_a_valid af_b_valid af_a af_b af_o_rdy af_p_rdy :=
--   let x := hw_add_fork af_a_valid af_b_valid af_a af_b af_o_rdy af_p_rdy (Stream'.const 0)
--   let x := hw_add_fork af_a_valid af_b_valid af_a af_b af_o_rdy af_p_rdy (fun i => (x i).2.2.2.2.2.2)
--   fun i => ((x i).1, (x i).2.1, (x i).2.2.1, (x i).2.2.2.1, (x i).2.2.2.2.1, (x i).2.2.2.2.2.1, (x i).2.2.2.2.2.2.1)

def cyc {α} (l : List α) (h := by simp) := Stream'.cycle l h

/-
We can stabilise with two iterations:

+ We set `add_out_rdy` to some arbitrary value.
+ We check the value of `fork_i_rdy`.
+ We set `add_out_rdy` to that value, and check if `add_out_rdy` now equals `fork_i_rdy`.
-/

-- #eval Stream'.take 3 <| hw_add_fork_fix (cyc [0, 0, 1]) (cyc [0, 1, 1]) (cyc [11, 12, 13]) (cyc [21, 22, 23]) (cyc [1]) (cyc [1])
-- #eval Stream'.take 3 <| hw_add_fork_fix (cyc [0, 0, 1]) (cyc [0, 1, 1]) (cyc [11, 12, 13]) (cyc [21, 22, 23]) (cyc [0, 0, 1]) (cyc [0, 0, 1])
/- #eval Stream'.take 1 <| hw_add_fork_fix (cyc [1]) (cyc [1]) (cyc [10]) (cyc [20]) (cyc [1]) (cyc [1])
 - #eval Stream'.take 1 <| hw_add_fork_fix (cyc [1]) (cyc [1]) (cyc [10]) (cyc [20]) (cyc [1]) (cyc [1])
 - #eval Stream'.take 1 <| hw_add_fork_fix (cyc [1]) (cyc [1]) (cyc [10]) (cyc [20]) (cyc [1]) (cyc [1]) -/

end TRY3

/-! We need two proofs:
  · handshake fork ~ delayed fork (for some non deterministic delay)
  · delayed fork ~ normal fork
-/

/- At the handshake level: (manual) delayed fork ~ normal fork: the outputs of the fork are bisimilar
  for any delay (up to any numbers of `none` inserted, anywhere). -/
-- theorem fork_refines {a x y x' y'} :
--   (x, y) = TRY2.hw_fork a →
--   x ~ x' →
--   y ~ y' →
--   x ~ x' ∧ y ~ y' := by grind

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

inductive relation' : Stream (BitVec w) → Stream (BitVec w) → Prop where
  | intro x y rd vld data rd1 vld1 o1 :  /- same as `∀ x y` -/
      /- x is the high-level (input), y is the low-level (output) -/
      x = toStream rd vld data →
      y = toStream rd1 vld1 o1 →
      (∀ j, (rd j = 1#1 ∧ vld j = 1#1) ↔ rd1 j = 1#1 ∧ vld1 j = 1#1) →
      -- (∃ k, rd k = 1#1 ∧ vld k = 1) → /- at least one transition happens frfr -/
      globallyValidUntilReady vld rd →
      globallyValidAndData vld data →
      globallyFinallyReady rd1 →
      (∀ n, vld n = 1#1 → data n = o1 n) → /- when the signal is valid, data and output are the same -/
      relation' x y /- defining the type of the relation -/


/-
  `(rdIn, vldOut1, ...) = TRY3.split_stream2 (TRY3.hw_fork rdOut1 rdOut2 vldIn dataIn)`
  and `TRY3.hw_fork` starts from `(0, 0#1, 0#1)`. In the coinductive step you must re-establish relation_fork for the dropped streams — which requires the dropped streams to again satisfy the fork equation from registers (0,0). That only holds if you cut at an instant where both emitted registers are actually 0, i.e. right after allDone fired. But the proof cuts at fstVldTrue + fstRdyOut + 1 — the instant out1 fired — and out2 may not have fired yet, so _emitted_0 = 1 at the cut and the restarted equation is false. The fix is to generalize the relation over register state: parameterize it by (e₀, e₁) (or quantify over a start state) and make hw_fork' take an initial state argument. Alternatively cut at the first allDone instant instead of the first out1 firing
-/
inductive relation_fork : Stream (BitVec w) → Stream (BitVec w) → Prop where
  | intro x y rdIn vldIn dataIn rdOut1 vldOut1 dataOut1 rdOut2 vldOut2 dataOut2 :  /- same as `∀ x y` -/
      /- x is the high-level (input), y is the low-level (output) -/
      x = toStream rdIn vldIn dataIn →
      y = toStream rdOut1 vldOut1 dataOut1 →
      /- if a signal in `x` is valid (`vldIn i = 1#1`), it will remain valid (at least) until a
        ready signal is received (`rdIn (i + k) = 1#1`). A ready signal is eventually definitely received.  -/
      globallyValidUntilReady vldIn rdIn →
      globallyValidUntilReady vldOut1 rdOut1 →
      globallyValidUntilReady vldOut2 rdOut2 →
      /- if a signal in `x` is valid for more than one cycle (`vldIn i = 1#1 ∧ vldIn (i + 1) = 1#1`),
        the data does not change (`dataIn i = dataIn (i + 1)`) -/
      globallyValidAndData vldIn dataIn →
      /- eventually a ready signal arrives from both receivers (`rdOut1 i = 1#1`), (`rdOut2 i = 1#1`) -/
      globallyFinallyReady rdOut1 →
      globallyFinallyReady rdOut2 →
      /- input/output relationship around the `fork` module -/

      (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) = TRY3.split_stream2 (TRY3.hw_fork rdOut1 rdOut2 vldIn dataIn) →
      relation_fork x y


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


/-- We unfold one step of the corecursive definition of `fork` -/
def fork_corec (_ready _ready_1 _valid : Stream' (BitVec 1)) (_in0 : Stream' (BitVec w)) :=
  fun (i, _emitted_0, _emitted_1) =>
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

/-- We re-define the fork circuit in terms of `fork_corec` -/
def hw_fork' (_ready _ready_1 _valid : Stream' (BitVec 1)) (_in0 : Stream' (BitVec w))
    : Stream' ( BitVec 1  -- ready (_12)
              × BitVec 1  -- valid_0 (_3)
              × BitVec 1  -- valid_1 (_9)
              × BitVec w -- rawOutput
              × BitVec w -- rawOutput
      )
  := Stream'.corec' (α := Nat × BitVec 1 × BitVec 1) (fork_corec _ready _ready_1 _valid _in0) (0, 0#1, 0#1)




/-- Prove that iterating `n` times starting from the `m`-th index of the stream yields the `n + m`-th index-/
theorem fork_corec1 {w : Nat}
    {rd0_in rd1_in vld_in : Stream' (BitVec 1)}
    {data_in : Stream' (BitVec w)}
    {m n : Nat} {x y : BitVec 1} :
  (Stream'.iterate (Prod.snd ∘ fork_corec rd0_in rd1_in vld_in data_in) (m, x, y) n).1 = n + m := by
  induction n generalizing m x y with
  | zero => grind [Stream'.iterate]
  | succ x h =>
    rw [Stream'.iterate_eq]
    dsimp [Stream'.cons]
    dsimp [fork_corec]
    grind

theorem hw_fork'_vldOut1_of_none (h : ∀ k, vldIn k = 0#1) :
    ((hw_fork' rdOut1 rdOut2 vldIn dataIn) k).2.1 = 0#1 := by
  unfold hw_fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get
  generalize hst : Stream'.iterate
    (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) k = s
  obtain ⟨a, b, c⟩ := s
  dsimp [fork_corec, comb_and, comb_xor, hw_constant]
  specialize h a
  simp [h]

theorem hw_fork'_vldOut2_of_none (h : ∀ k, vldIn k = 0#1) :
    ((hw_fork' rdOut1 rdOut2 vldIn dataIn) k).2.2.1 = 0#1 := by
  unfold hw_fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get
  generalize hst : Stream'.iterate
    (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) k = s
  obtain ⟨a, b, c⟩ := s
  dsimp [fork_corec, comb_and, comb_xor, hw_constant]
  specialize h a
  simp [h]

lemma iterate_back_succ (f : α → α) (s : α) (n : ℕ) :
    Stream'.iterate f s (n + 1) = f (Stream'.iterate f s n) := by
  induction n generalizing s with
  | zero => simp [Stream'.iterate_eq, Stream'.cons]
  | succ k ih => rw [Stream'.iterate_eq, Stream'.cons, ih]; rfl

lemma fork_emitted_zero_of_all_none (h : ∀ k, vldIn k = 0#1) :
    ∀ k, (Stream'.iterate (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn)
          (0, 0#1, 0#1) k).2 = (0#1, 0#1) := by
  intro k
  induction k with
  | zero => simp [Stream'.iterate]
  | succ k ih =>
    rw [iterate_back_succ]
    generalize hsk : Stream'.iterate
      (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) k = s
    obtain ⟨a, b, c⟩ := s
    simp [hsk] at ih
    obtain ⟨rfl, rfl⟩ := ih
    simp only [Function.comp]
    dsimp [fork_corec, comb_and, comb_xor, comb_or, hw_constant]
    simp [h a]

-- when vld is always 0, all signal outputs (not data) are 0
theorem hw_fork'_of_all_none (h : ∀ k, vldIn k = 0#1) :
    ∀ k, ((hw_fork' rdOut1 rdOut2 vldIn dataIn) k).1 = 0#1 ∧
         ((hw_fork' rdOut1 rdOut2 vldIn dataIn) k).2.1 = 0#1 ∧
         ((hw_fork' rdOut1 rdOut2 vldIn dataIn) k).2.2.1 = 0#1 := by
  unfold hw_fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get
  intro k
  and_intros
  · generalize hst : Stream'.iterate
      (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) k = s
    obtain ⟨a, b, c⟩ := s
    dsimp [fork_corec, comb_and, comb_xor, hw_constant]
    have hbc := fork_emitted_zero_of_all_none (dataIn := dataIn) (rdOut1 := rdOut1)
                                              (rdOut2 := rdOut2) h k
    rw [hst] at hbc
    simp at hbc
    obtain ⟨rfl, rfl⟩ := hbc
    simp [h a, comb_or]
  · generalize hst : Stream'.iterate
      (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) k = s
    obtain ⟨a, b, c⟩ := s
    dsimp [fork_corec, comb_and, comb_xor, hw_constant]
    specialize h a
    simp [h]
  · generalize hst : Stream'.iterate
      (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) k = s
    obtain ⟨a, b, c⟩ := s
    dsimp [fork_corec, comb_and, comb_xor, hw_constant]
    specialize h a
    simp [h]

/-- Prove that (at RTL level) the input and output data at the `n`-th position are the same.
  This is possible because `hw_fork'` does not introduce any delay, and there is no transformation
  happening on the data. -/
theorem hw_fork_out0
    (h : ⟨rdy_out, vld0_out, vld1_out, data0_out, data1_out⟩ = TRY3.split_stream2 (hw_fork' rd0_in rd1_in vld_in data_in)) :
    (∀ n, data_in n = data0_out n) := by
  intro n
  simp [TRY3.split_stream2] at h
  simp [h]
  unfold hw_fork'; clear h
  unfold Stream'.corec' Stream'.corec Stream'.map Stream'.get
  generalize h: (Stream'.iterate (Prod.snd ∘ fork_corec rd0_in rd1_in vld_in data_in) (0, 0#1, 0#1) n) = y
  obtain ⟨a, b, c⟩ := y
  dsimp [fork_corec]
  rw [show a = (a, b, c).1 by rfl, ←h, fork_corec1]; rfl

theorem hw_fork_out1
    (h : ⟨rdy_out, vld0_out, vld1_out, data0_out, data1_out⟩ = TRY3.split_stream2 (hw_fork' rd0_in rd1_in vld_in data_in)) :
    (∀ n, data_in n = data1_out n) := by
  intro n
  simp [TRY3.split_stream2] at h
  simp [h]
  unfold hw_fork'; clear h
  unfold Stream'.corec' Stream'.corec Stream'.map Stream'.get
  generalize h: (Stream'.iterate (Prod.snd ∘ fork_corec rd0_in rd1_in vld_in data_in) (0, 0#1, 0#1) n) = y
  obtain ⟨a, b, c⟩ := y
  dsimp [fork_corec]
  rw [show a = (a, b, c).1 by rfl, ←h, fork_corec1]; rfl




theorem fork_corec1bis :
  (Stream'.iterate (Prod.snd ∘ fork_corec rd0_in rd1_in vld_in data_in) (m, x, y) n).1 = n + m := by
  induction n generalizing m x y with
  | zero => grind [Stream'.iterate]
  | succ x h =>
    rw [Stream'.iterate_eq]
    dsimp [Stream'.cons]
    dsimp [fork_corec]
    grind

theorem hw_fork_eq : TRY3.hw_fork rd0 rd1 vld data = hw_fork' rd0 rd1 vld data := by
  unfold TRY3.hw_fork hw_fork'
  congr 1

theorem vldOut1_implies_vldIn {w : Nat}
    {rdIn rdOut1 rdOut2 vldIn vldOut1 vldOut2 : Stream' (BitVec 1)}
    {dataIn dataOut1 dataOut2 : Stream' (BitVec w)} {n : Nat}
    (h : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) =
      TRY3.split_stream2 (TRY3.hw_fork rdOut1 rdOut2 vldIn dataIn))
    (hvld : vldOut1 n = 1#1) : vldIn n = 1#1 := by
  rw [hw_fork_eq] at h
  simp [TRY3.split_stream2] at h
  obtain ⟨-, hvldout1, -⟩ := h
  have hn := congr_fun hvldout1 n
  rw [hvld] at hn
  unfold hw_fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hn
  generalize hst : Stream'.iterate
    (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) n = s at hn
  obtain ⟨a, b, c⟩ := s
  dsimp [fork_corec, comb_and, comb_xor, hw_constant] at hn
  have heq : a = n := by
    have := fork_corec1 (rd0_in := rdOut1) (rd1_in := rdOut2) (vld_in := vldIn) (data_in := dataIn) (m := 0) (x := 0#1) (y := 0#1) (n := n)
    rw [hst] at this
    simp at this
    assumption
  rw [← heq]
  apply Classical.byContradiction
  intro hcontra
  have : vldIn a = 0#1 := by grind
  simp [this] at hn

theorem vldOut2_implies_vldIn
    (h : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) =
      TRY3.split_stream2 (TRY3.hw_fork rdOut1 rdOut2 vldIn dataIn))
    (hvld : vldOut2 n = 1#1) : vldIn n = 1#1 := by
  rw [hw_fork_eq] at h
  simp [TRY3.split_stream2] at h
  obtain ⟨-, -, hvldout2, -⟩ := h
  have hn := congr_fun hvldout2 n
  rw [hvld] at hn
  unfold hw_fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hn
  generalize hst : Stream'.iterate
    (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) n = s at hn
  obtain ⟨a, b, c⟩ := s
  dsimp [fork_corec, comb_and, comb_xor, hw_constant] at hn
  have heq : a = n := by
    have := fork_corec1 (rd0_in := rdOut1) (rd1_in := rdOut2) (vld_in := vldIn) (data_in := dataIn) (m := 0) (x := 0#1) (y := 0#1) (n := n)
    rw [hst] at this
    simp at this
    assumption
  rw [← heq]
  apply Classical.byContradiction
  intro hcontra
  have : vldIn a = 0#1 := by grind
  simp [this] at hn

theorem rdOut1_before_allDone
  (hfork : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) =
    TRY3.split_stream2 (TRY3.hw_fork rdOut1 rdOut2 vldIn dataIn)) (hvldOut1 : vldOut1 n = 1#1)
  (hgvurIn : globallyValidUntilReady vldIn rdIn) :
    ∃ k, rdIn (n + k) = 1#1 ∧ vldIn (n + k) = 1#1 := by
  have hvldIn := vldOut1_implies_vldIn hfork hvldOut1
  unfold globallyValidUntilReady at hgvurIn
  specialize hgvurIn n  hvldIn
  obtain ⟨k, hk⟩ := hgvurIn
  exists k
  simp [hk]

lemma iterate_succ_apply (f : α → α) (s : α) (n : ℕ) :
    Stream'.iterate f s (n + 1) = f (Stream'.iterate f s n) := by
  induction n generalizing s with
  | zero => simp [Stream'.iterate]
  | succ k ih =>
    rw [Stream'.iterate_eq, Stream'.cons]
    exact ih _



theorem vldOut_eq_vldIn_of_fork_unitl_sent
    (hfork : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) =
      TRY3.split_stream2 (TRY3.hw_fork rdOut1 rdOut2 vldIn dataIn))
    /- nothing is emitted before `n`, as emission occurs if `rdOut1 j ∧ vldOut1 j` -/
    (hbefore : ∀ j < n, rdOut1 j = 0#1 ∨ vldOut1 j = 0#1) :
    vldOut1 n = vldIn n := by
  rw [hw_fork_eq] at hfork
  simp [TRY3.split_stream2] at hfork
  obtain ⟨-, hvldout1, -⟩ := hfork
  have hn := congr_fun hvldout1 n
  unfold hw_fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hn
  generalize hst : Stream'.iterate
    (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) n = s at hn
  obtain ⟨a, b, c⟩ := s
  dsimp [fork_corec, comb_and, comb_xor, hw_constant] at hn
  have hb : b = 0#1 := by
    apply Classical.byContradiction
    intro hcontra
    have : b = 1#1 := by grind
    subst this
    simp at hn
    suffices key : ∀ m, (∀ j < m, rdOut1 j = 0#1 ∨ vldOut1 j = 0#1) →
      (Stream'.iterate (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) m).2.1 = 0#1 by
      have := key n hbefore
      rw [hst] at this
      simp at this
    intro m
    induction m with
    | zero => simp [Stream'.iterate]
    | succ k ihk =>
      intro hbef
      have hbk := ihk (fun j hj => hbef j (Nat.lt_succ_of_lt hj))
      generalize hsk : Stream'.iterate
        (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) k = sk
      obtain ⟨ak, bk, ck⟩ := sk
      simp [hsk] at hbk; subst hbk
      rw [iterate_back_succ, hsk]
      have hak : ak = k := by
        have := fork_corec1 (rd0_in := rdOut1) (rd1_in := rdOut2) (vld_in := vldIn) (data_in := dataIn) (m := 0) (x := 0#1) (y := 0#1) (n := k)
        simp [hsk] at this; omega
      have hk := hbef k (Nat.lt_succ_self k)
      simp only [Function.comp]
      have hvldk : vldOut1 k = vldIn ak := by
        have h := congr_fun hvldout1 k
        unfold hw_fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at h
        simp_rw [hsk] at h
        dsimp [fork_corec, comb_and, comb_xor, hw_constant] at h
        simp_all
        ext k hk
        simp [show k = 0 by omega]
      dsimp [fork_corec, comb_and, comb_xor, comb_or, hw_constant]
      subst hak
      by_cases hrd : rdOut1 ak = 1#1 <;> by_cases hvld : vldIn ak = 1#1 <;> by_cases hck : ck = 1#1 <;> by_cases hrd2 : rdOut2 ak = 1#1
      · simp [hrd, hvld, hck]
      · simp [hrd, hvld, hck]
      · have h0 : ck = 0#1 := by grind
        simp [hrd, hvld, h0, hrd2]
      · have h0 : ck = 0#1 := by grind
        have h1 : rdOut2 ak = 0#1 := by grind
        simp [hrd] at hk
        simp_all
      · have h0 : vldIn ak  = 0#1 := by grind
        simp [hrd, h0, hrd2]
      · have h0 : vldIn ak = 0#1 := by grind
        have h1 : rdOut2 ak = 0#1 := by grind
        simp [hrd, h0, h1]
      · have h0 : vldIn ak = 0#1 := by grind
        simp [hrd, h0]
      · simp [hrd] at hk
        simp_all
      · have h1 : rdOut1 ak = 0#1 := by grind
        simp [h1, hvld, hck]
      · have h1 : rdOut1 ak = 0#1 := by grind
        simp [hvld, hck, h1]
      · have h1 : rdOut1 ak = 0#1 := by grind
        simp [hvld, h1]
      · have h1 : rdOut1 ak = 0#1 := by grind
        simp [h1, hvld]
      · have h1 : rdOut1 ak = 0#1 := by grind
        simp [h1, hck]
      · have h1 : rdOut1 ak = 0#1 := by grind
        simp [h1, hck]
      · have h1 : rdOut1 ak = 0#1 := by grind
        simp [h1]
      · have h1 : rdOut1 ak = 0#1 := by grind
        simp [h1]
  simp [hb] at hn
  have heq : a = n := by
    have := fork_corec1 (rd0_in := rdOut1) (rd1_in := rdOut2) (vld_in := vldIn) (data_in := dataIn) (m := 0) (x := 0#1) (y := 0#1) (n := n)
    rw [hst] at this
    simp at this
    assumption
  rw [← heq] at ⊢ hn
  simp [hn]
  ext k hk
  simp [show k = 0 by omega]

theorem vldOut_of_vldIn_rdy
    (hfork : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) =
      TRY3.split_stream2 (TRY3.hw_fork rdOut1 rdOut2 vldIn dataIn))
    /- nothing has been accepted so far -/
    (hbefore : ∀ l < j, rdOut1 l = 0#1 ∨ vldOut1 l = 0#1)
    (hin : vldIn j = 1#1 ∧ rdIn j = 1#1) :
    vldOut1 j = 1#1 := by
  rw [vldOut_eq_vldIn_of_fork_unitl_sent (hfork := hfork) (hbefore := hbefore)]
  simp [hin]

theorem vldOut_eq_vldIn_of_fork_unitl_sent2
    (hfork : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) =
      TRY3.split_stream2 (TRY3.hw_fork rdOut1 rdOut2 vldIn dataIn))
    /- nothing is emitted before `n`, as emission occurs if `rdOut1 j ∧ vldOut1 j` -/
    (hbefore : ∀ j < n, rdOut2 j = 0#1 ∨ vldOut2 j = 0#1) :
    vldOut2 n = vldIn n := by
  rw [hw_fork_eq] at hfork
  simp [TRY3.split_stream2] at hfork
  obtain ⟨-, -, hvldout2, -⟩ := hfork
  have hn := congr_fun hvldout2 n
  unfold hw_fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hn
  generalize hst : Stream'.iterate
    (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) n = s at hn
  obtain ⟨a, b, c⟩ := s
  dsimp [fork_corec, comb_and, comb_xor, hw_constant] at hn
  have hc0 : c = 0#1 := by
      suffices key : ∀ m, (∀ j < m, rdOut2 j = 0#1 ∨ vldOut2 j = 0#1) →
          (Stream'.iterate (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn)
            (0, 0#1, 0#1) m).2.2 = 0#1 by
        have := key n hbefore
        rw [hst] at this; simpa using this
      intro m
      induction m with
      | zero => simp [Stream'.iterate]
      | succ k ihk =>
        intro hbef
        have hck := ihk (fun j hj => hbef j (Nat.lt_succ_of_lt hj))
        generalize hsk : Stream'.iterate
          (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) k = sk
        obtain ⟨ak, bk, ck⟩ := sk
        simp [hsk] at hck; subst hck
        have hak : ak = k := by
          have := fork_corec1 (rd0_in := rdOut1) (rd1_in := rdOut2) (vld_in := vldIn) (data_in := dataIn) (m := 0) (x := 0#1) (y := 0#1) (n := k)
          grind
        have hvldk : vldOut2 k = vldIn ak := by
          have h := congr_fun hvldout2 k
          unfold hw_fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at h
          simp_rw [hsk] at h
          dsimp [fork_corec, comb_and, comb_xor, hw_constant] at h
          simp_all
          ext k hk
          simp [show k = 0 by omega]
        have hk := hbef k (Nat.lt_succ_self k)
        rw [iterate_back_succ, hsk]
        simp only [Function.comp]
        dsimp [fork_corec, comb_and, comb_xor, comb_or, hw_constant]
        rcases hk with h | h
        · simp_all
        · rw [hvldk] at h
          rcases hak ▸ h with h
          have hvldInA : vldIn ak = 0#1 := by grind
          simp [hvldInA];
  have heq : a = n := by
    have := fork_corec1 (rd0_in := rdOut1) (rd1_in := rdOut2) (vld_in := vldIn) (data_in := dataIn) (m := 0) (x := 0#1) (y := 0#1) (n := n)
    rw [hst] at this
    simp at this
    assumption
  rw [← heq] at ⊢ hn
  simp [hn]
  ext k hk
  simp [show k = 0 by omega]
  intros
  simp [hc0]

theorem data_remains_constant_if
    (h : globallyValidAndData vld data)
    (h' : globallyValidUntilReady vld rdy) :
  ∀ i, vld i = 1#1 →
    ∃ k, (rdy (i + k) = 1#1 ∧ vld (i + k) = 1#1 ∧
    (∀ j (_hj : j ≤ k), vld (i + j) = 1#1 )∧
   (∀ j (_hj : j ≤ k), data (i + j) = data i)) := by
  unfold globallyValidAndData at h
  unfold globallyValidUntilReady at h'
  intros i
  specialize h' i
  by_cases htrue : vld i = 1#1
  · simp [htrue] at h' ⊢
    obtain ⟨k, hk⟩ := h'
    exists k
    simp [hk]
    by_cases hk0 : 0 < k
    · and_intros
      · intro j hj
        obtain ⟨h1, h2, h3⟩ := hk
        by_cases hlt : j < k
        · apply h3
          exact hlt
        · simp [show j = k by omega, h2]
      · intros l hl
        induction l
        · simp
        · case _ l' ihl' =>
          rw [show (i + (l' + 1)) = (i + l') + 1 by omega]
          obtain ⟨h1, h2, h3⟩ := hk
          by_cases hle : l' + 1 < k
          · rw [← ihl' (by omega)]
            apply Eq.symm
            apply h
            simp_all
            and_intros
            · apply h3
              omega
            · rw [show (i + l') + 1 = (i + (l' + 1)) by omega]
              apply h3
              assumption
          · have : l' + 1 = k := by omega
            specialize ihl' (by omega)
            rw [← ihl']
            apply Eq.symm
            apply h
            and_intros
            · apply h3
              assumption
            · rw [show k = l' + 1 by omega, show (i + (l' + 1)) = (i + l') + 1 by omega] at h2
              assumption
    · simp [show k = 0 by omega, htrue]
  · simp [show vld i = 0#1 by grind]



theorem not_exists_transmitted_element
  (hv : ∀ i, vld i = 0#1)
  (hx : x = toStream rdy vld data) :
    ∀ k, x k  = none := by
  unfold toStream at hx
  simp at hx
  intros k
  have hkx := congr_fun hx k
  simp [show vld k = 0#1 by grind] at hkx
  simp [hkx]

theorem not_exists_transmitted_element_before
  (hv : ∀ i (_ : i < limit), vld i = 0#1)
  (hx : x = toStream rdy vld data) :
    ∀ k (_ : k < limit), x k  = none := by
  intros k hk
  unfold toStream at hx
  simp at hx
  have hkx := congr_fun hx k
  simp [show vld k = 0#1 by grind] at hkx
  simp [hkx]

theorem if_exists_first_exists {st : Stream' (BitVec 1)} (h : ∃ k , st k = 1#1) :
    ∃ j, (st j = 1#1 ∧ ∀ n (_ : n < j), st n = 0#1) := by
  suffices key : ∀ k, st k = 1#1 → ∃ j, st j = 1#1 ∧ ∀ n < j, st n = 0#1 by
    obtain ⟨k, hk⟩ := h; exact key k hk
  intro k
  induction k using Nat.strongRecOn with
  | _ k ih =>
    intro hk
    by_cases h0 : ∃ m < k, st m = 1#1
    · obtain ⟨m, hm, hms⟩ := h0
      exact ih m hm hms
    · refine ⟨k, hk, fun n hn => ?_⟩
      by_contra hc
      have hst : st n = 1#1 := by grind
      exact h0 ⟨n, hn, hst⟩

theorem exists_first_transmitted_element
  (hv : ∃ i, vld i = 1#1)
  (hgf : globallyValidUntilReady vld rdy)
  (hx : x = toStream rdy vld data) :
    ∃ k, (x k  = some (data k) ∧ ∀ j (_ : j < k), x j = none) := by
  obtain ⟨i, hi⟩ := hv
  obtain ⟨k, hkr, hkv, -⟩ := hgf i hi
  let combined := fun n => if rdy n == 1#1 && vld n == 1#1 then 1#1 else (0#1 : BitVec 1)
  have hex : ∃ n, combined n = 1#1 := ⟨i + k, by simp [combined, hkr, hkv]⟩
  obtain ⟨j, hjfire, hjmin⟩ := if_exists_first_exists hex
  refine ⟨j, ?_, ?_⟩
  · simp [combined] at hjfire
    rw [hx, toStream]
    simp [hjfire.1, hjfire.2]
  · intro l hl
    rw [hx, toStream]
    have h0 := hjmin l hl
    simp [combined] at h0
    grind

theorem exists_first_received_element
  (hv : ∃ i, rdy i = 1#1 ∧ vld i = 1#1)
  (hx : x = toStream rdy vld data) :
    ∃ k, (x k = some (data k) ∧ ∀ j (_ : j < k), x j = none) := by
  obtain ⟨fst, hfst_fire, hfst_min⟩ := if_exists_first_exists
    (st := fun n => if ((rdy n == 1#1) && (vld n == 1#1)) then 1#1 else 0#1)
    (by
      obtain ⟨k, hk⟩ := hv
      exists k
      simp [hk])
  refine ⟨fst, ?_, ?_⟩
  · rw [hx, toStream]
    have : ((rdy fst == 1#1) && (vld fst == 1#1))= true := by
      by_contra hc; simp [hc] at hfst_fire
    simp only [Bool.and_eq_true, beq_iff_eq] at this
    simp [this.1, this.2]
  · intro j hj
    rw [hx, toStream]
    have hj_not := hfst_min j hj
    by_cases hrdy : rdy j == 1#1 && vld j == 1#1
    · simp [hrdy] at hj_not
    · simp only [Bool.and_eq_true, beq_iff_eq, not_and] at hrdy
      by_cases hr : rdy j = 1#1
      · have hvj := hrdy (by simpa using hr)
        simp [show (rdy j == 1#1) = true by simpa, show (vld j == 1#1) = false by simpa]
      · simp [show (rdy j == 1#1) = false by simpa]


theorem exists_transmitted_element
  (h : globallyValidUntilReady vld rdy)
  (hx : x = toStream rdy vld data) :
    ∃ k, x k  = some (data k) ∨ ∀ k, x k = none := by
  by_cases hexists : ∃ i, vld i = 1#1
  · unfold toStream at hx
    unfold globallyValidUntilReady at h
    obtain ⟨i, hi⟩ := hexists
    specialize h i (by omega)
    obtain ⟨k, hk1, hk2, hk3⟩ := h
    exists (i + k)
    have hkx := congr_fun hx (i + k)
    simp [hk1, hk2] at hkx
    simp [hkx]
  · simp [not_exists_transmitted_element (x := x) (data := data) (rdy := rdy) (vld := vld) (by grind) hx]

theorem false_of_width_one (b : BitVec 1) (h : ¬ b = 1#1 ) : b = 0#1 := by grind

theorem true_of_width_one (b : BitVec 1) (h : ¬ b = 0#1 ) : b = 1#1 := by grind

theorem vldIn_and_eventually_ready_implies_vldOut1
  (hfork : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) = TRY3.split_stream2 (TRY3.hw_fork rdOut1 rdOut2 vldIn dataIn))
  (hvldIn : globallyFinallyReady vldIn) :
    ∃ k, vldOut1 k = 1#1 := by
  obtain ⟨n, hvldn, hnmin⟩ := if_exists_first_exists (hvldIn 0 |>.imp (fun k hk => by simpa using hk))
  have hbefore : ∀ j < n, rdOut1 j = 0#1 ∨ vldOut1 j = 0#1 := by
    intro j hj
    right
    have hvldj : vldIn j = 0#1 := hnmin j hj
    by_contra hc
    have : vldIn j = 1#1 := vldOut1_implies_vldIn hfork (by grind)
    rw [this] at hvldj
    simp at hvldj
  exact ⟨n, vldOut_eq_vldIn_of_fork_unitl_sent hfork hbefore |>.symm ▸ hvldn⟩

theorem vldIn_and_ready_implies_vldOut1
  (hfork : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) = TRY3.split_stream2 (TRY3.hw_fork rdOut1 rdOut2 vldIn dataIn))
  (hvldIn : ∃ j, vldIn j = 1#1) :
    ∃ k, vldOut1 k = 1#1 := by
  obtain ⟨n, hvldn, hnmin⟩ := if_exists_first_exists (st := vldIn) (by grind)
  have hbefore : ∀ j < n, rdOut1 j = 0#1 ∨ vldOut1 j = 0#1 := by
    intro j hj
    right
    have hvldj : vldIn j = 0#1 := hnmin j hj
    by_contra hc
    have : vldIn j = 1#1 := vldOut1_implies_vldIn hfork (by grind)
    rw [this] at hvldj
    simp at hvldj
  exact ⟨n, vldOut_eq_vldIn_of_fork_unitl_sent hfork hbefore |>.symm ▸ hvldn⟩

theorem vldIn_and_ready_implies_vldOut2
  (hfork : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) = TRY3.split_stream2 (TRY3.hw_fork rdOut1 rdOut2 vldIn dataIn))
  (hvldIn : ∃ j, vldIn j = 1#1) :
    ∃ k, vldOut2 k = 1#1 := by
  obtain ⟨n, hvldn, hnmin⟩ := if_exists_first_exists (st := vldIn) (by grind)
  have hbefore : ∀ j < n, rdOut2 j = 0#1 ∨ vldOut2 j = 0#1 := by
    intro j hj
    right
    have hvldj : vldIn j = 0#1 := hnmin j hj
    by_contra hc
    have : vldIn j = 1#1 := vldOut2_implies_vldIn hfork (by grind)
    rw [this] at hvldj
    simp at hvldj
  exact ⟨n, vldOut_eq_vldIn_of_fork_unitl_sent2 hfork hbefore |>.symm ▸ hvldn⟩

lemma fork_globallyValidAndData_out1
    (hfork : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) =
      TRY3.split_stream2 (TRY3.hw_fork rdOut1 rdOut2 vldIn dataIn))
    (hgv : globallyValidAndData vldIn dataIn) :
    globallyValidAndData vldOut1 dataOut1 := by
  intro i ⟨hi1, hi2⟩
  have hdata := hw_fork_out0 hfork
  rw [← hdata i, ← hdata (i+1)]
  apply hgv
  exact ⟨vldOut1_implies_vldIn hfork hi1, vldOut1_implies_vldIn hfork hi2⟩


lemma globallyValidAndData_stable (hgv : globallyValidAndData vld data)
    (hrange : ∀ j, m ≤ j → j ≤ n → vld j = 1#1) (h : m ≤ n) :
    data m = data n := by
  induction h with
  | refl => rfl
  | step h ih =>
    rw [ih (fun j hj1 hj2 => hrange j hj1 (Nat.le_succ_of_le hj2))]
    apply hgv
    exact ⟨hrange _ (by omega) (by omega),
           hrange _ (Nat.le_succ_of_le h) (Nat.le_refl _)⟩

theorem data_remains_constant_until_first
    (h : globallyValidAndData vld data)
    (h' : globallyValidUntilReady vld rdy)
    (hi : vld i = 1#1) :
    ∃ k, rdy (i + k) = 1#1 ∧ vld (i + k) = 1#1 ∧
    (∀ j (_hj : j ≤ k), vld (i + j) = 1#1) ∧
    (∀ j (_hj : j ≤ k), data (i + j) = data i) ∧
    (∀ m (_hm : m < k), rdy (i + m) = 0#1) := by
  -- get any witness first
  obtain ⟨k, hkrd, hkvld, hkvldall, hkdata⟩ := data_remains_constant_if h h' i hi
  -- find the minimum via if_exists_first_exists
  obtain ⟨kMin, hkMin_fire, hkMin_min⟩ := if_exists_first_exists
    (st := fun m => if rdy (i + m) == 1#1 && vld (i + m) == 1#1 then 1#1 else 0#1)
    ⟨k, by simp [hkrd, hkvld]⟩
  simp only [ite_eq_left_iff, Bool.and_eq_true, beq_iff_eq, not_and] at hkMin_fire hkMin_min
  -- extract rdy and vld at kMin
  have hkMinrd : rdy (i + kMin) = 1#1 := by
    by_contra hc
    simp [show rdy (i + kMin) ≠ 1#1 from hc] at hkMin_fire
  have hkMinvld : vld (i + kMin) = 1#1 := by
    by_contra hc
    grind
  -- kMin ≤ k
  have hkMinlek : kMin ≤ k := by
    by_contra hlt; push_neg at hlt
    have := hkMin_min k hlt
    simp [hkrd, hkvld] at this
  refine ⟨kMin, hkMinrd, hkMinvld, ?_, ?_, ?_⟩
  · -- vld stays 1 for j ≤ kMin
    intro j hj
    exact hkvldall j (by omega)
  · -- data stays constant for j ≤ kMin
    intro j hj
    exact hkdata j (by omega)
  · -- rdy = 0 before kMin
    intro m hm
    by_contra hc
    have hrdm : rdy (i + m) = 1#1 := by grind
    -- vld (i + m) = 1 since m < kMin ≤ k
    have hvldm : vld (i + m) = 1#1 := hkvldall m (by omega)
    have := hkMin_min m hm
    simp [hrdm, hvldm] at this



end HWComponents
