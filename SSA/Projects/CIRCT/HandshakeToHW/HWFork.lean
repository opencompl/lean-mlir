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
    ((_12, _3, _9, _rawOutput, _rawOutput), (i + 1, _1, _7))
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
      /- eventually a ready signal arrives (`rdOut i = 1#1`) -/
      globallyFinallyReady rdOut1 →
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
def fork_corec (_ready _ready_1 _valid : Stream' (BitVec 1)) (_in0 : Stream' (BitVec 32)) :=
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
def hw_fork' (_ready _ready_1 _valid : Stream' (BitVec 1)) (_in0 : Stream' (BitVec 32))
    : Stream' ( BitVec 1  -- ready (_12)
              × BitVec 1  -- valid_0 (_3)
              × BitVec 1  -- valid_1 (_9)
              × BitVec 32 -- rawOutput
              × BitVec 32 -- rawOutput
      )
  := Stream'.corec' (α := Nat × BitVec 1 × BitVec 1) (fork_corec _ready _ready_1 _valid _in0) (0, 0#1, 0#1)




/-- Prove that iterating `n` times starting from the `m`-th index of the stream yields the `n + m`-th index-/
theorem fork_corec1 :
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

theorem vldOut1_implies_vldIn
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
    have := @fork_corec1 rdOut1 rdOut2 vldIn dataIn 0 0#1 0#1 n
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
    have := @fork_corec1 rdOut1 rdOut2 vldIn dataIn 0 0#1 0#1 n
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
        have := @fork_corec1 rdOut1 rdOut2 vldIn dataIn 0 0#1 0#1 k
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
    have := @fork_corec1 rdOut1 rdOut2 vldIn dataIn 0 0#1 0#1 n
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
          have := @fork_corec1 rdOut1 rdOut2 vldIn dataIn 0 0#1 0#1 k
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
    have := @fork_corec1 rdOut1 rdOut2 vldIn dataIn 0 0#1 0#1 n
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

/-- the standard implementation of the fork refines the handshake fork (`TRY2.hw_fork`) -/
theorem hw_fork_refines1_with_fork:
    /- Given a handshake fork taking `a` as input and returning `(a, a)`, we take
      its lowering (with input a bisimilar ready-valid wrapped stream) -/
    (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) = TRY3.split_stream2 (TRY3.hw_fork rdOut1 rdOut2 vldIn dataIn) →
    /- We want to make sure that stalling is correctly modeled for `a` (input).
      We constrain the input and prove that if the input behaves properly,
      the output will. -/
    globallyValidUntilReady vldOut1 rdOut1 →
    globallyValidUntilReady vldOut2 rdOut2 →
    globallyValidUntilReady vldIn rdIn →

    globallyValidAndData vldOut1 dataOut1 →
    globallyValidAndData vldOut2 dataOut2 →
    globallyValidAndData vldIn dataIn →
    /- we assume no deadlock -/
    globallyFinallyReady rdIn →
    globallyFinallyReady rdOut1 →
    globallyFinallyReady rdOut2 →
    /- if we know that the hshake input stream is bisimilar to the ready-valid input of the hw fork (`a ~ rdy vld i`), meaning that the two outputs are also bisimilar by transitivity-/
    /- we want to prove that the outputs of the handshake fork are respectively
      bisimilar to the ready-valid wrapping of the output of the hardware fork -/
    (toStream rdIn vldIn dataIn) ~ (toStream rdOut1 vldOut1 dataOut1) := by
  intros hfork hgvurOutt1 hvgurOut2 hgvurIn hgvdOut1 hgvdOut2 hgvdIn hgfrIn hgfrOut1 hgfrOut2
  /- if 0, 0 works we don't need bisimilarity -/
  /- the high-level fork will never wait for anything (whenever an input is available),
    while the low-level one might have to, and depends on the `rd1` signal eventually being true.
    if we choose `pred := Eq` the relation is too strong, the second goal is not provable.
  -/
  apply Bisim.coinduct (pred := relation_fork)
  · intros sin sout hrel
    /- `sin` and `sout` exist at the handshake level of the design -/
    rcases hrel
    expose_names
    by_cases hvldExists : ∃ k, vldIn_1 k = 1#1
    · have := if_exists_first_exists hvldExists
      obtain ⟨fstVldTrue, hfstVldTrue1, hfstVldTrue2⟩ := this
      /- we need to find the first element that is transmitted -/
      have hfstSent := exists_first_transmitted_element
              (data := dataIn_1) (vld := vldIn_1) (rdy := rdIn_1) (x := sin)
              (by grind) (by assumption) (by assumption)
      unfold globallyFinallyReady at h_4
      have ⟨fstRdyOut, hfstRdyOut⟩ := if_exists_first_exists (h_4 fstVldTrue)
      have hvldinout := vldIn_and_ready_implies_vldOut1
              (dataIn := dataIn_1) (vldIn := vldIn_1) (rdIn := rdIn_1)
              (rdOut1 := rdOut1_1) (rdOut2 := rdOut2_1) (vldOut1 := vldOut1_1) (vldOut2 := vldOut2_1)
              (dataOut1 := dataOut1_1) (dataOut2 := dataOut2_1) (by grind) (by grind)
      have hfstRec := exists_first_received_element
              (data := dataOut1_1) (vld := vldOut1_1) (rdy := rdOut1_1) (x := sout) (hx := h_7)
      have ⟨fstSentIdx, hfstSentIdx⟩ := hfstSent
      exists fstSentIdx, (fstVldTrue + fstRdyOut)
      and_intros
      ·
        apply relation_fork.intro
          (Stream'.drop (fstSentIdx + 1) sin)
          (Stream'.drop (fstVldTrue + fstRdyOut + 1) sout)
          (dataIn := Stream'.drop (fstSentIdx + 1) dataIn_1)
          (rdIn := Stream'.drop (fstSentIdx + 1) rdIn_1)
          (vldIn := Stream'.drop (fstSentIdx + 1) vldIn_1)
          (vldOut1 := Stream'.drop (fstVldTrue + fstRdyOut + 1) vldOut1_1)
          (vldOut2 := Stream'.drop (fstVldTrue + fstRdyOut + 1) vldOut2_1)
          (dataOut1 := Stream'.drop (fstVldTrue + fstRdyOut + 1) dataOut1_1)
          (dataOut2 := Stream'.drop (fstVldTrue + fstRdyOut + 1) dataOut2_1)
          (rdOut1 := Stream'.drop (fstVldTrue + fstRdyOut + 1) rdOut1_1)
          (rdOut2 := Stream'.drop (fstVldTrue + fstRdyOut + 1) rdOut2_1)
        · simp_all
          rfl
        · simp_all
          rfl
        ·

          sorry
        · sorry
        · sorry
        · sorry
        · sorry
        · congr
          · sorry
          · sorry
          · sorry
          · sorry
          · sorry
      · simp [Stream'.get, h_6, h_7, toStream]
        have hdataeq := hw_fork_out0 (h := h_5)
        by_cases hle : fstVldTrue ≤ fstSentIdx
        · have hreadyIn : rdIn_1 fstSentIdx = 1#1 := by
            unfold toStream at h_6
            have h_6sent := congr_fun h_6 fstSentIdx
            simp [hfstSentIdx] at h_6sent
            simp [h_6sent]
          have hvalidIn: vldIn_1 fstSentIdx = 1#1 := by
            unfold toStream at h_6
            have h_6sent := congr_fun h_6 fstSentIdx
            simp [hfstSentIdx] at h_6sent
            simp [h_6sent]
          have hrdout : rdOut1_1 (fstVldTrue + fstRdyOut) = 1#1 := by
            simp [hfstRdyOut]
          have hvldout : vldOut1_1 (fstVldTrue + fstRdyOut) = 1#1 := by
            have hbefore : ∀ j < fstVldTrue + fstRdyOut, rdOut1_1 j = 0#1 ∨ vldOut1_1 j = 0#1 := by
              intro j hj
              by_cases hjlt : j < fstVldTrue
              · right; by_contra hc
                have : vldOut1_1 j = 1#1 := by grind
                have := vldOut1_implies_vldIn h_5 (n := j) (by assumption)
                specialize hfstVldTrue2 j hjlt
                simp [this] at hfstVldTrue2
              · left
                have := hfstRdyOut.2 (j - fstVldTrue) (by omega)
                rwa [Nat.add_sub_cancel' (by omega)] at this
            rw [vldOut_eq_vldIn_of_fork_unitl_sent h_5 hbefore]
            obtain ⟨k, hkrd, hkvld, hkall⟩ := h fstVldTrue hfstVldTrue1
            by_contra hlt; push_neg at hlt
            -- rdIn fires at fstVldTrue + k with k < fstRdyOut, but rdOut1 hasn't fired
            have hh5 := h_5
            rw [hw_fork_eq] at h_5
            simp [TRY3.split_stream2] at h_5
            obtain ⟨hrdin, -⟩ := h_5
            have hcirc := congr_fun hrdin (fstVldTrue + k)
            unfold hw_fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hcirc
            generalize hst : Stream'.iterate
              (Prod.snd ∘ fork_corec rdOut1_1 rdOut2_1 vldIn_1 dataIn_1) (0, 0#1, 0#1)
              (fstVldTrue + k) = s at hcirc
            obtain ⟨a, b, c⟩ := s
            dsimp [fork_corec, comb_and, comb_xor, comb_or, hw_constant] at hcirc
            have ha : a = fstVldTrue + k := by
              have := @fork_corec1 rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 0 0#1 0#1 (fstVldTrue + k)
              simp [hst] at this
              simp [this]
            have hb0 : b = 0#1 := by
              suffices key : ∀ m, (∀ j < m, rdOut1_1 j = 0#1 ∨ vldOut1_1 j = 0#1) →
                  (Stream'.iterate (Prod.snd ∘ fork_corec rdOut1_1 rdOut2_1 vldIn_1 dataIn_1)
                    (0, 0#1, 0#1) m).2.1 = 0#1 by
                have := key (fstVldTrue + k) (by
                  intro j hj
                  by_cases hjlt : j < fstVldTrue
                  · right; by_contra hc
                    have : vldOut1_1 j = 1#1 := true_of_width_one (b := vldOut1_1 j) hc
                    have := vldOut1_implies_vldIn hh5 (n := j) (by assumption)
                    specialize hfstVldTrue2 j hjlt
                    simp [this] at hfstVldTrue2
                  · have hklt : k < fstRdyOut := by
                      by_contra hkge; push_neg at hkge
                      rcases Nat.lt_or_eq_of_le hkge with hlt' | rfl
                      · exact hlt (hkall fstRdyOut hlt')
                      · exact hlt hkvld
                    have hklt : k < fstRdyOut := by
                      by_contra hkge; push_neg at hkge
                      exact hlt (hkall fstRdyOut (by omega))
                    left
                    have := hfstRdyOut.2 (j - fstVldTrue) (by omega)
                    rwa [Nat.add_sub_cancel' (by omega)] at this
                )
                rw [hst] at this; simpa using this
              intro m; induction m with
              | zero => simp [Stream'.iterate]
              | succ km ihkm =>
                intro hbef
                have hbk := ihkm (fun j hj => hbef j (Nat.lt_succ_of_lt hj))
                generalize hsk : Stream'.iterate
                  (Prod.snd ∘ fork_corec rdOut1_1 rdOut2_1 vldIn_1 dataIn_1) (0, 0#1, 0#1) km = sk
                obtain ⟨ak, bk, ck⟩ := sk
                simp [hsk] at hbk; subst hbk
                have hak : ak = km := by
                  have := @fork_corec1 rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 0 0#1 0#1 km
                  simp [hsk] at this; omega
                have hvldk : vldOut1_1 km = vldIn_1 ak := by
                  rw [hw_fork_eq] at hh5; simp [TRY3.split_stream2] at hh5
                  obtain ⟨-, hvldout1, -⟩ := hh5
                  have hn := congr_fun hvldout1 km
                  unfold hw_fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hn
                  simp_rw [hsk] at hn
                  dsimp [fork_corec, comb_and, comb_xor, hw_constant] at hn
                  simp [hn]
                  ext k hk
                  simp [show k = 0 by omega]
                have hkbef := hbef km (Nat.lt_succ_self km)
                rw [iterate_back_succ, hsk]; simp only [Function.comp]
                dsimp [fork_corec, comb_and, comb_xor, comb_or, hw_constant]
                subst hak
                rcases hkbef with hh | hh
                · simp [hh]
                · rw [hvldk] at hh; simp [hh]
            have hrda : rdOut1_1 (fstVldTrue + k) = 0#1 := by
              have := hfstRdyOut.2 k (by grind)
              simpa using this
            rw [hkrd, hb0, ha] at hcirc
            simp [hrda] at hcirc
          simp [hvalidIn, hreadyIn, hrdout, hvldout]
          rw [← hdataeq]
          let diff := fstSentIdx - fstVldTrue
          have hdiff : fstSentIdx = fstVldTrue + diff := by omega
          have hdatain : dataIn_1 fstSentIdx = dataIn_1 fstVldTrue := by
            rw [hdiff]
            have := data_remains_constant_if (i := fstVldTrue) (rdy := rdIn_1) (vld := vldIn_1) (data := dataIn_1)
                                              (by assumption) (by assumption) (by assumption)
            obtain ⟨kd, hkd1, hkd2, hkd3, hkd4⟩ := this
            by_cases hle : diff ≤ kd
            · specialize hkd4 diff hle
              apply hkd4
            · /- contra -/
              exfalso
              have hkdlt : fstVldTrue + kd < fstSentIdx := by omega
              have := hfstSentIdx.2 (fstVldTrue + kd) hkdlt
              rw [h_6, toStream] at this
              simp [hkd1, hkd2] at this
          rw [hdatain]
          symm
          have := data_remains_constant_until_first (i := fstVldTrue)
                    (data := dataIn_1) (rdy := rdIn_1) (vld := vldIn_1) (by assumption)
                    (by assumption) (by assumption)
          obtain ⟨k, hk1, hk2, hk3, hk4, hk5⟩ := this
          have hkeqdiff : k = diff := by
            apply Nat.le_antisymm
            · by_contra hlt; push_neg at hlt
              -- hlt : diff < k
              have := hk5 diff (by omega)
              rw [← hdiff] at this
              simp [hreadyIn] at this
            · by_contra hlt; push_neg at hlt
              have := hfstSentIdx.2 (fstVldTrue + k) (by omega)
              rw [h_6, toStream] at this
              simp [hk1, hk2] at this
          subst hkeqdiff
          apply hk4 fstRdyOut
          apply by_contra
          intro hcontra
          simp at hcontra
          obtain ⟨h1, h2⟩ := hfstRdyOut
          specialize hfstRec (by exists (fstVldTrue + fstRdyOut))
          obtain ⟨fstrec, hfstrec⟩ := hfstRec
          simp [h_7, toStream] at hfstrec
          simp_all
          sorry
        · /- contradiction: nothing can be sent before `fstSentIdx`  -/
          simp_all
          intro hcontra
          specialize hfstVldTrue2 fstSentIdx hle
          simp [toStream, hfstVldTrue2] at hfstSentIdx
      · intro i hi
        exact hfstSentIdx.2 i hi
      · intros j hj
        by_cases hj' : j < fstVldTrue
        · simp [Stream'.get, h_7, toStream]
          intro hvld
          have := vldOut1_implies_vldIn h_5 (n := j)
          have := hfstVldTrue2 j hj'
          grind
        · simp [h_7, toStream, Stream'.get]
          let diff := j - fstVldTrue
          have : j = fstVldTrue + diff := by omega
          rw [this]
          obtain ⟨h1,h2⟩ := hfstRdyOut
          specialize h2 diff (by omega)
          intro hc
          simp [hc] at h2
    · /- if we never have a valid signal, all streams are empty and the relation holds trivially -/
      have hnonein := not_exists_transmitted_element (x := sin) (data := dataIn_1) (rdy := rdIn_1)
                                              (vld := vldIn_1) (by grind) h_6
      /- the fork module will never transmit anything meaningful -/
      rw [hw_fork_eq] at h_5
      unfold TRY3.split_stream2 at h_5
      simp at h_5
      have hhfork1 := h_5
      obtain ⟨hrd', hvld1', hvld2', hdata1', hdata2'⟩ := hhfork1
      rw [h_6, h_7]
      have hnoneout : ∀ k, vldOut1_1 k = 0#1 := by
          unfold hw_fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hvld1'
          intros k
          generalize hst : Stream'.iterate
            (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) k = s at hvld1'
          simp [fork_corec] at hvld1'
          have hk := congr_fun hvld1' k
          simp [comb_and, hw_constant] at hk
          simp_all

          have : vldIn_1 (Stream'.iterate (Prod.snd ∘ fork_corec rdOut1_1 rdOut2_1 vldIn_1 dataIn_1) (0, 0#1, 0#1) k).1 = 0#1 := by
            grind
          simp [this]
      have hnoneout2 : ∀ k, vldOut2_1 k = 0#1 := by
          unfold hw_fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hvld2'
          intros k
          generalize hst : Stream'.iterate
            (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) k = s at hvld2'
          simp [fork_corec] at hvld2'
          have hk := congr_fun hvld2' k
          simp [comb_and, hw_constant] at hk
          simp_all
          have : vldIn_1 (Stream'.iterate (Prod.snd ∘ fork_corec rdOut1_1 rdOut2_1 vldIn_1 dataIn_1) (0, 0#1, 0#1) k).1 = 0#1 := by
            grind
          simp [this]
      have hnevldin : ∀ k, vldIn_1 k = 0#1 := by grind
      have hnonet := not_exists_transmitted_element (x := sout) (data := dataOut1_1) (rdy := rdOut1_1)
                                              (vld := vldOut1_1) (by grind) h_7
      exists 0, 0
      and_intros
      · simp
        generalize hxgen : Stream'.drop 1 (toStream rdIn_1 vldIn_1 dataIn_1) = y'
        generalize hygen : Stream'.drop 1 (toStream rdOut1_1 vldOut1_1 dataOut1_1) = x'
        apply relation_fork.intro (x := y') (y := x')
                (dataIn := Stream'.drop 1 dataIn_1)
                (rdIn := Stream'.drop 1 rdIn_1)
                (vldIn := Stream'.drop 1 vldIn_1)
                (vldOut1 := Stream'.drop 1 vldOut1_1)
                (vldOut2 := Stream'.drop 1 vldOut2_1)
                (dataOut1 := Stream'.drop 1 dataOut1_1)
                (dataOut2 := Stream'.drop 1 dataOut2_1)
                (rdOut1 := Stream'.drop 1 rdOut1_1)
                (rdOut2 := Stream'.drop 1 rdOut2_1)
        · rw [← hxgen]
          rfl
        · rw [← hygen]
          rfl
        · /- contra in hj: there is no i such that vldIn' = 1#1 -/
          unfold globallyValidUntilReady
          intros j hj
          specialize hnevldin (j + 1)
          have : Stream'.drop 1 vldIn_1 j = vldIn_1 (j + 1) := by rfl
          simp [this, hnevldin] at hj
        · unfold globallyValidUntilReady
          intros j hj
          apply Classical.byContradiction
          simp [Stream'.drop] at hj
          have := hnoneout (1 + j)
          simp [show vldOut1_1.get (j + 1) = vldOut1_1 (j + 1) by rfl] at hj
          simp [Nat.add_comm (n := j), this] at hj
        · unfold globallyValidUntilReady
          intros j hj
          apply Classical.byContradiction
          simp [Stream'.drop] at hj
          have := hnoneout2 (1 + j)
          simp [show vldOut2_1.get (j + 1) = vldOut2_1 (j + 1) by rfl] at hj
          simp [Nat.add_comm (n := j), this] at hj
        · /- contra in hj: there is no i such that vldIn' = 1#1 -/
          unfold globallyValidAndData
          intros j hj
          have : Stream'.drop 1 vldIn_1 j = vldIn_1 (j + 1) := by rfl
          specialize hnevldin (j + 1)
          simp [this, hnevldin] at hj
        · /- follows from `hgfrOut1'` -/
          unfold globallyFinallyReady at h_4 ⊢
          intros i
          specialize h_4 (i + 1)
          obtain ⟨j, hj⟩ := h_4
          exists j
          have : Stream'.drop 1 rdOut1_1 (i + j) = rdOut1_1 ((i + j) + 1) := by rfl
          rw [this, show i + j + 1 = i + 1 + j by omega, hj]
        · /- after dropping one element, all the relations defined by the fork module remain.
            We see this by unfolding the fork hypotheses -/
          unfold TRY3.split_stream2
          simp
          have h1 := hw_fork'_of_all_none
                    (dataIn := Stream'.drop 1 dataIn_1)
                    (vldIn := Stream'.drop 1 vldIn_1)
                    (rdOut1 := Stream'.drop 1 rdOut1_1)
                    (rdOut2 := Stream'.drop 1 rdOut2_1)
                    (by
                      intro k
                      specialize hnevldin (k + 1)
                      simp [show Stream'.drop 1 vldIn_1 k = vldIn_1 (k + 1) by rfl, hnevldin]
                      )
          have h2 := hw_fork'_of_all_none
                    (dataIn := dataIn_1)
                    (vldIn := vldIn_1)
                    (rdOut1 := rdOut1_1)
                    (rdOut2 := rdOut2_1)
                    (by grind)
          rw [hw_fork_eq]
          simp_all
          and_intros
          · rfl
          · ext l n
            have hlhs := hw_fork_out0
              (data_in := dataIn_1)
              (vld_in := vldIn_1)
              (rd0_in := rdOut1_1)
              (rd1_in := rdOut2_1)
              (rdy_out := fun i => (hw_fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).1)
              (vld0_out := fun i => (hw_fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.1)
              (vld1_out := fun i => (hw_fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.1)
              (data0_out := fun i => (hw_fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.2.1)
              (data1_out := fun i => (hw_fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.2.2)
              (by rw [← hw_fork_eq]; simp [TRY3.split_stream2]) (1 + l)
            have hrhs := hw_fork_out0
              (rdy_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).1)
              (vld0_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).2.1)
              (vld1_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).2.2.1)
              (data0_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).2.2.2.1)
              (data1_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).2.2.2.2)
              (by rw [← hw_fork_eq]; simp [TRY3.split_stream2]) l
            simp [Stream'.drop] at hrhs
            have h1 : Stream'.get (fun i => (hw_fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.2.1) (1 + l) =
                  (fun i => (hw_fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.2.1) (1 + l) := by rfl
            simp [h1]
            have h2 : (Stream'.get (fun i =>
                        (hw_fork' (Stream'.drop 1 rdOut1_1)
                          (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1)
                          (Stream'.drop 1 dataIn_1) i).2.2.2.1) l) =
                      (fun i =>
                        (hw_fork' (Stream'.drop 1 rdOut1_1)
                          (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1)
                          (Stream'.drop 1 dataIn_1) i).2.2.2.1) l := by rfl
            simp [h2]
            simp [← hrhs, ← hlhs]
            simp [show dataIn_1.get (l + 1) = dataIn_1 (l + 1) by rfl, Nat.add_comm]
          · ext l n
            have hlhs := hw_fork_out1
              (data_in := dataIn_1)
              (vld_in := vldIn_1)
              (rd0_in := rdOut1_1)
              (rd1_in := rdOut2_1)
              (rdy_out := fun i => (hw_fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).1)
              (vld0_out := fun i => (hw_fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.1)
              (vld1_out := fun i => (hw_fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.1)
              (data0_out := fun i => (hw_fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.2.1)
              (data1_out := fun i => (hw_fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.2.2)
              (by rw [← hw_fork_eq]; simp [TRY3.split_stream2]) (1 + l)
            have hrhs := hw_fork_out1
              (rdy_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).1)
              (vld0_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).2.1)
              (vld1_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).2.2.1)
              (data0_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).2.2.2.1)
              (data1_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).2.2.2.2)
              (by rw [← hw_fork_eq]; simp [TRY3.split_stream2]) l
            simp [Stream'.drop] at hrhs

            have h1 : Stream'.get (fun i => (hw_fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.2.2) (1 + l) =
                  (fun i => (hw_fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.2.2) (1 + l) := by rfl
            simp [h1]
            have h2 : (Stream'.get (fun i =>
                        (hw_fork' (Stream'.drop 1 rdOut1_1)
                          (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1)
                          (Stream'.drop 1 dataIn_1) i).2.2.2.2) l) =
                      (fun i =>
                        (hw_fork' (Stream'.drop 1 rdOut1_1)
                          (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1)
                          (Stream'.drop 1 dataIn_1) i).2.2.2.2) l := by rfl
            simp [h2]
            simp [← hrhs, ← hlhs]
            simp [show dataIn_1.get (l + 1) = dataIn_1 (l + 1) by rfl, Nat.add_comm]
      · unfold toStream
        congr
        have : (fun i => if rdIn_1 i = 1#1 ∧ vldIn_1 i = 1#1 then some (dataIn_1 i) else none) =
              fun i => none := by
            ext k hk
            grind
        simp [this]
        have : (fun i => if rdOut1_1 i = 1#1 ∧ vldOut1_1 i = 1#1 then some (dataOut1_1 i) else none) =
              fun i => none := by
            ext k hk
            grind
        simp [this]
      · simp
      · simp
  · apply relation_fork.intro (toStream rdIn vldIn dataIn) (toStream rdOut1 vldOut1 dataOut1)
          (dataOut2 := dataOut2) (vldOut2 := vldOut2)
    · rfl
    · rfl
    · assumption
    · assumption
    · assumption
    · congr
    · assumption
    · assumption

#print axioms hw_fork_refines1_with_fork

/-- the standard implementation of the fork refines the handshake fork (`TRY2.hw_fork`) -/
theorem hw_fork_refines2:
    /- Given a handshake fork taking `a` as input and returning `(a, a)`, we take
      its lowering (with input a bisimilar ready-valid wrapped stream) -/
    (rdy, vld1, vld2, o1, o2) = TRY3.split_stream2 (TRY3.hw_fork rd1 rd2 vld data) →
    /- We want to make sure that stalling is correctly modeled for `a` (input).
      We constrain the input and prove that if the input behaves properly,
      the output will. -/
    globallyValidUntilReady vld rdy →
    globallyValidUntilReady vld1 rd1 →
    globallyValidUntilReady vld2 rd2 →
    globallyValidAndData vld data →
    /- we assume no deadlock -/
    globallyFinallyReady rd1 →
    globallyFinallyReady rd2 →
    /- if we know that the hshake input stream is bisimilar to the ready-valid input of the hw fork (`a ~ rdy vld i`), meaning that the two outputs are also bisimilar by transitivity-/
    /- we want to prove that the outputs of the handshake fork are respectively
      bisimilar to the ready-valid wrapping of the output of the hardware fork -/
    (toStream rd2 vld2 o2) ~ (toStream rdy vld data) := by
  intros hardware_hw globValReady globValReady1 globValReady2 globValData globFinReady1 globFinReady2
  /- if 0, 0 works we don't need bisimilarity -/
  /- the high-level fork will never wait for anything (whenever an input is available),
    while the low-level one might have to, and depends on the `rd1` signal eventually being true.
    if we choose `pred := Eq` the relation is too strong, the second goal is not provable.
  -/
  apply Bisim.coinduct (pred := relation_fork)
  · intros s1 s2 hrel

    sorry
  · apply relation_fork.intro (toStream rd2 vld2 o2) (toStream rdy vld data)
    · rfl
    · rfl
    · unfold globallyValidUntilReady
      intros j hj1
      unfold globallyValidUntilReady at globValReady2
      specialize globValReady2 j
      simp [hj1] at globValReady2
      obtain ⟨k', hk'⟩ := globValReady2
      exists k'
    · unfold globallyValidAndData
      intros j hj
      unfold globallyValidAndData at globValData
      unfold globallyValidUntilReady at globValReady2
      specialize globValReady2 j (by simp [hj])
      have := fork_corec rdy rd1 vld o2
      sorry
    ·
      sorry
    · unfold TRY3.split_stream2 TRY3.hw_fork
      simp
      sorry
    ·
      sorry
    ·
      sorry
    ·
      sorry


/-- the standard implementation of the fork refines the handshake fork (`TRY2.hw_fork`) -/
theorem hw_fork_refines1:
    /- Given a handshake fork taking `a` as input and returning `(a, a)`, we take
      its lowering (with input a bisimilar ready-valid wrapped stream) -/
    (rdy, vld1, vld2, o1, o2) = TRY3.split_stream2 (TRY3.hw_fork rd1 rd2 vld data) →
    /- We want to make sure that stalling is correctly modeled for `a` (input).
      We constrain the input and prove that if the input behaves properly,
      the output will. -/
    globallyValidUntilReady vld1 rd1 →
    globallyValidUntilReady vld2 rd2 →
    globallyValidUntilReady vld rdy →
    globallyValidAndData vld1 o1 →
    globallyValidAndData vld2 o2 →
    /- we assume no deadlock -/
    globallyFinallyReady rdy →
    globallyFinallyReady rd1 →
    globallyFinallyReady rd2 →
    /- if we know that the hshake input stream is bisimilar to the ready-valid input of the hw fork (`a ~ rdy vld i`), meaning that the two outputs are also bisimilar by transitivity-/
    /- we want to prove that the outputs of the handshake fork are respectively
      bisimilar to the ready-valid wrapping of the output of the hardware fork -/
    (toStream rd1 vld1 o1) ~ (toStream rdy vld data) := by
  intros hardware_hw globValReady1 globValReady2 globValReady globValData1 globValData2 globFinReady globFinReady1 globFinReady2
  /- if 0, 0 works we don't need bisimilarity -/
  /- the high-level fork will never wait for anything (whenever an input is available),
    while the low-level one might have to, and depends on the `rd1` signal eventually being true.
    if we choose `pred := Eq` the relation is too strong, the second goal is not provable.
  -/
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
