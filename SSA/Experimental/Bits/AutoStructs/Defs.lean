/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import SSA.Experimental.Bits.AutoStructs.ForMathlib
import SSA.Experimental.Bits.Frontend.Defs
import SSA.Projects.InstCombine.ForStd

open Fin.NatCast

-- A bunch of maps from `Fin n` to `Fin m` that we use to
-- lift and project variables when we interpret formulas
def liftMaxSucc1 (n m : Nat) : Fin (n + 1) → Fin (max n m + 2) :=
  fun k => if _ : k = n then Fin.last (max n m) else k.castLE (by omega)
def liftMaxSucc2 (n m : Nat) : Fin (m + 1) → Fin (max n m + 2) :=
  fun k => if _ : k = m then Fin.last (max n m + 1) else k.castLE (by omega)
def liftLast2 n : Fin 2 → Fin (n + 2)
| 0 => n
| 1 => Fin.last (n + 1)
def liftExcept2 n : Fin n → Fin (n + 2) :=
  fun k => Fin.castLE (by omega) k
def liftMax1 (n m : Nat) : Fin n → Fin (max n m) :=
  fun k => k.castLE (by omega)
def liftMax2 (n m : Nat) : Fin m → Fin (max n m) :=
  fun k => k.castLE (by omega)

def liftLast3 n : Fin 3 → Fin (n + 3)
| 0 => n
| 1 => n + 1
| 2 => Fin.last (n + 2)
def liftMaxSuccSucc1 (n m : Nat) : Fin (n + 1) → Fin (max n m + 3) :=
  fun k => if _ : k = Fin.last n then (max n m).cast else k.castLE (by omega)
def liftMaxSuccSucc2 (n m : Nat) : Fin (m + 1) → Fin (max n m + 3) :=
  fun k => if _ : k = Fin.last m then max n m + 1 else k.castLE (by omega)
def liftExcept3 n : Fin n → Fin (n + 3) :=
  fun k => Fin.castLE (by omega) k

@[simp] lemma liftMaxSuccSucc1_cast {x : Fin n} : liftMaxSuccSucc1 n m x.castSucc = x.castLE (by omega) := by
  rcases x
  simp [liftMaxSuccSucc1, Fin.last]; omega
@[simp] lemma liftMaxSuccSucc2_cast {x : Fin m} : liftMaxSuccSucc2 n m x.castSucc = x.castLE (by omega) := by
  rcases x
  simp [liftMaxSuccSucc2, Fin.last]; omega

/--
Evaluate a term `t` to the BitVec it represents.

