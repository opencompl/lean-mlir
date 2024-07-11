-- Register allocation for a single basic block program.
import SSA.Core.Framework
import Lean.Data.HashMap
import Mathlib.Init.Function

namespace Pure

inductive Op
| increment
| const (i : Int)

inductive Ty
-- | int (width : Nat) : Ty
| int : Ty


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


instance : TyDenote Ty where
   toType := fun
    | .int => Int

 instance : DialectSignature dialect where
   signature := Op.signature

instance : DialectDenote dialect where
  denote := fun op args _ =>
  match op with
  | .increment =>
    let l : Int := args.getN 0
    l + 1
  | .const i => i

 abbrev Program (Γ Δ : Ctxt Ty) : Type := Lets dialect Γ .pure Δ

 end Pure


 namespace RegAlloc

 def Reg := Nat
 deriving DecidableEq, Repr, Inhabited, BEq

abbrev RegisterFile : Type := Reg → Int
def RegisterFile.get (R : RegisterFile) (r : Reg) : Int := R r
 def RegisterFile.set (R : RegisterFile) (r : Reg) (v : Int) : RegisterFile :=
  fun r' => if r = r' then v else R r'

inductive Op
| increment (l out : Reg)
| const (i : Int) (out : Reg)

inductive Ty
| unit : Ty

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

 def Program (Γ Δ : Ctxt Ty) : Type := Lets dialect Γ .impure Δ

 end RegAlloc


/-- A mapping of variables in a context to a register. -/
structure RegisterMap (Γ : Ctxt Pure.Ty) where
  toFun : Γ.Var Pure.Ty.int → Option RegAlloc.Reg
  dead : List RegAlloc.Reg -- list of dead registers

/-- A register is free if no variable maps to it. -/
def RegisterMap.registerDead (f : RegisterMap Γ) (r : RegAlloc.Reg) : Prop :=
  ∀ (v : Γ.Var Pure.Ty.int), r ∉ f.toFun v


/-- A register is live if some variable maps to the register. -/
def RegisterMap.registerLive (f : RegisterMap Γ) (r : RegAlloc.Reg) : Prop :=
  ¬ f.registerDead r

structure LawfulRegisterMap (Γ : Ctxt Pure.Ty) extends RegisterMap Γ where
  /-- every register in the set of dead registers is in fact dead. -/
  hdead : ∀ r ∈ dead, toRegisterMap.registerDead r
  /-- our mapping from variables to registers is injective. -/
  hinj : Function.Injective toRegisterMap.toFun

 /--
 A correspondence between variables 'v ∈ Γ' and registers in the register file.
 This correspondence is witnessed by 'f'.
 -/
 def ValToReg {Γ : Ctxt Pure.Ty} (V : Γ.Valuation) (f : RegisterMap Γ) (R : RegAlloc.RegisterFile) : Prop :=
  ∀ (v : Γ.Var Pure.Ty.int), ∃ r ∈ f.toFun v, R r = V v

/-- All register files correspond to the start of the program. -/
theorem correspondVar2Reg_nil (R : RegAlloc.RegisterFile) :
    ValToReg (Γ := []) V f R := by
  intros v
  exact v.emptyElim

/--
All live registers correspond to correct values.
This says that the register file is correct at the start of the program.
-/
def RegToVal {Γ : Ctxt Pure.Ty} (V : Γ.Valuation) (f : RegisterMap Γ) (R : RegAlloc.RegisterFile) : Prop :=
  ∀ (r : RegAlloc.Reg) (v : Γ.Var Pure.Ty.int) (hlive : f.toFun v = .some r), R r = V v

theorem RegToVal.ofValToReg {Γ : Ctxt Pure.Ty} {V : Γ.Valuation} {f : RegisterMap Γ} {R : RegAlloc.RegisterFile}
    (h : ValToReg V f R) : RegToVal V f R := by
    intros r v hlive
    obtain ⟨r', hr', hR⟩ := h v
    rw [hlive] at hr'
    injection hr'
    subst r'
    exact hR

/--
NOTE: Reg2Val does not imply Val2Reg!
For example, consider the  mapping that maps every variable to a dead register.
This satisfies Reg2Val (since trivially, every 'live' register (ie, none of them) maps right), but not Val2Reg.
-/

structure AllocateDeadRegisterResult (fold : RegisterMap Γ) where
  r : RegAlloc.Reg
  f : RegisterMap Γ
  -- hr : f.registerDead r

