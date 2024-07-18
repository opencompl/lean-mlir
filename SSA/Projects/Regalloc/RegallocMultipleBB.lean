import Init.Data.BitVec.Basic
import Init.Data.BitVec.Lemmas
import Init.Data.BitVec.Bitblast

-- 1) RegionTree in Polly, from our work in Polly:
-- 2) https://github.com/llvm/llvm-project/blob/7b08c2774ca7350b372f70f63135eacc04d739c5/llvm/include/llvm/Analysis/RegionInfo.h#L9-L22
--      Which is, in turn, based on the program structure Tree: https://en.wikipedia.org/wiki/Program_structure_tree
-- 3) LLVM's functional API for BB utils,
--     which we shall provide as a surface level API https://llvm.org/doxygen/BasicBlockUtils_8h.html
-- import SSA.Core.Framework
import Lean.Data.HashMap
import Mathlib.Init.Function
import Mathlib.CategoryTheory.Category.Basic

import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.EffectKind
import Mathlib.Control.Monad.Basic
import SSA.Core.Framework.Dialect
import Mathlib.Data.List.AList
import Mathlib.Data.Finset.Piecewise

open Ctxt (Var VarSet Valuation)
open TyDenote (toType)

namespace Pure

/-- A simple term, consisting of variables, operations, pairs, units, and booleans -/
inductive Term (Γ : Ctxt Ty) : Ty → Type where
  | var : {α : Ty} → (v : Γ.Var α) → Term Γ α
  -- | op : φ → Term φ → Term φ
  -- | let1 : Term φ → Term φ → Term φ
  -- | pair : Term φ → Term φ → Term φ
  -- | unit : Term φ
  -- | let2 : Term φ → Term φ → Term φ
  -- | inl : Term φ → Term φ
  -- | inr : Term φ → Term φ
  -- | case: Term φ → Term φ → Term φ → Term φ
  -- | abort : Term φ → Term φ

-- inductive Wf : Ctx α ε → Region φ → LCtx α → Prop
--   | br : L.Trg n A → a.Wf Γ ⟨A, ⊥⟩ → Wf Γ (br n a) L
--   | case : a.Wf Γ ⟨Ty.coprod A B, e⟩
--     → s.Wf (⟨A, ⊥⟩::Γ) L
--     → t.Wf (⟨B, ⊥⟩::Γ) L
--     → Wf Γ (case a s t) L
--   | let1 : a.Wf Γ ⟨A, e⟩ → t.Wf (⟨A, ⊥⟩::Γ) L → (let1 a t).Wf Γ L
--   | let2 : a.Wf Γ ⟨(Ty.prod A B), e⟩ → t.Wf (⟨B, ⊥⟩::⟨A, ⊥⟩::Γ) L → (let2 a t).Wf Γ L
--   | cfg (n) {G} (R : LCtx α) :
--     (hR : R.length = n) → β.Wf Γ (R ++ L) →
--     (∀i : Fin n, (G i).Wf (⟨R.get (i.cast hR.symm), ⊥⟩::Γ) (R ++ L)) →
--     Wf Γ (cfg β n G) L

def Term.evaluate [TyDenote Ty] {Γ : Ctxt Ty} {ty : Ty} (t : Term Γ ty) (VΓ : Ctxt.Valuation Γ) : toType ty :=
  match t with
  | var v => VΓ v

-- def InS.br {Γ : Ctx α ε} {L : LCtx α} (ℓ) (a : Term.InS φ Γ ⟨A, ⊥⟩)
--   (hℓ : L.Trg ℓ A) : InS φ Γ L
--   := ⟨Region.br ℓ a, Wf.br hℓ a.2⟩


-- | TODO: add a thingie that coerces case into `Bool`.
-- def InS.case {Γ : Ctx α ε} {L : LCtx α} {A B e}
--  (a : Term.InS φ Γ ⟨Ty.coprod A B, e⟩) (s : InS φ (⟨A, ⊥⟩::Γ) L) (t : InS φ (⟨B, ⊥⟩::Γ) L) : InS φ Γ L

class TyHasCoprod (Ty : Type) where
  coprod : Ty → Ty → Ty

instance : Append (Ctxt Ty) where
  append Γ Δ := Γ.append Δ


inductive Region [C : TyHasCoprod Ty] : (Γ : Ctxt Ty) → (L : Ctxt Ty) → Type
| br (a : Term Γ α) (hl : L.Var α) : Region Γ L
| case (a : Term Γ (C.coprod α β)) (s : Region (Γ.snoc α) L) (t : Region (Γ.snoc β) L) : Region Γ L
| let₁ (a : Term Γ α) (t : Region (Γ.snoc α) L) : Region Γ L
-- | cfg {R L D : Ctxt Ty}
--     (hD : D = R ++ L)
--     (t : Region Γ D) -- t for terminator, G for fixpoint graph.
--     (G : R.Var α → Region (Γ.snoc α) D)
--    : Region Γ L
| cfg {R L D : Ctxt Ty}
    -- (hD : D = R ++ L)
    (inL : Ctxt.Hom D (R ++ L))
    (t : Region Γ D) -- t for terminator, G for fixpoint graph.
    (G : R.Var α → Region (Γ.snoc α) D)
   : Region Γ L