This differs from `Term.eval` in that `Term.evalFin` uses `Term.arity` to
determine the number of free variables that occur in the given term,
and only require that many bitstream values to be given in `vars`.
-/
@[simp] def Term.evalFinBV (t : Term) (vars : Fin (arity t) → BitVec w) : BitVec w :=
  match t with
  | .var n => vars (Fin.last n)
  | .zero    => BitVec.zero w
  | .one     => 1
  | .negOne  => -1
  | .ofNat n => BitVec.ofNat _ n
  | .and t₁ t₂ =>
      let x₁ := t₁.evalFinBV (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFinBV (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ &&& x₂
  | .or t₁ t₂ =>
      let x₁ := t₁.evalFinBV (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFinBV (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ ||| x₂
  | .xor t₁ t₂ =>
      let x₁ := t₁.evalFinBV (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFinBV (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ ^^^ x₂
  | .not t     => ~~~(t.evalFinBV vars)
  -- | ls b t    => (t.evalFin vars).concat b
  | .add t₁ t₂ =>
      let x₁ := t₁.evalFinBV (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFinBV (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ + x₂
  | .sub t₁ t₂ =>
      let x₁ := t₁.evalFinBV (fun i => vars (Fin.castLE (by simp [arity]) i))
      let x₂ := t₂.evalFinBV (fun i => vars (Fin.castLE (by simp [arity]) i))
      x₁ - x₂
  | .neg t       => -(t.evalFinBV vars)
  | .shiftL a n => (a.evalFinBV vars) <<< n

lemma evalFin_eq {t : Term} {vars1 : Fin t.arity → BitVec w1} {vars2 : Fin t.arity → BitVec w2} :
    ∀ (heq : w1 = w2),
    (∀ n, vars1 n = heq ▸ vars2 n) →
    t.evalFinBV vars1 = heq ▸ t.evalFinBV vars2 := by
  rintro rfl heqs
  simp only
  congr; ext1; simp_all

@[simp] def Term.evalNat (t : Term) (vars : Nat → BitVec w) : BitVec w :=
  match t with
  | .var n => vars n
  | .zero    => BitVec.zero w
  | .one     => 1
  | .negOne  => -1
  | .ofNat n => BitVec.ofNat _ n
  | .and t₁ t₂ =>
      let x₁ := t₁.evalNat vars
      let x₂ := t₂.evalNat vars
      x₁ &&& x₂
  | .or t₁ t₂ =>
      let x₁ := t₁.evalNat vars
      let x₂ := t₂.evalNat vars
      x₁ ||| x₂
  | .xor t₁ t₂ =>
      let x₁ := t₁.evalNat vars
      let x₂ := t₂.evalNat vars
      x₁ ^^^ x₂
  | .not t     => ~~~(t.evalNat vars)
  -- | ls b t    => (t.evalNat vars).concat b
  | .add t₁ t₂ =>
      let x₁ := t₁.evalNat vars
      let x₂ := t₂.evalNat vars
      x₁ + x₂
  | .sub t₁ t₂ =>
      let x₁ := t₁.evalNat vars
      let x₂ := t₂.evalNat vars
      x₁ - x₂
  | .neg t       => -(t.evalNat vars)
  | .shiftL a n => (a.evalNat vars) <<< n

def Term.language (t : Term) : Set (BitVecs (t.arity + 1)) :=
  { bvs : BitVecs (t.arity + 1) | t.evalFinBV (fun n => bvs.bvs.get n) = bvs.bvs.get t.arity }

inductive RelationOrdering
| lt | le | gt | ge
deriving Repr, Fintype

inductive Relation
| eq
| signed (ord : RelationOrdering)
| unsigned (ord : RelationOrdering)
deriving Repr

def evalRelation (rel : Relation) {w} (bv1 bv2 : BitVec w) : Prop :=
  match rel with
  | .eq => bv1 = bv2
  | .signed .lt => bv1 <ₛ bv2
  | .signed .le => bv1 ≤ₛ bv2
  | .signed .gt => bv1 >ₛ bv2
  | .signed .ge => bv1 ≥ₛ bv2
  | .unsigned .lt => bv1 <ᵤ bv2
  | .unsigned .le => bv1 ≤ᵤ bv2
  | .unsigned .gt => bv1 >ᵤ bv2
  | .unsigned .ge => bv1 ≥ᵤ bv2

@[simp]
lemma evalRelation_coe (rel : Relation) (bv1 bv2 : BitVec w1) (heq : w1 = w2) :
    evalRelation rel (heq ▸ bv1) (heq ▸ bv2) = evalRelation rel bv1 bv2 := by
  rcases heq; simp

@[simp]
def Relation.language (rel : Relation) : Set (BitVecs 2) :=
  { bvs | evalRelation rel (bvs.bvs.get 0) (bvs.bvs.get 1) }

inductive Binop
| and | or | impl | equiv
deriving Repr

def evalBinop (op : Binop) (b1 b2 : Prop) : Prop :=
  match op with
  | .and => b1 ∧ b2
  | .or => b1 ∨ b2
  | .impl => b1 → b2
  | .equiv => b1 ↔ b2

@[simp]
def evalBinop' (op : Binop) (b1 b2 : Prop) : Prop :=
  match op with
  | .and => b1 ∧ b2
  | .or => b1 ∨ b2
  | .impl => b1 → b2
  | .equiv => b1 ↔ b2

def langBinop (op : Binop) (l1 l2 : Set (BitVecs n)) : Set (BitVecs n) :=
  match op with
  | .and => l1 ∩ l2
  | .or => l1 ∪ l2
  | .impl => l1ᶜ ∪ l2
  | .equiv => (l1ᶜ ∪ l2) ∩ (l2ᶜ ∪ l1)

inductive Unop
| neg
deriving Repr

inductive Formula : Type
| width : WidthPredicate → Nat → Formula
| atom : Relation → Term → Term → Formula
| msbSet : Term → Formula
| unop : Unop → Formula → Formula
| binop : Binop → Formula → Formula → Formula
deriving Repr

def formula_of_predicate (p : Predicate) : Formula :=
  match p with
  | .width wp n => .width wp n
  | .binary rel t₁ t₂ =>
    match rel with
    | .eq => .atom .eq t₁ t₂
    | .neq => .unop .neg (.atom .eq t₁ t₂)
    | .ult => .atom (.unsigned .lt) t₁ t₂
    | .ule => .atom (.unsigned .le) t₁ t₂
    | .slt => .atom (.signed .lt) t₁ t₂
    | .sle => .atom (.signed .le) t₁ t₂
  | .lor p q => .binop .or (formula_of_predicate p) (formula_of_predicate q)
  | .land p q => .binop .and (formula_of_predicate p) (formula_of_predicate q)

instance : Inhabited Formula := ⟨Formula.msbSet default⟩

@[simp]
def Formula.arity : Formula → Nat
| width _ _ => 0
| atom _ t1 t2 => max t1.arity t2.arity
| msbSet t => t.arity
| unop _ φ => φ.arity
| binop _ φ1 φ2 => max φ1.arity φ2.arity

@[simp]
def WidthPredicate.sat (wp : WidthPredicate) (w n : Nat) : Bool :=
  match wp with
  | .eq => w = n
  | .neq => w ≠ n
  | .lt => w < n
  | .le => w ≤ n
  | .gt => w > n
  | .ge => w ≥ n

@[simp]
def Formula.sat {w : Nat} (φ : Formula) (ρ : Fin φ.arity → BitVec w) : Prop :=
  match φ with
  | .width wp n => wp.sat w n
  | .atom rel t1 t2 =>
    let bv1 := t1.evalFinBV (fun n => ρ $ Fin.castLE (by simp [arity]) n)
    let bv2 := t2.evalFinBV (fun n => ρ $ Fin.castLE (by simp [arity]) n)
    evalRelation rel bv1 bv2
  | .unop .neg φ => ¬ φ.sat ρ
  | .binop op φ1 φ2 =>
    let b1 := φ1.sat (fun n => ρ $ Fin.castLE (by simp [arity]) n)
    let b2 := φ2.sat (fun n => ρ $ Fin.castLE (by simp [arity]) n)
    evalBinop op b1 b2
  | .msbSet t => (t.evalFinBV ρ).msb

@[simp]
def _root_.Set.lift (f : Fin n → Fin m) (bvs : Set (BitVecs n)) : Set (BitVecs m) :=
  BitVecs.transport f ⁻¹' bvs

@[simp]
def _root_.Set.proj (f : Fin n → Fin m) (bvs : Set (BitVecs m)) : Set (BitVecs n) :=
  BitVecs.transport f '' bvs

@[simp]
def langMsb : Set (BitVecs 1) := { bvs | bvs.bvs.get 0 |>.msb }

@[simp]
def Formula.language (φ : Formula) : Set (BitVecs φ.arity) :=
  match φ with
  | .width wp n => { bvs | wp.sat bvs.w n }
  | .atom rel t1 t2 =>
    let l1 := t1.language.lift (liftMaxSucc1 (FinEnum.card $ Fin t1.arity) (FinEnum.card $ Fin t2.arity))
    let l2 := t2.language.lift (liftMaxSucc2 (FinEnum.card $ Fin t1.arity) (FinEnum.card $ Fin t2.arity))
    let lrel := rel.language.lift $ liftLast2 (max (FinEnum.card (Fin t1.arity)) (FinEnum.card (Fin t2.arity)))
    let l := lrel ∩ l1 ∩ l2
    l.proj (liftExcept2 _)
  | .unop .neg φ => φ.languageᶜ
  | .binop op φ1 φ2 =>
    let l1 := φ1.language.lift $ liftMax1 φ1.arity φ2.arity
    let l2 := φ2.language.lift $ liftMax2 φ1.arity φ2.arity
    langBinop op l1 l2
  | .msbSet t =>
    let lmsb := langMsb.lift $ fun _ => Fin.last t.arity
    let l' := t.language ∩ lmsb
    l'.proj fun n => n.castLE (by simp [Formula.arity, FinEnum.card])

lemma helper1 : (k = 0) → (x ::ᵥ vs).get k = x := by rintro rfl; simp
lemma helper2 : (k = 1) → (x ::ᵥ y ::ᵥ vs).get k = y := by rintro rfl; simp [List.Vector.get]
lemma msb_coe {x : BitVec w1} (heq : w1 = w2) : x.msb = (heq ▸ x).msb := by rcases heq; simp

lemma formula_language_case_atom :
    let φ := Formula.atom rel t1 t2
    φ.language = λ (bvs : BitVecs φ.arity) => φ.sat (fun k => bvs.bvs.get k) := by
  unfold Formula.language
  rintro φ
  let n := φ.arity
  unfold φ
  dsimp (config := { zeta := false })
  lift_lets
  intros l1 l2 lrel l
  ext bvs
  constructor
  · intros h; simp at h
    obtain ⟨bvsb, h, heqb⟩ := h
    unfold l at h
    simp at h
    unfold lrel l1 l2 at h
    obtain ⟨⟨hrel, h1⟩, h2⟩ := h
    have _ : n+1 < bvsb.bvs.length := by simp +zetaDelta [n]
    have _ : n < bvsb.bvs.length := by simp +zetaDelta [n]
    have hrel : evalRelation rel (bvsb.bvs.get n) (bvsb.bvs.get (Fin.last (n + 1))) := by
      simp at hrel
      apply hrel
    have ht1 : bvsb.bvs.get n = t1.evalFinBV fun n => bvsb.bvs.get n := by
      unfold Term.language at h1
      simp [List.Vector.transport, liftMaxSucc1] at h1
      unfold n; simp +zetaDelta; rw [←h1]
      congr; ext1 k
      congr; ext; simp; rw [Nat.mod_eq_of_lt]; omega
    have ht2 : bvsb.bvs.get (Fin.last (n+1)) = t2.evalFinBV fun n => bvsb.bvs.get n := by
      unfold Term.language at h2
      simp [List.Vector.transport, liftMaxSucc2] at h2
      unfold n; simp +zetaDelta only [Formula.arity, Fin.natCast_self]; rw [←h2]
      congr; ext1 k
      congr; ext; simp; rw [Nat.mod_eq_of_lt]; omega
    have hw : bvsb.w = bvs.w := by rw [←heqb]; simp
    have heq1 : (t1.evalFinBV fun n => bvsb.bvs.get n) =
        hw ▸ t1.evalFinBV fun n => bvs.bvs.get $ n.castLE (by simp) := by
      apply evalFin_eq hw; intros k
      rcases bvs with ⟨w, bvs⟩; rcases hw
      injection heqb with _ heqb; rw [←heqb]
      simp [List.Vector.transport, liftExcept2]
      congr; ext; simp; omega
    have heq2 : (t2.evalFinBV fun n => bvsb.bvs.get n) =
        hw ▸ t2.evalFinBV fun n => bvs.bvs.get $ n.castLE (by simp) := by
      apply evalFin_eq hw; intros k
      rcases bvs with ⟨w, bvs⟩; rcases hw
      injection heqb with _ heqb; rw [←heqb]
      simp [List.Vector.transport, liftExcept2]
      congr; ext; simp; omega
    rw [ht1, ht2, heq1, heq2, evalRelation_coe] at hrel
    dsimp only [Set.instMembership, Set.Mem]
    simp_all
  · intros h
    simp
    let bv1 := t1.evalFinBV fun k => bvs.bvs.get $ k.castLE (by simp)
    let bv2 := t2.evalFinBV fun k => bvs.bvs.get $ k.castLE (by simp)
    use ⟨bvs.w, bvs.bvs ++ bv1 ::ᵥ bv2 ::ᵥ List.Vector.nil⟩
    rcases bvs with ⟨w, bvs⟩
    simp
    constructor
    · unfold l; simp; split_ands
      · unfold lrel; simp only [Fin.isValue, BitVecs.transport_getElem,
          liftLast2, Set.mem_setOf_eq, Fin.val_last, le_add_iff_nonneg_right, zero_le,
          List.Vector.append_get_ge]
        rw [List.Vector.append_get_ge (by dsimp; rw [Nat.mod_eq_of_lt]; omega)]
        simp [Set.instMembership, Set.Mem] at h
        convert h using 2
        · apply helper1; ext; simp; rw [Nat.mod_eq_of_lt] <;> omega
        · apply helper2; ext; simp
      · unfold l1 Term.language; simp [List.Vector.transport, liftMaxSucc1]
        rw [List.Vector.append_get_ge (by dsimp; rw [Nat.mod_eq_of_lt]; omega)]
        rw [helper1 (by ext; simp; rw [Nat.mod_eq_of_lt] <;> omega)]
        unfold bv1
        congr;
      · unfold l2 Term.language; simp [List.Vector.transport, liftMaxSucc2]
        rw [helper2 (by ext; simp)]
        unfold bv2
        congr
    · ext1; simp
      next i =>
        simp [List.Vector.transport, liftExcept2]
        rw [List.Vector.append_get_lt i.isLt]
        congr 1

theorem formula_language (φ : Formula) :
    φ.language = { (bvs : BitVecs φ.arity) | φ.sat (fun k => bvs.bvs.get k) } := by
  let n : Nat := φ.arity
  induction φ
  case width wp n =>
    simp
  case atom rel t1 t2 =>
    apply formula_language_case_atom
  case unop op φ ih =>
    rcases op; simp [ih, Set.compl_def]
  case binop op φ1 φ2 ih1 ih2 =>
    unfold Formula.language
    ext1 bvs
    simp [ih1, ih2]
    have heq1 : (φ1.sat fun k => bvs.bvs.get (liftMax1 φ1.arity φ2.arity k)) ↔
           (φ1.sat fun n => bvs.bvs.get (Fin.castLE (by simp) n)) := by
      congr!
    have heq2 : (φ2.sat fun k => bvs.bvs.get (liftMax2 φ1.arity φ2.arity k)) = true ↔
           (φ2.sat fun n => bvs.bvs.get (Fin.castLE (by simp) n)) = true := by
      congr!
    rcases op <;>
      simp [evalBinop, langBinop, Set.compl, Set.instMembership,
        Set.Mem, List.Vector.transport] <;> simp_all <;> tauto
  case msbSet t =>
    ext1 bvs; simp only [Formula.arity, Formula.language, Set.proj, Set.lift, langMsb, Fin.isValue,
      Set.preimage_setOf_eq, Set.mem_image, Set.mem_inter_iff,
      Set.mem_setOf_eq, Formula.sat]
    rcases bvs with ⟨w, bvs⟩
    constructor
    · rintro ⟨bvsb, ⟨ht, hmsb⟩, heq⟩
      simp only [Fin.isValue, Formula.arity] at ht hmsb ⊢
      unfold Term.language at ht
      simp only [BitVecs.transport, List.Vector.transport] at hmsb
      simp at ht; rw [←ht] at hmsb; rw [←hmsb]
      simp [BitVecs.transport] at heq
      obtain ⟨hw, hbvs⟩ := heq
      simp [hw]; congr 1; simp [hw]
      rcases hw; simp
      congr 1; ext1 k
      simp at hbvs; simp [←hbvs, List.Vector.transport]; congr
    · intros heq
      use ⟨w,
        bvs ++ ((t.evalFinBV fun k => bvs.get $ k.castLE (by simp)) ::ᵥ List.Vector.nil)⟩
      unfold Term.language
      simp [BitVecs.transport, List.Vector.transport] at heq ⊢
      constructor; assumption
      ext1 k; simp; congr 1

/--
The formula `φ` is true for evey valuation.
-/
@[simp]
def Formula.Tautology (φ : Formula) := φ.language = ⊤

/--
The formula `φ` is true for evey valuation made up of non-empty bitvectors.
-/
@[simp]
def Formula.Tautology' (φ : Formula) := φ.language ∪ BitVecs0 = ⊤

/--
Same as `Formula.sat` but the environment is indexed by unbounded natural number.
-/
@[simp]
def Formula.sat' {w : Nat} (φ : Formula) (ρ : Nat → BitVec w) : Prop :=
  match φ with
  | .width wp n => wp.sat w n
  | .atom rel t1 t2 =>
    let bv1 := t1.evalNat ρ
    let bv2 := t2.evalNat ρ
    evalRelation rel bv1 bv2
  | .unop .neg φ => ¬ φ.sat' ρ
  | .binop op φ1 φ2 =>
    let b1 := φ1.sat' ρ
    let b2 := φ2.sat' ρ
    evalBinop' op b1 b2
  | .msbSet t => (t.evalNat ρ).msb

lemma evalFin_evalNat (t : Term):
    t.evalFinBV (fun k => ρ k.val) = t.evalNat ρ := by
  induction t <;> simp_all

lemma sat_impl_sat' {φ : Formula} :
    (φ.sat fun k => ρ k.val) ↔ φ.sat' ρ := by
  induction φ
  case width wp n => simp
  case atom rel t1 t2 =>
    simp [←evalFin_evalNat]
  case binop op φ1 φ2 ih1 ih2 =>
    simp [evalBinop, ←ih1, ←ih2]
  case unop op φ ih => rcases op; simp [←ih]
  case msbSet t =>
    simp [←evalFin_evalNat]

lemma env_to_bvs (φ : Formula) (ρ : Fin φ.arity → BitVec w) :
    let bvs : BitVecs φ.arity := ⟨w, List.Vector.ofFn fun k => ρ k⟩
    ρ = fun k => bvs.bvs.get k := by
  simp

@[simp]
abbrev envOfArray {w} (a : Array (BitVec w)) : Nat → BitVec w := fun n => a.getD n 0

@[simp]
abbrev envOfList {w} (a : List (BitVec w)) : Nat → BitVec w := fun n => a.getD n 0