def RegisterMap.allocateDeadRegister {Γ : Ctxt Pure.Ty} (f : RegisterMap Γ) : Option (AllocateDeadRegisterResult f) :=
  match hf : f.dead with
  | [] => none
  | r :: rs =>
    .some {
      r := r,
      f := {
        toFun := f.toFun,
        dead := rs,
      },
    }



/--
Consume the allocate dead register result,
and use this for the variable 'v'.
-/
def AllocateDeadRegisterResult.consume {Γ : Ctxt Pure.Ty}
    {fold : RegisterMap Γ}
    (f : AllocateDeadRegisterResult fold) {v : Γ.Var t} (hv : fold.toFun v = .none) : RegAlloc.Reg × RegisterMap Γ :=
  (f.r, {
    toFun := fun v' => if v' = v then .some f.r else fold.toFun v'
    dead := f.f.dead
  })

def RegisterMap.lookupOrInsert {Γ : Ctxt Pure.Ty} (f : RegisterMap Γ) (v : Γ.Var int) : Option (RegAlloc.Reg × RegisterMap Γ) :=
  match hv : f.toFun v with
  | .some r => (r, f)
  | .none =>
      match f.allocateDeadRegister with
      | .none => .none
      | .some result =>
        some (result.consume hv)

/-- Lookup an argument in a register map, where the variable is defined in the register map. -/
def RegisterMap.lookupOrInsertArg {Γ : Ctxt Pure.Ty} (f : RegisterMap <| Γ.snoc t) (v : Γ.Var int) :
  Option (RegAlloc.Reg × RegisterMap (Γ.snoc t)) :=
  match hv : f.toFun v with
  | .some r => (r, f)
  | .none =>
      match f.allocateDeadRegister with
      | .none => .none
      | .some result =>
        some (result.consume hv)

def RegisterMap.lookupOrInsertResult {Γ : Ctxt Pure.Ty} (f : RegisterMap (Γ.snoc t)) : Option (RegAlloc.Reg × RegisterMap (Γ.snoc t)) :=
  f.lookupOrInsert (Ctxt.Var.last Γ t)

/-- Delete the last register from the register map. -/
def RegisterMap.deleteLast {Γ : Ctxt Pure.Ty} (f : RegisterMap (Γ.snoc t)) : RegisterMap Γ :=
  let toFun := fun v => f.toFun v.toSnoc
  match f.toFun (Ctxt.Var.last Γ t) with
  | .none => { toFun := toFun, dead := f.dead }
  | .some r =>  { toFun := toFun, dead := f.dead.erase r }

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
  Option (Expr RegAlloc.dialect (doRegAllocCtx Γ) EffectKind.impure .unit × RegisterMap Γ) :=
  match e with
  | Expr.mk (.const i) .. => do
      let (rout, f) ← f.lookupOrInsertResult
      some (Expr.mk (RegAlloc.Op.const i rout) rfl (by simp) .nil .nil, f.deleteLast)
  | Expr.mk .increment rfl _heff args .. => do
      let arg := args.getN 0
      let (rout, f) ← f.lookupOrInsertResult
      let (r₁, f) ← f.lookupOrInsertArg arg
      some (Expr.mk (RegAlloc.Op.increment rout r₁) rfl (by simp) .nil .nil, f.deleteLast)


-- theorem eq_of_doRegAllocExpr_eq (f : RegisterMap Γ.snoc s)
--   (e : Expr Pure.dialect Γ EffectKind.pure .int)

/--
TODO: we will get stuck in showing that 'nregs > 0' when we decrement it when a variable is defined (ie, dies in reverse order).
This might have us actually need to compute liveness anyway to prove correctness.
-/
def doRegAllocLets (p : Pure.Program Γ Δ) (fΔ : RegisterMap Δ) :
  Option (RegAlloc.Program (doRegAllocCtx Γ) (doRegAllocCtx Δ) × RegisterMap Γ) :=
  match  p with
  | .nil => some (.nil, fΔ)
  | .var ps e (Γ_out := Ξ) (t := t) => by
    -- stop
    exact match doRegAllocExpr fΔ e with
    | none => none
    | some (er, fΞ) =>
      match doRegAllocLets ps fΞ with
      | none => none
      | some (psr, fΓ) => some (.var psr er, fΓ)
termination_by structural p

/-- Equation theorem for doRegAllocLets when argument is nil. -/
@[simp]
theorem RegisterMap.doRegAllocLets_nil (f : RegisterMap Γ) : doRegAllocLets .nil f = some (.nil, f) := rfl


