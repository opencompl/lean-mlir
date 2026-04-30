import SSA.Projects.CIRCT.Stream.Basic
import SSA.Projects.CIRCT.Stream.Lemmas
import SSA.Projects.CIRCT.Register.Basic
import SSA.Projects.CIRCT.Register.Lemmas

namespace HWComponents

open HandshakeStream



/--
  Latency-insensitive (handshake) fork component.
  We assume that there are infinite buffers at the input and output of the fork.
  This implies that ready == 1 (at the output), and that the input stream can be delayed infinitely long.

  Under this assumption, we do not really need the registers,
  because we will instantly emit a value, and the registers will be constant true.

  This spec is the same as the hardware implementation if we guarantee that
  a `ready` signal is received (no deadlock).
 -/
def handshake.fork (in0 : Stream (BitVec 32)) : Stream (BitVec 32) × Stream (BitVec 32) :=
  (in0, in0)


/-!
  RTL-level definitions of circuit components
-/
def hw_constant (b : Bool) : BitVec 1 := if b then 1#1 else 0#1

def comb_xor (x y : BitVec 1) : BitVec 1 := BitVec.xor x y

def comb_and (x y : BitVec 1) : BitVec 1 := BitVec.and x y

def comb_add (x y : BitVec 32) : BitVec 32 := BitVec.add x y

def comb_or (x y : BitVec 1) : BitVec 1 := BitVec.or x y

/--
  RTL implementation of fork circuit.
  We assume that valid signals are given by the stream,
  and that ready signals are given by nondeterministic booleans.
 -/
def rtl.fork (_ready _ready_1 _valid : Stream' (BitVec 1)) (_in0 : Stream' (BitVec 32))
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

/--
  Split a stream containing the product of 5 objects into a product of 5 streams,
  each representing a stream of single objects.
-/
def project_stream :
    Stream' (a × b × c × d × e) → Stream' a × Stream' b × Stream' c × Stream' d × Stream' e :=
  fun g =>
      (fun i => (g i).1,
        fun i => (g i).2.1,
          fun i => (g i).2.2.1,
            fun i => (g i).2.2.2.1,
              fun i => (g i).2.2.2.2)

/--
  Define the relation between a latency-insensitive `Stream := Stream' (Option α)`
  and three concrete `Stream'` (representingready, valid, data signal).