inductive Region.Evaluated [C : TyHasCoprod Ty] [TyDenote Ty] :
    (Γ : Ctxt Ty) → (VΓ : Ctxt.Valuation Γ) → (L : Ctxt Ty) → (R : Region Γ L) → (VL' : Ctxt.CoValuation L) → Prop
| br :  Evaluated Γ VL L (Region.br a hl) (Ctxt.CoValuation.ofVar hl (a.evaluate VΓ))


/- # Classes -/

abbrev RegionSignature Ty := List (Ctxt Ty × Ty)


abbrev BBIn (Ty : Type) := Ctxt Ty
abbrev BBOut (Ty : Type) := Ctxt Ty
abbrev Parents (Ty : Type) := Ctxt Ty

/-- control flow out of Δ into π assigns values to π by relabelling variables in π to variables in Δ. -/
def BBIn.fromBBOut {Ty : Type} (π : BBIn Ty) (Δ : BBOut Ty) :  Type :=
  Ctxt.Hom π Δ


/-- control flow out of Δ into π assigns values to π by relabelling variables in π to variables in Δ. -/
def Parents.fromBBOut {Ty : Type} (π : Parents Ty) (Δ : BBOut Ty) :  Type :=
  Ctxt.Hom π Δ

instance [TyDenote Ty] : TyDenote (Ctxt Ty) where
  toType Γ := Γ.Valuation

structure BBTy (Ty : Type) where
  Γ : BBIn Ty -- in context.
  Δ : BBOut Ty -- out context.
  π : Parents Ty -- context of parent values.


structure Signature (Ty : Type) where
  mkEffectful ::
  sig        : List Ty
  bbSig :    List (BBIn Ty)
  -- regSig     : RegionSignature Ty
  outTy      : Ty
  effectKind : EffectKind := .pure

abbrev Signature.mk (sig : List Ty) (bbSig : List (BBIn Ty)) (outTy : Ty) : Signature Ty :=
 { sig := sig, bbSig := bbSig,  outTy := outTy }

class DialectSignature (d : Dialect) where
  signature : d.Op → Signature d.Ty
export DialectSignature (signature)

section
variable {d} [s : DialectSignature d]

def DialectSignature.sig        := Signature.sig ∘ s.signature
def DialectSignature.bbSig        := Signature.bbSig ∘ s.signature
-- def DialectSignature.regSig     := Signature.regSig ∘ s.signature
def DialectSignature.outTy      := Signature.outTy ∘ s.signature
-- def DialectSignature.effectKind := Signature.effectKind ∘ s.signature

end


class DialectDenote (d : Dialect) [TyDenote d.Ty] [DialectSignature d] where
  denoteOp : (op : d.Op) → HVector toType (DialectSignature.sig op) →
    -- (HVector (fun t : Ctxt d.Ty × d.Ty => t.1.Valuation → EffectKind.impure.toMonad d.m (toType t.2))
    --         (DialectSignature.regSig op)) →
    -- ((DialectSignature.effectKind op).toMonad d.m
     (toType <| DialectSignature.outTy op)

/-
Some considerations about purity:

We want pure operations to be able to be run in an impure context (but not vice versa, of course).

However, the current definition of `DialectDenote` forces an expressions regions to be of the same purity
as the operation.
In particular, a pure operation which has regions requires those regions to be available as pure
functions `args → result` to be able call `DialectDenote.denote`, whereas an instance of this operation
with impure regions would have them be `args → d.m result`.

Thus, a change to `DialectDenote.denote` is necessary (eventually), but the main question there is:
how can we incorporate effect polymorphism without exposing the possibility that a user might
define semantics for an operation that behave differently when running purely vs when running
impurely.

One option is to generalize `DialectDenote` to take an effect, like so
```lean
class DialectDenote (d) [Goedel Ty] [DialectSignature d] where
  denote (op : Op) {eff : EffectKind} (heff : DialectSignature.effectKind op ≤ eff)  :
    HVector toType (DialectSignature.sig op) →
    (HVector (fun t : Ctxt d.Ty × Ty => t.1.Valuation → eff.toMonad d.m (toType t.2))
            (DialectSignature.regSig op)) →
    (eff.toMonad d.m (toType <| DialectSignature.outTy op))
```

But, then we'd have to enforce that the semantics don't change when a pure operation is being run
impurely.
```lean
class LawfulOpDenote (Op Ty : Type) (m : Type → Type)
    [Goedel Ty] [DialectSignature d] [DialectDenote d] [Monad d.m] where
  pure_denote (op : Op) (heff : DialectSignature.effectKind op = .pure) (args) (regions) :
      pure (DialectDenote.denote op (eff:=.pure) (by simp [heff]) args regions)
      = DialectDenote.denote op (eff:=.impure) (by simp) args (regions.map fun _ r V => return r V)
```

Another option, which would be more complicated, but correct by construction, is to have the
`denote` function be run within a specific `OpDenoteM` monad, whose monadic actions are
"eval region $x". Assuming the `op` is pure, `OpDenoteM α` could then be evaluated both purely or
impurely.
-/


/-
Recall that dominance can be defined as the fixpoint of the dataflow equations:
  entry.Δ ⊆ Φ -- the live out of the entry block is in every block.
  ∀ p ∈ preds(B), Φ ⊆ p.Δ -- the live-out of a block is the intersection of the live-ins of its predecessors.

Next, recall that if 'A ⊆ B', then there is a function 'f: A -> B' that maps elements of A to elements of B.
-/

-- instance : Subset (Ctxt Ty) where
--   union Γ Δ := List.append Γ Δ

/-- A typeclass for type indexes 'Ty' which are pointed with a boolean point β. -/
class TyDenoteBool (Ty : Type) extends TyDenote Ty where
    tyBool : Ty
    hβ : toType β = Bool

/- # Datastructures -/
section DataStructures

variable (d : Dialect) [DialectSignature d]

inductive BBVar (Γ : Ctxt d.Ty) {t : d.Ty} : Type where
| var : Γ.Var t → BBVar Γ

mutual
/-- An intrinsically typed expression. -/
inductive Expr (π : Parents d.Ty) : (Γ : Ctxt d.Ty) → (ty : d.Ty) → Type :=
  | mk {Γ} {ty} (op : d.Op)
    (ty_eq : ty = DialectSignature.outTy op)
    (args : HVector (Var (π ∪ Γ)) <| DialectSignature.sig op) : Expr π Γ ty

/-- A very intrinsically sequence of lets: a sequence of let bindings. -/
inductive Lets (π : Parents d.Ty) : BBIn d.Ty → BBOut d.Ty → Type where
  | ret (v : Var Γ t) : Lets π Γ Γ
  | var (body : Lets π Γ Δ) (e : Expr π Δ α) : Lets π Γ (Δ.snoc α)
end

inductive Ret {Ty : Type} [TyDenoteBool Ty] (bbΓ : Ctxt (BBTy Ty)) (Δ : BBOut Ty) (α : Ty)
| ret (v : Δ.Var α)
| condbr (b : Δ.Var tyBool) -- make this a custom thing that is coercible to bool.
      (bb₁ : bbΓ.Var σ)
      (relabel₁ : σ.Γ.fromBBOut Δ)
      (bb₂ : bbΓ.Var τ)
      (relabel₂ : τ.Γ.fromBBOut Δ)

end DataStructures

structure SeaOfBBS (d : Dialect) [DialectSignature d] [TyDenoteBool d.Ty] (bbΓ : Ctxt ((BBTy d.Ty))) where
  bbs : HVector (fun bbty => Lets d bbty.π  bbty.Γ bbty.Δ) bbΓ

structure CFG (d : Dialect) [DialectSignature d] [TyDenoteBool d.Ty] (bbΓ : Ctxt (BBTy d.Ty)) (α : d.Ty)
  extends SeaOfBBS d bbΓ where
  terminators : HVector (fun bbTy => Ret bbΓ bbTy.Δ α) bbΓ
end Pure

/-
Note that execution of a CFG executes basic blocks as well as control flow across
basic blocks *backwards*. The execution of a basic block is recursively backwards,
since it says:
- to compute the value for a binding `v`, walk backwards and execute the previous `body`, and then evaluate `v`.
- In exactly the same fashion, to compute the value for a terminator, walk backwards and execute the previous `body`, and then evaluate the terminator.
-/


/-
First, recall that contexts form a category with (Γ Δ : Ctxt Ty) and Ctxt.Hom Γ Δ,
where the morphisms are given by substitutions.
-/

/-
Next, recall that dominance essentially says that "the same" variable must exist
in ones predecessors. However, we are category theorists, and we know that
thinking upto equality is bad;
What we actually need is the *pullback* of the predecessor contexts. For
simplicity, we shall first focus on the use-case where we allow one or two
predecessors.
Note that, in this regime, our definition of dominance becomes broader:
We allow relabellings of variables, and we will say that 'def d' domintes 'use v'
if, as it flows from the def to the use, the variable 'd' is relabelled to 'v'.
to get the usual definition, we build the pullback square:

```
Γ∩Δ→→→∃!→→Δ
↓         ↓
∃!        ↓
↓         ↓
Γ→→→→→→→→Γ∪Δ
```

See that this definition precisely lets us walk backward from the top of our BB
to variables in the predecessor BB.
-/

/-
Even more morally, what we are actually building is a *sheaf*.
We have local information, which is per basic block.
We have a preorder, given by where control flows, (https://en.wikipedia.org/wiki/Category_of_preordered_sets).
We are trying to glue the basic blocks together, according to the preorder relation.
This gives us the full control flow graph.
-/

/-- A pullback of contexts. asserts-/
structure Ctxt.pullback (Γ Δ : Ctxt Ty) where
  base : Ctxt Ty
  projΓ : Ctxt.Hom Γ base
  projΔ : Ctxt.Hom Δ base
  -- hproj : universal property of the pullback.
  -- hprojΓ : ∀ {Γ' : Ctxt Ty} (f : Ctxt.Hom Γ' Γ) (f' : Ctxt.Hom Γ' base), f = f' ∘ projΓ

/-
Now that we have pullbacks, we define a full CFG, where we have basic blocks,
with live-ins equal to the pullback of the predecessor blocks.
We must, as usual, work upto iso to be good category theorists.
-/

inductive TerminatorKind where
| ret /- return instruction -/

inductive TerminatorVal : TerminatorKind → Type
| ret (i : Int) : TerminatorVal .ret

inductive Op
| increment
| const (i : Int)
| ret
| condbr

inductive Ty
| int : Ty
| terminator (k : TerminatorKind) : Ty

abbrev dialect : Dialect where
 Op := Op
 Ty := Ty

def Op.signature : Op → Signature Ty
| .increment => {
    sig := [.int],
    regSig := .nil,
    outTy := .int
  }
| .const _x => {
    sig := []
    regSig := .nil,
    outTy := .int
  }
| .ret => {
    sig := [.int],
    regSig := .nil,
    outTy := .terminator .ret
  }
| .condbr => {
    sig := [.int],
    regSig := .nil,
    outTy := .terminator .ret
  }

 instance : DialectSignature dialect where
   signature := Op.signature

instance : TyDenote Ty where
   toType := fun
    | .int => Int
    | .terminator t => TerminatorVal t

 instance : DialectSignature dialect where
   signature := Op.signature

instance : DialectDenote dialect where
  denote := fun op args _ =>
  match op with
  | .increment =>
    let l : Int := args.getN 0
    l + 1
  | .const i => i
  | .terminator .ret => TerminatorVal.ret <| args.getN 0


structure BBSig where
  Γ : Ctxt Ty
  Δ : Ctxt Ty

abbrev BBWithRet (bbΓ : Ctxt BBSig) (sig : BBSig) : Type :=
  FlatCom dialect sig.Γ .pure sig.Δ (Ty.terminator .ret)


structure CFG where
  bbΓ : Ctxt BBSig
  bbs : HVector (BBWithRet bbΓ) bbΓ -- A collection of basic blocks, each of which have access to the full BB context.

/-- The terminator instruction for a control flow graph. -/
inductive CFGRet (t : Type) (d : Dialect) [DialectSignature d]
    (bbTys : Ctxt ((Ctxt d.Ty) × (Ctxt d.Ty))) where
| ret : t → CFGRet t d bbTys
| condbr (v : bbTys.Var nextBBTys)
    (cond : bbTys.Var .int)
    (args : HVector (fun nextBBTy => nextBBTy.Var ) nextBBTys.1) :
    CFGRet t d bbTys

/--
An intrinsically well typed control flow graph,
where the types of live-ins and live-outs are well typed.
-/
structure CFG {Ty : Type} (d : Dialect) [DialectSignature d]
    (bbTys : Ctxt ((Ctxt d.Ty) × (Ctxt d.Ty))) where
  blocks : HVector (fun bbTy => FlatCom d bbTy.1 .pure bbTy.2 ()) bbTys




@[simp]
theorem effectKind_const :
  DialectSignature.effectKind (d := Pure.dialect)
    (Pure.Op.const i) = EffectKind.pure := rfl

def const (i : Int) : Expr dialect Γ .pure Ty.int :=
  Expr.mk (Op.const i) rfl (by simp) .nil .nil

@[simp]
theorem effectKind_increment :
  DialectSignature.effectKind (d := Pure.dialect)
    (Pure.Op.increment) = EffectKind.pure := rfl

def increment (v : Γ.Var .int) : Expr dialect Γ .pure Ty.int :=
  Expr.mk Op.increment rfl (by simp) (.cons v .nil) .nil


 @[simp]
 theorem Expr.denote_const {Γ : Ctxt Ty} {V : Ctxt.Valuation Γ} {i : Int}
    {ty_eq : Ty.int = DialectSignature.outTy (d := dialect) (Op.const i)}
    {eff_le : DialectSignature.effectKind (d := dialect) (Op.const i) ≤ EffectKind.pure}
    {args : HVector Γ.Var [] }
    {regArgs : HVector (fun t => Com dialect t.1 EffectKind.impure t.2) (DialectSignature.regSig (Op.const i)) } :
    (Expr.mk (d := dialect) (Γ := Γ) (eff := .pure) (Op.const i) (ty := .int) ty_eq eff_le args regArgs).denote V = i := by
  simp [Expr.denote, DialectDenote.denote]


 @[simp]
 theorem Expr.denote_increment {Γ : Ctxt Ty} {V : Ctxt.Valuation Γ}
    {ty_eq : Ty.int = DialectSignature.outTy (d := dialect) (Op.increment)}
    {eff_le : DialectSignature.effectKind (d := dialect) (Op.increment) ≤ EffectKind.pure}
    {args : HVector Γ.Var [.int] }
    {regArgs : HVector (fun t => Com dialect t.1 EffectKind.impure t.2) (DialectSignature.regSig (Op.increment)) } :
    (Expr.mk (d := dialect) (Γ := Γ) (eff := .pure) (Op.increment) (ty := .int) ty_eq eff_le args regArgs).denote V =
    (show Int from (V (args.getN 0))) + 1 := by
  rcases args
  simp [Expr.denote, DialectDenote.denote, HVector.map, HVector.getN, HVector.get]

 end Pure


 namespace RegAlloc

 def Reg := Nat
 deriving DecidableEq, Inhabited, BEq

def Reg.ofNat (n : Nat) : Reg := n

instance : Repr Reg where
  reprPrec n _ :=
    "%r<" ++ repr (show Nat from n) ++ ">"

def Reg.ofNat_eq (n : Nat) : Reg.ofNat n = n := rfl

abbrev RegisterFile : Type := Reg → Int
@[simp]
def RegisterFile.get (R : RegisterFile) (r : Reg) : Int := R r

def RegisterFile.set (R : RegisterFile) (r : Reg) (v : Int) : RegisterFile :=
  fun r' => if r = r' then v else R r'

@[simp]
theorem RegisterFile.get_set_of_eq {R : RegisterFile} {r s : Reg} {v : Int} (hs : r = s := by trivial) :
  (R.set r v) s = v := by
  simp [RegisterFile.set, hs]

@[simp]
theorem RegisterFile.get_set_of_neq {R : RegisterFile} {r s : Reg} {v : Int} (hs : r ≠ s := by trivial) :
  (R.set r v) s = R s := by
  simp [RegisterFile.set, hs]

@[simp]
theorem RegisterFile.set_set (R : RegisterFile) (r : Reg) (v w : Int) :
  (R.set r v).set r w = R.set r w := by
  ext v
  unfold RegisterFile.set
  split <;> simp

@[simp]
theorem RegisterFile.set_set_eq_set_fst_of_eq (R : RegisterFile) (r s : Reg) (v w : Int) (heq : r = s) :
    (R.set r v).set s w = R.set r w := by
  ext v
  unfold RegisterFile.set
  subst heq
  split <;> simp

@[simp]
theorem RegisterFile.set_set_eq_set_snd_of_eq (R : RegisterFile) (r s : Reg) (v w : Int) (heq : r = s) :
    (R.set r v).set s w = R.set r w := by
  subst heq
  simp

@[simp]
theorem RegisterFile.get_set_of_eq' (R : RegisterFile) (r : Reg) (v : Int) :
  (R.set r v) r = v := by
  simp [RegisterFile.set]


inductive Op
| increment (l out : Reg)
| const (i : Int) (out : Reg)
deriving Repr

inductive Ty
| unit : Ty
deriving Repr

abbrev dialect : Dialect where
  Op := Op
  Ty := Ty
  m := StateM RegisterFile

def Op.signature : Op → Signature Ty
| .increment _ _ => {
    sig := [],
    regSig := .nil,
    outTy := .unit,
    effectKind := .impure
  }
| .const _x _  => {
    sig := []
    regSig := .nil,
    outTy := .unit,
    effectKind := .impure
  }

 instance : DialectSignature dialect where
   signature := Op.signature

instance : TyDenote Ty where
   toType := fun
    | .unit => Unit

 instance : DialectSignature dialect where
   signature := Op.signature

def readRegister (r : Reg) : StateM RegisterFile Int := fun R => (R r, R)
def writeRegister (r : Reg) (v : Int) : StateM RegisterFile Unit := fun R => ((), R.set r v)

instance : DialectDenote dialect where
  denote := fun op _ _ =>
  match op with
  | .increment r rout => show StateM _ _ from
     readRegister r >>= fun vr =>
     writeRegister rout (vr + 1)
  | .const i rout => show StateM _ _ from
     writeRegister rout i

instance : Subsingleton (HVector f []) where
  allEq := fun x y => by
    cases x
    cases y
    rfl

@[simp]
theorem HVector.nil_eq {f : Ty → Type} (v : HVector f []) : v = HVector.nil := by
  cases v
  rfl

def Program (Γ Δ : Ctxt Ty) : Type := Lets dialect Γ .impure Δ

def Program.toLets {Γ Δ : Ctxt Ty} (p : Program Γ Δ) : Lets dialect Γ .impure Δ := p

instance : Repr (Program Γ Δ) where
  reprPrec p n := reprPrec p.toLets n

abbrev ProgramWithRet (Γ Δ : Ctxt Ty) : Type := FlatCom dialect Γ .impure Δ Ty.unit

@[simp]
theorem regSig_const : DialectSignature.regSig (d := dialect) (Op.const i out) = [] :=  rfl

 @[simp]
 theorem Expr.const_eq {Γ : Ctxt Ty} {i : Int}
    {ty_eq : Ty.unit = DialectSignature.outTy (d := dialect) (Op.const i out)}
    {eff_le : DialectSignature.effectKind (d := dialect) (Op.const i out) ≤ EffectKind.impure}
    {args : HVector Γ.Var [] }
    {regArgs : HVector (fun t => Com dialect t.1 EffectKind.impure t.2) (DialectSignature.regSig (Op.const i out)) } :
    (Expr.mk (d := dialect) (Γ := Γ) (Op.const i out) (ty := .unit) ty_eq eff_le args regArgs) =
    (Expr.mk (d := dialect) (Γ := Γ) (eff := EffectKind.impure) (Op.const i out) (ty := .unit) (by rfl) (by simp) .nil .nil) := by
  simp_all
  apply Subsingleton.elim

end RegAlloc

/--
Convert a pure context to an impure context, where all SSA variables are now side effecting, and thus
have type ().
-/
def doCtxt (ctx : Ctxt ty) : Ctxt RegAlloc.Ty := ctx.map (fun _ => RegAlloc.Ty.unit)

#check Ctxt.Var
def doVar {Γ : Ctxt Pure.Ty} (v : Γ.Var Pure.Ty.int) : (doCtxt Γ).Var RegAlloc.Ty.unit :=
  let ⟨ix, isLt⟩ := v
  ⟨ix, by
    simp [doCtxt, Ctxt.map]
    exists Pure.Ty.int
    apply List.getElem?_eq_some.mpr
    obtain ⟨ix₂, ix₂Lt⟩ := List.get?_eq_some.mp isLt
    exists ix₂
  ⟩


/--
Build a register allocation valuation for a given context Γ. Really, this just marks every variable as returning (),
since the semantics is purely side-effecting and nothing flows via the def-use chain.
-/
def doValuation (Γ : Ctxt RegAlloc.Ty) : Γ.Valuation :=
  fun t _v => match t with | .unit => ()


instance (t : RegAlloc.Ty): Subsingleton (TyDenote.toType t) where
  allEq := fun x y => by
    cases x
    cases y
    rfl

instance (Γ : Ctxt RegAlloc.Ty) : Subsingleton (Ctxt.Valuation Γ) where
  allEq := fun V V' => by
    simp_all [Ctxt.Valuation]
    ext t v
    apply Subsingleton.elim

/-- All valuations for the RegAlloc type are equal, so we canonicalize into `doValuation Γ`-/
@[simp]
theorem RegAlloc.doValuation_eq (Γ : Ctxt RegAlloc.Ty) (V : Γ.Valuation) : V = doValuation Γ := by
  apply Subsingleton.elim

/-- run a `StateM` program and discard the final result, leaving the stat behind. -/
def StateM.exec (cmd : StateM σ α) (s : σ) : σ :=
  (cmd.run s).2

/-- Evaluating at an arbitrary valuation is the same as evaluating at a 'doValuation'-/
@[simp]
def RegAlloc.Expr.denote_eq_denote_doValuation {Γ : Ctxt RegAlloc.Ty} {V: Γ.Valuation}
  (e : Expr RegAlloc.dialect Γ EffectKind.impure .unit) :
  (e.denote V) = e.denote (doValuation Γ) := by simp

def RegAlloc.Expr.exec {Γ : Ctxt RegAlloc.Ty}
  (e : Expr RegAlloc.dialect Γ EffectKind.impure .unit)
  (R : RegAlloc.RegisterFile) : RegAlloc.RegisterFile :=
  (StateM.exec <| e.denote (doValuation Γ)) R

def RegAlloc.Program.exec {Γ Δ : Ctxt RegAlloc.Ty}
    (p : RegAlloc.Program Γ Δ)
    (R : RegAlloc.RegisterFile) : RegAlloc.RegisterFile :=
  (StateM.exec <| p.denote (doValuation Γ)) R

/-- Get the register into which value is written to. -/
def RegAlloc.Op.outRegister (op : RegAlloc.Op) : RegAlloc.Reg :=
  match op with
  | .increment _ out => out
  | .const _ out => out

/-- Get the register into which value is written to. -/
def RegAlloc.Expr.outRegister (e : Expr RegAlloc.dialect Γ EffectKind.impure .unit) : RegAlloc.Reg :=
  match e with
  | Expr.mk op .. => RegAlloc.Op.outRegister op

@[simp]
theorem RegAlloc.Expr.outRegister_const_eq (i : Int) (r : RegAlloc.Reg) :
  RegAlloc.Expr.outRegister (Expr.mk (Γ := Γ) (RegAlloc.Op.const i r) rfl (by simp) .nil .nil) = r := rfl

@[simp]
theorem RegAlloc.Expr.outRegister_increment_eq (r₁ r₂ : RegAlloc.Reg) :
  RegAlloc.Expr.outRegister (Expr.mk (Γ := Γ) (RegAlloc.Op.increment r₁ r₂) rfl (by simp) .nil .nil) = r₂ := rfl

/-- A continuation based proof of what read register does to the state. -/
@[simp]
theorem exec_readRegisterK {k : Int → StateM RegAlloc.RegisterFile α}:
  (StateM.exec ((RegAlloc.readRegister r) >>= k)) R = (StateM.exec (k (R r))) R := by
  simp [RegAlloc.readRegister, StateT.run, StateM.exec, (· >>= ·), StateT.bind]

/-- Executing a read register does nothing to the state. -/
@[simp]
theorem exec_readRegister :
  (StateM.exec ((RegAlloc.readRegister r))) R = R := by
  simp [RegAlloc.readRegister, StateT.run, StateM.exec, (· >>= ·), StateT.bind]

/-- A continuation based version of what writing a register does to the state. -/
@[simp]
theorem exec_writeRegisterK {k : Unit → StateM RegAlloc.RegisterFile α} :
  (StateM.exec (RegAlloc.writeRegister r v >>= k) R) =
  StateM.exec (k ()) (R.set r v) := by
  simp [RegAlloc.writeRegister, StateT.run, StateM.exec, (· >>= ·), StateT.bind]

/-- Executing a write register writes the value to the register file. -/
@[simp]
theorem exec_writeRegister :
  (StateM.exec (RegAlloc.writeRegister r v) R) = R.set r v := by
  simp [RegAlloc.writeRegister, StateT.run, StateM.exec, (· >>= ·), StateT.bind]

@[simp]
theorem RegAlloc.Expr.exec_const_eq {i : Int} {R : RegAlloc.RegisterFile} :
  RegAlloc.Expr.exec (Expr.mk (Γ := Γ) (RegAlloc.Op.const i r) rfl (by simp) .nil .nil) R = R.set r i := by
  simp [RegAlloc.Expr.exec, Expr.denote, DialectDenote.denote,
    (exec_writeRegister)]

@[simp]
theorem RegAlloc.Expr.exec_increment_eq {R : RegAlloc.RegisterFile} :
  RegAlloc.Expr.exec (Expr.mk (Γ := Γ)
    (RegAlloc.Op.increment in₁ out) rfl (by simp) .nil .nil) R =
    R.set out (R in₁ + 1) := by
  simp [RegAlloc.Expr.exec, Expr.denote, DialectDenote.denote,
    (exec_writeRegister)]

-- Evaluating an empty program yields the same register file.
@[simp]
def RegAlloc.Program.exec_nil_eq :
    RegAlloc.Program.exec (Γ := Γ) (Δ := Γ) Lets.nil R = R := by
  simp [RegAlloc.Program.exec, StateM.exec]

-- Evaluating a register yields a new register file whose value has been modified at R.
@[simp]
def RegAlloc.Program.exec_cons_eq (body : Program Γ Δ) (er : Expr RegAlloc.dialect Δ EffectKind.impure .unit) :
    RegAlloc.Program.exec (Lets.var body er) R = RegAlloc.Expr.exec er (RegAlloc.Program.exec body R) := by
  simp [RegAlloc.Program.exec, StateM.exec, RegAlloc.Expr.exec]

-- Evaluating a register yields a new register file whose value has been modified at R.
@[simp]
def RegAlloc.Program.exec_cons_eq' (body : Program Γ Δ) (er : Expr RegAlloc.dialect Δ EffectKind.impure .unit)
    (hRmid : body.exec R = Rmid)
    (hRer : RegAlloc.Expr.exec er Rmid = Rout) :
    RegAlloc.Program.exec (Lets.var body er) R = Rout := by simp_all

/-- A mapping of variables in a context to a register. -/
structure Var2Reg (Γ : Ctxt Pure.Ty) where
  toFun : Γ.Var Pure.Ty.int → Option RegAlloc.Reg
  dead : List RegAlloc.Reg -- list of dead registers
  hdead : ∀ r ∈ dead, ∀ v, r ∉ toFun v -- the dead register set is correct, and all registers that are dead cannot be mapped.
  hdeadNoDup : List.Nodup dead
  -- the mappping of variables to registers is injective, so no two variables map to the same register.
  hinj : ∀ {r s : RegAlloc.Reg} {v w : Γ.Var .int} (hr : r ∈ toFun v) (hs : s ∈ toFun w) (hneq : v ≠ w), r ≠ s


def Var2Reg.nil (dead : List RegAlloc.Reg) (hdead : dead.Nodup := by decide) : Var2Reg ∅ where
  toFun := fun v => none
  dead := dead
  hdead := by
    intros r hr v
    simp
  hinj := by
    intros r s v w hr hs hneq
    simp at hr
  hdeadNoDup := hdead

/-- A register is free if no variable maps to it. -/
def Var2Reg.registerDead (V2R : Var2Reg Γ) (r : RegAlloc.Reg) : Prop :=
  ∀ (v : Γ.Var Pure.Ty.int), r ∉ V2R.toFun v

/-- A register 'r' is live for a variable 'v' if 'v' maps to 'r'. -/
def Var2Reg.registerLiveFor (V2R : Var2Reg Γ) (r : RegAlloc.Reg) (v : Γ.Var .int) : Prop :=
  V2R.toFun v = some r

/--
A register 'r' is either dead, or is maybe live for value 'v'.
This is useful to prove no-alias properties, as either the register is dead and thus cannot
alias with a live register, or points to a different value, and thus cannot alias.
-/
def Var2Reg.registerDeadOrLiveFor (V2R : Var2Reg Γ) (r : RegAlloc.Reg) (v : Γ.Var .int) : Prop :=
  V2R.registerDead r ∨ V2R.registerLiveFor r v

-- @[elab_as_elim, cases_eliminator] -- TODO: why can't I mark this as elab_as_elim?
def Var2Reg.registerDeadOrLiveFor.casesOn_does_not_work {motive : Prop} {V2R : Var2Reg Γ} {r : RegAlloc.Reg} {v : Γ.Var .int}
    (h : Var2Reg.registerDeadOrLiveFor V2R r v)
    (hdead : V2R.registerDead r → motive)
    (hlive : V2R.registerLiveFor r v → motive) : motive := by
  cases h
  case inl h => exact hdead h
  case inr h => exact hlive h

/-- A dead register is dead or live for any variable. This strictly weakens the information in posession. -/
theorem Var2Reg.registerDeadOrLiveFor_of_registerDead {V2R : Var2Reg Γ} {r : RegAlloc.Reg} {v : Γ.Var .int}
    (h : V2R.registerDead r) : V2R.registerDeadOrLiveFor r v := by
  left
  exact h

/-- A live register is dead or live for the same variable. This strictly weakens the information in posession. -/
theorem Var2Reg.registerDeadOrLiveFor_of_registerLiveFor {V2R : Var2Reg Γ} {r : RegAlloc.Reg} {v : Γ.Var .int}
    (h : V2R.registerLiveFor r v) : V2R.registerDeadOrLiveFor r v := by
  right
  exact h


/-- A register that is in the list of dead registers is, in fact, dead. -/
theorem Var2Reg.registerDead_of_mem_dead
    {Γ₁ : Ctxt Pure.Ty}
    {Γ₁2Reg : Var2Reg Γ₁}
    {r : RegAlloc.Reg}
    (h : r ∈ Γ₁2Reg.dead) :
    Γ₁2Reg.registerDead r := by
  simp [Var2Reg.registerDead]
  have hdead := Var2Reg.hdead Γ₁2Reg
  apply hdead
  exact h

/-- A register that is in the list of dead registers is, in fact, dead. -/
theorem Var2Reg.registerDead_of_dead_self
    {Γ₁ : Ctxt Pure.Ty}
    {Γ₁2Reg : Var2Reg Γ₁}
    {r : RegAlloc.Reg}
    {rs : List RegAlloc.Reg}
    (hdead : Γ₁2Reg.dead = r :: rs := by trivial) :
    Γ₁2Reg.registerDead r := by
  simp [Var2Reg.registerDead]
  have hdead' := Var2Reg.hdead Γ₁2Reg
  have hr : r ∈ Γ₁2Reg.dead := by
    simp [hdead]
  intros v
  apply hdead' at hr
  specialize hr v
  simpa using hr

/-- The same register may not be both dead and alive at the same time. -/
def Var2Reg.elim_of_registerDead_of_registerLiveFor {V2R : Var2Reg Γ} {r : RegAlloc.Reg} {v : Γ.Var .int}
    (h₁ : V2R.registerDead r)
    (h₂ : V2R.registerLiveFor r v) : (α : Sort _) := by
  exfalso
  simp [Var2Reg.registerDead, Var2Reg.registerLiveFor] at h₁ h₂
  have hcontra := h₁ v
  contradiction

/--
Prove that a register is live for a value from the fact that the 'f' maps 'v' to 'r'.
This is a low-level theorem.
-/
private theorem Var2Reg.registerLiveFor_of_toFun_eq {f : Var2Reg Γ}
    {r : RegAlloc.Reg}
    {v : Γ.Var .int}
    (heq : f.toFun v = some r) :
    f.registerLiveFor r v := by
  simp [Var2Reg.registerLiveFor, heq]

private theorem Var2Reg.toFun_eq_of_registerLiveFor {f : Var2Reg Γ}
    {r : RegAlloc.Reg}
    {v : Γ.Var .int}
    (heq : f.toFun v = some r) :
    f.registerLiveFor r v := by
  simp [Var2Reg.registerLiveFor, heq]

/-- RegisterLiveFor is injective -/
theorem eq_of_registerLiveFor_of_registerLiveFor {V2R : Var2Reg Γ} {r s : RegAlloc.Reg}
    {v : Γ.Var .int}
    (h₁ : V2R.registerLiveFor r v)
    (h₂ : V2R.registerLiveFor s v) : r = s := by
  simp [Var2Reg.registerLiveFor] at h₁ h₂
  rw [h₁] at h₂
  simpa using h₂


/-- A dead register and a live register may not alias. -/
theorem Var2Reg.neq_of_registerLiveFor_of_registerLiveFor_of_neq {V2R : Var2Reg Γ}
    {r s : RegAlloc.Reg} {v w: Γ.Var .int}
    (h₁ : V2R.registerLiveFor r v)
    (h₂ : V2R.registerLiveFor s w)
    (hneq : v ≠ w) : r ≠ s := by
  simp [Var2Reg.registerLiveFor] at h₁ h₂
  apply V2R.hinj h₁ h₂ hneq

/-- A dead register and a live register may not alias. -/
theorem Var2Reg.neq_of_registerLiveFor_of_registerDead {V2R : Var2Reg Γ}
    {r s : RegAlloc.Reg} {v : Γ.Var .int}
    (h₁ : V2R.registerLiveFor r v)
    (h₂ : V2R.registerDead s) : r ≠ s := by
  by_contra hcontra
  subst hcontra
  apply Var2Reg.elim_of_registerDead_of_registerLiveFor h₂ h₁

/--
A dead register and a live register may not alias.
Flipped version of 'Var2Reg.neq_of_registerLiveFor_of_registerDead'.
-/
theorem Var2Reg.neq_of_registerDead_of_registerLiveFor {V2R : Var2Reg Γ}
    {r s : RegAlloc.Reg} {w : Γ.Var .int}
    (h₁ : V2R.registerDead r)
    (h₂ : V2R.registerLiveFor s w) : r ≠ s := by
  symm
  apply Var2Reg.neq_of_registerLiveFor_of_registerDead h₂ h₁

/--
A register 's' that is live for 'w' may never alias with a dead register 'r',
or the same register that maybe live for a different variable 'v'.
-/
theorem Var2Reg.neq_of_registerDeadOrLiveFor_of_registerLiveFor_of_neq {V2R : Var2Reg Γ}
    {r s : RegAlloc.Reg} {w : Γ.Var .int}
    (h₁ : V2R.registerDeadOrLiveFor r v)
    (h₂ : V2R.registerLiveFor s w)
    (hneq : v ≠ w): r ≠ s := by
  cases h₁
  case inl hdead =>
    symm
    apply Var2Reg.neq_of_registerLiveFor_of_registerDead h₂ hdead
  case inr hlive =>
    apply Var2Reg.neq_of_registerLiveFor_of_registerLiveFor_of_neq hlive h₂ hneq

/-- RegisterLiveFor is injective -/
theorem registerLiveFor_inj {f : Var2Reg Γ} {r s : RegAlloc.Reg}
    {v : Γ.Var .int}
    (h₁ : f.registerLiveFor r v)
    (h₂ : f.registerLiveFor s v) : r = s :=
  eq_of_registerLiveFor_of_registerLiveFor h₁ h₂

/-- A register that 'r' that is known to be live cannot be in the dead set. -/
theorem Var2Reg.not_mem_dead_of_registerLiveFor {Γ2R: Var2Reg Γ} {r : RegAlloc.Reg} {v : Γ.Var .int}
    (hlive : Γ2R.registerLiveFor r v) : r ∉ Γ2R.dead := by
  intro hmem
  simp [registerLiveFor] at hlive
  have hdead := Γ2R.hdead r hmem v
  contradiction

/-- A register is live if some variable maps to the register. -/
def Var2Reg.registerLive (f : Var2Reg Γ) (r : RegAlloc.Reg) : Prop :=
  ∃ (v : Γ.Var .int), f.registerLiveFor r v

theorem dead_iff_not_live {f : Var2Reg Γ} {r : RegAlloc.Reg} :
  f.registerDead r ↔ ¬ f.registerLive r := by
  simp [Var2Reg.registerDead, Var2Reg.registerLive, Var2Reg.registerLiveFor]

theorem live_iff_not_dead {f : Var2Reg Γ} {r : RegAlloc.Reg} :
  f.registerLive r ↔ ¬ f.registerDead r := by
  simp [Var2Reg.registerDead, Var2Reg.registerLive, Var2Reg.registerLiveFor]

/-- A register that 'r' that is known to be live cannot be in the dead set. -/
theorem Var2Reg.not_mem_dead_of_registerLive {Γ2R: Var2Reg Γ} {r : RegAlloc.Reg}
    (hlive : Γ2R.registerLive r) : r ∉ Γ2R.dead := by
  intro hmem
  simp [registerLive] at hlive
  obtain ⟨w, hlive⟩ := hlive
  have hdead := Γ2R.hdead r hmem w
  contradiction

  theorem Var2Reg.not_mem_dead_of_toFun_eq_some {Γ2R: Var2Reg Γ} {r : RegAlloc.Reg} {v : Γ.Var .int}
    (heq : Γ2R.toFun v = some r) : r ∉ Γ2R.dead := by
    intro hmem
    have hdead := Γ2R.hdead r hmem v
    contradiction

 /--
 A correspondence between variables 'v ∈ Γ' and registers in the register file.
 This correspondence is witnessed by 'f'.
 -/
 def complete_mapping {Γ : Ctxt Pure.Ty} (V : Γ.Valuation) (V2R : Var2Reg Γ) (R : RegAlloc.RegisterFile) : Prop :=
  ∀ (v : Γ.Var Pure.Ty.int), ∃ r, V2R.registerLiveFor r v ∧ R r = V v

/-- All register files correspond to the start of the program. -/
theorem complete_mapping_nil (R : RegAlloc.RegisterFile) :
    complete_mapping (Γ := ∅) V f R := by
  intros v
  exact v.emptyElim

/--
All live registers correspond to correct values.
This says that the register file is correct at the start of the program.
-/
def sound_mapping {Γ : Ctxt Pure.Ty} (V : Γ.Valuation) (V2R : Var2Reg Γ) (R : RegAlloc.RegisterFile) : Prop :=
  ∀ (r : RegAlloc.Reg) (v : Γ.Var Pure.Ty.int)
    (_hlive : V2R.registerLiveFor r v), R r = V v

theorem eq_of_sound_mapping_of_registerLiveFor {Γ : Ctxt Pure.Ty} {V : Γ.Valuation} {V2R : Var2Reg Γ} {R : RegAlloc.RegisterFile}
  (hsound : sound_mapping V V2R R) {r : RegAlloc.Reg} {v : Γ.Var int}
  (hlive : V2R.registerLiveFor r v) : R r = V v := by
  exact hsound r v hlive

/-- Every complete mapping (which maps every live variable) is also sound (it correctly maps each register soundly.)-/
theorem sound_mapping.of_complete {Γ : Ctxt Pure.Ty} {V : Γ.Valuation} {f : Var2Reg Γ} {R : RegAlloc.RegisterFile}
  (hcomplete : complete_mapping V f R) : sound_mapping V f R := by
    intros r v hlive
    obtain ⟨r', hr', hR⟩ := hcomplete v
    have : r = r' := registerLiveFor_inj hlive hr'
    subst this
    assumption

@[simp]
theorem List.pairwise_succ_neq_range (n : Nat):
    List.Pairwise (fun a b => a ≠ b) (List.range n) := by
  induction n
  case zero => simp
  case succ n ih =>
    simp
    rw [List.pairwise_iff_get]
    intros i ij hij
    simp
    omega

theorem List.nondup_range (n : Nat):
    List.Nodup (List.range n) := by
  simp [List.Nodup, List.pairwise_succ_neq_range]

/-- Allocate a register mapping data structure to extract the result (v ∈ Γ), with `n` free registers. -/
def Var2Reg.singleton (Γ : Ctxt Pure.Ty) (v : Γ.Var .int) (nregs : Nat) : Var2Reg Γ where
  toFun := fun w => if w = v then some <| RegAlloc.Reg.ofNat 0 else none
  dead := List.range nregs |>.map .succ
  hdead := by
    intros r hr w
    simp [List.mem_range, List.mem_map] at hr
    obtain ⟨a, ha₁, ha₂⟩ := hr
    simp
    intros hw
    subst hw
    simp only [RegAlloc.Reg.ofNat_eq]
    by_contra h
    subst h
    simp at ha₂
  hinj := by
    intros r s v w hr hs
    simp only [Option.mem_def, ite_some_none_eq_some] at hr hs
    obtain ⟨rfl, _⟩ := hr
    obtain ⟨rfl, _⟩ := hs
    intros hcontra
    contradiction
  hdeadNoDup := by
    simp [List.Nodup]
    simp [List.pairwise_map]
    have heq : (fun (a b : Nat) => a + 1 ≠ b + 1) = (fun (a b : Nat) => a ≠ b) := by
      funext i i
      simp
    simp [heq]
/-- In 'Var2Reg.singleton Γ v', The register 0 is live 'v' for -/
@[simp]
theorem Var2Reg.registerLiveFor_singleton {Γ : Ctxt Pure.Ty} {v : Γ.Var .int} :
    Var2Reg.registerLiveFor (Var2Reg.singleton Γ v nregs)
      (RegAlloc.Reg.ofNat 0) v := by
  simp [Var2Reg.registerLiveFor, Var2Reg.singleton]

/--
NOTE: Reg2Val does not imply Val2Reg!
For example, consider the  mapping that maps every variable to a dead register.
This satisfies Reg2Val (since trivially, every 'live' register (ie, none of them) maps right), but not Val2Reg.
-/

def Var2Reg.lookupOrInsert {Γ : Ctxt Pure.Ty} (f : Var2Reg Γ) (v : Γ.Var int) :
  Option (RegAlloc.Reg × Var2Reg Γ) :=
  match hfv : f.toFun v with
  | .some r => (r, f)
  | .none =>
    match hfdead : f.dead with
    | [] => none
    | r :: rs =>
      .some ⟨r, {
        toFun := fun v' => if v' = v then .some r else f.toFun v',
        dead := rs,
        hdead := by
          intros s ss w hw
          simp at hw
          have hdead := f.hdead
          have hnodup := f.hdeadNoDup
          split at hw
          case isTrue h =>
            subst h
            simp at hw
            subst hw
            rw [hfdead] at hnodup
            simp at hnodup
            obtain hcontra := hnodup.1
            contradiction
          case isFalse h =>
            specialize hdead s (by simp [hfdead, ss]) w
            -- contradiction from hw, hdead
            contradiction,
        hdeadNoDup := by
          have hfdup := f.hdeadNoDup
          rw [hfdead] at hfdup
          simp at hfdup
          simp [hfdup]
        hinj := by
          intros s t w x hs ht hneq
          simp at hs ht
          -- have hfinj := f.hinj hs
          split at hs
          · case isTrue h =>
            subst h
            simp at hs
            subst hs
            split at ht
            · case isTrue h =>
              subst h
              simp at ht
              subst ht
              contradiction
            · case isFalse h =>
              have ht : t ∉ f.dead := Var2Reg.not_mem_dead_of_toFun_eq_some ht
              rw [hfdead] at ht
              intros hcontra
              subst hcontra
              simp at ht
          · case isFalse h =>
            split at ht
            · case isTrue h =>
              subst h
              simp at ht
              subst ht
              have hs : s ∉ f.dead := Var2Reg.not_mem_dead_of_toFun_eq_some hs
              rw [hfdead] at hs
              simp at hs
              simp [hs]
            · case isFalse h =>
              have hfinj := f.hinj hs ht hneq
              simp [hfinj]
      }⟩

/-- The register inserted by lookupOrInsert is live. -/
theorem Var2Reg.registerLiveFor_of_lookupOrInsert {Γ : Ctxt Pure.Ty}
    {Γ₁2R₁ Γ₁2R₂: Var2Reg Γ}
    {r : RegAlloc.Reg} {v : Γ.Var int}
    (hlookup : Γ₁2R₁.lookupOrInsert v = some (r, Γ₁2R₂)) :
  Γ₁2R₂.registerLiveFor r v := by
  unfold lookupOrInsert at hlookup
  split at hlookup
  · case h_1 r hv =>
    simp [hv] at hlookup
    obtain ⟨req, Γ2Req⟩ := hlookup
    subst req
    subst Γ2Req
    apply registerLiveFor_of_toFun_eq hv
  · case h_2 _hv =>
      split at hlookup
      case h_1 s =>
        simp [hdead] at hlookup
      case h_2 s ss hdead =>
        simp [hdead] at hlookup
        obtain ⟨rfl, rfl⟩ := hlookup
        apply registerLiveFor_of_toFun_eq
        simp
/--
Before a lookup or insert, the register that was allocated is either dead,
or was live for the same variable.
-/
theorem Var2Reg.registerDeadOrLiveFor_of_lookupOrInsert {Γ : Ctxt Pure.Ty}
    {Γ₁2R₁ Γ₁2R₂: Var2Reg Γ}
    {r : RegAlloc.Reg} {v : Γ.Var int}
    (hlookup : Γ₁2R₁.lookupOrInsert v = some (r, Γ₁2R₂)) :
  Γ₁2R₁.registerDeadOrLiveFor r v := by
  unfold lookupOrInsert at hlookup
  split at hlookup
  · case h_1 r hv =>
    simp [hv] at hlookup
    obtain ⟨req, Γ2Req⟩ := hlookup
    subst req
    subst Γ2Req
    apply registerDeadOrLiveFor_of_registerLiveFor hv
  · case h_2 _hv =>
    split at hlookup
    case h_1 s =>
      simp [hdead] at hlookup
    case h_2 s ss hdead =>
      simp [hdead] at hlookup
      obtain ⟨rfl, rfl⟩ := hlookup
      apply registerDeadOrLiveFor_of_registerDead
      apply registerDead_of_mem_dead
      simp [hdead]

/--
The register was either dead, or was pointing to the same value when using 'lookupOrInsert'.
Does this need a new name?
-/
theorem Var2Reg.registerDead_or_registerLiveFor_of_lookupOrInsert {Γ : Ctxt Pure.Ty}
    {Γ₁2R₁ Γ₁2R₂: Var2Reg Γ}
    {r : RegAlloc.Reg} {v : Γ.Var int}
    (hlookup : Γ₁2R₁.lookupOrInsert v = some (r, Γ₁2R₂)) :
  (Γ₁2R₁.registerLiveFor r v) ∨ (Γ₁2R₁.registerDead r) := by
  unfold lookupOrInsert at hlookup
  split at hlookup
  · case h_1 r hv =>
    simp [hv] at hlookup
    obtain ⟨req, Γ2Req⟩ := hlookup
    subst req
    subst Γ2Req
    left
    apply hv
  · case h_2 _hv =>
    split at hlookup
    case h_1 s =>
      simp [hdead] at hlookup
    case h_2 s ss hdead =>
      simp [hdead] at hlookup
      right
      apply registerDead_of_mem_dead
      simp [hdead, hlookup]

/-- The register 'w' that was previously live for 's' continues to be live for 's'. -/
theorem Var2Reg.registerLiveFor_of_lookupOrInsert_of_registerLiveFor {Γ : Ctxt Pure.Ty}
    {Γ₁2R₁ Γ₁2R₂: Var2Reg Γ}
    {r s : RegAlloc.Reg} {v w : Γ.Var int}
    (hlookup : Γ₁2R₁.lookupOrInsert v = some (r, Γ₁2R₂))
    (hlive : Γ₁2R₁.registerLiveFor s w) :
    Γ₁2R₂.registerLiveFor s w := by
  unfold lookupOrInsert at hlookup
  split at hlookup
  · case h_1 r hv =>
    simp [hv] at hlookup
    obtain ⟨req, Γ2Req⟩ := hlookup
    subst req
    subst Γ2Req
    assumption
  · case h_2 _hv =>
    split at hlookup
    case h_1 s =>
      simp [hdead] at hlookup
    case h_2 t ts hdead =>
      simp [hdead] at hlookup
      obtain ⟨rfl, rfl⟩ := hlookup
      apply registerLiveFor_of_toFun_eq
      simp
      split_ifs
      case pos h =>
        subst h
        have hcontra : Γ₁2R₁.toFun w = .some s := by
          apply registerLiveFor_of_toFun_eq hlive
        rw [hcontra] at _hv
        contradiction
      case neg h =>
        apply toFun_eq_of_registerLiveFor hlive

/--
Lookup an argument in a register map, where the variable is defined in the register map.
See that the variable comes from Γ, but the register map is for (Γ.snoc t).
This tells us that this is happening at the phase of the algorithm
where we are allocating registers for the arguments of a `let` binding.
TODO: delete all occurrences of 'Option'.
TODO: note that this is redundant, we should unify this with lookupOrInsert.
-/
def Var2Reg.lookupOrInsertArg {Γ : Ctxt Pure.Ty} (f : Var2Reg <| Γ.snoc t)
    (v : Γ.Var int) : Option (RegAlloc.Reg × Var2Reg (Γ.snoc t)) :=
  match hfv : f.toFun v with
  | .some r => (r, f)
  | .none =>
    match hfdead : f.dead with
    | [] => none
    | r :: rs =>
      .some ⟨r, {
        toFun := fun v' => if v' = v then .some r else f.toFun v',
        dead := rs,
        hdead := by
          intros s ss w
          have hdead := f.hdead
          have hnodup := f.hdeadNoDup
          rw [hfdead] at hdead
          simp at hdead
          obtain ⟨hdead₁, hdead₂⟩ := hdead
          simp
          split
          case isTrue h =>
            subst h
            simp
            by_contra heq
            subst heq
            rw [hfdead] at hnodup
            simp at hnodup
            obtain hnodup := hnodup.1
            contradiction
          case isFalse h =>
            apply hdead₂
            assumption,
        hdeadNoDup := by
          have hfdup := f.hdeadNoDup
          rw [hfdead] at hfdup
          simp at hfdup
          simp [hfdup]
        hinj := by -- this is really stupid.
          intros s t w x hs ht hneq
          simp at hs ht
          split at hs
          · case isTrue h =>
            subst h
            simp at hs
            subst hs
            split at ht
            · case isTrue h =>
              subst h
              simp at ht
              subst ht
              contradiction
            · case isFalse h =>
              have ht : t ∉ f.dead := Var2Reg.not_mem_dead_of_toFun_eq_some ht
              rw [hfdead] at ht
              intros hcontra
              subst hcontra
              simp at ht
          · case isFalse h =>
            split at ht
            · case isTrue h =>
              subst h
              simp at ht
              subst ht
              have hs : s ∉ f.dead := Var2Reg.not_mem_dead_of_toFun_eq_some hs
              rw [hfdead] at hs
              simp at hs
              simp [hs]
            · case isFalse h =>
              have hfinj := f.hinj hs ht hneq
              simp [hfinj]
      }⟩

/-- The register inserted by lookupOrInsertArg is live. -/
theorem Var2Reg.registerLiveFor_of_lookupOrInsertArg {Γ : Ctxt Pure.Ty}
    {Γ₁2R₁ Γ₁2R₂: Var2Reg (Γ.snoc t)}
    {r : RegAlloc.Reg} {v : Γ.Var int}
    (hlookup : Γ₁2R₁.lookupOrInsertArg v = some (r, Γ₁2R₂)) :
  Γ₁2R₂.registerLiveFor r v := by
  unfold lookupOrInsertArg at hlookup
  split at hlookup
  · case h_1 r hv =>
    simp [hv] at hlookup
    obtain ⟨req, Γ2Req⟩ := hlookup
    subst req
    subst Γ2Req
    apply registerLiveFor_of_toFun_eq hv
  · case h_2 hv =>
    split at hlookup
    case h_1 =>
      simp [hdead] at hlookup
    case h_2 s ss hdead =>
      simp [hdead] at hlookup
      obtain ⟨rfl, rfl⟩ := hlookup
      apply registerLiveFor_of_toFun_eq
      simp

/-- Looking up the register that was inserted returns the variable that was inserted. -/
theorem Var2Reg.lookupOrInsertArg_toFun_self_eq {Γ : Ctxt Pure.Ty}
    {Γ₁2R₁ Γ₁2R₂: Var2Reg (Γ.snoc t)}
    {r : RegAlloc.Reg} {v : Γ.Var int}
    (hlookup : Γ₁2R₁.lookupOrInsertArg v = some (r, Γ₁2R₂)) :
    Γ₁2R₂.toFun v = some r := by
  unfold lookupOrInsertArg at hlookup
  split at hlookup
  · case h_1 r hv =>
    simp [hv] at hlookup
    obtain ⟨req, Γ2Req⟩ := hlookup
    subst req
    subst Γ2Req
    apply hv
  · case h_2 hv =>
    split at hlookup
    case h_1 s =>
      simp [hdead] at hlookup
    case h_2 s ss hdead =>
      simp [hdead] at hlookup
      obtain ⟨rfl, rfl⟩ := hlookup
      simp

/-- The register inserted by lookupOrInsertArg is live. -/
theorem Var2Reg.registerLiveFor_of_lookupOrInsertArg_of_registerLiveFor {Γ : Ctxt Pure.Ty}
    {Γ₁2R₁ Γ₁2R₂: Var2Reg (Γ.snoc t)}
    {r s : RegAlloc.Reg} {v w : Γ.Var int}
    (hlookup : Γ₁2R₁.lookupOrInsertArg v = some (r, Γ₁2R₂))
    (hlive : Γ₁2R₁.registerLiveFor s w) :
    Γ₁2R₂.registerLiveFor s w := by
  unfold lookupOrInsertArg at hlookup
  split at hlookup
  · case h_1 r hv =>
    simp [hv] at hlookup
    obtain ⟨req, Γ2Req⟩ := hlookup
    subst req
    subst Γ2Req
    assumption
  · case h_2 hv =>
    split at hlookup
    case h_1 s =>
      simp [hdead] at hlookup
    case h_2 t ts hdead =>
      simp [hdead] at hlookup
      obtain ⟨rfl, rfl⟩ := hlookup
      apply registerLiveFor_of_toFun_eq
      simp
      split_ifs
      case pos h =>
        rw [h] at hlive
        have hcontra : Γ₁2R₁.toFun v = .some s := by
          apply registerLiveFor_of_toFun_eq hlive
        rw [hcontra] at hv
        contradiction
      case neg h =>
        apply toFun_eq_of_registerLiveFor hlive

/-- Var.toSnoc is injective. -/
@[simp]
theorem Ctxt.Var.toSnoc_injective {Γ : Ctxt Ty} {t : Ty} {t' : Ty} {v w : Γ.Var t}
    (h : (↑v : (Γ.snoc t').Var t) = (↑w : (Γ.snoc t').Var t)) : v = w := by
  have h₁ : (↑v : (Γ.snoc t').Var t).1 = (↑w : (Γ.snoc t').Var t).1 := by
    simp [h]
  rcases v with ⟨v, hv⟩
  rcases w with ⟨w, hw⟩
  simp only [get?, val_toSnoc, add_left_inj] at h₁
  subst h₁
  rfl


/-- Two variables are equal iff their toSnoc's are equal. -/
@[simp]
theorem Ctxt.Var.toSnoc_eq_iff_eq {Γ : Ctxt Ty} {t : Ty} {t' : Ty} {v w : Γ.Var t} :
    (↑v : (Γ.snoc t').Var t) = (↑w : (Γ.snoc t').Var t) ↔ v = w := by
  constructor
  · intros h
    simp [Ctxt.Var.toSnoc_injective h]
  · intros h
    subst h
    simp



/-- Delete the last register from the register map. -/
def Var2Reg.deleteLast {Γ : Ctxt Pure.Ty} (f : Var2Reg (Γ.snoc t)) : Var2Reg Γ :=
  let toFun := fun v => f.toFun v.toSnoc
  match hflast : f.toFun (Ctxt.Var.last Γ t) with
  | .none =>
    { toFun := toFun,
      dead := f.dead,
      hdead := by
        have hdead := f.hdead
        intros r hr v
        apply hdead
        assumption,
      hdeadNoDup := f.hdeadNoDup
      hinj := by
        intros r s v w hr hs hneq
        apply f.hinj hr hs
        simp [hneq]
    }
  | .some r =>
    { toFun := toFun,
      dead := r :: f.dead,
      hdead := by
        intros s hs v
        have hfdead := f.hdead
        simp only [toFun]
        simp at hs
        rcases hs with rfl | hs
        case inl =>
          have : ↑ v ≠ Ctxt.Var.last Γ t := by simp
          by_contra h
          have hfinj := f.hinj h hflast this
          contradiction
        case inr =>
          apply hfdead _ hs v,
      hdeadNoDup := by
        have hfnodup := f.hdeadNoDup
        have hfdead := Var2Reg.not_mem_dead_of_toFun_eq_some hflast
        simp [hfdead]
        simp [hfnodup]
      hinj := by
        intros r s v w hr hs hneq
        apply f.hinj hr hs
        simp [hneq]
    }

/-
`toFun` of `deleteLast` just invokes the `toFun` of the underlying map.
-/
@[simp]
theorem Var2Reg.toFun_deleteLast
    {Γ : Ctxt Pure.dialect.Ty}
    {Γ2R : Var2Reg (Γ.snoc t)} :
    Γ2R.deleteLast.toFun = fun v => Γ2R.toFun v.toSnoc := by
  simp [deleteLast]
  split <;> simp_all

@[simp]
theorem Var2Reg.registerLiveFor_deleteLast
    {Γ : Ctxt Pure.dialect.Ty}
    {t : Pure.dialect.Ty}
    {Γ2R : Var2Reg (Γ.snoc t)}
    {r : RegAlloc.Reg}
    {v : Γ.Var .int} :
    Γ2R.deleteLast.registerLiveFor r v ↔ Γ2R.registerLiveFor r v := by
  simp [registerLiveFor]

theorem Var2Reg.registerLiveFor_of_registerLiveFor_deleteLast
    {Γ₂ : Ctxt Pure.dialect.Ty}
    {v : Γ₂.Var Pure.Ty.int}
    {t : Pure.dialect.Ty}
    {Γ₁2Reg : Var2Reg (Γ₂.snoc t)}
    {Γ₂2reg : Var2Reg Γ₂}
    (hΓ₂2reg : Γ₁2Reg.deleteLast = Γ₂2reg)
    (hlive : Γ₁2Reg.registerLiveFor r v) :
    Γ₂2reg.registerLiveFor r v := by
  subst hΓ₂2reg
  simp_all [Var2Reg.registerLiveFor]


@[simp]
def doRegAllocCtx_cons : doCtxt (Γ.snoc s) = (doCtxt Γ).snoc RegAlloc.Ty.unit := rfl

def doExpr (f : Var2Reg (Γ.snoc s))
  (e : Expr Pure.dialect Γ EffectKind.pure .int) :
  Option (Expr RegAlloc.dialect (doCtxt Γ) EffectKind.impure .unit × Var2Reg Γ) :=
  match e with
  | Expr.mk (.const i) .. => do
      let (rout, f) ← f.lookupOrInsert (Ctxt.Var.last Γ s)
      some (Expr.mk (RegAlloc.Op.const i rout) rfl (by simp) .nil .nil, f.deleteLast)
  | Expr.mk .increment rfl _heff args .. => do
      let arg := args.getN 0
      let (rout, f) ← f.lookupOrInsert (Ctxt.Var.last Γ s)
      let (r₁, f) ← f.lookupOrInsertArg arg
      some (Expr.mk (RegAlloc.Op.increment r₁ rout)
        rfl (by simp) .nil .nil, f.deleteLast)

/--
TODO: we will get stuck in showing that 'nregs > 0' when we decrement it when a variable is defined (ie, dies in reverse order).
This might have us actually need to compute liveness anyway to prove correctness.
-/
def doLets (p : Pure.Program Γ₁ Γ₃) (Γ₃2Reg : Var2Reg Γ₃) :
  Option (RegAlloc.Program (doCtxt Γ₁) (doCtxt Γ₃) × Var2Reg Γ₁) :=
  match  p with
  | .nil => some (.nil, Γ₃2Reg)
  | .var ps e (Γ_out := Γ₂) (t := t) => by
    -- stop
    exact match doExpr Γ₃2Reg e with
    | none => none
    | some (er, Γ₂2Reg) =>
      match doLets ps Γ₂2Reg with
      | none => none
      | some (bodyr, Γ₁2Reg) => some (.var bodyr er, Γ₁2Reg)
termination_by structural p

/-- Equation theorem for doLets when argument is nil. -/
@[simp]
theorem Var2Reg.doLets_nil {Γ2Reg : Var2Reg Γ} : doLets .nil Γ2Reg = some (.nil, Γ2Reg) := rfl


/-- Inversion equation theorem for doLets when argument is cons. -/
@[simp]
theorem Var2Reg.eq_of_doRegAllocLets_var_eq_some {ps : Pure.Program Γ₁ Γ₂}
    {Γ₃2Reg : Var2Reg (Γ₂.snoc .int)}
    {Γ₁2Reg : Var2Reg Γ₁}
    {rsout : RegAlloc.Program (doCtxt Γ₁) (doCtxt (Γ₂.snoc .int))}
    (h : doLets (.var ps e) Γ₃2Reg = some (rsout, Γ₁2Reg)) :
    ∃ bodyr er Γ₂2Reg, rsout = .var bodyr er ∧
       (doExpr Γ₃2Reg e = some (er, Γ₂2Reg)) ∧
       doLets ps Γ₂2Reg = some (bodyr, Γ₁2Reg) := by
  simp [doLets] at h
  split at h
  case h_1 => simp at h
  case h_2 a er _ _ =>
    split at h
    case h_1 => simp at h
    case h_2 _ bodyr _ ih =>
      simp_all only [Option.some.injEq, Prod.mk.injEq, exists_and_left]
      simp only [← h.1]
      exists bodyr
      exists er
      have ⟨eq₁, eq₂⟩ := h
      have eq₂ := eq₂.symm
      subst eq₂
      subst eq₁
      simp [ih]

theorem Var2Reg.toFun_lookupOrInsertArg
    {Γ₁ : Ctxt Pure.Ty}
    {Γ₁2Reg : Var2Reg (Γ₁.snoc t)}
    {s : RegAlloc.Reg}
    {Γ₂2Reg : Var2Reg (Γ₁.snoc t)}
    {v : Γ₁.Var .int}
    (h : Γ₁2Reg.lookupOrInsertArg v = some (s, Γ₂2Reg)) :
    Γ₂2Reg.toFun = fun v' => if v' = ↑v then .some s else Γ₁2Reg.toFun v' := by
  simp [Var2Reg.lookupOrInsertArg] at h
  split at h
  · case h_1 r hv =>
    simp [hv] at h
    simp_all [h.1]
    subst h
    funext w
    split <;> simp_all
  · case h_2 r =>
    split at h
    case h_1 s =>
      simp [hdead] at h
    case h_2 s hdead =>
      simp [hdead] at h
      obtain ⟨rfl, rfl⟩ := h
      simp

theorem Var2Reg.toFun_lookupOrInsert
    {Γ₁ : Ctxt Pure.Ty}
    {Γ₁2R : Var2Reg Γ₁}
    {v : Γ₁.Var .int}
    {Γ₂2R: Var2Reg Γ₁}
    (h : Γ₁2R.lookupOrInsert v = some (r, Γ₂2R)) :
    Γ₂2R.toFun = fun w => if w = v then .some r else Γ₁2R.toFun w := by
  simp [Var2Reg.lookupOrInsert] at h
  split at h
  · case h_1 s hv =>
    funext w
    split_ifs <;> simp_all
  · case h_2 s  =>
    split at h
    case h_1 s =>
      simp [hdead] at h
    case h_2 s hdead =>
      simp [hdead] at h
      obtain ⟨rfl, rfl⟩ := h
      funext w
      split_ifs <;> simp_all

/-
Evaluating an expression will return an expression whose values equals
the value that we expect at the output register of the expression.
TODO: extract into four proofs:
  `{pure, impure} x {const, add}`.
-/
theorem doExpr_sound {Γ₁ : Ctxt Pure.dialect.Ty} {V: Γ₁.Valuation} {Γ₁2Reg : Var2Reg Γ₁}
    {Γ₂2Reg : Var2Reg (Γ₁.snoc t)}
    {e : Expr Pure.dialect Γ₁ EffectKind.pure .int}
    {er : Expr RegAlloc.dialect (doCtxt Γ₁) EffectKind.impure .unit}
    (hsound : sound_mapping V Γ₁2Reg R)
    (he : doExpr Γ₂2Reg e = some (er, Γ₁2Reg))
    : e.denote V = (RegAlloc.Expr.exec er R) (RegAlloc.Expr.outRegister er) :=
  match e with
  | Expr.mk op rfl _ args _ =>
    match op with
    | .const i => by
      simp [doExpr] at he
      cases hresult₁ : Γ₂2Reg.lookupOrInsert (Ctxt.Var.last Γ₁ t)
      case none => simp [hresult₁] at he
      case some val =>
        replace ⟨r, Γs2reg⟩ := val
        simp [hresult₁] at he
        simp only  [EffectKind.toMonad_pure, Pure.Expr.denote_const, he.1.symm]
        rw [RegAlloc.Expr.const_eq, RegAlloc.Expr.exec_const_eq,
          RegAlloc.Expr.outRegister_const_eq]
        simp
    | .increment => by
      simp [doExpr] at he
      cases hresult₁ : Γ₂2Reg.lookupOrInsert (Ctxt.Var.last Γ₁ t)
      case none => simp [hresult₁] at he
      case some result₁ =>
        simp [hresult₁] at he
        cases hresult₂ : result₁.2.lookupOrInsertArg (args.getN 0 doExpr.proof_3)
        case none => simp [hresult₂] at he
        case some result₂ =>
          simp [hresult₂] at he
          rw [Pure.Expr.denote_increment]
          obtain ⟨her, hΓ₁2Reg⟩ := he
          rw [← her] at *
          have hΓ₁2Reg := hΓ₁2Reg.symm
          subst hΓ₁2Reg
          -- TODO: why does this not fire?
          simp only [(RegAlloc.Expr.exec_increment_eq)]
          rw [RegAlloc.Expr.outRegister_increment_eq]
          simp
          congr
          symm
          apply eq_of_sound_mapping_of_registerLiveFor
          apply hsound
          simp
          apply Var2Reg.registerLiveFor_of_lookupOrInsertArg (by assumption)

/-## Facts about register allocating a 'const' expression. -/
section DoExprConst

variable
  {Γ₁ : Ctxt Pure.Ty}
  {Γ₂2Reg₁ : Var2Reg (Γ₁.snoc t)}
  {Γ₁2Reg : Var2Reg Γ₁}
  {er : _}
  {heff : _}
  {r : RegAlloc.Reg} {Γ₂2Reg₂ : _}
  -- | I can weaken this to being '.isSome', rather than naming it.
  (hresult₁ : Γ₂2Reg₁.lookupOrInsert (Ctxt.Var.last _ _) = some (r, Γ₂2Reg₂))
  (he : doExpr Γ₂2Reg₁ (Expr.mk (Pure.Op.const i) rfl heff .nil .nil) = some (er, Γ₁2Reg))

/--
A 'const' expression does not create new live registers, and only kills the result register.
This killing is implicit, due to the coercion from `Γ₁` to `Γ₂`.
-/
@[simp]
theorem toFun_const :
    Γ₁2Reg.toFun = fun (v : Γ₁.Var Pure.Ty.int) => Γ₂2Reg₁.toFun ↑v := by
  simp [doExpr, hresult₁] at he
  simp [← he]
  funext v
  obtain ⟨he₁, he₂⟩ := he
  have he₂ := he₂.symm
  subst he₂
  rw [Var2Reg.toFun_lookupOrInsert hresult₁]
  simp

/--
If a register was already live, then we keep it live for the same variable
-/
theorem registerLiveFor_of_doExpr_const_of_registerLiveFor {s : RegAlloc.Reg} {w : Γ₁.Var .int}
    (hlive : Γ₂2Reg₁.registerLiveFor s w) :
    Γ₁2Reg.registerLiveFor s w := by
  simp [doExpr, hresult₁] at he
  simp [← he]
  obtain ⟨he₁, he₂⟩ := he
  have he₂ := he₂.symm
  subst he₂
  apply Var2Reg.registerLiveFor_of_toFun_eq
  rw [Var2Reg.toFun_lookupOrInsert hresult₁]
  simp
  assumption

end DoExprConst

/-## Facts about register allocating a increment expression. -/
section DoExprIncrement

@[simp]
theorem effectKind_increment :
  DialectSignature.effectKind (d := Pure.dialect)
    Pure.Op.increment = EffectKind.pure := rfl

@[simp]
theorem HVector.getN_zero : (HVector.cons a as).getN 0 = a := by
  simp [getN, get]

@[simp]
theorem HVector.getN_succ
    {α : Type*} {f : α → Type*} {a : α} {as : List α}
    {xs : HVector f as} {x : f a} {n : Nat}
    {hn : n < as.length} {hnsucc : n + 1 < as.length + 1}:
    (HVector.cons x xs).getN (n + 1) hnsucc = xs.getN n hn := by
  simp [getN, get]


variable
  {Γ₁ : Ctxt Pure.Ty}
  {Γ₂2Reg₁ Γ₂2Reg₂ Γ₂2Reg₃ : Var2Reg (Γ₁.snoc t)}
  {Γ₁2Reg : Var2Reg Γ₁}
  {er : _}
  {heff : _}
  {arg₁ : Γ₁.Var Pure.Ty.int}
  {r : RegAlloc.Reg} {Γ₂2Reg₂ : _}
  (hresult₁ : Γ₂2Reg₁.lookupOrInsert (Ctxt.Var.last _ _) = some (r, Γ₂2Reg₂))
  (harg₁ : Γ₂2Reg₂.lookupOrInsertArg arg₁ = some (s, Γ₂2Reg₃))
  (he : doExpr Γ₂2Reg₁ (Expr.mk Pure.Op.increment rfl heff (.cons arg₁ .nil) .nil) = some (er, Γ₁2Reg))


/-
A increment expression changes the register file by
simply adding a new binding for arguments.
-/
@[simp]
theorem toFun_increment :
    Γ₁2Reg.toFun =
    fun (v : Γ₁.Var Pure.Ty.int) =>
      if ↑v = ↑arg₁
      then some s
      else Γ₂2Reg₁.toFun ↑v := by
  simp [doExpr, hresult₁, harg₁] at he
  simp [← he]
  funext v
  obtain ⟨he₁, he₂⟩ := he
  have he₂ := he₂.symm
  subst he₂
  rw [Var2Reg.toFun_lookupOrInsertArg harg₁]
  rw [Var2Reg.toFun_lookupOrInsert hresult₁]
  simp

/--
If a register was already live, then we keep it live for the same variable
-/
theorem registerLiveFor_of_doExpr_increment_of_registerLiveFor {s : RegAlloc.Reg} {w : Γ₁.Var .int}
    (hlive : Γ₂2Reg₁.registerLiveFor s w) :
    Γ₁2Reg.registerLiveFor s w := by
  simp [doExpr, hresult₁, harg₁] at he
  simp [← he]
  obtain ⟨he₁, he₂⟩ := he
  have he₂ := he₂.symm
  subst he₂
  apply Var2Reg.registerLiveFor_of_toFun_eq
  have := Var2Reg.registerLiveFor_of_lookupOrInsert_of_registerLiveFor hresult₁ hlive
  have := Var2Reg.registerLiveFor_of_lookupOrInsertArg_of_registerLiveFor harg₁ this
  assumption

end DoExprIncrement

/-
Given a valuation of `V` for a pure program `p` and a register file `R`such that `V ~fΓ~ R`,
then it must be that `(p V) ~ fΔ ~ (regalloc p) R`. That is, the valuation after executing `p`
is in correspondence with the register file after executing the register allocated program.

Note that this is not literally true, since a variable that has
-/
theorem doRegAllocLets_correct
    {pure : Lets Pure.dialect Γ₁ .pure Γ₂}
    {Γ₂2Reg : Var2Reg Γ₂}
    {regalloc : RegAlloc.Program (doCtxt Γ₁) (doCtxt Γ₂)}
    {Γ₁2Reg : Var2Reg Γ₁}
    (hDoLets : doLets pure Γ₂2Reg = some (regalloc, Γ₁2Reg))
    {R : RegAlloc.RegisterFile}
    {V₁ : Γ₁.Valuation}
    /- When we start out, all values we need are in registers. -/
    (hcomplete : complete_mapping V₁ Γ₁2Reg R)  :
    /- At the end, All live out registers have the same value -/
    sound_mapping (pure.denote V₁)
      Γ₂2Reg
      (RegAlloc.Program.exec regalloc R) :=
  match hmatch : pure, h₁ : Γ₂2Reg, regalloc with
  | .nil, _, _ => by
    rename_i h
    subst h
    simp_all only [Var2Reg.doLets_nil, Option.some.injEq, Prod.mk.injEq, heq_eq_eq,
      Lets.denote_nil, EffectKind.toMonad_pure, Id.pure_eq]
    subst hmatch
    subst h₁
    simp only [← hDoLets.1, RegAlloc.Program.exec_nil_eq]
    apply sound_mapping.of_complete hcomplete
  | .var body e (Γ_out := Γ₁₂) (t := t), Γ₂2Reg, regalloc => by
    rename_i h
    subst h
    obtain ⟨regalloc_body, regalloc_e, Γ₁₂2Reg, hregalloc, he, hbody⟩ :=
      Var2Reg.eq_of_doRegAllocLets_var_eq_some (by assumption)
    subst hregalloc
    subst hmatch
    subst h₁
    -- I know that er corresponds to e from
    -- doLets (body.var e) Δ2reg = some (bodyr.var er, Γ2reg)
    -- note that Γ₁₂2Reg is sound for all registers taht came from Δ2reg.
    have ih := doRegAllocLets_correct
      (hDoLets := hbody)
      hcomplete
    -- simp [sound_mapping] at ih ⊢
    intros s w hlive_sw
    -- how do I know that 'r' is the outRegister for er?
    -- Since I have doExpr Δ2reg e = some (er, Ξ2reg),
    -- it must be that (Ctxt.Var.Last Ξ .int) ~ er.outRegister.
    simp_all
    /- evaluating the expression was sound. -/
    have hsound := doExpr_sound (e := e)
      (er := regalloc_e)
      (Γ₂2Reg := Γ₂2Reg)
      (Γ₁2Reg := Γ₁₂2Reg)
      (V := body.denote V₁)
      (R := RegAlloc.Program.exec regalloc_body R)
      (hsound := ih)
      (he := he)
    /- hbody: evaluating body was sound. -/
    cases w using Ctxt.Var.casesOn
    case toSnoc w =>
      simp
      -- since 's' is alive for 'w', and 'doExpr' does not change liveness, we know that
      -- 's' will be alive before. We then use hsound.
      rcases e with ⟨op, ty_eq, heff, args, regArgs⟩
      cases op
      case increment =>
        simp_all
        simp [doExpr] at he
        cases hresult₁ : Γ₂2Reg.lookupOrInsert (Ctxt.Var.last Γ₁₂ .int)
        case none =>  simp [hresult₁] at he
        case some val =>
          obtain ⟨result, Γs2reg'⟩ := val -- result computation
          simp_all [hresult₁]
          cases harg₁ : Γs2reg'.lookupOrInsertArg (args.getN 0 doExpr.proof_3)
          case none => simp [harg₁] at he
          case some val =>
            obtain ⟨arg, Γs2reg''⟩ := val
            simp_all [harg₁]
            simp [← he]
             -- TODO: Somehow, const gets executed automatically by simp, but increment does not.
            rw [RegAlloc.Expr.exec_increment_eq]
            have hneq : result ≠ s := by -- the two don't alias
              -- TODO: create a concept of temporal ordering, and show that the two
              -- don't alias because one is created before the other.
              -- hlive_sw : Γ₂2Reg.registerLiveFor s ↑w
              -- hresult₁ : Γ₂2Reg.lookupOrInsert (Ctxt.Var.last Γ₁₂ Pure.Ty.int) = some (result, Γs2reg')
              have hdead_result : Γ₂2Reg.registerDeadOrLiveFor result (Ctxt.Var.last Γ₁₂ Pure.Ty.int) := by
                apply Var2Reg.registerDeadOrLiveFor_of_lookupOrInsert hresult₁
              apply Var2Reg.neq_of_registerDeadOrLiveFor_of_registerLiveFor_of_neq hdead_result hlive_sw
              simp
            rw [RegAlloc.RegisterFile.get_set_of_neq hneq]
            apply ih
            -- flow the lookup forwards, since it doeds not alias with any
            -- of these operations.
            apply Var2Reg.registerLiveFor_of_registerLiveFor_deleteLast he.2
            apply Var2Reg.registerLiveFor_of_lookupOrInsertArg_of_registerLiveFor harg₁
            apply Var2Reg.registerLiveFor_of_lookupOrInsert_of_registerLiveFor hresult₁
            assumption
      case const =>
        simp_all
        simp [doExpr] at he
        cases hresult₁ : Γ₂2Reg.lookupOrInsert (Ctxt.Var.last Γ₁₂ .int)
        case none =>  simp [hresult₁] at he
        case some val =>
          obtain ⟨result, Γs2reg'⟩ := val
          simp [hresult₁] at he
          simp [← he]
          -- TODO: Somehow, const gets executed automatically by simp, but increment does not.
          -- Debug this.
          have hneq : result ≠ s := by  -- the two don't alias
            have hdead_result : Γ₂2Reg.registerDeadOrLiveFor result (Ctxt.Var.last Γ₁₂ Pure.Ty.int) := by
              apply Var2Reg.registerDeadOrLiveFor_of_lookupOrInsert hresult₁
            apply Var2Reg.neq_of_registerDeadOrLiveFor_of_registerLiveFor_of_neq hdead_result hlive_sw
            simp
          rw [RegAlloc.RegisterFile.get_set_of_neq hneq]
          apply ih
          -- flow the lookup forwards, since it doeds not alias with any
          -- of these operations.
          apply Var2Reg.registerLiveFor_of_registerLiveFor_deleteLast he.2
          apply Var2Reg.registerLiveFor_of_lookupOrInsert_of_registerLiveFor hresult₁
          assumption
    case last =>
      simp
      rw [hsound]
      congr
      rcases e with ⟨op, ty_eq, heff, args, regArgs⟩
      cases op
      case e_a.mk.increment =>
        -- Key intuition: we know that 's' is live for 'Var.last',
        -- and we know that when we allocate, we try to allocate for 'Var.last'.
        -- by the correctness of 'lookupOrInsert', we know that
        -- a) lookupOrInsert will keep 's' live for 'Var.last' since it was live after, and
        -- b) lookupOrInsert will make 'r' alive for 'Var.last'. since we successfully allocated 'Var.last'
        -- By injectivity of a register being alive, we deduce that 's = r'.
        simp_all
        simp [doExpr] at he
        cases hresult₁ : Γ₂2Reg.lookupOrInsert (Ctxt.Var.last Γ₁₂ .int)
        case none =>  simp [hresult₁] at he
        case some val =>
          obtain ⟨r, Γs2reg'⟩ := val
          simp_all [hresult₁]
          cases harg₁ : Γs2reg'.lookupOrInsertArg (args.getN 0 doExpr.proof_3)
          case none => simp [harg₁] at he
          case some val =>
            obtain ⟨arg, Γs2reg⟩ := val
            simp_all [harg₁]
            simp [← he]
            rw [RegAlloc.Expr.outRegister_increment_eq]
            -- hlive_sw  : Γ₂2Reg.registerLiveFor s (Ctxt.Var.last Γ₁₂ .int)
            -- hresult₁ : Γ₂2Reg.lookupOrInsert (Ctxt.Var.last Γ₁₂ Pure.Ty.int) = some (r, Γs2reg✝)
            have live₁ := Var2Reg.registerLiveFor_of_lookupOrInsert_of_registerLiveFor hresult₁ hlive_sw
            have live₂ := Var2Reg.registerLiveFor_of_lookupOrInsert hresult₁
            apply registerLiveFor_inj live₁ live₂
      case e_a.mk.const =>
        simp_all
        simp [doExpr] at he
        cases hresult₁ : Γ₂2Reg.lookupOrInsert (Ctxt.Var.last Γ₁₂ .int)
        case none =>  simp [hresult₁] at he
        case some val =>
          obtain ⟨r, Γs2reg⟩ := val
          simp [hresult₁] at he
          simp [← he]
          have live₁ := Var2Reg.registerLiveFor_of_lookupOrInsert_of_registerLiveFor hresult₁ hlive_sw
          have live₂ := Var2Reg.registerLiveFor_of_lookupOrInsert hresult₁
          apply registerLiveFor_inj live₁ live₂

/-- info: 'doRegAllocLets_correct' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in #print axioms doRegAllocLets_correct

/-
Proof sketch:

given: in registers are *live*: every variable in the in context Γ of
(Γ lets Δ) has a register.
proven:

out registers are *sound*: every variable that *has* a register in the context Δ
is computed correctly.

Vibes based proof
-----------------
- empty program: we don't change the context at all, and soundness is weakeer
  than completeness, so we are done (`sound_mapping.of_complete`)
- `[Γ body Ξ (let v := e) Δ]`. We want to reason "backwards".
  IH tells us that if the live-ins are correct at Γ, then the live-outs are correct at Ξ.
  We then need to show that the live-outs are correct at Δ.
  We know that we kill the register `r` for `v` that we assign.
  We also know that we don't intefere with any other registers.
  Thus, the register mapping that we create at the end of processing this statement
  is such that we have potentially assigned registers for `e`.
  From the IH, we get that `R U {e} - {v}` is correct at Ξ. To show that `R U {e}`
  is correct at Δ, see that everything except `{v}` is correct from IH, and that
  we compute `v` at this location, and so we are correct for `v` as


Formal blueprint
----------------

1) proof for empty program:
 - (Γ nil Γ): we know that every variable is live in the in context Γ.
    In the out context Γ, we change no register mappings, and the values
    of the variables are unchanged. Thus, the every variable that has a register
    (the live-ins) is computed correctly, since the outs are identical to the ins.
2) Proof for extension.
     - `Γ body Ξ (let v := e) Δ`
     - `IH (Γ body Ξ)`: if all live ins are correct at Γ, then all live outs
          are correct at `Ξ`.

-/

section FinalTheorems

/-- Register allocate a program that has no inputs (i.e., is closed.) -/
def regallocClosedProgramWithRet (pure : Pure.ProgramWithRet ∅ Δ) (nregs : Nat := 5):
    Option (RegAlloc.ProgramWithRet (doCtxt (∅ : Ctxt Pure.Ty)) (doCtxt Δ)) :=
  match doLets pure.lets (Var2Reg.singleton Δ pure.ret nregs) with
  | .none => .none
  | .some ⟨regalloc, _Γ2Reg⟩ =>
    .some ({
        lets := regalloc,
        ret := doVar pure.ret
    })

/--
The program created with regallocProgramWithRet in fact
soundly models the pure program.
-/
theorem sound_mapping_of_regallocProgramWithRet
    {pure : Pure.ProgramWithRet ∅ Δ}
    {regalloc : RegAlloc.ProgramWithRet (doCtxt ∅) (doCtxt Δ)}
    (hregalloc : regalloc ∈ regallocClosedProgramWithRet pure nregs)
    (R : RegAlloc.RegisterFile) :
    sound_mapping (pure.denoteLets Ctxt.Valuation.nil)
      (Var2Reg.singleton Δ pure.ret nregs)
      (RegAlloc.Program.exec regalloc.lets R) := by
  simp [regallocClosedProgramWithRet] at hregalloc
  cases hregalloc' : doLets pure.lets (Var2Reg.singleton Δ pure.ret nregs)
  case none => simp [hregalloc'] at hregalloc
  case some out =>
    obtain ⟨regalloc, Γ₁2reg⟩ := out
    simp [hregalloc'] at hregalloc
    rw [hregalloc.symm]
    apply doRegAllocLets_correct
    case hcomplete => apply complete_mapping_nil
    case hDoLets =>
        congr

/-- info: 'sound_mapping_of_regallocProgramWithRet' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in #print axioms sound_mapping_of_regallocProgramWithRet

/--
The program created with regallocProgramWithRet
has the correct return value at register `0`.
-/
theorem ret_eq_of_regallocProgramWithRet
    {pure : Pure.ProgramWithRet ∅ Δ}
    {regalloc : RegAlloc.ProgramWithRet (doCtxt ∅) (doCtxt Δ)}
    (hregalloc : regalloc ∈ regallocClosedProgramWithRet pure nregs)
    (R : RegAlloc.RegisterFile) :
      (pure.denoteLets Ctxt.Valuation.nil) pure.ret =
      /- NOTE: the `0` is currently hardcoded, this should be changed. -/
      (RegAlloc.Program.exec regalloc.lets R).get (RegAlloc.Reg.ofNat 0) := by
  have := sound_mapping_of_regallocProgramWithRet hregalloc R
  symm
  apply eq_of_sound_mapping_of_registerLiveFor this
  simp only [Var2Reg.registerLiveFor_singleton]

/-- info: 'ret_eq_of_regallocProgramWithRet' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in #print axioms ret_eq_of_regallocProgramWithRet

end FinalTheorems

section Example1
def eg1 : Pure.ProgramWithRet ∅ [.int, .int, .int, .int] where
  lets :=
  .var (.var (.var (.var .nil (Pure.const 42)) (Pure.const 42)) (Pure.const 2)) (Pure.increment ⟨0, by simp⟩)
  ret := ⟨1, by simp⟩

def eg1_regalloc : RegAlloc.ProgramWithRet ∅ (doCtxt [Pure.Ty.int, Pure.Ty.int, Pure.Ty.int, Pure.Ty.int]) :=
  (regallocClosedProgramWithRet eg1 5).get (by decide)

/-- info: 'eg1_regalloc' depends on axioms: [propext, Quot.sound] -/
#guard_msgs in #print axioms eg1_regalloc

/--
info: {
  ^entry():
    %0 = RegAlloc.Op.const 42 %r<0> : () → (RegAlloc.Ty.unit)
    %1 = RegAlloc.Op.const 42 %r<0> : () → (RegAlloc.Ty.unit)
    %2 = RegAlloc.Op.const 2 %r<0> : () → (RegAlloc.Ty.unit)
    %3 = RegAlloc.Op.increment %r<0> %r<1> : () → (RegAlloc.Ty.unit)
    return %2 : (RegAlloc.Ty.unit) → ()
}
-/
#guard_msgs in #eval eg1_regalloc

end Example1
