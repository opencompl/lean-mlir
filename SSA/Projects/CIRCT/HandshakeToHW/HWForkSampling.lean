import SSA.Projects.CIRCT.HandshakeToHW.HWFork

/-!
# Transaction-level sampling of the `fork` circuit — definitions

Refactoring of the fork refinement around the *`allDone` sampling* idea:

* The refinement theorem `toStream rdIn vldIn dataIn ~ toStream rdOut1 vldOut1 dataOut1`
  is factored through a third, auxiliary stream: output 1 *sampled at `allDone`*,
  i.e. observed only when **all** receivers have received the current token.
* Since `rdIn = allDone` and `dataOut1 = dataIn` hold pointwise in the circuit,
  the sampled stream is *equal* to the input stream. All bisimulation content
  is then concentrated in one lemma (`out1_sampling_bisim`): moving each token's
  observation instant from receiver 1's accept (`fire1`) to the transaction's
  completion (`allDone`) only changes the stream by finitely many `none`s.
  The producer interprets rdIn = 1 as "this token is consumed — I may present the next one."


Layout:
1. register trajectory (`emitted`) as a plain recursion over time, and named
   combinational signals (`fire1`, `done0`, `allDone`, ...);
2. pointwise characterization of `hw_fork'` (`hw_fork'_get`) — the only place
   `Stream'.corec'` ever needs to be unfolded;
3. statements for the library of circuit facts (the intermediate predicates,
   *derived* from the circuit rather than assumed);
4. the coinduction relation `SampleRel` and the statements of
   `out1_sampling_bisim` and `hw_fork_refines_out1`.
-/

namespace HWComponents
namespace Fork

open HandshakeStream

/-! ## Boolean infrastructure on `BitVec 1` -/

theorem comb_and_eq_one_iff (a b : BitVec 1) :
    comb_and a b = 1#1 ↔ a = 1#1 ∧ b = 1#1 := by
  bv_decide

theorem comb_and_eq_zero_iff (a b : BitVec 1) :
    comb_and a b = 0#1 ↔ a = 0#1 ∨ b = 0#1 := by
  bv_decide

theorem comb_or_eq_one_iff (a b : BitVec 1) :
    comb_or a b = 1#1 ↔ a = 1#1 ∨ b = 1#1 := by
  bv_decide

theorem comb_or_eq_zero_iff (a b : BitVec 1) :
    comb_or a b = 0#1 ↔ a = 0#1 ∧ b = 0#1 := by
  bv_decide

theorem comb_not_eq_one_iff (a : BitVec 1) :
    comb_xor a (hw_constant true) = 1#1 ↔ a = 0#1 := by
  bv_decide

theorem comb_not_eq_zero_iff (a : BitVec 1) :
    comb_xor a (hw_constant true) = 0#1 ↔ a = 1#1 := by
  bv_decide

/-! ## The register trajectory, as a plain recursion over time

Instead of reasoning through `Stream'.corec'`/`Stream'.iterate`, we define the
`emitted` registers as a recursive function of the cycle index. Every signal of
the circuit then becomes a pure function of the current cycle. -/

/-- One clock cycle of the fork's register update. `e.1`/`e.2` are the
`emitted` registers of output 1/output 2. This is (definitionally) the state
update performed by `fork_corec`. -/
def stepRegs (rd1 rd2 vld : BitVec 1) (e : BitVec 1 × BitVec 1) :
    BitVec 1 × BitVec 1 :=
  let fire1 := comb_and rd1 (comb_and (comb_xor e.1 (hw_constant true)) vld)
  let fire2 := comb_and rd2 (comb_and (comb_xor e.2 (hw_constant true)) vld)
  let done0 := comb_or fire1 e.1
  let done1 := comb_or fire2 e.2
  let allDone := comb_and done0 done1 -- `_12` in `hw_fork`
  (comb_and done0 (comb_xor allDone (hw_constant true)),
   comb_and done1 (comb_xor allDone (hw_constant true)))