-/
def toStream {α} (rdy : Stream' (BitVec 1)) (vld : Stream' (BitVec 1)) (data : Stream' α) : Stream α := fun i =>
  if rdy i == 1#1 && vld i == 1#1 then
    .some (data i)
  else
    .none


/--
  For every valid signal at any point in time `vld i = 1#1`,
  there is a later point in time `i + k` where the ready signal is true (`rdy (i + k) = 1#1`),
  and the valid signal remains constantly true until then.
-/
def globallyValidUntilReady (vld rdy : Stream' (BitVec 1)) : Prop :=
    ∀ (i : Nat), (vld i = 1#1) →
      ∃ (k : Nat), rdy (i + k) = 1#1 ∧ vld (i + k) = 1#1 ∧
        ∀ (j : Nat) (_hj : j < k), vld (i + j) = 1#1

/--
  Given a couple of consecutive valid signals (`vld i = 1#1 ∧ vld (i + 1) = 1#1`),
  the `data` stream at both points in time remains constant.
-/
def globallyValidAndData (vld : Stream' (BitVec 1)) (data : Stream' (BitVec w)) : Prop :=
    ∀ (i : Nat), (vld i = 1#1 ∧ vld (i + 1) = 1#1) → data i = data (i + 1)

/--
  For every point in time `i` of the ready signal, there exists a later (or simultaneous)
  point in time `i + k` where the signal is true.
-/
def globallyFinallyReady (rdy : Stream' (BitVec 1)) :=
  ∀ (i : Nat), ∃ (k : Nat), rdy (i + k) = 1#1

/--
  We propose a bisimilarity relation between latency-insensitive streams at the input and
  output of a `fork` circuit.
-/
inductive relation_fork : Stream (BitVec w) → Stream (BitVec w) → Prop where
  | intro x y rdIn vldIn dataIn rdOut1 vldOut1 dataOut1 rdOut2 vldOut2 dataOut2 :  /- same as `∀ x y` -/
      /- *If* x is the input stream, encoded via 3-way-handshake of streams rdIn, vldIn, dataIn -/
      x = toStream rdIn vldIn dataIn →
      /- *If* y is either of output streams of the fork,
        encoded via 3-way-handshake of streams rdOut1, vldOut1, dataOut1 -/
      y = toStream rdOut1 vldOut1 dataOut1 →
      /- *If* when a signal in `x` is valid (`vldIn i = 1#1`), it will remain valid (at least) until a
        ready signal is received (`rdIn (i + k) = 1#1`).
        A ready signal is eventually definitely received.  -/
      globallyValidUntilReady vldIn rdIn →
      /- *If* when a signal in `y` is valid (`vldOut1 i = 1#1`), it will remain valid (at least) until a
        ready signal is received (`rdOut1 (i + k) = 1#1`).
        A ready signal is eventually definitely received.  -/
      globallyValidUntilReady vldOut1 rdOut1 →
      /- *If* when a signal in `y` is valid (`vldOut2 i = 1#1`), it will remain valid (at least) until a
        ready signal is received (`rdOut2 (i + k) = 1#1`).
        A ready signal is eventually definitely received.  -/
      globallyValidUntilReady vldOut2 rdOut2 →
      /- *If* when a signal in `x` is valid for more than one cycle (`vldIn i = 1#1 ∧ vldIn (i + 1) = 1#1`),
        the data stream at those points in time remains constant (`dataIn i = dataIn (i + 1)`). -/
      globallyValidAndData vldIn dataIn →
      /- *If* eventually,
        a ready signal arrives from both receivers (`rdOut1 i = 1#1`), (`rdOut2 i = 1#1`). -/
      globallyFinallyReady rdOut1 →
      globallyFinallyReady rdOut2 →
      /- *If* the relations between the input and output ready, valid, data signals
        are given by the `rtl.fork` component. -/
      (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) = project_stream (rtl.fork rdOut1 rdOut2 vldIn dataIn) →
      /- The relation holds. -/
      relation_fork x y


/--
  Define the unfolding of one step of the corecursive definition of `fork`.
-/
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

/--
  Define the fork circuit in terms of `fork_corec`.
-/
def rtl.fork' (_ready _ready_1 _valid : Stream' (BitVec 1)) (_in0 : Stream' (BitVec 32))
    : Stream' ( BitVec 1  -- ready (_12)
              × BitVec 1  -- valid_0 (_3)
              × BitVec 1  -- valid_1 (_9)
              × BitVec 32 -- rawOutput
              × BitVec 32 -- rawOutput
      )
  := Stream'.corec' (α := Nat × BitVec 1 × BitVec 1) (fork_corec _ready _ready_1 _valid _in0) (0, 0#1, 0#1)

/--
  Prove that iterating `n` times starting from the `m`-th index of the stream
  yields the `n + m`-th index.
-/
theorem fork_corec_iter :
  (Stream'.iterate (Prod.snd ∘ fork_corec rd0_in rd1_in vld_in data_in) (m, x, y) n).1 = n + m := by
  induction n generalizing m x y with
  | zero => grind [Stream'.iterate]
  | succ x h =>
    rw [Stream'.iterate_eq]
    dsimp [Stream'.cons]
    dsimp [fork_corec]
    grind

/--
  If the valid input stream is false at all points in time (`vldIn k = 0#1`),
  the first valid output stream of the fork component is also false at all times.
-/
theorem fork'_vldOut1_of_none (h : ∀ k, vldIn k = 0#1) :
    ((rtl.fork' rdOut1 rdOut2 vldIn dataIn) k).2.1 = 0#1 := by
  unfold rtl.fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get
  generalize hst : Stream'.iterate
    (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) k = s
  obtain ⟨a, b, c⟩ := s
  dsimp [fork_corec, comb_and, comb_xor, hw_constant]
  specialize h a
  simp [h]

/--
  If the valid input stream is false at all points in time (`vldIn k = 0#1`),
  the second valid output stream of the fork component is also false at all times.
-/
theorem fork'_vldOut2_of_none (h : ∀ k, vldIn k = 0#1) :
    ((rtl.fork' rdOut1 rdOut2 vldIn dataIn) k).2.2.1 = 0#1 := by
  unfold rtl.fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get
  generalize hst : Stream'.iterate
    (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) k = s
  obtain ⟨a, b, c⟩ := s
  dsimp [fork_corec, comb_and, comb_xor, hw_constant]
  specialize h a
  simp [h]

/--
  TODO: Luisa does not understand what the gist of this lemma is.
-/
lemma iterate_back_succ (f : α → α) (s : α) (n : ℕ) :
    Stream'.iterate f s (n + 1) = f (Stream'.iterate f s n) := by
  induction n generalizing s with
  | zero => simp [Stream'.iterate_eq, Stream'.cons]
  | succ k ih => rw [Stream'.iterate_eq, Stream'.cons, ih]; rfl

/--
  TODO: Luisa does not understand what the gist of this lemma is.
-/
lemma fork_emitted_zero_of_all_none (h : ∀ k, vldIn k = 0#1) :
    ∀ k, (Stream'.iterate (Prod.snd ∘ (fork_corec rdOut1 rdOut2 vldIn dataIn))
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

/--
  If the input's valid signal is always false,
  for every point in time `k` the ready signal of the input and valid signals of the outputs of
  a fork circuit are false as well.
-/
theorem fork'_of_all_none (h : ∀ k, vldIn k = 0#1) :
    ∀ k, ((rtl.fork' rdOut1 rdOut2 vldIn dataIn) k).1 = 0#1 ∧
         ((rtl.fork' rdOut1 rdOut2 vldIn dataIn) k).2.1 = 0#1 ∧
         ((rtl.fork' rdOut1 rdOut2 vldIn dataIn) k).2.2.1 = 0#1 := by
  unfold rtl.fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get
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

/--
  We prove that, at RTL level, the input and first output data stream at the `n`-th position are the same.
  This is possible because `rtl.fork'` does not introduce any delay nor buffering,
  and there is no transformation happening on the data.
-/
theorem fork_dataIn_eq_dataOut1
    (h : ⟨rdy_out, vld0_out, vld1_out, data0_out, data1_out⟩ = project_stream (rtl.fork' rd0_in rd1_in vld_in data_in)) :
    (∀ n, data_in n = data0_out n) := by
  intro n
  simp [project_stream] at h
  simp [h]
  unfold rtl.fork'; clear h
  unfold Stream'.corec' Stream'.corec Stream'.map Stream'.get
  generalize h: (Stream'.iterate (Prod.snd ∘ fork_corec rd0_in rd1_in vld_in data_in) (0, 0#1, 0#1) n) = y
  obtain ⟨a, b, c⟩ := y
  dsimp [fork_corec]
  rw [show a = (a, b, c).1 by rfl, ← h, fork_corec_iter]; rfl

/--
  We prove that, at RTL level, the input and second output data stream at the `n`-th position are the same.
  This is possible because `rtl.fork'` does not introduce any delay nor buffering,
  and there is no transformation happening on the data.
-/
theorem fork_dataIn_eq_dataOut2
    (h : ⟨rdy_out, vld0_out, vld1_out, data0_out, data1_out⟩ =
      project_stream (rtl.fork' rd0_in rd1_in vld_in data_in)) :
    (∀ n, data_in n = data1_out n) := by
  intro n
  simp [project_stream] at h
  simp [h]
  unfold rtl.fork'; clear h
  unfold Stream'.corec' Stream'.corec Stream'.map Stream'.get
  generalize h: (Stream'.iterate (Prod.snd ∘ fork_corec rd0_in rd1_in vld_in data_in) (0, 0#1, 0#1) n) = y
  obtain ⟨a, b, c⟩ := y
  dsimp [fork_corec]
  rw [show a = (a, b, c).1 by rfl, ← h, fork_corec_iter]; rfl

/--
  Prove the equivalence of the two definitions of `rtl.fork`.
-/
theorem hw_fork_eq : rtl.fork rd0 rd1 vld data = rtl.fork' rd0 rd1 vld data := by
  unfold rtl.fork rtl.fork'
  congr 1

/--
  If at a certain point in time `n` the first output valid signal is true,
  then the input valid signal at that point in time is also true.
-/
theorem vldOut1_implies_vldIn
    (h : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) =
      project_stream (rtl.fork rdOut1 rdOut2 vldIn dataIn))
    (hvld : vldOut1 n = 1#1) : vldIn n = 1#1 := by
  rw [hw_fork_eq] at h
  simp [project_stream] at h
  obtain ⟨-, hvldout1, -⟩ := h
  have hn := congr_fun hvldout1 n
  rw [hvld] at hn
  unfold rtl.fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hn
  generalize hst : Stream'.iterate
    (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) n = s at hn
  obtain ⟨a, b, c⟩ := s
  dsimp [fork_corec, comb_and, comb_xor, hw_constant] at hn
  have heq : a = n := by
    have := @fork_corec_iter rdOut1 rdOut2 vldIn dataIn 0 0#1 0#1 n
    rw [hst] at this
    simp at this
    assumption
  rw [← heq]
  apply Classical.byContradiction
  intro hcontra
  have : vldIn a = 0#1 := by grind
  simp [this] at hn

/--
  If at a certain point in time `n` the second output valid signal is true,
  then the input valid signal at that point in time is also true.
-/
theorem vldOut2_implies_vldIn
    (h : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) =
      project_stream (rtl.fork rdOut1 rdOut2 vldIn dataIn))
    (hvld : vldOut2 n = 1#1) : vldIn n = 1#1 := by
  rw [hw_fork_eq] at h
  simp [project_stream] at h
  obtain ⟨-, -, hvldout2, -⟩ := h
  have hn := congr_fun hvldout2 n
  rw [hvld] at hn
  unfold rtl.fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hn
  generalize hst : Stream'.iterate
    (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn) (0, 0#1, 0#1) n = s at hn
  obtain ⟨a, b, c⟩ := s
  dsimp [fork_corec, comb_and, comb_xor, hw_constant] at hn
  have heq : a = n := by
    have := @fork_corec_iter rdOut1 rdOut2 vldIn dataIn 0 0#1 0#1 n
    rw [hst] at this
    simp at this
    assumption
  rw [← heq]
  apply Classical.byContradiction
  intro hcontra
  have : vldIn a = 0#1 := by grind
  simp [this] at hn

/--
  In a fork component with no-deadlock guarantees, there always exists a point in time
  when both the ready and the valid input signals are true, and therefore a valid input
  data signal arrives.
-/
theorem rdOut1_before_allDone
  (hfork : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) =
    project_stream (rtl.fork rdOut1 rdOut2 vldIn dataIn)) (hvldOut1 : vldOut1 n = 1#1)
  (hgvurIn : globallyValidUntilReady vldIn rdIn) :
    ∃ k, rdIn (n + k) = 1#1 ∧ vldIn (n + k) = 1#1 := by
  have hvldIn := vldOut1_implies_vldIn hfork hvldOut1
  unfold globallyValidUntilReady at hgvurIn
  specialize hgvurIn n  hvldIn
  obtain ⟨k, hk⟩ := hgvurIn
  exists k
  simp [hk]

/--
  In a fork circuit, at all points in time that come before the first element is transmitted,
  the input and output valid signal have the same value.
-/
theorem vldOut_eq_vldIn_of_fork_unitl_sent
    (hfork : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) =
      project_stream (rtl.fork rdOut1 rdOut2 vldIn dataIn))
    /- nothing is emitted before `n`, as emission occurs if `rdOut1 j ∧ vldOut1 j` -/
    (hbefore : ∀ j < n, rdOut1 j = 0#1 ∨ vldOut1 j = 0#1) :
    vldOut1 n = vldIn n := by
  rw [hw_fork_eq] at hfork
  simp [project_stream] at hfork
  obtain ⟨-, hvldout1, -⟩ := hfork
  have hn := congr_fun hvldout1 n
  unfold rtl.fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hn
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
        have := @fork_corec_iter rdOut1 rdOut2 vldIn dataIn 0 0#1 0#1 k
        simp [hsk] at this; omega
      have hk := hbef k (Nat.lt_succ_self k)
      simp only [Function.comp]
      have hvldk : vldOut1 k = vldIn ak := by
        have h := congr_fun hvldout1 k
        unfold rtl.fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at h
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
    have := @fork_corec_iter rdOut1 rdOut2 vldIn dataIn 0 0#1 0#1 n
    rw [hst] at this
    simp at this
    assumption
  rw [← heq] at ⊢ hn
  simp [hn]
  ext k hk
  simp [show k = 0 by omega]

theorem vldOut_of_vldIn_rdy
    (hfork : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) =
      project_stream (rtl.fork rdOut1 rdOut2 vldIn dataIn))
    /- nothing has been accepted so far -/
    (hbefore : ∀ l < j, rdOut1 l = 0#1 ∨ vldOut1 l = 0#1)
    (hin : vldIn j = 1#1 ∧ rdIn j = 1#1) :
    vldOut1 j = 1#1 := by
  rw [vldOut_eq_vldIn_of_fork_unitl_sent (hfork := hfork) (hbefore := hbefore)]
  simp [hin]

theorem vldOut_eq_vldIn_of_fork_unitl_sent2
    (hfork : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) =
      project_stream (rtl.fork rdOut1 rdOut2 vldIn dataIn))
    /- nothing is emitted before `n`, as emission occurs if `rdOut1 j ∧ vldOut1 j` -/
    (hbefore : ∀ j < n, rdOut2 j = 0#1 ∨ vldOut2 j = 0#1) :
    vldOut2 n = vldIn n := by
  rw [hw_fork_eq] at hfork
  simp [project_stream] at hfork
  obtain ⟨-, -, hvldout2, -⟩ := hfork
  have hn := congr_fun hvldout2 n
  unfold rtl.fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hn
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
          unfold rtl.fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at h
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
  (hfork : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) =
    project_stream (rtl.fork rdOut1 rdOut2 vldIn dataIn))
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
  (hfork : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) =
    project_stream (rtl.fork rdOut1 rdOut2 vldIn dataIn))
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
  (hfork : (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) =
    project_stream (rtl.fork rdOut1 rdOut2 vldIn dataIn))
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
      project_stream (rtl.fork rdOut1 rdOut2 vldIn dataIn))
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


def readyOut1UntilAllReceiversAre(rdOut1 rdOut2 : Stream' (BitVec 1)) :=
  ∀ i,
    rdOut1 i = 1#1 →
    ∀ j, rdOut2 (i + j) = 0#1 → rdOut1 (i + j) = 1#1

def readyOut2UntilAllReceiversAre (rdOut1 rdOut2 : Stream' (BitVec 1)) :=
  ∀ i,
    rdOut2 i = 1#1 →
    ∀ j, rdOut1 (i + j) = 0#1 → rdOut2 (i + j) = 1#1

/-- the standard implementation of the fork refines the handshake fork (`TRY2.hw_fork`) -/
theorem hw_fork_refines1_with_fork:
    /- Given a handshake fork taking `a` as input and returning `(a, a)`, we take
      its lowering (with input a bisimilar ready-valid wrapped stream) -/
    (rdIn, vldOut1, vldOut2, dataOut1, dataOut2) = project_stream (rtl.fork rdOut1 rdOut2 vldIn dataIn) →
    /- We want to make sure that stalling is correctly modeled for `a` (input).
      We constrain the input and prove that if the input behaves properly,
      the output will. -/
    globallyValidUntilReady vldOut1 rdOut1 →
    globallyValidUntilReady vldOut2 rdOut2 →
    globallyValidUntilReady vldIn rdIn →
    readyOut1UntilAllReceiversAre (rdOut1 := rdOut1) (rdOut2 := rdOut2) →
    readyOut2UntilAllReceiversAre (rdOut1 := rdOut1) (rdOut2 := rdOut2)  →
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
  intros hfork hgvurOutt1 hvgurOut2 hgvurIn hout1 hout2 hgvdOut1 hgvdOut2 hgvdIn hgfrIn hgfrOut1 hgfrOut2
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
      have ⟨fstRdyOut, hfstRdyOut⟩ := if_exists_first_exists (h_4 fstVldTrue)
      have ⟨fstRdyOut2, hfstRdyOut2⟩ := if_exists_first_exists (h_5 fstVldTrue)
      unfold globallyFinallyReady at h_4
      have hvldinout := vldIn_and_ready_implies_vldOut1
              (dataIn := dataIn_1) (vldIn := vldIn_1) (rdIn := rdIn_1)
              (rdOut1 := rdOut1_1) (rdOut2 := rdOut2_1) (vldOut1 := vldOut1_1) (vldOut2 := vldOut2_1)
              (dataOut1 := dataOut1_1) (dataOut2 := dataOut2_1) (by grind) (by grind)
      have hvldinout2 := vldIn_and_ready_implies_vldOut2
              (dataIn := dataIn_1) (vldIn := vldIn_1) (rdIn := rdIn_1)
              (rdOut1 := rdOut1_1) (rdOut2 := rdOut2_1) (vldOut1 := vldOut1_1) (vldOut2 := vldOut2_1)
              (dataOut1 := dataOut1_1) (dataOut2 := dataOut2_1) (by grind) (by grind)
      have hfstRec := exists_first_received_element
              (data := dataOut1_1) (vld := vldOut1_1) (rdy := rdOut1_1) (x := sout) (hx := h_8)
      have ⟨fstSentIdx, hfstSentIdx⟩ := hfstSent
      exists fstSentIdx, (fstVldTrue + fstRdyOut)
      and_intros
      · apply relation_fork.intro
          (Stream'.drop (fstSentIdx + 1) sin) (Stream'.drop (fstVldTrue + fstRdyOut + 1) sout)
          (dataIn := Stream'.drop (fstSentIdx + 1) dataIn_1)
          (rdIn := Stream'.drop (fstSentIdx + 1) rdIn_1)
          (vldIn := Stream'.drop (fstSentIdx + 1) vldIn_1)
          (vldOut1 := Stream'.drop (fstVldTrue + fstRdyOut + 1) vldOut1_1)
          (vldOut2 := Stream'.drop (fstVldTrue + fstRdyOut + 1) vldOut2_1)
          (dataOut1 := Stream'.drop (fstVldTrue + fstRdyOut + 1) dataOut1_1)
          (dataOut2 := Stream'.drop (fstSentIdx + 1) dataOut2_1)
          (rdOut1 := Stream'.drop (fstVldTrue + fstRdyOut + 1) rdOut1_1)
          (rdOut2 := Stream'.drop (fstVldTrue + fstRdyOut + 1) rdOut2_1)
        · simp_all
          rfl
        · simp_all
          rfl
        · unfold globallyValidUntilReady at ⊢ h
          intro j hj
          specialize h (j + fstSentIdx + 1) hj
          obtain ⟨k, hk1, hk2, hk3⟩ := h
          exists k
          have hv : Stream'.drop (fstSentIdx + 1) vldIn_1 j = vldIn_1 (j + fstSentIdx + 1) := by rfl
          rw [hv] at hj
          have hv : Stream'.drop (fstSentIdx + 1) vldIn_1 (j + k) = vldIn_1 (j + k + fstSentIdx + 1) := by rfl
          have hr : Stream'.drop (fstSentIdx + 1) rdIn_1 (j + k) = rdIn_1 (j + k + fstSentIdx + 1) := by rfl
          simp [hv, hr, show j + k + fstSentIdx + 1 = j + fstSentIdx + 1 + k by omega, hk1, hk2]
          intros n hn
          have hn : Stream'.drop (fstSentIdx + 1) vldIn_1 (j + n) = vldIn_1 (j + n + fstSentIdx + 1) := by rfl
          simp [hn]
          specialize hk3 n (by omega)
          simp [show j + n + fstSentIdx + 1 = j + fstSentIdx + 1 + n by omega, hk3]
        · unfold globallyValidUntilReady at ⊢ h_1
          intro j hj
          have hj2 : Stream'.drop (fstVldTrue + fstRdyOut + 1) vldOut1_1 j = vldOut1_1 (j + fstVldTrue + fstRdyOut + 1) := by
            simp [Stream'.drop, Stream'.get]
            congr 1
            omega
          rw [hj2] at hj
          specialize h_1 (j + fstVldTrue + fstRdyOut + 1) hj
          obtain ⟨k, hk1, hk2, hk3⟩ := h_1
          exists k
          have hv : Stream'.drop (fstVldTrue + fstRdyOut + 1) vldOut1_1 (j + k) = vldOut1_1 (j + k + fstVldTrue + fstRdyOut + 1) := by
            simp [Stream'.drop, Stream'.get]
            congr 1
            omega
          have hr : Stream'.drop (fstVldTrue + fstRdyOut + 1) rdOut1_1 (j + k) = rdOut1_1 (j + k + fstVldTrue + fstRdyOut + 1) := by
            simp [Stream'.drop, Stream'.get]
            congr 1
            omega
          simp [hv, hr, show j + k + fstVldTrue + fstRdyOut + 1 = j + fstVldTrue + fstRdyOut + 1 + k by omega, hk1, hk2]
          intros n hn
          have hn : Stream'.drop (fstVldTrue + fstRdyOut + 1) vldOut1_1 (j + n) = vldOut1_1 (j + n + fstVldTrue + fstRdyOut + 1) := by
            simp [Stream'.drop, Stream'.get]
            congr 1
            omega
          simp [hn]
          specialize hk3 n (by omega)
          simp [show j + n + fstVldTrue + fstRdyOut + 1 = j + fstVldTrue + fstRdyOut + 1 + n by omega, hk3]
        · unfold globallyValidUntilReady at ⊢ h_2
          intro j hj
          have hj2 : Stream'.drop (fstVldTrue + fstRdyOut + 1) vldOut2_1 j = vldOut2_1 (j + fstVldTrue + fstRdyOut + 1) := by
            simp [Stream'.drop, Stream'.get]
            congr 1
            omega
          rw [hj2] at hj
          specialize h_2 (j + fstVldTrue + fstRdyOut + 1) hj
          obtain ⟨k, hk1, hk2, hk3⟩ := h_2
          exists k
          have hv : Stream'.drop (fstVldTrue + fstRdyOut + 1) vldOut2_1 (j + k) = vldOut2_1 (j + k + fstVldTrue + fstRdyOut + 1) := by
            simp [Stream'.drop, Stream'.get]
            congr 1
            omega
          have hr : Stream'.drop (fstVldTrue + fstRdyOut + 1) rdOut2_1 (j + k) = rdOut2_1 (j + k + fstVldTrue + fstRdyOut + 1) := by
            simp [Stream'.drop, Stream'.get]
            congr 1
            omega
          simp [hv, hr, show j + k + fstVldTrue + fstRdyOut + 1 = j + fstVldTrue + fstRdyOut + 1 + k by omega, hk1, hk2]
          intros n hn
          have hn : Stream'.drop (fstVldTrue + fstRdyOut + 1) vldOut2_1 (j + n) = vldOut2_1 (j + n + fstVldTrue + fstRdyOut + 1) := by
            simp [Stream'.drop, Stream'.get]
            congr 1
            omega
          simp [hn]
          specialize hk3 n (by omega)
          simp [show j + n + fstVldTrue + fstRdyOut + 1 = j + fstVldTrue + fstRdyOut + 1 + n by omega, hk3]
        · unfold globallyValidAndData at ⊢ h_3
          intro j
          specialize h_3 (j + fstSentIdx + 1)
          have hr : Stream'.drop (fstSentIdx + 1) dataIn_1 j = dataIn_1 (j + fstSentIdx + 1) := by rfl
          have hr' : Stream'.drop (fstSentIdx + 1) dataIn_1 (j + 1) = dataIn_1 (j + 1 + fstSentIdx + 1) := by rfl
          simp [hr, hr']
          simp [show j + 1 + fstSentIdx + 1 = j + fstSentIdx + 1 + 1 by omega]
          intro h1 h2
          apply h_3
          have htmp : Stream'.drop (fstSentIdx + 1) vldIn_1 j = vldIn_1 (j + fstSentIdx + 1) := by rfl
          rw [htmp] at h1
          simp [h1]
          have htmp : Stream'.drop (fstSentIdx + 1) vldIn_1 (j + 1)  = vldIn_1 (j + 1 + fstSentIdx + 1) := by rfl
          simp [show j + 1 + fstSentIdx + 1 = j + fstSentIdx + 1 + 1 by omega, htmp] at h2
          simp [h2]
        · unfold globallyFinallyReady
          intros i
          specialize h_4 (i + fstVldTrue + fstRdyOut + 1)
          obtain ⟨k, hk⟩ := h_4
          exists k
          have htmp : Stream'.drop (fstVldTrue + fstRdyOut + 1) rdOut1_1 (i + k) = rdOut1_1 (i + k + fstVldTrue + fstRdyOut + 1) := by
            simp [Stream'.drop, Stream'.get]
            congr 1
            omega
          simp [htmp, show i + k + fstVldTrue + fstRdyOut + 1 = i + fstVldTrue + fstRdyOut + 1 + k by omega, hk]
        · unfold globallyFinallyReady at h_5 ⊢
          intro j
          specialize h_5 (fstVldTrue + fstRdyOut + 1 + j)
          obtain ⟨k, hk⟩ := h_5
          exists k
          have h : Stream'.drop (fstVldTrue + fstRdyOut + 1) rdOut2_1 (j + k) = rdOut2_1 (fstVldTrue + fstRdyOut + 1 + j + k) := by
            simp [Stream'.drop, Stream'.get]
            congr 1
            omega
          simp [h, hk]
        · have : fstVldTrue ≤ fstSentIdx := by
            simp_all
            apply Classical.byContradiction
            intro hcontra
            specialize hfstVldTrue2 fstSentIdx (by omega)
            simp [toStream, hfstVldTrue2] at hfstSentIdx
          by_cases fstRecfst : fstRdyOut ≤ fstRdyOut2
          · /- first receiver comes first -/
            by_cases fstRecBeforeSent : fstVldTrue + fstRdyOut ≤ fstSentIdx
            · /- first receiver before sent -/
              by_cases sndRecBeforeSent : fstVldTrue + fstRdyOut2 ≤ fstSentIdx
              · /- second receiver before sent -/
                simp [project_stream]
                and_intros
                · funext i
                  have := rdOut1_before_allDone (hfork := h_6) (n := i)
                  /- what happens to `rdOut1` after data is dispatched? -/
                  have heq : Stream'.drop (fstSentIdx + 1) rdIn_1 i = rdIn_1 (fstSentIdx + 1 + i) := by
                    simp [Stream'.drop]
                    congr 1
                    grind
                  rw [heq]
                  by_cases hfalse : rdIn_1 (fstSentIdx + 1 + i) = 0#1
                  · have := congr_fun h_7 (fstSentIdx + 1 + i)
                    unfold toStream at this
                    simp [hfalse] at *
                    rw [hw_fork_eq]

                    have : ∀ k, ∀ i, Stream'.drop k rdOut1_1 i =  rdOut1_1 (i + k) := by
                      intros
                      simp [Stream'.drop, Stream'.get]
                    simp [rtl.fork', Stream'.corec']
                    unfold fork_corec
                    simp [comb_and, comb_xor, comb_or, hw_constant]

                    sorry
                  · sorry
                · sorry
                · sorry
                · sorry
                · sorry
              · /- first receiver after sent -/
                sorry
            · /- first receiver after sent, implies second receiver after sent -/
              have : fstSentIdx ≤ fstVldTrue + fstRdyOut2 := by omega
              sorry
          · /- second receiver comes first -/
            by_cases fstRecBeforeSent : fstVldTrue + fstRdyOut ≤ fstSentIdx
            · /- first receiver before sent, implies second receiver before sent -/
              have : fstVldTrue + fstRdyOut2 ≤ fstSentIdx := by omega
              sorry
            · /- first receiver after sent -/
              by_cases sndRecBeforeSent : fstVldTrue + fstRdyOut2 ≤ fstSentIdx
              · /- second receiver before sent -/
                sorry
              · /- first receiver after sent -/
                sorry
      · simp [Stream'.get, h_8, h_7, toStream]
        have hdataeq := hw_fork_out0 (h := h_6)
        by_cases hle : fstVldTrue ≤ fstSentIdx
        · have hreadyIn : rdIn_1 fstSentIdx = 1#1 := by
            unfold toStream at h_7
            have h_6sent := congr_fun h_7 fstSentIdx
            simp [hfstSentIdx] at h_6sent
            simp [h_6sent]
          have hvalidIn: vldIn_1 fstSentIdx = 1#1 := by
            unfold toStream at h_7
            have h_6sent := congr_fun h_7 fstSentIdx
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
                have := vldOut1_implies_vldIn h_6 (n := j) (by assumption)
                specialize hfstVldTrue2 j hjlt
                simp [this] at hfstVldTrue2
              · left
                have := hfstRdyOut.2 (j - fstVldTrue) (by omega)
                rwa [Nat.add_sub_cancel' (by omega)] at this
            rw [vldOut_eq_vldIn_of_fork_unitl_sent h_6 hbefore]
            obtain ⟨k, hkrd, hkvld, hkall⟩ := h fstVldTrue hfstVldTrue1
            by_contra hlt; push_neg at hlt
            have hrda : rdOut1_1 (fstVldTrue + k) = 0#1 := by
              have := hfstRdyOut.2 k (by grind)
              simpa using this
            -- rdIn fires at fstVldTrue + k with k < fstRdyOut, but rdOut1 hasn't fired
            have hh5 := h_6
            rw [hw_fork_eq] at h_6
            simp [project_stream] at h_6
            obtain ⟨hrdin, -⟩ := h_6
            have hcirc := congr_fun hrdin (fstVldTrue + k)
            unfold rtl.fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hcirc
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
                  rw [hw_fork_eq] at hh5; simp [project_stream] at hh5
                  obtain ⟨-, hvldout1, -⟩ := hh5
                  have hn := congr_fun hvldout1 km
                  unfold rtl.fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hn
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
              rw [h_7, toStream] at this
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
              rw [h_7, toStream] at this
              simp [hk1, hk2] at this
          subst hkeqdiff
          apply hk4 fstRdyOut
          -- fstRdyOut ≤ diff, i.e., fstVldTrue + fstRdyOut ≤ fstSentIdx
          -- proved by contradiction: if fstSentIdx < fstVldTrue + fstRdyOut,
          -- allDone fires but rdOut1 hasn't, contradicting the circuit
          have hrdyOutLe : fstVldTrue + fstRdyOut ≤ fstSentIdx := by
            by_contra hlt; push_neg at hlt
            have hh5 := h_6
            rw [hw_fork_eq] at h_6
            simp [project_stream] at h_6
            obtain ⟨hrdin, -⟩ := h_6
            have hcirc2 := congr_fun hrdin fstSentIdx
            unfold rtl.fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hcirc2
            generalize hst2 : Stream'.iterate
              (Prod.snd ∘ fork_corec rdOut1_1 rdOut2_1 vldIn_1 dataIn_1) (0, 0#1, 0#1)
              fstSentIdx = s2 at hcirc2
            obtain ⟨a2, b2, c2⟩ := s2
            dsimp [fork_corec, comb_and, comb_xor, comb_or, hw_constant] at hcirc2
            have ha2 : a2 = fstSentIdx := by
              have := @fork_corec1 rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 0 0#1 0#1 fstSentIdx
              simp [hst2] at this; omega
            have hb02 : b2 = 0#1 := by
              suffices key2 : ∀ m, (∀ j < m, rdOut1_1 j = 0#1 ∨ vldOut1_1 j = 0#1) →
                  (Stream'.iterate (Prod.snd ∘ fork_corec rdOut1_1 rdOut2_1 vldIn_1 dataIn_1)
                    (0, 0#1, 0#1) m).2.1 = 0#1 by
                have := key2 fstSentIdx (by
                  intro j hj
                  by_cases hjlt : j < fstVldTrue
                  · right; by_contra hc
                    have : vldOut1_1 j = 1#1 := by grind
                    have := vldOut1_implies_vldIn hh5 (n := j) this
                    exact absurd (hfstVldTrue2 j hjlt) (by grind)
                  · left
                    have := hfstRdyOut.2 (j - fstVldTrue) (by omega)
                    rwa [Nat.add_sub_cancel' (by omega)] at this)
                rw [hst2] at this; simpa using this
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
                have hvldk2 : vldOut1_1 km = vldIn_1 ak := by
                  rw [hw_fork_eq] at hh5; simp [project_stream] at hh5
                  obtain ⟨-, hvldout1, -⟩ := hh5
                  have hn := congr_fun hvldout1 km
                  unfold rtl.fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hn
                  simp_rw [hsk] at hn
                  dsimp [fork_corec, comb_and, comb_xor, hw_constant] at hn
                  simp [hn]
                  ext k
                  simp [show k = 0 by omega]
                rw [iterate_back_succ, hsk]; simp only [Function.comp]
                dsimp [fork_corec, comb_and, comb_xor, comb_or, hw_constant]
                subst hak
                rcases hbef ak (Nat.lt_succ_self ak) with hh | hh
                · simp [hh]
                · rw [hvldk2] at hh; simp [hh]
            have hrda2 : rdOut1_1 fstSentIdx = 0#1 := by
              have := hfstRdyOut.2 (fstSentIdx - fstVldTrue) (by omega)
              rwa [Nat.add_sub_cancel' (by omega)] at this
            rw [hreadyIn, hb02, ha2, hrda2] at hcirc2
            simp at hcirc2
          omega
        · /- contradiction: nothing can be sent before `fstSentIdx`  -/
          simp_all
          intro hcontra
          specialize hfstVldTrue2 fstSentIdx hle
          simp [toStream, hfstVldTrue2] at hfstSentIdx
      · intro i hi
        exact hfstSentIdx.2 i hi
      · intros j hj
        by_cases hj' : j < fstVldTrue
        · simp [Stream'.get, h_8, toStream]
          intro hvld
          have := vldOut1_implies_vldIn h_6 (n := j)
          have := hfstVldTrue2 j hj'
          grind
        · simp [h_8, toStream, Stream'.get]
          let diff := j - fstVldTrue
          have : j = fstVldTrue + diff := by omega
          rw [this]
          obtain ⟨h1,h2⟩ := hfstRdyOut
          specialize h2 diff (by omega)
          intro hc
          simp [hc] at h2
    · /- if we never have a valid signal, all streams are empty and the relation holds trivially -/
      have hnonein := not_exists_transmitted_element (x := sin) (data := dataIn_1) (rdy := rdIn_1)
                                              (vld := vldIn_1) (by grind) h_7
      /- the fork module will never transmit anything meaningful -/
      rw [hw_fork_eq] at h_6
      unfold project_stream at h_6
      simp at h_6
      have hhfork1 := h_6
      obtain ⟨hrd', hvld1', hvld2', hdata1', hdata2'⟩ := hhfork1
      rw [h_7, h_8]
      have hnoneout : ∀ k, vldOut1_1 k = 0#1 := by
          unfold rtl.fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hvld1'
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
          unfold rtl.fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get at hvld2'
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
                                              (vld := vldOut1_1) (by grind) h_8
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
        · unfold globallyFinallyReady at h_5 ⊢
          intros i
          specialize h_5 (i + 1)
          obtain ⟨j, hj⟩ := h_5
          exists j
          have : Stream'.drop 1 rdOut2_1 (i + j) = rdOut2_1 ((i + j) + 1) := by rfl
          rw [this, show i + j + 1 = i + 1 + j by omega, hj]
        · /- after dropping one element, all the relations defined by the fork module remain.
            We see this by unfolding the fork hypotheses -/
          unfold project_stream
          simp
          have h1 := rtl.fork'_of_all_none
                    (dataIn := Stream'.drop 1 dataIn_1)
                    (vldIn := Stream'.drop 1 vldIn_1)
                    (rdOut1 := Stream'.drop 1 rdOut1_1)
                    (rdOut2 := Stream'.drop 1 rdOut2_1)
                    (by
                      intro k
                      specialize hnevldin (k + 1)
                      simp [show Stream'.drop 1 vldIn_1 k = vldIn_1 (k + 1) by rfl, hnevldin]
                      )
          have h2 := rtl.fork'_of_all_none
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
              (rdy_out := fun i => (rtl.fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).1)
              (vld0_out := fun i => (rtl.fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.1)
              (vld1_out := fun i => (rtl.fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.1)
              (data0_out := fun i => (rtl.fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.2.1)
              (data1_out := fun i => (rtl.fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.2.2)
              (by rw [← hw_fork_eq]; simp [project_stream]) (1 + l)
            have hrhs := hw_fork_out0
              (rdy_out := fun i =>
                (rtl.fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).1)
              (vld0_out := fun i =>
                (rtl.fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).2.1)
              (vld1_out := fun i =>
                (rtl.fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).2.2.1)
              (data0_out := fun i =>
                (rtl.fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).2.2.2.1)
              (data1_out := fun i =>
                (rtl.fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).2.2.2.2)
              (by rw [← hw_fork_eq]; simp [project_stream]) l
            simp [Stream'.drop] at hrhs
            have h1 : Stream'.get (fun i => (rtl.fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.2.1) (1 + l) =
                  (fun i => (rtl.fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.2.1) (1 + l) := by rfl
            simp [h1]
            have h2 : (Stream'.get (fun i =>
                        (rtl.fork' (Stream'.drop 1 rdOut1_1)
                          (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1)
                          (Stream'.drop 1 dataIn_1) i).2.2.2.1) l) =
                      (fun i =>
                        (rtl.fork' (Stream'.drop 1 rdOut1_1)
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
              (rdy_out := fun i => (rtl.fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).1)
              (vld0_out := fun i => (rtl.fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.1)
              (vld1_out := fun i => (rtl.fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.1)
              (data0_out := fun i => (rtl.fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.2.1)
              (data1_out := fun i => (rtl.fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.2.2)
              (by rw [← hw_fork_eq]; simp [project_stream]) (1 + l)
            have hrhs := hw_fork_out1
              (rdy_out := fun i =>
                (rtl.fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).1)
              (vld0_out := fun i =>
                (rtl.fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).2.1)
              (vld1_out := fun i =>
                (rtl.fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).2.2.1)
              (data0_out := fun i =>
                (rtl.fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).2.2.2.1)
              (data1_out := fun i =>
                (rtl.fork' (Stream'.drop 1 rdOut1_1) (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1) (Stream'.drop 1 dataIn_1) i).2.2.2.2)
              (by rw [← hw_fork_eq]; simp [project_stream]) l
            simp [Stream'.drop] at hrhs

            have h1 : Stream'.get (fun i => (rtl.fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.2.2) (1 + l) =
                  (fun i => (rtl.fork' rdOut1_1 rdOut2_1 vldIn_1 dataIn_1 i).2.2.2.2) (1 + l) := by rfl
            simp [h1]
            have h2 : (Stream'.get (fun i =>
                        (rtl.fork' (Stream'.drop 1 rdOut1_1)
                          (Stream'.drop 1 rdOut2_1) (Stream'.drop 1 vldIn_1)
                          (Stream'.drop 1 dataIn_1) i).2.2.2.2) l) =
                      (fun i =>
                        (rtl.fork' (Stream'.drop 1 rdOut1_1)
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
    · assumption


theorem hw_fork_refines':
    /- Given a handshake fork -/
    (x, y) = handshake.fork a →
    /- we get the output of the corresponding lowered fork -/
    (rdy, vld1, vld2, o1, o2) = project_stream (a := BitVec 1) (rtl.fork rd1 rd2 vld data) →
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
  · unfold handshake.fork at handshake_fork
    have heq : x = a := by
      simp at handshake_fork
      exact handshake_fork.1
    have heq' : y = a := by
      simp at handshake_fork
      exact handshake_fork.2
    rw [heq, heq']
    and_intros
    · sorry
    · sorry

end HWComponents
