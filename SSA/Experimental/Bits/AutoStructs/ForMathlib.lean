import Batteries.Data.Fin.Basic
import Mathlib.Computability.NFA
import Mathlib.Data.FinEnum
import Mathlib.Data.Rel
import Mathlib.Data.Vector.Basic
import Mathlib.Data.Vector.Defs
import SSA.Experimental.Bits.AutoStructs.ForLean
import Std.Data.HashSet.Basic

open Set
open Mathlib

@[simp]
lemma List.Vector.append_get_lt {x : List.Vector α n} {y : List.Vector α m} {i : Fin (n+m)} (hlt: i < n) :
    (x.append y).get i = x.get (i.castLT hlt) := by
  rcases x with ⟨x, hx⟩; rcases y with ⟨y, hy⟩
  dsimp [List.Vector.append, List.Vector.get]
  apply List.getElem_append_left

@[simp]
lemma List.Vector.append_get_ge {x : List.Vector α n} {y : List.Vector α m} {i : Fin (n+m)} (hlt: n ≤ i) :
    (x.append y).get i = y.get ((i.cast (Nat.add_comm n m) |>.subNat n hlt)) := by
  rcases x with ⟨x, hx⟩; rcases y with ⟨y, hy⟩
  dsimp [List.Vector.append, List.Vector.get]
  rcases hx
  apply List.getElem_append_right hlt

@[simp]
def BitVec.getLsbD_cast' (bv : BitVec n) (h : n = m):
    (h ▸ bv).getLsbD i = bv.getLsbD i := by
  rcases h; simp


-- this is better because card is defeq to n
@[simps]
instance finenum_fin : FinEnum (Fin n) where
  card := n
  equiv := by rfl

instance (α : Type) : Inter (Language α) := ⟨Set.inter⟩
instance (α : Type) : Union (Language α) := ⟨Set.union⟩

def List.Vector.transport (v : Vector α m) (f : Fin n → Fin m) : Vector α n :=
  Vector.ofFn fun i => v.get (f i)

def BitVec.transport (f : Fin n2 → Fin n1) (bv : BitVec n1) : BitVec n2 :=
  BitVec.ofFn fun i => bv.getLsbD (f i)

@[simp]
lemma BitVec.transport_getLsbD (f : Fin n2 → Fin n1) (bv : BitVec n1) (i : Fin n2) :
    (bv.transport f).getLsbD i = bv.getLsbD (f i) := by
  simp [transport]

@[simp]
lemma BitVec.transport_getLsbD_nat (f : Fin n2 → Fin n1) (bv : BitVec n1) (i : Nat) (hlt : i < n2) :
    (bv.transport f).getLsbD i = bv.getLsbD (f ⟨i, hlt⟩) := by
  have heq : i = (Fin.mk i hlt).val := by rfl
  nth_rw 1 [heq]
  rw [transport_getLsbD]

/--
The set of `n`-tuples of bit vectors of an arbitrary width.
-/
structure BitVecs (n : Nat) where
  w : Nat
  bvs : List.Vector (BitVec w) n

abbrev BitVecs.empty : BitVecs n := ⟨0, List.Vector.replicate n .nil⟩
abbrev BitVecs.singleton {w : Nat} (bv : BitVec w) : BitVecs 1 := ⟨w, bv ::ᵥ .nil⟩
abbrev BitVecs.pair {w : Nat} (bv1 bv2 : BitVec w) : BitVecs 2 := ⟨w, bv1 ::ᵥ bv2 ::ᵥ .nil⟩

def BitVecs0 : Set (BitVecs n) :=
  {⟨0, List.Vector.replicate n (BitVec.zero 0)⟩}

-- TODO: this ought to be way easier
@[ext (iff := false)]
lemma BitVecs.ext (x y : BitVecs n) :
    ∀ (heq : x.w = y.w),
      (∀ (i : Fin n), x.bvs.get i = heq ▸ y.bvs.get i) →
      x = y := by
  intros heq hbvs
  rcases x with ⟨wx, bvsx⟩
  rcases y with ⟨wy, bvsy⟩
  congr
  rcases heq
  apply heq_of_eq
  ext i j
  simp_all

/--
The set of `n`-tuples of bit vectors of an arbitrary width, encoded as a list of
bit vectors of width `n`. The width of the encoded bit vectors is the length of
the list.
-/
abbrev BitVecs' (n : Nat) := List (BitVec n)