variable (rdOut1 rdOut2 vldIn : Stream' (BitVec 1))

/-- The trajectory of the fork's `emitted` registers over time. -/
def emitted : Nat → BitVec 1 × BitVec 1
  | 0 => (0#1, 0#1)
  | n + 1 => stepRegs (rdOut1 n) (rdOut2 n) (vldIn n) (emitted n)

/-- `e0 n = 1` iff receiver 1 has already accepted the token of the transaction
that is still open at cycle `n`. -/
def e0 (n : Nat) : BitVec 1 := (emitted rdOut1 rdOut2 vldIn n).1

/-- `e1 n = 1` iff receiver 2 has already accepted the token of the transaction
that is still open at cycle `n`. -/
def e1 (n : Nat) : BitVec 1 := (emitted rdOut1 rdOut2 vldIn n).2

/-- The fork's `valid` signal on output 1 (`_3` in the MLIR output). -/
def vldOut1 (n : Nat) : BitVec 1 :=
  comb_and (comb_xor (e0 rdOut1 rdOut2 vldIn n) (hw_constant true)) (vldIn n)

/-- The fork's `valid` signal on output 2 (`_9` in the MLIR output). -/
def vldOut2 (n : Nat) : BitVec 1 :=
  comb_and (comb_xor (e1 rdOut1 rdOut2 vldIn n) (hw_constant true)) (vldIn n)

/-- Receiver 1 accepts a token at cycle `n` (`_4` in the MLIR output). -/
def fire1 (n : Nat) : BitVec 1 :=
  comb_and (rdOut1 n) (vldOut1 rdOut1 rdOut2 vldIn n)

/-- Receiver 2 accepts a token at cycle `n` (`_10` in the MLIR output). -/
def fire2 (n : Nat) : BitVec 1 :=
  comb_and (rdOut2 n) (vldOut2 rdOut1 rdOut2 vldIn n)

/-- Receiver 1 has received the current token, now or earlier (`done0`, `_5`). -/
def done0 (n : Nat) : BitVec 1 :=
  comb_or (fire1 rdOut1 rdOut2 vldIn n) (e0 rdOut1 rdOut2 vldIn n)

/-- Receiver 2 has received the current token, now or earlier (`done1`, `_11`). -/
def done1 (n : Nat) : BitVec 1 :=
  comb_or (fire2 rdOut1 rdOut2 vldIn n) (e1 rdOut1 rdOut2 vldIn n)

/-- All receivers have received the current token; this is also the fork's
`ready` signal towards the producer (`allDone`, `_12`). -/
def allDone (n : Nat) : BitVec 1 :=
  comb_and (done0 rdOut1 rdOut2 vldIn n) (done1 rdOut1 rdOut2 vldIn n)

/-! Definitional equations for the registers (all `rfl`). -/

@[simp] theorem e0_zero : e0 rdOut1 rdOut2 vldIn 0 = 0#1 := rfl
@[simp] theorem e1_zero : e1 rdOut1 rdOut2 vldIn 0 = 0#1 := rfl

theorem e0_succ (n : Nat) :
    e0 rdOut1 rdOut2 vldIn (n + 1)
      = comb_and (done0 rdOut1 rdOut2 vldIn n)
          (comb_xor (allDone rdOut1 rdOut2 vldIn n) (hw_constant true)) := rfl

theorem e1_succ (n : Nat) :
    e1 rdOut1 rdOut2 vldIn (n + 1)
      = comb_and (done1 rdOut1 rdOut2 vldIn n)
          (comb_xor (allDone rdOut1 rdOut2 vldIn n) (hw_constant true)) := rfl

/-! Unfolding equations for the combinational signals (all `rfl`). These
signals have no state of their own, so their `_def` equations hold at *every*
cycle; use them with `rw`/`simp` instead of `unfold`. -/

theorem vldOut1_def (n : Nat) :
    vldOut1 rdOut1 rdOut2 vldIn n
      = comb_and (comb_xor (e0 rdOut1 rdOut2 vldIn n) (hw_constant true))
          (vldIn n) := rfl

theorem vldOut2_def (n : Nat) :
    vldOut2 rdOut1 rdOut2 vldIn n
      = comb_and (comb_xor (e1 rdOut1 rdOut2 vldIn n) (hw_constant true))
          (vldIn n) := rfl

theorem fire1_def (n : Nat) :
    fire1 rdOut1 rdOut2 vldIn n
      = comb_and (rdOut1 n) (vldOut1 rdOut1 rdOut2 vldIn n) := rfl

theorem fire2_def (n : Nat) :
    fire2 rdOut1 rdOut2 vldIn n
      = comb_and (rdOut2 n) (vldOut2 rdOut1 rdOut2 vldIn n) := rfl

theorem done0_def (n : Nat) :
    done0 rdOut1 rdOut2 vldIn n
      = comb_or (fire1 rdOut1 rdOut2 vldIn n) (e0 rdOut1 rdOut2 vldIn n) := rfl

theorem done1_def (n : Nat) :
    done1 rdOut1 rdOut2 vldIn n
      = comb_or (fire2 rdOut1 rdOut2 vldIn n) (e1 rdOut1 rdOut2 vldIn n) := rfl

theorem allDone_def (n : Nat) :
    allDone rdOut1 rdOut2 vldIn n
      = comb_and (done0 rdOut1 rdOut2 vldIn n)
          (done1 rdOut1 rdOut2 vldIn n) := rfl

/-! `_succ` forms (all `rfl`): the cycle-`n + 1` value of each signal with the
register occurrence expanded one step, i.e. in terms of cycle-`n` signals and
cycle-`n + 1` inputs. The combinational signals are stateless, so all the
`succ`-structure funnels through `e0_succ`/`e1_succ`; these lemmas just
pre-compose that register step with the `_def` equations, which is the shape an
`induction n` proof consumes. -/

theorem vldOut1_succ (n : Nat) :
    vldOut1 rdOut1 rdOut2 vldIn (n + 1)
      = comb_and
          (comb_xor
            (comb_and (done0 rdOut1 rdOut2 vldIn n)
              (comb_xor (allDone rdOut1 rdOut2 vldIn n) (hw_constant true)))
            (hw_constant true))
          (vldIn (n + 1)) := rfl

theorem vldOut2_succ (n : Nat) :
    vldOut2 rdOut1 rdOut2 vldIn (n + 1)
      = comb_and
          (comb_xor
            (comb_and (done1 rdOut1 rdOut2 vldIn n)
              (comb_xor (allDone rdOut1 rdOut2 vldIn n) (hw_constant true)))
            (hw_constant true))
          (vldIn (n + 1)) := rfl

theorem fire1_succ (n : Nat) :
    fire1 rdOut1 rdOut2 vldIn (n + 1)
      = comb_and (rdOut1 (n + 1))
          (comb_and
            (comb_xor
              (comb_and (done0 rdOut1 rdOut2 vldIn n)
                (comb_xor (allDone rdOut1 rdOut2 vldIn n) (hw_constant true)))
              (hw_constant true))
            (vldIn (n + 1))) := rfl

theorem fire2_succ (n : Nat) :
    fire2 rdOut1 rdOut2 vldIn (n + 1)
      = comb_and (rdOut2 (n + 1))
          (comb_and
            (comb_xor
              (comb_and (done1 rdOut1 rdOut2 vldIn n)
                (comb_xor (allDone rdOut1 rdOut2 vldIn n) (hw_constant true)))
              (hw_constant true))
            (vldIn (n + 1))) := rfl

theorem done0_succ (n : Nat) :
    done0 rdOut1 rdOut2 vldIn (n + 1)
      = comb_or (fire1 rdOut1 rdOut2 vldIn (n + 1))
          (comb_and (done0 rdOut1 rdOut2 vldIn n)
            (comb_xor (allDone rdOut1 rdOut2 vldIn n) (hw_constant true))) := rfl

theorem done1_succ (n : Nat) :
    done1 rdOut1 rdOut2 vldIn (n + 1)
      = comb_or (fire2 rdOut1 rdOut2 vldIn (n + 1))
          (comb_and (done1 rdOut1 rdOut2 vldIn n)
            (comb_xor (allDone rdOut1 rdOut2 vldIn n) (hw_constant true))) := rfl

theorem allDone_succ (n : Nat) :
    allDone rdOut1 rdOut2 vldIn (n + 1)
      = comb_and
          (comb_or (fire1 rdOut1 rdOut2 vldIn (n + 1))
            (comb_and (done0 rdOut1 rdOut2 vldIn n)
              (comb_xor (allDone rdOut1 rdOut2 vldIn n) (hw_constant true))))
          (comb_or (fire2 rdOut1 rdOut2 vldIn (n + 1))
            (comb_and (done1 rdOut1 rdOut2 vldIn n)
              (comb_xor (allDone rdOut1 rdOut2 vldIn n) (hw_constant true)))) := rfl

/-! ## `hw_fork'`, pointwise -/

/-- The iteration of `fork_corec`'s state update is `(n, emitted n)`.
Subsumes `fork_corec1`. (Induction on `n` via `iterate_back_succ`.) -/
theorem iterate_eq_emitted (dataIn : Stream' (BitVec 32)) (n : Nat) :
    Stream'.iterate (Prod.snd ∘ fork_corec rdOut1 rdOut2 vldIn dataIn)
        (0, 0#1, 0#1) n
      = (n, emitted rdOut1 rdOut2 vldIn n) := by
  induction n
  · simp [emitted, Stream'.iterate]
  · case _ m ihm =>
    simp [Stream'.iterate, ihm]
    unfold fork_corec
    simp [emitted, stepRegs]

/-- Pointwise characterization of the fork circuit: at each cycle the outputs
are the combinational signals computed from the current register state and the
current inputs. This is the only lemma that ever needs to unfold
`Stream'.corec'`; everything downstream uses it via `rw`/`simp`. -/
theorem hw_fork'_get (dataIn : Stream' (BitVec 32)) (n : Nat) :
    hw_fork' rdOut1 rdOut2 vldIn dataIn n
      = (allDone rdOut1 rdOut2 vldIn n,
         vldOut1 rdOut1 rdOut2 vldIn n,
         vldOut2 rdOut1 rdOut2 vldIn n,
         dataIn n, dataIn n) := by
  unfold hw_fork' Stream'.corec' Stream'.corec Stream'.map Stream'.get
  rw [iterate_eq_emitted]
  rfl

/-! ## Library of circuit facts

The intermediate predicates describing the fork's behaviour, stated as
*derived* facts about the circuit (not assumptions). -/

/-- `allDone` holds exactly when *every* receiver has received the current
token — accepting it this cycle (`fireᵢ`) or having accepted it earlier
(`emittedᵢ`). This is the circuit-level meaning of "allDone is such after all
receivers have received". -/
theorem allDone_iff_all_received (n : Nat) :
    allDone rdOut1 rdOut2 vldIn n = 1#1
      ↔ (fire1 rdOut1 rdOut2 vldIn n = 1#1 ∨ e0 rdOut1 rdOut2 vldIn n = 1#1)
        ∧ (fire2 rdOut1 rdOut2 vldIn n = 1#1 ∨ e1 rdOut1 rdOut2 vldIn n = 1#1) := by
  rw [allDone_def, done0_def, done1_def]
  bv_decide

/-- If receiver 1 accepts at cycle `n`, then the receiver is ready, output 1 is
valid, a token is being presented, and the receiver had not accepted the
current token before. -/
theorem fire1_spec {n : Nat} (h : fire1 rdOut1 rdOut2 vldIn n = 1#1) :
    rdOut1 n = 1#1 ∧ vldOut1 rdOut1 rdOut2 vldIn n = 1#1
      ∧ vldIn n = 1#1 ∧ e0 rdOut1 rdOut2 vldIn n = 0#1 := by
  rw [fire1_def, vldOut1_def] at h
  rw [vldOut1_def]
  bv_decide

/-- The fork does not offer the same token twice: output 1 is not valid while
its receiver has already accepted the current token. -/
theorem vldOut1_zero_of_e0_one {n : Nat}
    (h : e0 rdOut1 rdOut2 vldIn n = 1#1) :
    vldOut1 rdOut1 rdOut2 vldIn n = 0#1 := by
  rw [vldOut1_def]
  bv_decide

/-- Receiver 1 cannot accept while it has already accepted the current token. -/
theorem fire1_zero_of_e0_one {n : Nat} (h : e0 rdOut1 rdOut2 vldIn n = 1#1) :
    fire1 rdOut1 rdOut2 vldIn n = 0#1 := by
  rw [fire1_def, vldOut1_def]
  bv_decide

/-- If output 1 is quiet (register clear, no accept), the transaction cannot
complete this cycle. -/
theorem allDone_zero_of_quiet {n : Nat}
    (he : e0 rdOut1 rdOut2 vldIn n = 0#1)
    (hf : fire1 rdOut1 rdOut2 vldIn n = 0#1) :
    allDone rdOut1 rdOut2 vldIn n = 0#1 := by
  rw [allDone_def]
  rw [fire1_def] at hf
  rw [done0_def, fire1_def]
  bv_decide

/-- The `emitted` registers are mutually exclusive: at most one output can be
waiting for the other to catch up. (Case on `n`; for `n + 1` both registers
being set would require `allDone n = 1` and `allDone n = 0` at once.) -/
theorem e0_e1_not_both {n : Nat} :
    ¬(e0 rdOut1 rdOut2 vldIn n = 1#1 ∧ e1 rdOut1 rdOut2 vldIn n = 1#1) := by
  induction n
  · simp [e0_zero, e1_zero]
  · simp [e0_succ, e1_succ, allDone_def]
    bv_decide

/-- `allDone` only fires while a token is actually being presented.
(Via `allDone_iff_all_received` and `e0_e1_not_both`.) -/
theorem vldIn_of_allDone {n : Nat}
    (h : allDone rdOut1 rdOut2 vldIn n = 1#1) : vldIn n = 1#1 := by
  induction n
  · simp [allDone_def, done0_def, done1_def, fire1_def, fire2_def, vldOut1_def] at h
    bv_decide
  · simp [allDone_succ, fire1_succ, fire2_succ, allDone_def] at h
    bv_decide

/-- Once the transaction completes, the register of output 1 is cleared. -/
theorem e0_zero_of_allDone {n : Nat}
    (h : allDone rdOut1 rdOut2 vldIn n = 1#1) :
    e0 rdOut1 rdOut2 vldIn (n + 1) = 0#1 := by
  simp [allDone_def, done0_def, done1_def, fire1_def, fire2_def, vldOut1_def, vldOut2_def] at h
  simp [e0_succ, done0_def, allDone_def, fire1_def, vldOut1_def, done1_def, fire2_def, vldOut2_def]
  bv_decide

/-- While receiver 1 does not accept, its register stays clear.
(Induction via `Nat.le_induction`.) -/
theorem e0_zero_of_no_fire {m n : Nat} (hmn : m ≤ n)
    (h0 : e0 rdOut1 rdOut2 vldIn m = 0#1)
    (hf : ∀ t, m ≤ t → t < n → fire1 rdOut1 rdOut2 vldIn t = 0#1) :
    e0 rdOut1 rdOut2 vldIn n = 0#1 := by
  induction n
  · simp
  · case _ t iht =>
    by_cases hle : m ≤ t
    · specialize iht (by omega) (by intros; apply hf <;> omega)
      specialize hf t
      specialize hf hle (by omega)
      simp [e0_succ, allDone_def, done0_def, done1_def]
      simp [hf]
      simp [comb_and, comb_or, comb_xor, hw_constant]
      simp [fire2_def, comb_and, vldOut2, comb_xor, hw_constant]
      simp [iht]
    · have : m = t + 1 := by omega
      subst this
      simp [h0]

/-- After receiver 1 accepts at `F`, its register stays set until the
transaction completes: `e0` is 1 on the whole window `(F, n]` as long as
`allDone` has not fired on `[F, n)`. (Induction via `Nat.le_induction`.) -/
theorem e0_one_of_window {F n : Nat} (hFn : F < n)
    (hF : fire1 rdOut1 rdOut2 vldIn F = 1#1)
    (hAD : ∀ t, F ≤ t → t < n → allDone rdOut1 rdOut2 vldIn t = 0#1) :
    e0 rdOut1 rdOut2 vldIn n = 1#1 := by
  induction n
  · omega -- contra
  · case _ m ihm =>
    simp [e0_succ]
    by_cases hlt : F < m
    · specialize ihm hlt (by intros; apply hAD <;> omega)
      specialize hAD m (by omega) (by omega)
      simp [hAD]
      simp [fire1, vldOut1_def, comb_and, comb_xor, hw_constant] at hF
      simp [done0_def, fire1_def, vldOut1_def, ihm,
        comb_and, comb_or, comb_xor, hw_constant]
    · simp [show F = m by omega] at *
      specialize hAD m (by omega) (by omega)
      simp [hAD]
      simp [done0, hF]
      bv_decide

/-- **Data is constant until all receivers have received.** Whenever a token is
presented, the transaction eventually completes (`allDone`), the token stays
valid throughout, and the data does not change until completion. This is the
predicate "data remains constant until all receivers have received", *derived*
from the handshake contracts and `data_remains_constant_until_first`. -/
theorem dataIn_constant_until_allDone {dataIn : Stream' (BitVec 32)}
    (hvr : globallyValidUntilReady vldIn (allDone rdOut1 rdOut2 vldIn))
    (hvd : globallyValidAndData vldIn dataIn)
    {i : Nat} (hi : vldIn i = 1#1) :
    ∃ k, allDone rdOut1 rdOut2 vldIn (i + k) = 1#1 ∧ vldIn (i + k) = 1#1 ∧
      (∀ j (_hj : j ≤ k), vldIn (i + j) = 1#1) ∧
      (∀ j (_hj : j ≤ k), dataIn (i + j) = dataIn i) ∧
      (∀ m (_hm : m < k), allDone rdOut1 rdOut2 vldIn (i + m) = 0#1) :=
  data_remains_constant_until_first hvd hvr hi

/-! ## The two views of output 1 -/

/-- The *receiver-1 view* of output 1: a token is observed at the cycle where
receiver 1 accepts it (`fire1`). This is what receiver 1 actually sees on the
wires, waiting (`none`) included. -/
def out1View (dataIn : Stream' (BitVec 32)) : Stream (BitVec 32) :=
  toStream rdOut1 (vldOut1 rdOut1 rdOut2 vldIn) dataIn

/-- The *transaction-level view* of output 1: a token is observed only at the
cycle where the whole transaction completes (`allDone`), i.e. after **all**
receivers have received it. Note that, pointwise, this is exactly
`toStream rdIn vldIn dataIn` — the input stream — since `rdIn = allDone` and
`dataOut1 = dataIn` in the circuit (`hw_fork'_get`). -/
def sampledView (dataIn : Stream' (BitVec 32)) : Stream (BitVec 32) :=
  toStream (allDone rdOut1 rdOut2 vldIn) vldIn dataIn

/-! `get`-characterizations of the two views: each view is `some` exactly at
its observation instants (`fire1` resp. `allDone`). -/

theorem out1View_get_none {dataIn : Stream' (BitVec 32)} {t : Nat}
    (h : fire1 rdOut1 rdOut2 vldIn t = 0#1) :
    Stream'.get (out1View rdOut1 rdOut2 vldIn dataIn) t = none := by
  rw [fire1_def, comb_and_eq_zero_iff] at h
  rcases h with h | h <;> simp [out1View, toStream, Stream'.get, h]

theorem out1View_get_some {dataIn : Stream' (BitVec 32)} {t : Nat}
    (h : fire1 rdOut1 rdOut2 vldIn t = 1#1) :
    Stream'.get (out1View rdOut1 rdOut2 vldIn dataIn) t = some (dataIn t) := by
  obtain ⟨h1, h2, -, -⟩ := fire1_spec rdOut1 rdOut2 vldIn h
  simp [out1View, toStream, Stream'.get, h1, h2]

theorem sampledView_get_none {dataIn : Stream' (BitVec 32)} {t : Nat}
    (h : allDone rdOut1 rdOut2 vldIn t = 0#1) :
    Stream'.get (sampledView rdOut1 rdOut2 vldIn dataIn) t = none := by
  simp [sampledView, toStream, Stream'.get, h]

theorem sampledView_get_some {dataIn : Stream' (BitVec 32)} {t : Nat}
    (h : allDone rdOut1 rdOut2 vldIn t = 1#1) :
    Stream'.get (sampledView rdOut1 rdOut2 vldIn dataIn) t = some (dataIn t) := by
  simp [sampledView, toStream, Stream'.get, h,
        vldIn_of_allDone rdOut1 rdOut2 vldIn h]

/-- If receiver 1 never accepts from cycle `m` on, the receiver-1 view is
silent from `m` on. -/
theorem out1View_none_of_no_fire {dataIn : Stream' (BitVec 32)} {m : Nat}
    (hf : ∀ t, m ≤ t → fire1 rdOut1 rdOut2 vldIn t = 0#1) :
    ∀ t, m ≤ t → Stream'.get (out1View rdOut1 rdOut2 vldIn dataIn) t = none :=
  fun t ht => out1View_get_none rdOut1 rdOut2 vldIn (hf t ht)

/-- If receiver 1 never accepts from cycle `m` on (and its register is clear
at `m`), then no transaction ever completes from `m` on: the handshake-level
(transaction-sampled) stream is silent forever. This is the "one stalled
receiver blocks the whole fork" behaviour. -/
theorem sampledView_none_of_no_fire {dataIn : Stream' (BitVec 32)} {m : Nat}
    (he : e0 rdOut1 rdOut2 vldIn m = 0#1)
    (hf : ∀ t, m ≤ t → fire1 rdOut1 rdOut2 vldIn t = 0#1) :
    ∀ t, m ≤ t → Stream'.get (sampledView rdOut1 rdOut2 vldIn dataIn) t = none := by
  intro t ht
  refine sampledView_get_none rdOut1 rdOut2 vldIn ?_
  refine allDone_zero_of_quiet rdOut1 rdOut2 vldIn ?_ (hf t ht)
  exact e0_zero_of_no_fire rdOut1 rdOut2 vldIn ht he
    (fun s hs1 _ => hf s hs1)


/-! ## The sampling bisimulation -/

/-- Coinduction relation for `out1_sampling_bisim`. Both streams are *tails of
one fixed run* of the circuit, cut at `tA` (receiver-1 view) and `tB`
(transaction-level view). The invariant ties the two cut points together
through the register: `e0` is set exactly on the skew window `[tA, tB)`, i.e.
receiver 1 has already been served the transaction that is still open at the
input side, and `tB` sits at a transaction boundary (`e0 tB = 0`).

Keeping the *original* streams (cut, never restarted) means the circuit
equation and the handshake contracts never have to be re-established on
suffixes inside the coinduction. -/
inductive SampleRel (rdOut1 rdOut2 vldIn : Stream' (BitVec 1))
    (dataIn : Stream' (BitVec 32)) :
    Stream (BitVec 32) → Stream (BitVec 32) → Prop where
  /-- Both streams are silent forever: no token will ever be exchanged again.
  (Reached when no receiver-1 accept ever happens after the cut.) -/
  | stuck (a b : Stream (BitVec 32))
      (ha : ∀ i, Stream'.get a i = none)
      (hb : ∀ j, Stream'.get b j = none) :
      SampleRel rdOut1 rdOut2 vldIn dataIn a b
  /-- Tails of one fixed run, with the `e0` window invariant. -/
  | cut (a b : Stream (BitVec 32)) (tA tB : Nat)
      (ha : a = Stream'.drop tA (out1View rdOut1 rdOut2 vldIn dataIn))
      (hb : b = Stream'.drop tB (sampledView rdOut1 rdOut2 vldIn dataIn))
      (htAB : tA ≤ tB)
      (hwin : ∀ t, tA ≤ t → t < tB → e0 rdOut1 rdOut2 vldIn t = 1#1)
      (he0 : e0 rdOut1 rdOut2 vldIn tB = 0#1) :
      SampleRel rdOut1 rdOut2 vldIn dataIn a b


theorem sampleRel_of_nones (hs1 : ∀ t, s1 t = none) (hs3 : ∀ t, s2 t = none) :
    SampleRel rdOut1 rdOut2 vldIn dataIn s1 s2 := by
  exact SampleRel.stuck s1 s2 hs1 hs3

/-- **Sampling output 1 when receiver 1 accepts, and sampling it when the whole
transaction completes (`allDone`), yield bisimilar streams.** Moving each
token's observation instant from `fire1` to `allDone` changes the stream only
by finitely many `none`s. This is the essential correctness content of the
fork: every presented token is delivered exactly once to receiver 1, with the
value it has at completion time.

Proof plan (`Bisim.coinduct` with `pred := SampleRel ...`):
* `stuck` case: match `none` with `none` at `0`, stay `stuck`.
* `cut` case, no `fire1` at or after `tA`: both tails are all-`none`
  (`e0_zero_of_no_fire` + `allDone_zero_of_quiet`); re-establish via `stuck`.
* `cut` case, first `fire1` at `F ≥ tA`: by the window invariant `F ≥ tB`;
  the contract `hvr` yields the first completion `T ≥ F`; match
  `some (dataIn F) = some (dataIn T)` (`globallyValidAndData_stable`), with
  `none`s before on both sides (minimality of `F` and `T`); re-establish `cut`
  at `(F + 1, T + 1)` — the new window is `e0_one_of_window`, the new boundary
  is `e0_zero_of_allDone`. -/
theorem out1_sampling_bisim (dataIn : Stream' (BitVec 32))
    (hvr : globallyValidUntilReady vldIn (allDone rdOut1 rdOut2 vldIn))
    (hvd : globallyValidAndData vldIn dataIn) :
    out1View rdOut1 rdOut2 vldIn dataIn ~ sampledView rdOut1 rdOut2 vldIn dataIn := by
  apply Bisim.coinduct (pred := SampleRel rdOut1 rdOut2 vldIn dataIn)
  · intros s1 s2 hsample
    rcases hsample
    · case _ hs1 hs2 =>
      exists 0, 0
      simp
      have hz1 := hs1 0
      have hz2 := hs2 0
      simp [hz1, hz2]
      exact
        SampleRel.stuck (Stream'.drop 1 s1) (Stream'.drop 1 s2) (fun i => hs1 (i + 1)) fun j =>
          hs2 (j + 1)
    · case _ tA tB ha hb hAB hwin he0 =>
      by_cases hfire : ∃ t, fire1 rdOut1 rdOut2 vldIn (tA + t) = 1#1
      · /-
          Next fires at tfst = tA + j
          out1 | tA | ... | n | ... |   |
          out2 | tB | ... |   | ... | m |
          such that `out1 n = out2 m` and bisimilarity hold from then onwards.
          * `n` is the first one to fire for the first stream, obtained from `fire1`
          * `m` is the first one after `allDone` (at or after `tB`)
        -/
        have hfirst := if_exists_first_exists hfire
        obtain ⟨tdiff, htfst, htmin⟩ := hfirst
        have hFtB : tB ≤ tA + tdiff := by
          by_contra hcon
          push_neg at hcon
          have h1 := hwin (tA + tdiff) (by omega) hcon
          simp [fire1, vldOut1_def, h1] at htfst
          bv_decide
        /-
          out1 | tA  | ... | tA + tdiff | ... |       |                    |
          out2 | ... | tB  |    ...     |     |  ...  | tA + tdiff + tbfst |
        -/
        simp [globallyValidUntilReady] at hvr
        specialize hvr (tA + tdiff)
          (by simp [fire1, vldOut1_def] at htfst; bv_decide)
        have hexists : ∃ k, allDone rdOut1 rdOut2 vldIn (tA + tdiff + k) = 1#1 := by grind
        have ⟨tbfst, hbfst1, hbfst2⟩ := if_exists_first_exists hexists
        exists tdiff, (tA + tdiff + tbfst - tB)
        and_intros
        · apply SampleRel.cut _ _ (tA + tdiff + 1) (tA + tdiff + tbfst + 1)
          · simp [ha]
            congr 1
          · simp [hb]
            congr 1
            omega
          · omega
          · intro j hj hj2
            apply e0_one_of_window rdOut1 rdOut2 vldIn (by omega) htfst
            intro jj hjj1 hjj2
            have := hbfst2 (jj - (tA + tdiff)) (by omega)
            simp [show tA + tdiff + (jj - (tA + tdiff)) = jj by omega] at this
            simp [this]
          · exact e0_zero_of_allDone rdOut1 rdOut2 vldIn hbfst1
        · simp [ha, hb, Stream'.drop, show tA + tdiff + tbfst - tB + tB = tA + tdiff + tbfst by omega, Stream'.get]
          simp [out1View, sampledView]
          simp [fire1] at htfst
          simp [toStream]
          have hrd1 : rdOut1 (tA + tdiff) = 1#1 := by bv_decide
          have hvldIn : vldIn (tA + tdiff + tbfst) = 1#1 := by grind
          have hvld1 : vldOut1 rdOut1 rdOut2 vldIn (tA + tdiff) = 1#1 := by bv_decide
          simp [show tdiff + tA = tA + tdiff by omega, hrd1, hvld1, hbfst1, hvldIn]
          apply globallyValidAndData_stable (m := tA + tdiff) (n := tA + tdiff + tbfst) (data := dataIn)
                (vld := vldIn)
          · exact hvd
          · intro k hk1 hk2
            obtain ⟨l, hl2, hl3, hl4⟩ := hvr
            let jj := k - (tA + tdiff)
            simp [show k = tA + tdiff + jj by omega]
            have : jj ≤ l := by grind
            by_cases hlt : jj < l
            · apply hl4
              omega
            · simp [show jj = l by omega]
              exact hl3
          · omega
        · simp [ha]
          intro i hi
          specialize htmin i hi
          simp [fire1] at htmin
          simp [Stream'.get, out1View, toStream]
          bv_decide
        · intro i hi
          simp [hb]
          simp [sampledView]
          by_cases hlt : tB + i < tA + tdiff
          · have hfire0 : ∀ s, tB ≤ s → s < tB + i + 1 → fire1 rdOut1 rdOut2 vldIn s = 0#1 := by
              intro s hs1 hs2
              have := htmin (s - tA) (by omega)
              simp [show tA + (s - tA) = s by omega] at this
              exact this
            have he0' : e0 rdOut1 rdOut2 vldIn (tB + i) = 0#1 :=
              e0_zero_of_no_fire rdOut1 rdOut2 vldIn (by omega) he0 (fun s h1 h2 => hfire0 s h1 (by omega))
            exact sampledView_get_none rdOut1 rdOut2 vldIn
              (allDone_zero_of_quiet rdOut1 rdOut2 vldIn he0' (hfire0 _ (by omega) (by omega)))
          · let jj := tB + i - tA - tdiff
            simp [show tB + i = tA + tdiff + jj by omega]
            specialize hbfst2 jj (by omega)
            simp [Stream'.get, toStream, hbfst2]
      · /- no fire ever again -/
        exists tA, tB
        simp at hfire
        have ha1 := out1View_none_of_no_fire rdOut1 rdOut2 vldIn
                (m := tB) (dataIn := dataIn)
                (by
                  intro t' ht'
                  specialize hfire (t' - tA)
                  simp [show tA + (t' - tA) = t' by omega] at hfire
                  bv_decide)
        have ha2 := out1View_none_of_no_fire rdOut1 rdOut2 vldIn
                (m := tA) (dataIn := dataIn)
                (by
                  intro t' ht'
                  specialize hfire (t' - tA)
                  simp [show tA + (t' - tA) = t' by omega] at hfire
                  bv_decide)
        simp [out1View] at ha2
        have hb2 := sampledView_none_of_no_fire rdOut1 rdOut2 vldIn (dataIn := dataIn)
                (m := tB) he0
                (by
                  intro t' ht'
                  specialize hfire (t' - tA)
                  simp [show tA + (t' - tA) = t' by omega] at hfire
                  bv_decide)
        simp [sampledView] at hb2
        simp [out1View] at ha
        simp [sampledView] at hb
        and_intros
        · apply sampleRel_of_nones
          · intro t
            simp [ha]
            apply ha2
            omega
          · intro t
            simp [hb]
            apply hb2
            omega
        · simp [ha, hb]
          specialize ha2 (tA + tA)
          specialize hb2 (tB + tB)
          simp [ha2, hb2]
        · simp [ha]
          intro j hj
          apply ha2
          omega
        · simp [hb]
          intro j hj
          apply hb2
          omega
  · apply SampleRel.cut _ _ 0 0
    · simp
    · simp
    · omega
    · intros
      simp at *
    · simp [e0_zero]

/-! ## Refinement of the handshake fork -/

/-- The components produced by `TRY3.hw_fork` are exactly the named signals of
this file. (Via `hw_fork_eq`, `split_stream2` and `hw_fork'_get`.) -/
theorem hw_fork_components {dataIn : Stream' (BitVec 32)}
    {rdIn vld1 vld2 : Stream' (BitVec 1)} {data1 data2 : Stream' (BitVec 32)}
    (hfork : (rdIn, vld1, vld2, data1, data2)
      = TRY3.split_stream2 (TRY3.hw_fork rdOut1 rdOut2 vldIn dataIn)) :
    rdIn = allDone rdOut1 rdOut2 vldIn
      ∧ vld1 = vldOut1 rdOut1 rdOut2 vldIn
      ∧ vld2 = vldOut2 rdOut1 rdOut2 vldIn
      ∧ data1 = dataIn ∧ data2 = dataIn := by
  rw [hw_fork_eq] at hfork
  simp only [TRY3.split_stream2, Prod.mk.injEq] at hfork
  obtain ⟨hrdIn, hvld1, hvld2, hdata1, hdata2⟩ := hfork
  and_intros
  · simp [hrdIn, hw_fork'_get, vldOut2_def]
  · simp [hvld1, hw_fork'_get]
  · simp [hvld2, hw_fork'_get]
  · simp [hdata1, hw_fork'_get]
  · simp [hdata2, hw_fork'_get]

/-- **The RTL fork refines the handshake fork on output 1**: under the
handshake contracts on the input (valid persists until acknowledged, data
stable while valid — no deadlock included), the stream of tokens seen by
receiver 1 is bisimilar to the input stream of tokens.

(The transaction-level view is *pointwise equal* to the input stream by
`hw_fork_components`, so this is `out1_sampling_bisim` up to symmetry of `~`.) -/
theorem hw_fork_refines_out1 {dataIn : Stream' (BitVec 32)}
    {rdIn vld1 vld2 : Stream' (BitVec 1)} {data1 data2 : Stream' (BitVec 32)}
    (hfork : (rdIn, vld1, vld2, data1, data2)
      = TRY3.split_stream2 (TRY3.hw_fork rdOut1 rdOut2 vldIn dataIn))
    (hvr : globallyValidUntilReady vldIn rdIn)
    (hvd : globallyValidAndData vldIn dataIn) :
    toStream rdIn vldIn dataIn ~ toStream rdOut1 vld1 data1 := by
  obtain ⟨h1, h2, -, h4, -⟩ := hw_fork_components rdOut1 rdOut2 vldIn hfork
  subst h1 h2 h4
  apply HandshakeStream.symm
  apply out1_sampling_bisim
  · exact hvr
  · exact hvd

end Fork
end HWComponents