/-- Inversion equation theorem for doRegAllocLets when argument is cons. -/
@[simp]
theorem RegisterMap.eq_of_doRegAllocLets_var_eq_some {ps : Pure.Program Γ Δ}
    {fΔ : RegisterMap (Δ.snoc .int)}
    {fΓ : RegisterMap Γ}
    {rsout : RegAlloc.Program (doRegAllocCtx Γ) (doRegAllocCtx (Δ.snoc .int))}
    (h : doRegAllocLets (.var ps e) fΔ = some (rsout, fΓ)) :
    ∃ psr er fΞ, rsout = .var psr er ∧
       doRegAllocExpr fΔ e = some (er, fΞ) ∧
       doRegAllocLets ps fΞ = some (psr, fΓ) := by
  simp [doRegAllocLets] at h
  split at h
  case h_1 => simp at h
  case h_2 a er _ _ =>
    split at h
    case h_1 => simp at h
    case h_2 _ psr _ ih =>
      simp_all only [Option.some.injEq, Prod.mk.injEq, exists_and_left]
      simp only [← h.1]
      exists psr
      exists er
      simp [ih]


/--
Build a register allocation valuation for a given context Γ. Really, this just marks every variable as returning (),
since the semantics is purely side-effecting and nothing flows via the def-use chain.
-/
def doRegAllocValuation (Γ : Ctxt Pure.Ty) : (doRegAllocCtx Γ).Valuation :=
  fun t _v => match t with | .unit => ()


#check Lets


theorem Lets.nil_of_eq [DialectSignature d] {Γ Δ : Ctxt d.Ty} (p : Lets d Γ eff Δ) (hΔ : Δ = Γ) : p = hΔ ▸ .nil :=
  match Δ, p with
  | .(Γ), .nil  => rfl
  | _, .var body e (Γ_out := Ξ) (t := t) => by
    have hbody := Lets.nil_of_eq body
    by_contra hcontra
    sorry

/-- run a `StateT` program and discard the final result, leaving the stat behind. -/
def StateT.exec {m : Type u → Type v} [Functor m] (cmd : StateT σ m α) (s : σ) : m σ :=
  Prod.snd <$> cmd.run s



/-

-/

/-
Given a valuation of `V` for a pure program `p` and a register file `R`such that `V ~fΓ~ R`,
then it must be that `(p V) ~ fΔ ~ (regalloc p) R`. That is, the valuation after executing `p`
is in correspondence with the register file after executing the register allocated program.

Note that this is not literally true, since a variable that has
-/
theorem doRegAllocLets_correct
    -- (p : Pure.Program Γ Δ)
    (p : Lets Pure.dialect Γ .pure Δ)
    (fΔ : RegisterMap Δ)
    (q : RegAlloc.Program (doRegAllocCtx Γ) (doRegAllocCtx Δ))
    (fΓ : RegisterMap Γ)
    (hq : doRegAllocLets p fΔ = some (q, fΓ))
    (R : RegAlloc.RegisterFile)
    (V : Γ.Valuation)
    /- When we start out, all values we need are in registers. -/
    (hRV : ValToReg V fΓ R)  :
    /- At the end, All live out registers have the same value -/
    RegToVal (p.denote V) fΔ ((show StateM _ _ from (q.denote (doRegAllocValuation Γ))).exec R) :=
  match hmatch : p, h₁ : fΔ,  q with
  | .nil, f, q => by
    rename_i h
    subst h
    simp_all only [RegisterMap.doRegAllocLets_nil, Option.some.injEq, Prod.mk.injEq, heq_eq_eq,
      Lets.denote_nil, EffectKind.toMonad_pure, Id.pure_eq]
    subst hmatch
    -- have hq := Lets.nil_of_eq q rfl
    subst h₁
    simp_all only [hq.1.symm, true_and, Lets.denote_nil, EffectKind.toMonad_impure,
      EffectKind.return_impure_toMonad_eq, StateT.run_pure, Id.pure_eq]
    apply RegToVal.ofValToReg hRV
  | .var body e (Γ_out := Ξ) (t := t), f, q => by
    rename_i h
    obtain ⟨psr, er, fΞ, hq, he, hbody⟩ := RegisterMap.eq_of_doRegAllocLets_var_eq_some hq
    subst hq
    subst h
    subst h₁
    have ih := doRegAllocLets_correct (hq := hbody) R V hRV
    subst hmatch
    simp [RegToVal]
    intros r v hlive
    sorry
