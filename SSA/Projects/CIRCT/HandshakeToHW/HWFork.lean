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
  | intro x y rdIn vldIn dataIn rdOut1 vldOut1 dataOut1 :  /- same as `∀ x y` -/
      /- x is the high-level (input), y is the low-level (output) -/
      x = toStream rdIn vldIn dataIn →
      y = toStream rdOut1 vldOut1 dataOut1 →
      /- if a signal in `x` is valid (`vldIn i = 1#1`), it will remain valid (at least) until a
        ready signal is received (`rdIn (i + k) = 1#1`). A ready signal is eventually definitely received.  -/
      globallyValidUntilReady vldIn rdIn →
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

theorem emitted0_zero_before_allDone
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

theorem data_remains_constant_if
    (h : globallyValidAndData vld data)
    (h' : globallyValidUntilReady vld rdy) :
  ∀ i, vld i = 1#1 →
    ∃ k, rdy (i + k) = 1#1 ∧ vld (i + k) = 1#1 ∧
    ∀ j (_hj : j < k), vld (i + j) = 1#1 ∧
    ∀ j (_hj : j ≤ k), data (i + j) = data i := by
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
    · intros j hj
      and_intros
      · obtain ⟨h1, h2, h3⟩ := hk
        apply h3
        assumption
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
    · simp [show k = 0 by omega]
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

theorem exists_transmitted_element
  (h : globallyValidUntilReady vld rdy)
  (hx : x = toStream rdy vld data) :
    ∃ k, x k  = some (data k ) ∨ ∀ k, x k = none := by
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
  intros hfork hgvurOutt1 hvgurOut2 hgvurIn hgvdOut1 hgvdOut2 hgvIn hgfrIn hgfrOUt1 hgfrOut2
  /- if 0, 0 works we don't need bisimilarity -/
  /- the high-level fork will never wait for anything (whenever an input is available),
    while the low-level one might have to, and depends on the `rd1` signal eventually being true.
    if we choose `pred := Eq` the relation is too strong, the second goal is not provable.
  -/

  apply Bisim.coinduct (pred := relation_fork)
  · intros sin sout hrel
    /- `sin` and `sout` exist at the handshake level of the design -/
    rcases hrel
    rename_i vldOut2' dataOut2' rdOut2' rdIn' vldIn' dataIn' rdOut1' vldOut1' dataOut1' hgvurIn' hgvdIn' hgfrOut1' hhfork hsin hsout
    by_cases hvldExists : ∃ k, vldIn' k = 1#1
    · sorry
    · /- if we never have a valid signal, all streams are empty and the relation holds trivially -/
      have hnonein := not_exists_transmitted_element (x := sin) (data := dataIn') (rdy := rdIn')
                                              (vld := vldIn') (by grind) hsin
      /- the fork module will never transmit anything meaningful -/
      rw [hw_fork_eq] at hhfork
      unfold TRY3.split_stream2 at hhfork
      simp at hhfork
      have hhfork1 := hhfork
      obtain ⟨hrd', hvld1', hvld2', hdata1', hdata2'⟩ := hhfork1
      rw [hsin, hsout]
      have hnoneout : ∀ k, vldOut1' k = 0#1 := by
          unfold hw_fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hvld1'
          intros k
          generalize hst : Stream'.iterate
            (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) k = s at hvld1'
          simp [fork_corec] at hvld1'
          have hk := congr_fun hvld1' k
          simp [comb_and, hw_constant] at hk
          simp_all
          have : vldIn' (Stream'.iterate (Prod.snd ∘ fork_corec rdOut1' rdOut2' vldIn' dataIn') (0, 0#1, 0#1) k).1 = 0#1 := by
            grind
          simp [this]
      have hnevldin : ∀ k, vldIn' k = 0#1 := by grind
      have hnonet := not_exists_transmitted_element (x := sout) (data := dataOut1') (rdy := rdOut1')
                                              (vld := vldOut1') (by grind) hsout

      exists 0, 0
      and_intros
      · simp
        generalize hxgen : Stream'.drop 1 (toStream rdIn' vldIn' dataIn') = x'
        generalize hygen : Stream'.drop 1 (toStream rdOut1' vldOut1' dataOut1') = y'
        apply relation_fork.intro (x := x') (y := y')
                (dataIn := Stream'.drop 1 dataIn')
                (rdIn := Stream'.drop 1 rdIn')
                (vldIn := Stream'.drop 1 vldIn')
                (vldOut1 := Stream'.drop 1 vldOut1')
                (vldOut2 := Stream'.drop 1 vldOut2')
                (dataOut1 := Stream'.drop 1 dataOut1')
                (dataOut2 := Stream'.drop 1 dataOut2')
                (rdOut1 := Stream'.drop 1 rdOut1')
                (rdOut2 := Stream'.drop 1 rdOut2')
        · rw [← hxgen]
          rfl
        · rw [← hygen]
          rfl
        · /- contra in hj: there is no i such that vldIn' = 1#1 -/
          unfold globallyValidUntilReady
          intros j hj
          specialize hnevldin (j + 1)
          have : Stream'.drop 1 vldIn' j = vldIn' (j + 1) := by rfl
          simp [this, hnevldin] at hj
        · /- contra in hj: there is no i such that vldIn' = 1#1 -/
          unfold globallyValidAndData
          intros j hj
          have : Stream'.drop 1 vldIn' j = vldIn' (j + 1) := by rfl
          specialize hnevldin (j + 1)
          simp [this, hnevldin] at hj
        · /- follows from `hgfrOut1'` -/
          unfold globallyFinallyReady at hgfrOut1' ⊢
          intros i
          specialize hgfrOut1' (i + 1)
          obtain ⟨j, hj⟩ := hgfrOut1'
          exists j
          have : Stream'.drop 1 rdOut1' (i + j) = rdOut1' ((i + j) + 1) := by rfl
          rw [this, show i + j + 1 = i + 1 + j by omega, hj]
        · /- after dropping one element, all the relations defined by the fork module remain.
            We see this by unfolding the fork hypotheses -/
          unfold TRY3.split_stream2
          simp
          have h1 := hw_fork'_of_all_none
                    (dataIn := Stream'.drop 1 dataIn')
                    (vldIn := Stream'.drop 1 vldIn')
                    (rdOut1 := Stream'.drop 1 rdOut1')
                    (rdOut2 := Stream'.drop 1 rdOut2')
                    (by
                      intro k
                      specialize hnevldin (k + 1)
                      simp [show Stream'.drop 1 vldIn' k = vldIn' (k + 1) by rfl, hnevldin]
                      )
          have h2 := hw_fork'_of_all_none
                    (dataIn := dataIn')
                    (vldIn := vldIn')
                    (rdOut1 := rdOut1')
                    (rdOut2 := rdOut2')
                    (by grind)
          rw [hw_fork_eq]
          simp_all
          and_intros
          · rfl
          · ext l n
            have hlhs := hw_fork_out0
              (data_in := dataIn')
              (vld_in := vldIn')
              (rd0_in := rdOut1')
              (rd1_in := rdOut2')
              (rdy_out := fun i => (hw_fork' rdOut1' rdOut2' vldIn' dataIn' i).1)
              (vld0_out := fun i => (hw_fork' rdOut1' rdOut2' vldIn' dataIn' i).2.1)
              (vld1_out := fun i => (hw_fork' rdOut1' rdOut2' vldIn' dataIn' i).2.2.1)
              (data0_out := fun i => (hw_fork' rdOut1' rdOut2' vldIn' dataIn' i).2.2.2.1)
              (data1_out := fun i => (hw_fork' rdOut1' rdOut2' vldIn' dataIn' i).2.2.2.2)
              (by rw [← hw_fork_eq]; simp [TRY3.split_stream2]) (1 + l)
            have hrhs := hw_fork_out0
              (rdy_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1') (Stream'.drop 1 rdOut2') (Stream'.drop 1 vldIn') (Stream'.drop 1 dataIn') i).1)
              (vld0_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1') (Stream'.drop 1 rdOut2') (Stream'.drop 1 vldIn') (Stream'.drop 1 dataIn') i).2.1)
              (vld1_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1') (Stream'.drop 1 rdOut2') (Stream'.drop 1 vldIn') (Stream'.drop 1 dataIn') i).2.2.1)
              (data0_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1') (Stream'.drop 1 rdOut2') (Stream'.drop 1 vldIn') (Stream'.drop 1 dataIn') i).2.2.2.1)
              (data1_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1') (Stream'.drop 1 rdOut2') (Stream'.drop 1 vldIn') (Stream'.drop 1 dataIn') i).2.2.2.2)
              (by rw [← hw_fork_eq]; simp [TRY3.split_stream2]) l
            simp [Stream'.drop] at hrhs
            have h1 : Stream'.get (fun i => (hw_fork' rdOut1' rdOut2' vldIn' dataIn' i).2.2.2.1) (1 + l) =
                  (fun i => (hw_fork' rdOut1' rdOut2' vldIn' dataIn' i).2.2.2.1) (1 + l) := by rfl
            simp [h1]
            have h2 : (Stream'.get (fun i =>
                        (hw_fork' (Stream'.drop 1 rdOut1')
                          (Stream'.drop 1 rdOut2') (Stream'.drop 1 vldIn')
                          (Stream'.drop 1 dataIn') i).2.2.2.1) l) =
                      (fun i =>
                        (hw_fork' (Stream'.drop 1 rdOut1')
                          (Stream'.drop 1 rdOut2') (Stream'.drop 1 vldIn')
                          (Stream'.drop 1 dataIn') i).2.2.2.1) l := by rfl
            simp [h2]
            simp [← hrhs, ← hlhs]
            simp [show dataIn'.get (l + 1) = dataIn' (l + 1) by rfl, Nat.add_comm]
          · ext l n
            have hlhs := hw_fork_out1
              (data_in := dataIn')
              (vld_in := vldIn')
              (rd0_in := rdOut1')
              (rd1_in := rdOut2')
              (rdy_out := fun i => (hw_fork' rdOut1' rdOut2' vldIn' dataIn' i).1)
              (vld0_out := fun i => (hw_fork' rdOut1' rdOut2' vldIn' dataIn' i).2.1)
              (vld1_out := fun i => (hw_fork' rdOut1' rdOut2' vldIn' dataIn' i).2.2.1)
              (data0_out := fun i => (hw_fork' rdOut1' rdOut2' vldIn' dataIn' i).2.2.2.1)
              (data1_out := fun i => (hw_fork' rdOut1' rdOut2' vldIn' dataIn' i).2.2.2.2)
              (by rw [← hw_fork_eq]; simp [TRY3.split_stream2]) (1 + l)
            have hrhs := hw_fork_out1
              (rdy_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1') (Stream'.drop 1 rdOut2') (Stream'.drop 1 vldIn') (Stream'.drop 1 dataIn') i).1)
              (vld0_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1') (Stream'.drop 1 rdOut2') (Stream'.drop 1 vldIn') (Stream'.drop 1 dataIn') i).2.1)
              (vld1_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1') (Stream'.drop 1 rdOut2') (Stream'.drop 1 vldIn') (Stream'.drop 1 dataIn') i).2.2.1)
              (data0_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1') (Stream'.drop 1 rdOut2') (Stream'.drop 1 vldIn') (Stream'.drop 1 dataIn') i).2.2.2.1)
              (data1_out := fun i =>
                (hw_fork' (Stream'.drop 1 rdOut1') (Stream'.drop 1 rdOut2') (Stream'.drop 1 vldIn') (Stream'.drop 1 dataIn') i).2.2.2.2)
              (by rw [← hw_fork_eq]; simp [TRY3.split_stream2]) l
            simp [Stream'.drop] at hrhs

            have h1 : Stream'.get (fun i => (hw_fork' rdOut1' rdOut2' vldIn' dataIn' i).2.2.2.2) (1 + l) =
                  (fun i => (hw_fork' rdOut1' rdOut2' vldIn' dataIn' i).2.2.2.2) (1 + l) := by rfl
            simp [h1]
            have h2 : (Stream'.get (fun i =>
                        (hw_fork' (Stream'.drop 1 rdOut1')
                          (Stream'.drop 1 rdOut2') (Stream'.drop 1 vldIn')
                          (Stream'.drop 1 dataIn') i).2.2.2.2) l) =
                      (fun i =>
                        (hw_fork' (Stream'.drop 1 rdOut1')
                          (Stream'.drop 1 rdOut2') (Stream'.drop 1 vldIn')
                          (Stream'.drop 1 dataIn') i).2.2.2.2) l := by rfl
            simp [h2]
            simp [← hrhs, ← hlhs]
            simp [show dataIn'.get (l + 1) = dataIn' (l + 1) by rfl, Nat.add_comm]
      · unfold toStream
        congr
        have : (fun i => if rdIn' i = 1#1 ∧ vldIn' i = 1#1 then some (dataIn' i) else none) =
              fun i => none := by
            ext k hk
            grind
        simp [this]
        have : (fun i => if rdOut1' i = 1#1 ∧ vldOut1' i = 1#1 then some (dataOut1' i) else none) =
              fun i => none := by
            ext k hk
            grind
        simp [this]
      · simp
      · simp
  · apply relation_fork.intro (toStream rdIn vldIn dataIn) (toStream rdOut1 vldOut1 dataOut1)
    · rfl
    · rfl
    · assumption
    · assumption
    · assumption
    · congr



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
