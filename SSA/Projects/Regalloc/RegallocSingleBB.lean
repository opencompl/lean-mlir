-- Register allocation for a single basic block program.
import SSA.Core.Framework
import Lean.Data.HashMap

namespace Pure

inductive Op
| add
| const (i : Int)

inductive Ty
-- | int (width : Nat) : Ty
| int : Ty


abbrev dialect : Dialect where
 Op := Op
 Ty := Ty

def Op.signature : Op → Signature Ty
| .add => {
    sig := [.int, .int],
    regSig := .nil,
    outTy := .int
  }
| .const _x => {
    sig := []
    regSig := .nil,
    outTy := .int
  }


instance : TyDenote Ty where
   toType := fun
    | .int => Int

 instance : DialectSignature dialect where
   signature := Op.signature

instance : DialectDenote dialect where
  denote := fun op args _ =>
  match op with
  | .add =>
    let l : Int := args.getN 0
    let r : Int := args.getN 1
    l + r
  | .const i => i

 def Program (Γ Δ : Ctxt Ty) : Type := Lets dialect Γ .pure Δ

 end Pure


 namespace RegAlloc

 def Reg := Nat
 deriving DecidableEq, Repr, Inhabited, BEq

 abbrev RegisterFile : Type := Reg → Int
def RegisterFile.get (R : RegisterFile) (r : Reg) : Int := R r
 def RegisterFile.set (R : RegisterFile) (r : Reg) (v : Int) : RegisterFile :=
  fun r' => if r = r' then v else R r'

inductive Op
| add (l r out : Reg)
| const (i : Int) (out : Reg)

inductive Ty
| unit : Ty

abbrev dialect : Dialect where
  Op := Op
  Ty := Ty
  m := StateM RegisterFile

def Op.signature : Op → Signature Ty
| .add _ _ _ => {
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
  | .add l r rout => show StateM _ _ from
     readRegister l >>= fun vl =>
     readRegister r >>= fun vr =>
     writeRegister rout (vl + vr)
  | .const i rout => show StateM _ _ from
     writeRegister rout i

 def Program (Γ Δ : Ctxt Ty) : Type := Lets dialect Γ .impure Δ

 end RegAlloc


/-- A mapping of variables in a context to a register. -/
structure RegisterMap (Γ : Ctxt Pure.Ty) where
  toFun : Γ.Var Pure.Ty.int → RegAlloc.Reg -- I actually want a partial function here.
  live : List RegAlloc.Reg -- TODO: move to using HashMap once available for HashSet.
  -- hlive : ∀ r ∈ live, ∃ v, toFun v = r -- every live register is mapped to a variable.
  -- hinjective : Injective toFun

 /--
 A correspondence between variables 'v ∈ Γ' and registers in the register file.
 This correspondence is witnessed by 'f'.
 -/
 def correspondence {Γ : Ctxt Pure.Ty} (V : Γ.Valuation) (f : RegisterMap Γ) (R : RegAlloc.RegisterFile) : Prop :=
  ∀ (v : Γ.Var Pure.Ty.int), R (f.toFun v) = V v

/-- All register files correspond to the start of the program. -/
theorem correspondence_nil (R : RegAlloc.RegisterFile) :
    correspondence (Γ := []) V f R := by
  intros v
  exact v.emptyElim


/--
For a sequence of lets [v1 := e1, ..., vn := en, vn+1 := en+1], clear the register assigned to 'vn+1' and return it.
-/
def RegisterMap.lookupAndDeleteLast {Γ : Ctxt Pure.Ty} {t : Pure.Ty} (f : RegisterMap <| Γ.snoc t) : RegAlloc.Reg × RegisterMap Γ :=
  let vlast := Ctxt.Var.last Γ t
  let r := f.toFun vlast
  (r, {
    toFun := fun v => f.toFun (v.toSnoc),
    live := f.live.erase (f.toFun <| Ctxt.Var.last Γ t) -- state that this register is now killed.
  })


/--
Convert a pure context to an impure context, where all SSA variables are now side effecting, and thus
have type ().
-/
def doRegAllocCtx (ctx : Ctxt Pure.Ty) : Ctxt RegAlloc.Ty := ctx.map (fun _ => RegAlloc.Ty.unit)

@[simp]
theorem doRegAllocCtx_nil : doRegAllocCtx [] = [] := rfl

@[simp]
def doRegAllocCtx_cons : doRegAllocCtx (Γ.snoc s) = (doRegAllocCtx Γ).snoc RegAlloc.Ty.unit := rfl

def doRegAllocExpr (f : RegisterMap (Γ.snoc s))
  (e : Expr Pure.dialect Γ EffectKind.pure .int) :
  Expr RegAlloc.dialect (doRegAllocCtx Γ) EffectKind.impure .unit × RegisterMap Γ :=
  match e.op with
  | .const i =>
      let (r, f) := f.lookupAndDeleteLast
      (Expr.mk (RegAlloc.Op.const i r) rfl (by simp) .nil .nil, f)
  | .add => sorry

/-- TODO: we will get stuck in showing that 'nregs > 0' when we decrement it when a variable is defined (ie, dies in reverse order).
This might have us actually need to compute liveness anyway to prove correctness.
-/
def doRegAllocLets (f : RegisterMap Δ) (p : Pure.Program Γ Δ) : RegAlloc.Program (doRegAllocCtx Γ) (doRegAllocCtx Δ) × RegisterMap Γ :=
  match p with
  | .nil => (.nil, f)
  | .var ps e (Γ_out := Ξ) (t := t) =>
    let (er, f) := doRegAllocExpr f e
    let (psr, f) := doRegAllocLets f ps
    (.var psr er, f)
