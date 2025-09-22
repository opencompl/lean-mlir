/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Tactic.TypeStar
import Qq

/-- An heterogeneous vector -/
inductive HVector {α : Type*} (f : α → Type*) : List α → Type _
  | nil : HVector f []
  | cons {a : α} : (f a) → HVector f as → HVector f (a :: as)

namespace HVector

variable {α : Type u} {A B : α → Type*} {as : List α}

/-
  # Definitions
-/

--TODO: this should be derived when this becomes possible
protected instance decidableEq [∀ a, DecidableEq (A a)] :
    ∀ {l : List α}, DecidableEq (HVector A l)
  | _, .nil, .nil => isTrue rfl
  | _, .cons x₁ v₁, .cons x₂ v₂ =>
    letI d := HVector.decidableEq v₁ v₂
    decidable_of_iff (x₁ = x₂ ∧ v₁ = v₂) (by simp)

def head : HVector A (a :: as) → A a
  | .cons x _ => x

def tail : HVector A (a :: as) → HVector A as
  | .cons _ xs => xs

def map (f : ∀ (a : α), A a → B a) :
    ∀ {l : List α}, HVector A l → HVector B l
  | [],   .nil        => .nil
  | t::_, .cons a as  => .cons (f t a) (map f as)

/-- An alternative to `map` which also maps a function over the index list -/
def map' {A : α → Type*} {B : β → Type*} (f' : α → β) (f : ∀ (a : α), A a → B (f' a)) :
    ∀ {l : List α}, HVector A l → HVector B (l.map f')
  | [],   .nil        => .nil
  | t::_, .cons a as  => .cons (f t a) (map' f' f as)

def mapM [Monad m] {α : Type 0} {A : α → Type} {B : α → Type}
    (f : ∀ (a : α), A a → m (B a)) :
    ∀ {l : List α}, HVector A l → m (HVector B l)
  | [], .nil => return .nil
  | t :: _ts, .cons a as => do return HVector.cons (← f t a) (← HVector.mapM f as)

/-- Folds a function over an hvector from the left, where the accumulator has a fixed type. -/
def foldl {B : Type*} (f : ∀ (a : α), B → A a → B) :
    ∀ {l : List α}, B → HVector A l → B
  | [],   b, .nil       => b
  | t::_, b, .cons a as => foldl f (f t b a) as

def foldr {β : Type*} (f : ∀ (a : α), A a → β → β) :
    ∀ {l : List α}, (init : β) → HVector A l → β
  | [],   b, .nil       => b
  | t::_, b, .cons a as =>
    let b' := foldr f b as
    f t a b'

/--
Folds a function over an hvector from the left, where the type of the
accumulator depends on the elements processed.

In particular, the type of the accumulator after processing i elements is obtained
by folding `fType` over the first i elements of `as`, and applying `B` to the
result of that fold.
-/
def foldld {β : Type*} (B : β → Type*) (fType : β → α → β)
    (fElem : {b : β} → {a : α} → B b → A a → B (fType b a)) :
    {as : List α} → HVector A as → {b : β} → (init : B b) → B (as.foldl fType b)
  | [], .nil, _, init         => init
  | _::_, .cons a as, _, init => foldld B fType fElem as (fElem init a)

def foldlM {B : Type*} [Monad m] (f : ∀ (a : α), B → A a → m B) :
    ∀ {l : List α}, (init : B) → (as : HVector A l) → m B
  | [],   b, .nil       => return b
  | t::_, b, .cons a as => do foldlM f (← f t b a) as

/--
Simultaneous map on the type and value level of an HVector while
performing monadic effects for value translation.-/
def mapM' [Monad m] {α : Type 0} {A : α → Type} {B : β → Type}
    {l : List α}
    {F : α → β}
    (f : (a : α) → (v : A a) → m (B (F a)) )
    (as : HVector A l) : m (HVector B (F <$> l)) :=
  match l, as with
  | [], .nil => return .nil
  | t :: _ts, .cons a as => do return HVector.cons (← f t a) (← HVector.mapM' f as)

def get {as} : HVector A as → (i : Fin as.length) → A (as.get i)
  | .nil, i => i.elim0
  | .cons x  _, ⟨0,   _⟩  => x
  | .cons _ xs, ⟨i+1, h⟩  => get xs ⟨i, Nat.succ_lt_succ_iff.mp h⟩

/-- To be used as an auto-tactic to prove that the index of getN is within bounds -/
macro "hvector_get_elem_tactic" : tactic =>
  `(tactic|
      (
      simp [List.length]
      )
   )

/-- `x.getN i` indexes into a `HVector` with a `Nat`.

Note that we cannot define a proper instance of `GetElem` for `HVector`,
since `GetElem` requires us to specify a type `elem` such that `xs[i] : elem`,
but `elem` is *not* allowed to depend on the concrete index `i`.
Thus, `GetElem` does not properly support heterogeneous container types like `HVector`
-/
abbrev getN (x : HVector A as) (i : Nat) (hi : i < as.length := by hvector_get_elem_tactic) :
    A (as.get ⟨i, hi⟩) :=
  x.get ⟨i, hi⟩

/-! ## ToTuple -/

def ToTupleType (A : α → Type*) : List α → Type _
  | [] => PUnit
  | [a] => A a
  | a :: as => A a × (ToTupleType A as)

/--
  Turns a `HVector A [a₁, a₂, ..., aₙ]` into a tuple `(A a₁) × (A a₂) × ... × (A aₙ)`
-/
def toTuple {as} : HVector A as → ToTupleType A as
  | .nil => ⟨⟩
  | .cons x .nil => x
  | .cons x₁ <| .cons x₂ xs => (x₁, (cons x₂ xs).toTuple)

abbrev toSingle : HVector A [a₁] → A a₁ := toTuple
abbrev toPair   : HVector A [a₁, a₂] → A a₁ × A a₂ := toTuple
abbrev toTriple : HVector A [a₁, a₂, a₃] → A a₁ × A a₂ × A a₃ := toTuple


/-!
## Conversion to a List
-/

/-- Convert an hvector where every element provably has the same type β into
a `List` of βs-/
def toListOf {A : α → _} {as} (β : Type _)
    (hα : ∀ a ∈ as, A a = β := by intros; rfl) :
    HVector A as → List β
  | .nil => []
  | .cons x xs =>
    let y := cast (hα _ <| by simp) x
    let ys := xs.toListOf β (fun a h => hα a <| by simpa using .inr h)
    y :: ys

/--
Map a function with a constant output type over an hvector to produce a list.
-/
def mapToList (f : ∀ {a : α}, A a → β) {as : List α} (xs : HVector A as) : List β :=
  xs.map @f |>.toListOf β

/-!
## Repr
-/

instance [∀ a, Repr (f a)] : Repr (HVector f as) where
  reprPrec xs prec :=
    let xs := xs.map (fun _ x => s!"{repr x}") |>.toListOf String |> ", ".intercalate
    f!"[{xs}]"

/-
  # Theorems
-/

/-! ## get -/

@[simp] theorem cons_get_zero {A : α → Type*} {a: α} {as : List α} {e : A a} {vec : HVector A as} :
   (HVector.cons e vec).get (@OfNat.ofNat (Fin (as.length + 1)) 0 Fin.instOfNat) = e :=
  rfl

@[simp] theorem cons_get_succ {A : α → Type*} {a: α} {as : List α} {e : A a} {vec : HVector A as} {i : Fin as.length} :
   (HVector.cons e vec).get (i.succ) = vec.get i :=
  rfl

/-! ## map -/

@[simp] theorem map_cons {A B : α → Type u} {as : List α} {f : (a : α) → A a → B a}
    {x : A a} {xs : HVector A as} :
    map f (cons x xs) = cons (f _ x) (map f xs) := by
  induction xs <;> simp_all [map]

theorem map_map {A B C : α → Type*} {l : List α} (t : HVector A l)
    (f : ∀ a, A a → B a) (g : ∀ a, B a → C a) :
    (t.map f).map g = t.map (fun a v => g a (f a v)) := by
  induction t <;> simp_all [map]

@[simp] theorem get_map (xs : HVector A as) (f : (a : α) → A a → B a) :
    (xs.map f).get i = f _ (xs.get i) := by
  induction xs with
  | nil     => exact i.elim0
  | cons x xs ih =>
    cases i using Fin.succRecOn
    · rfl
    · simp_all [map]

/-! ## fold -/

@[simp] theorem foldl_cons :
    foldl f b (cons x xs) = foldl f (f _ b x) xs :=
  rfl

@[simp] theorem foldl_map :
    foldl f b (map g xs) = foldl (fun a x b => f a x (g _ b)) b xs := by
  induction xs generalizing f b with
  | nil => rfl
  | cons _ _ ih => simp [foldl, map, ih]

/-! ## misc -/

theorem eq_of_type_eq_nil {A : α → Type*} {l : List α}
    {t₁ t₂ : HVector A l} (h : l = []) : t₁ = t₂ := by
  cases h; cases t₁; cases t₂; rfl
syntax "[" withoutPosition(term,*) "]ₕ"  : term


@[ext] theorem ext {xs ys : HVector A as}
    (h : ∀ i, xs.get i = ys.get i) : xs = ys := by
  induction xs <;> cases ys
  case nil => rfl
  case cons ih _ _ =>
    specialize ih (fun i => by simpa using h i.succ)
    specialize h (0 : Fin <| _ + 1)
    simp_all

-- Copied from core for List
macro_rules
  | `([ $elems,* ]ₕ) => do
    let rec expandListLit (i : Nat) (skip : Bool) (result : Lean.TSyntax `term) : Lean.MacroM Lean.Syntax := do
      match i, skip with
      | 0,   _     => pure result
      | i+1, true  => expandListLit i false result
      | i+1, false => expandListLit i true  (← ``(HVector.cons $(⟨elems.elemsAndSeps[i]!⟩) $result))
    if elems.elemsAndSeps.size < 64 then
      expandListLit elems.elemsAndSeps.size false (← ``(HVector.nil))
    else
      `(%[ $elems,* | List.nil ])

infixr:50 "::ₕ" => HVector.cons


/-!
  ## OfFn
-/
section OfFn

def ofFn (A : α → Type _) (as : List α) (f : (i : Fin as.length) → A as[i]) :
    HVector A as :=
  match as with
  | _ :: as => f (0 : Fin (_ + 1)) ::ₕ ofFn A as (fun i => f i.succ)
  | [] => .nil

@[simp] theorem ofFn_nil : ofFn A [] f = .nil := rfl

@[simp] theorem get_ofFn : (ofFn A as f).get i = f i := by
  induction as
  case nil => exact i.elim0
  case cons ih =>
    cases i using Fin.succRec
    · rfl
    · simp [ofFn, ih]

end OfFn

/-!
## Append
-/
section Append

def append {as bs} : HVector A as → HVector A bs → HVector A (as ++ bs)
  | .nil, ys => ys
  | x ::ₕ xs, ys => x ::ₕ (append xs ys)

instance : HAppend (HVector A as) (HVector A bs) (HVector A (as ++ bs)) where
  hAppend := append

variable {bs} {xs : HVector A as} {ys : HVector A bs}

@[simp] theorem append_eq : append xs ys = xs ++ ys := rfl

@[simp] theorem nil_append : nil (f:=A) ++ ys = ys := rfl
@[simp] theorem cons_append : (x ::ₕ xs) ++ ys = (x ::ₕ (xs ++ ys)) := rfl

end Append

/-
  # ToExpr and other Meta helpers
-/
section ToExprPi
open Lean Qq

class ToExprPi {α : Type u} (A : α → Type v) [∀ a, ToExpr (A a)] where
  /-- The expression representing `A` -/
  toTypeExpr : Expr

variable {A : α → Type v}

/--
Given an array of elements, such that `elems[i].snd` is of type `f elems[i].fst`,
construct an expression of type `@HVector α f _`, where
* `α : Type u₁`, and
* `f : α → Type u₂`
-/
def mkOfElems (u₁ u₂ : Level) (α f : Expr) (elems : Array (Expr × Expr)) : MetaM Expr := do
  let us := [u₁, u₂]
  let init := (
    mkApp (.const ``List.nil [u₁]) α,
    mkApp2 (.const ``HVector.nil us) α f
  )
  let res := elems.foldr (init := init) fun (a, elem) (as, vec) => (
      mkApp3 (.const ``List.nil [u₁]) α a as,
      mkApp6 (.const ``HVector.cons us) α f as a elem vec
    )
  return res.snd

instance [Lean.ToExpr α] [∀ a, Lean.ToExpr (A a)] [HVector.ToExprPi A]
    [Lean.ToLevel.{u}] [Lean.ToLevel.{v}] :
    Lean.ToExpr (HVector A as) :=
  let α := toTypeExpr α
  let AE := ToExprPi.toTypeExpr A
  let us := [toLevel.{u}, toLevel.{v}]
  let rec toExpr : {as : List _} → HVector A as → Lean.Expr
  | [], .nil =>
    mkApp2 (.const ``HVector.nil us) α AE
  | a::as, .cons x xs =>
    let a := Lean.toExpr a
    let as := Lean.toExpr as
    let x := Lean.toExpr x
    let xs := toExpr xs
    mkApp6 (.const ``HVector.cons us) α AE as a x xs
  { toTypeExpr :=
      let as := Lean.toExpr as
      mkApp2 (.const ``HVector us) AE as
    toExpr }

end ToExprPi

/- ### cast -/

def castFun {A B : α → Type u} {as}
    (h : ∀ (i : Fin as.length), A as[i] = B as[i]) :
    HVector A as → HVector B as
  | .nil => .nil
  | x ::ₕ xs =>
    let x := h (0 : Fin (_ + 1)) ▸ x
    let xs := xs.castFun (fun i => h i.succ)
    x ::ₕ xs

def cast {A : α → Type u} {B : β → Type u} {as : List α} {bs : List β}
    (h_len : as.length = bs.length)
    (h_elem : ∀ i (_ : i < as.length), A as[i] = B bs[i])
    (xs : HVector A as) : HVector B bs :=
  match bs, xs with
  | [], .nil        => .nil
  | _::_, x ::ₕ xs  =>
      have h₀ := h_elem 0 (by simp)
      let xs := xs.cast (by simpa using h_len)
                        (fun i => by simpa using h_elem i.succ)
      (h₀ ▸ x) ::ₕ xs

/-!
## Find
-/

def idxOf? (x : A a) {as} [DecidableEq α] [∀ a, DecidableEq (A a)] :
    HVector A as → Option { i : Fin <| as.length // as.get i = a }
  | .nil => none
  | .cons (a:=b) y ys =>
      if h : ∃ h : a = b, x = h ▸ y then
        some ⟨(0 : Fin <| _ + 1), h.1 ▸ rfl⟩
      else
        (ys.idxOf? x).map fun ⟨i, h⟩ =>
          ⟨i.succ, by simpa⟩

section Lemmas
variable [DecidableEq α] [∀ a, DecidableEq (A a)]
variable (xs : HVector A as) {a : α} (x : A a)

@[simp] theorem idxOf?_cons_same :
    idxOf? x (x ::ₕ xs) = some ⟨(0 : Fin <| _ + 1), rfl⟩ := by
  simp [idxOf?]

end Lemmas

/-!
## Meta helpers & simprocs
-/
section Meta
open Lean Meta Qq

structure HVectorLiteral where
  u : Level
  v : Level
  α : Q(Type $u)
  A : Q($α → Type $v)
  elems : Array ((a : Q($α)) × Q($A $a))

/-- Given a Lean expression of type `HVector _ _`, try to decompose it into an
array of element expressions.
Returns `none` if the passed expression is not a literal. -/
def litExpr? : Expr → Option HVectorLiteral
  | mkApp6 (.const ``HVector.cons _) _α _A _as a x xs => do
      let ret ← litExpr? xs
      some { ret with elems := ret.elems.push ⟨ a, x ⟩ }
  | mkApp2 (.const ``HVector.nil [u, v]) α A => some { u, v, α, A, elems := #[] }
  | _ => none

dsimproc reduceGetN (HVector.getN (_ ::ₕ _) _ _) := fun e => do
  let_expr HVector.getN _α _A _as xs i _hi := e
    | return .continue
  let some lit := litExpr? xs
    | trace[LeanMLIR.Elab] "{crossEmoji} Expected an HVector literal, found: {xs}"
      return .continue
  let some i ← getNatValue? i
    | trace[LeanMLIR.Elab] "{crossEmoji} Expected a Nat literal, found: {i}"
      return .continue

  let some ⟨_a, x⟩ := lit.elems[i]?
    | let errMsg := m!"Index {i} out of bounds for elements:\n\t{lit.elems}\
        \nIn expression:\n\t{e}\
        \n\nNote: this probably indicates a mall-formed expression!"
      try
        Meta.check e
      catch checkErr =>
        throwError "{errMsg}\n\nWhile typechecking {e}:\n{checkErr.toMessageData}"
      throwError errMsg

  return .visit x

end Meta

end HVector