def enc (bvs : BitVecs n) : BitVecs' n :=
  (List.finRange bvs.w).map (fun i =>
    BitVec.ofFn (fun (k : Fin n) => (bvs.bvs.get k)[i]))

def dec (bvs' : BitVecs' n) : BitVecs n where
  w := bvs'.length
  bvs := List.Vector.ofFn fun k => BitVec.ofFn fun i => bvs'[i].getLsbD k

@[simp]
lemma dec_nil n : dec (n := n) [] = BitVecs.empty := by
  ext <;> simp [dec]

-- The two sets are in bijection.

@[simp]
lemma enc_length (bvs : BitVecs n) : (enc bvs).length = bvs.w := by
  simp [enc]

@[simp]
lemma dec_w (bvs' : BitVecs' n) : (dec bvs').w = bvs'.length := by
  simp [dec]

@[simp]
lemma enc_spec (bvs : BitVecs n) (i : Fin bvs.w) (k : Fin n) :
    (enc bvs)[i][k] = (bvs.bvs.get k)[i] := by
  simp [enc, dec]

@[simp]
lemma dec_spec (bvs' : BitVecs' n) (k : Fin n) (i : Fin bvs'.length) :
    ((dec bvs').bvs.get k).getLsbD i = bvs'[i].getLsbD k := by
  simp [dec]

@[simp]
lemma dec_spec' (bvs' : BitVecs' n) (k : Fin n) (i : Fin bvs'.length) :
    ((dec bvs').bvs.get k).getLsbD i = bvs'[i].getLsbD k := by
  simp [dec]

lemma dec_enc_w (bvs : BitVecs n) : (dec (enc bvs)).w = bvs.w := by simp [enc, dec]

lemma helper_dec_enc (bvs : BitVecs n) (h : w' = bvs.w) i (j : Nat) :
    (bvs.bvs.get i)[j]?.getD false = (h ▸ bvs.bvs.get i)[j]?.getD false := by
  rcases h; simp

@[simp]
lemma dec_enc : Function.RightInverse (α := BitVecs' n) enc dec := by
  intros bvs; ext1; exact dec_enc_w bvs
  next i =>
    simp only [enc, Fin.getElem_fin, dec, List.getElem_map, List.getElem_finRange, Fin.cast_mk,
      Fin.is_lt, BitVec.ofFn_getLsbD', Fin.eta, List.Vector.get_ofFn]
    ext
    simp_all only [List.length_map, List.length_finRange, BitVec.ofFn_getLsbD',
      BitVec.getLsbD_cast']
    rfl

@[simp]
lemma enc_dec : Function.LeftInverse (α := BitVecs' n) enc dec := by
  intros bvs'; simp [enc, dec]
  ext1 k
  by_cases hin : k < (List.length bvs')
  · simp
    rw [List.getElem?_eq_getElem] <;> simp_all only [List.length_finRange, List.getElem_finRange,
      Fin.cast_mk, Option.map_some', List.getElem?_eq_getElem, Option.some.injEq]
    ext1; simp_all
  · simp; repeat rw [List.getElem?_eq_none] <;> simp_all

@[simp]
lemma dec_enc' : dec (enc bvs) = bvs := by apply dec_enc
@[simp]
lemma enc_dec' : enc (dec bvs') = bvs' := by apply enc_dec

@[simp]
def dec_bij {n : Nat} : Function.Bijective (dec (n := n)) := by
  rw [Function.bijective_iff_has_inverse]; use enc; simp

def dec_surj (n : Nat) : Function.Surjective (dec (n := n)) := by
  exact Function.Bijective.surjective dec_bij

def dec_inj {n : Nat} : Function.Injective (dec (n := n)) := by
  exact Function.Bijective.injective dec_bij

@[simp]
lemma dec_snoc n (bvs' : BitVecs' n) (a : BitVec n) : dec (bvs' ++ [a]) =
  { w := bvs'.length + 1
    bvs := List.Vector.ofFn fun k => BitVec.cons (a.getLsbD k) ((dec bvs').bvs.get k) } := by
  ext k i <;> simp_all only [dec, Fin.getElem_fin, List.length_append, List.length_singleton,
    List.Vector.get_ofFn, BitVec.ofFn_getLsbD', BitVec.getLsbD_cast']
  rw [BitVec.getLsbD_cons]
  split
  next heq => simp_all
  next h =>
    have hlt : i < List.length bvs' := by omega
    rw [List.getElem_append_left hlt, BitVec.ofFn_getLsbD' _ _ hlt]

@[simp]
lemma dec_enc_image : dec '' (enc '' S) = S := Function.LeftInverse.image_image dec_enc _

@[simp]
lemma env_dec_image : enc '' (dec '' S) = S :=  Function.LeftInverse.image_image enc_dec _

def BitVecs.transport (f : Fin n → Fin m) (bvs : BitVecs m) : BitVecs n :=
  { w := bvs.w, bvs := bvs.bvs.transport f }


@[simp]
lemma BitVecs.transport_w {bvs : BitVecs n} : (BitVecs.transport f bvs).w = bvs.w := by
  simp [transport]

@[simp]
lemma BitVecs.transport_getElem {bvs : BitVecs m} (f : Fin n → Fin m) (i : Fin n) :
    (bvs.transport f).bvs.get i = bvs.bvs.get (f i) := by
  simp [transport, List.Vector.transport]

def BitVecs'.transport (f : Fin n → Fin m) (bvs' : BitVecs' m): BitVecs' n :=
  bvs'.map fun bv => bv.transport f

@[simp]
lemma BitVecs'.tranport_length {bvs' : BitVecs' n} : (BitVecs'.transport f bvs').length = bvs'.length := by
  simp [transport]

@[simp]
lemma BitVecs'.transport_getElem {bvs' : BitVecs' m} (f : Fin n → Fin m) (i : Fin bvs'.length) :
    (bvs'.transport f)[i] = bvs'[i].transport f := by
  simp [transport]

@[simp]
lemma BitVecs'.transport_getElem' {bvs' : BitVecs' m} (f : Fin n → Fin m) (i : Nat) (h : i < bvs'.length) :
    (bvs'.transport f)[i]'(by simp_all) = (bvs'[i]'h).transport f := by
  simp [transport]

-- TODO: this script generates an ill typed proof :(
set_option debug.skipKernelTC true in
@[simp]
def dec_transport_idx {bvs' : BitVecs' n} (f : Fin m → Fin n) :
    have h : (BitVecs.transport f (dec bvs')).w = (dec (BitVecs'.transport f bvs')).w := by simp
    (dec (bvs'.transport f)).bvs.get i =  h ▸ (((dec bvs').transport f).bvs.get i) := by
  intros h
  simp [dec]
  ext1 i hi
  simp_all [BitVecs'.tranport_length, BitVec.getLsbD_cast']

@[simp]
def dec_transport :
    dec (bvs'.transport f) = (dec bvs').transport f := by
  ext k j <;> simp

@[simp]
def enc_transport_idx {bvs : BitVecs n} (f : Fin m → Fin n) (i : Fin bvs.w) :
    (enc (bvs.transport f))[i] = (enc bvs)[i].transport f := by
  ext1 k hk; simp_all [enc]; rfl

@[simp]
def enc_transport :
     enc (bvs.transport f) = (enc bvs).transport f := by
  apply List.ext_getElem <;> simp
  intros i hi hi'
  have _ := enc_transport_idx f ⟨i, hi⟩
  simp_all

@[simp]
def dec_transport_preim :
    dec '' (BitVecs'.transport f ⁻¹' S) = BitVecs.transport f ⁻¹' (dec '' S) := by
  ext1 bvs; simp; constructor
  · rintro ⟨bvs', htr, hdec⟩
    use bvs'.transport f; constructor; apply htr
    simp [← hdec]
  · rintro ⟨bvs', hS, hdec⟩
    use enc bvs
    rw [←enc_transport]
    constructor <;> simp_all [←hdec, enc_dec]

@[simp]
def dec_transport_image (f : Fin m → Fin n) :
    dec '' (BitVecs'.transport f '' S) = BitVecs.transport f '' (dec '' S) := by
  ext1; simp

namespace NFA

def Complete' (M : NFA α σ) : Prop := ∀ q a, M.step q a ≠ ∅

def Complete (M : NFA α σ) : Prop := ∀ w, Nonempty (M.eval w)

lemma complete_stepSet_ne {M : NFA α σ} {hc : M.Complete'} : S ≠ ∅ → M.stepSet S a ≠ ∅ := by
  push_neg; rintro ⟨q, hq⟩
  have hne := hc q a
  push_neg at hne
  rcases hne with ⟨q', hq'⟩
  use q'; simp [stepSet]; use q

structure Deterministic (M : NFA α σ) : Prop where
  start : M.start.Subsingleton
  step : ∀ q a, M.step q a |>.Subsingleton

attribute [simp] Deterministic.start Deterministic.step

lemma deterministic_stepSet_subsingleton {M : NFA α σ} {S : Set σ} (hd : M.Deterministic) :
    S.Subsingleton → (M.stepSet S a |>.Subsingleton) := by
  intros hS
  simp_all [stepSet, Set.Subsingleton]
  intros q1' q1 hq1 hq1' q2' q2 hq2 hq2'
  obtain rfl := hS hq1 hq2
  obtain rfl := hd.step q1 a hq1' hq2'
  rfl

lemma deterministic_eval_subsingleton {M : NFA α σ} (hd : M.Deterministic) w :
    M.eval w |>.Subsingleton := by
  induction w using List.list_reverse_induction
  case base => simp_all
  case ind w a ih => simp; apply deterministic_stepSet_subsingleton <;> assumption

private noncomputable instance {M : NFA α σ} : Decidable M.Complete :=
  Classical.propDecidable _


@[simp, aesop 50% unsafe]
theorem stepSet_mono (M : NFA α σ) (S₁ S₂ : Set σ) (a : α) (h : S₁ ⊆ S₂) :
    M.stepSet S₁ a ⊆ M.stepSet S₂ a := by
  simp only [stepSet]; apply biUnion_mono <;> simp_all

@[simp, aesop 50% unsafe]
theorem evalFrom_mono (M : NFA α σ) (S₁ S₂ : Set σ) (x : List α) (h : S₁ ⊆ S₂) :
    M.evalFrom S₁ x ⊆ M.evalFrom S₂ x := by
  simp only [evalFrom]; induction' x with a x ih generalizing S₁ S₂ <;> simp_all [List.foldl_cons]

def Reachable (M : NFA α σ) : Set σ := λ q ↦ ∃ w, q ∈ M.eval w

def reduce (M : NFA α σ) : NFA α M.Reachable where
  start q :=  M.start q.val
  accept q := M.accept q.val
  step q a q' := M.step q.val a q'.val

lemma reduce_stepSet {M : NFA α σ} {q : σ} (S1 : Set M.Reachable) (S2 : Set σ) :
    (∀ q, (∃ hq, S1 ⟨q, hq⟩) ↔ S2 q) →
    ((∃ hq,  ⟨q, hq⟩ ∈ M.reduce.stepSet S1 a) ↔ q ∈ M.stepSet S2 a) := by
  intros h
  simp_all [reduce, stepSet]; constructor
  · rintro ⟨hq, q', ⟨hr, hs1⟩, hs⟩
    have hin : S2 q' := by rw [←h q']; use hr; apply hs1
    use q'; constructor; apply hin; apply hs
  · rintro ⟨q', hs2, hs⟩
    obtain ⟨hr', hs1⟩ :=(h q').mpr hs2
    have hr : q ∈ M.Reachable := by
      obtain ⟨w, he⟩ := hr'
      use (w ++ [a]); simp [stepSet]; use q'
    use hr, q'; constructor
    · use hr'; apply hs1
    · apply hs

lemma reduce_stepSet' {M : NFA α σ} (q : M.Reachable) (S1 : Set M.Reachable) (S2 : Set σ) :
    (∀ q, (∃ hq, S1 ⟨q, hq⟩) ↔ S2 q) →
    (q ∈ M.reduce.stepSet S1 a → q.val ∈ M.stepSet S2 a) := by
  intros h; simp [←reduce_stepSet _ _ h]

lemma reduce_eval {M : NFA α σ} {w} (q : σ) : (∃ hq, ⟨q, hq⟩ ∈ M.reduce.eval w) ↔ q ∈ M.eval w := by
  induction w using List.list_reverse_induction generalizing q
  case base => simp [reduce, Set.instMembership, Set.Mem]; intros hs; use .nil; simpa
  case ind a w ih =>
    simp [eval]; constructor
    · rintro ⟨hq, hs⟩
      apply reduce_stepSet' at hs
      apply hs
      apply ih
    · rintro hs
      rw [←reduce_stepSet] at hs
      apply hs
      apply ih

@[simp]
lemma reduce_spec (M : NFA α σ) : M.reduce.accepts = M.accepts := by
  ext w; simp [accepts]; constructor
  · rintro ⟨q, hr, ha, he⟩
    use q
    constructor
    · apply ha
    · simp_all [←reduce_eval q]
  · rintro ⟨q, ha, he⟩
    obtain ⟨hq, he'⟩ := reduce_eval q |>.mpr he
    use q, hq
    constructor
    · apply ha
    · simp_all [←reduce_eval q]

def closed_set (M : NFA α σ) (S : Set σ) := M.start ⊆ S ∧ ∀ a, M.stepSet S a ⊆ S

theorem reachable_sub_closed_set (M : NFA α σ) (S : Set σ) (hcl: M.closed_set S) :
    M.Reachable ⊆ S := by
  rintro q ⟨w, hw⟩
  rcases hcl with ⟨hstart, hincl⟩
  induction w using List.list_reverse_induction generalizing q
  case base => aesop
  case ind w a ih =>
    simp only [eval] at hw
    rw [evalFrom_append_singleton, mem_stepSet] at hw
    rcases hw with ⟨q', h1, h2⟩
    apply ih at h1
    suffices _ : q ∈ M.stepSet S a by aesop
    rw [mem_stepSet]; use q'

@[simps]
def complete (M : NFA α σ) : NFA α (σ ⊕ Unit) where
  start := { x | match x with | .inl x => x ∈ M.start | .inr () => True }
  accept := { x | match x with | .inl x => x ∈ M.accept | .inr () => False }
  step x a := { y |
    match x with
    | .inl x => match y with | .inl y => y ∈ M.step x a | .inr () => False
    | .inr () => y = .inr () }

@[simp]
lemma accepts_cast {M : NFA α σ} (h : σ = ς): (h ▸ M).accepts = M.accepts := by
  rcases h; simp

@[simp]
lemma step_cast {M : NFA α σ} (h : σ = ς) (q q' : σ): (h ▸ q') ∈ (h ▸ M).step (h ▸ q) a ↔ q' ∈  M.step q a := by
  rcases h; simp

@[simp]
lemma complete_cast {M : NFA α σ} (h : σ = ς) : (h ▸ M).Complete ↔ M.Complete := by
  rcases h; simp

@[simp]
lemma complete_stepSet {M : NFA α σ} (q : σ) :
    (∀ q, (Sum.inl q ∈ S1) ↔ S2 q) →
    ((.inl q ∈ M.complete.stepSet S1 a) ↔ q ∈ M.stepSet S2 a) := by
  simp_all [complete, stepSet, Set.instMembership, Set.Mem]

lemma complete_stepSet_sink {M : NFA α σ} :
    .inr () ∈ S → .inr () ∈ M.complete.stepSet S a := by
  simp_all [complete, stepSet, Set.instMembership, Set.Mem]

@[simp]
lemma complete_eval {M : NFA α σ} {w} (q : σ) :
    (.inl q ∈ M.complete.eval w) ↔ q ∈ M.eval w := by
  induction w using List.list_reverse_induction generalizing q
  case base => simp [complete, Set.instMembership, Set.Mem]
  case ind a w ih =>
    simp only [eval]; constructor
    · simp; rintro _; rw [←complete_stepSet]; assumption; apply ih
    · simp; rintro _; rw [complete_stepSet]; assumption; apply ih

@[simp]
theorem complete_accepts (M : NFA α σ) : M.complete.accepts = M.accepts := by
  simp [accepts]

@[simp]
theorem complete_complete (M : NFA α σ) : M.complete.Complete := by
  intros w
  use (.inr ())
  induction w using List.list_reverse_induction
  case base => simp
  case ind w a ih =>
    simp [eval]
    apply complete_stepSet_sink
    apply ih

def product (accept? : Prop → Prop → Prop) (M : NFA α σ) (N : NFA α ς) : NFA α (σ × ς) where
  step := fun (q₁, q₂) a => { (q₁', q₂') | (q₁' ∈ M.step q₁ a) ∧ (q₂' ∈ N.step q₂ a) }
  start := { (q₁, q₂) | (q₁ ∈ M.start) ∧ (q₂ ∈ N.start) }
  accept := { (q₁, q₂) | accept? (q₁ ∈ M.accept) (q₂ ∈ N.accept) }

def inter (M : NFA α σ) (N : NFA α ς) : NFA α (σ × ς) := product And M N

-- Note: the automata need to be complete!
def union' (M : NFA α σ) (N : NFA α ς) : NFA α (σ × ς) := product Or M N

def union (M : NFA α σ) (N : NFA α ς) : NFA α ((σ ⊕ Unit) × (ς ⊕ Unit)) :=
  M.complete.union' N.complete

@[simp]
lemma product_accept {M : NFA α σ} {N : NFA α ς} :
    (q1, q2) ∈ (M.product accept? N).accept ↔ accept? (q1 ∈ M.accept) (q2 ∈ N.accept) := by
  simp [product]

@[simp]
lemma product_stepSet {M : NFA α σ} {N : NFA α ς} :
    (M.product accept? N).stepSet (S1 ×ˢ S2) a = ((M.stepSet S1 a) ×ˢ (N.stepSet S2 a)) := by
  ext ⟨q1, q2⟩; simp [product, stepSet]; constructor
  · rintro ⟨q1', hq1, q2', hS, hq2⟩; constructor
    · use q1'; simp_all
    · use q2'; simp_all
  · rintro ⟨⟨q1', h1, hs1⟩, ⟨q2', h2, hs2⟩⟩
    use q1'; constructor; assumption; use q2'

@[simp]
lemma product_eval {M : NFA α σ} {N : NFA α ς} {w} :
  (M.product accept? N).eval w = M.eval w ×ˢ N.eval w := by
  unfold eval; induction w using List.list_reverse_induction
  case base => ext; simp [product]
  case ind w a ih => simp only [eval, evalFrom_append_singleton, product_stepSet, ih]

@[simp]
theorem inter_accepts (M : NFA α σ) (N : NFA α ς) :
    (M.inter N).accepts = M.accepts ∩ N.accepts:= by
  ext w; simp [accepts, inter]; constructor
  · rintro ⟨q1, q2, ⟨_, _⟩, _, _⟩; constructor; use q1; use q2
  · rintro ⟨⟨q1, _⟩, q2, _⟩; use q1, q2; simp_all

@[simp]
theorem union'_accepts (M : NFA α σ) (N : NFA α ς) (hcM: M.Complete) (hcN : N.Complete) :
    (M.union' N).accepts = M.accepts ∪ N.accepts := by
  ext w; constructor
  · simp [accepts]
    rintro ⟨q1, q2, ha, he⟩
    simp [union'] at he ha
    rcases ha with ha | ha
    · left; use q1; simp_all
    · right; use q2; simp_all
  · simp [accepts]
    rintro (⟨q1, ha, he⟩ | ⟨q2, ha, he⟩)
    · obtain ⟨q2, he2⟩ := hcN w
      use q1, q2; simp_all [union']
    · obtain ⟨q1, he1⟩ := hcM w
      use q1, q2; simp_all [union']

@[simp]
theorem union_accepts (M : NFA α σ) (N : NFA α ς) :
    (M.union N).accepts = M.accepts ∪ N.accepts := by
  simp [union]

def flipAccept (M : NFA α σ) : NFA α σ where
  start := M.start
  accept := M.accept.compl
  step := M.step

@[simp]
theorem flipAccept_eval {M : NFA α σ} : M.flipAccept.eval w = M.eval w := by
  simp [flipAccept, eval, evalFrom]; unfold stepSet; simp

@[simp]
theorem flipAccept_accepts (M : NFA α σ) (hc : M.Complete) (hdet : M.Deterministic) :
    M.flipAccept.accepts = M.acceptsᶜ := by
  ext w; constructor; simp [accepts, Language.eq_def, Set.compl_def]; rintro q ha he
  · intros q' ha' he'
    obtain rfl := deterministic_eval_subsingleton hdet w he he'
    simp_all [flipAccept, Set.compl]
  · simp [accepts, Language.eq_def, Set.compl_def]
    intros hw
    obtain ⟨qf, hqf⟩ := hc w
    have ha : ¬ qf ∈ M.accept := by by_contra; apply hw <;> assumption
    use qf; simp_all [flipAccept, Set.compl]

def neg (M : NFA α σ) := M.toDFA.toNFA.flipAccept

@[simp]
lemma determinize_complete (M : NFA α σ) :
    M.toDFA.toNFA.Complete := by
  simp [Complete, eval]

@[simp]
lemma determinize_deternistic (M : NFA α σ) :
    M.toDFA.toNFA.Deterministic := by
  simp [Deterministic, DFA.toNFA, toDFA]
  constructor <;> simp

@[simp]
theorem neg_accepts (M : NFA α σ) :
    M.neg.accepts = M.acceptsᶜ := by
  simp [neg]


/-
NOTE: all that follows is defined in terms of bit vectors, even though it should
probably be defined in terms of `Vec n α` for an arbitrary type `α`.
-/

/-- Defined as bv'[i] = bv[f i] -/
@[simps]
def lift (M: NFA (BitVec n1) σ) (f : Fin n1 → Fin n2) : NFA (BitVec n2) σ where
  start := M.start
  accept := M.accept
  step q a := M.step q (a.transport f)

@[simp]
lemma lift_stepSet (M : NFA (BitVec n) σ) (f : Fin n → Fin m) :
    (M.lift f).stepSet S a = M.stepSet S (a.transport f) := by
  simp [lift, stepSet]

@[simp]
lemma lift_eval (M : NFA (BitVec n) σ) (f : Fin n → Fin m) :
    (M.lift f).eval w = M.eval (BitVecs'.transport f w) := by
  induction w using List.list_reverse_induction
  case base => simp [lift, BitVecs'.transport]
  case ind w a ih => simp [BitVecs'.transport, ih]

@[simp]
lemma lift_accepts (M : NFA (BitVec n) σ) (f : Fin n → Fin m) :
    (M.lift f).accepts = BitVecs'.transport f ⁻¹' M.accepts := by
  simp [accepts]

@[simps]
def proj (M: NFA (BitVec n1) σ) (f : Fin n2 → Fin n1) : NFA (BitVec n2) σ where
  start := M.start
  accept := M.accept
  step q a := { q' | ∃ a', a'.transport f = a ∧ q' ∈ M.step q a' }

@[simp]
lemma proj_stepSet (M : NFA (BitVec m) σ) (f : Fin n → Fin m) :
    (M.proj f).stepSet S a =
      ⋃ a' ∈ BitVec.transport f ⁻¹' {a}, M.stepSet S a' := by
  ext q; simp [proj, stepSet]; constructor
  · rintro ⟨q', hS, a', htr, hs⟩
    use a'; constructor; assumption; use q'
  · rintro ⟨a', htr, q', hS, hs⟩
    use q'; constructor; assumption; use a'

@[simp]
lemma proj_eval (M : NFA (BitVec m) σ) (f : Fin n → Fin m) :
    (M.proj f).eval w =
      ⋃ w' ∈ BitVecs'.transport f ⁻¹' {w}, M.eval w' := by
  induction w using List.list_reverse_induction
  case base => simp [proj, BitVecs'.transport]
  case ind w a ih =>
    ext q; simp [BitVecs'.transport]; constructor
    · rintro ⟨a', htr, S, hrS, hqS⟩
      rcases hrS with ⟨q', rfl⟩
      simp [ih] at hqS
      rcases hqS with ⟨⟨w', htr', he⟩, hs⟩
      use w' ++ [a']; constructor
      · simp_all; exact htr'
      · simp; use M.step q' a'; constructor
        on_goal 2 => assumption
        use q'; simp_all
    · rintro ⟨wa', heq, he⟩
      by_cases hemp : wa' = []
      · simp_all
      have hdl := List.dropLast_concat_getLast hemp
      rw [←hdl] at heq he
      simp at heq
      use List.getLast wa' hemp; constructor
      · apply List.append_inj_right' at heq; simp_all
      · obtain rfl := List.append_inj_left' heq (by simp)
        simp at he; rcases he with ⟨S, ⟨q', rfl⟩, hqS⟩
        simp at hqS; rcases hqS with ⟨he, hs⟩
        simp only [stepSet, mem_iUnion, exists_prop]
        use q'
        simp [ih]; constructor
        on_goal 2 => assumption
        use wa'.dropLast
        simp_all [BitVecs'.transport]

@[simp]
lemma proj_accepts (M : NFA (BitVec m) σ) (f : Fin n → Fin m) :
    (M.proj f).accepts = BitVecs'.transport f '' M.accepts := by
  ext w; simp [accepts]; constructor
  · rintro ⟨q, ha, w', htr, he⟩
    use w'; simp [htr]; use q
  · rintro ⟨w', ⟨q, he, hv⟩, htr⟩
    use q; simp [he]; use w'

/- Simulations -/

structure _root_.Rel.set_eq (R : Rel α β) (A : Set α) (B : Set β) where
  fwd : a ∈ A → ∃ b ∈ B, R a b
  bwd : b ∈ B → ∃ a ∈ A, R a b

theorem _root_.Rel.set_eq_symm {R : Rel α β} (h : R.set_eq A B) : R.inv.set_eq B A := by
  rcases h with ⟨h1, h2⟩; constructor <;> simp_all [Rel.inv, flip]

structure Bisimul (R : Rel σ ς) (M₁ : NFA α σ) (M₂ : NFA α ς) where
  accept : R q₁ q₂ → (q₁ ∈ M₁.accept ↔ q₂ ∈ M₂.accept)
  start : R.set_eq M₁.start M₂.start
  trans_match₁ : R q₁ q₂ → q₁' ∈ M₁.step q₁ a → ∃ q₂', q₂' ∈ M₂.step q₂ a ∧ R q₁' q₂'
  trans_match₂ : R q₁ q₂ → q₂' ∈ M₂.step q₂ a → ∃ q₁', q₁' ∈ M₁.step q₁ a ∧ R q₁' q₂'

def Bisim (M₁ : NFA α σ) (M₂ : NFA α ς) := ∃ R, M₁.Bisimul R M₂

theorem Bisimul.symm (hsim : Bisimul R M₁ M₂) : Bisimul R.inv M₂ M₁ := by
  rcases hsim with ⟨h1, h2, h3, h4⟩; constructor <;> simp_all [Rel.inv, flip]
  · intros; symm; apply h1; assumption
  · apply R.set_eq_symm; assumption
  · intros; apply h4 <;> assumption
  · intros; apply h3 <;> assumption

lemma bisimul_eval_one (hsim : Bisimul R M₁ M₂) :
    R.set_eq Q₁ Q₂ → R.set_eq (M₁.stepSet Q₁ a) (M₂.stepSet Q₂ a) := by
  rintro ⟨h1, h2⟩; constructor <;> simp only [stepSet, mem_iUnion, exists_prop,
    forall_exists_index, and_imp] at *
  · rintro q₁' q₁ hq₁ hst
    obtain ⟨q₂, hq₂, hR⟩ := h1 hq₁
    obtain ⟨q₂', hst', hR'⟩ := hsim.trans_match₁ hR hst
    use q₂', ⟨q₂, hq₂, hst'⟩
  · rintro q₂' q₂ hq₂ hst
    obtain ⟨q₁, hq₁, hR⟩ := h2 hq₂
    obtain ⟨q₁', hst', hR'⟩ := hsim.trans_match₂ hR hst
    use q₁', ⟨q₁, hq₁, hst'⟩

lemma bisimul_eval (hsim : Bisimul R M₁ M₂) w :
    R.set_eq Q₁ Q₂ → R.set_eq (M₁.evalFrom Q₁ w) (M₂.evalFrom Q₂ w) := by
  induction w using List.list_reverse_induction generalizing Q₁ Q₂
  case base => simp
  case ind w a ih => rintro heq; simp [evalFrom_append_singleton, bisimul_eval_one, *]

theorem bisimul_accepts₁ :
    Bisimul R M₁ M₂ → M₁.accepts ≤ M₂.accepts := by
  rintro hsim w ⟨q₁, ha, he⟩
  have ⟨q₂, he', hR⟩ := (bisimul_eval hsim w hsim.start).1 he
  use q₂, (hsim.accept hR).mp ha, he'

theorem bisimul_accepts :
    Bisimul R M₁ M₂ → M₁.accepts = M₂.accepts := by
  rintro hsim
  apply le_antisymm
  · apply bisimul_accepts₁ hsim
  · apply bisimul_accepts₁ hsim.symm

end NFA

def Std.HashSet.toSet [BEq α] [Hashable α] (m : HashSet α) : Set α := { x | x ∈ m }

@[simp]
lemma Std.HashSet.mem_toSet [BEq α] [Hashable α] (m : HashSet α) : x ∈ m.toSet ↔ x ∈ m := by rfl

theorem Std.HashSet.fold_induction [BEq α] [LawfulBEq α] [Hashable α]
  {f : β → α → β} {m : HashSet α} {motive : β → Set α → Prop} :
    motive b ∅ →
    (∀ b x s, x ∉ s → motive b s → motive (f b x) (s ∪ {x})) →
    motive (m.fold f b) m.toSet := by
  sorry
