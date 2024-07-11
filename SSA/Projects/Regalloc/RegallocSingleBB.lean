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

/--
Convert a pure context to an impure context, where all SSA variables are now side effecting, and thus
have type ().
-/
def doCtxt (ctx : Ctxt ty) : Ctxt RegAlloc.Ty := ctx.map (fun _ => RegAlloc.Ty.unit)

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

/-- run a `StateT` program and discard the final result, leaving the stat behind. -/
def StateT.exec {m : Type u → Type v} [Functor m] (cmd : StateT σ m α) (s : σ) : m σ :=
  Prod.snd <$> cmd.run s



/-- Evaluating at an arbitrary valuation is the same as evaluating at a 'doValuation'-/
@[simp]
def RegAlloc.Expr.denote_eq_denote_doValuation {Γ : Ctxt RegAlloc.Ty} {V: Γ.Valuation}
  (e : Expr RegAlloc.dialect Γ EffectKind.impure .unit) :
  (e.denote V) = e.denote (doValuation Γ) := by simp

def RegAlloc.Expr.exec {Γ : Ctxt RegAlloc.Ty}
  (e : Expr RegAlloc.dialect Γ EffectKind.impure .unit)
  (R : RegAlloc.RegisterFile) : RegAlloc.RegisterFile :=
  (StateT.exec <| e.denote (doValuation Γ)) R

def RegAlloc.Program.exec {Γ Δ : Ctxt RegAlloc.Ty}
    (p : RegAlloc.Program Γ Δ)
    (R : RegAlloc.RegisterFile) : RegAlloc.RegisterFile :=
  (StateT.exec <| p.denote (doValuation Γ)) R


/-- Get the register into which value is written to. -/
def RegAlloc.Op.outRegister (op : RegAlloc.Op) : RegAlloc.Reg :=
  match op with
  | .increment _ out => out
  | .const _ out => out

/-- Get the register into which value is written to. -/
def RegAlloc.Expr.outRegister (e : Expr RegAlloc.dialect Γ EffectKind.impure .unit) : RegAlloc.Reg :=
  match e with
  | Expr.mk op .. => RegAlloc.Op.outRegister op

-- Evaluating an empty program yields the same register file.
@[simp]
def RegAlloc.Program.exec_nil_eq :
    RegAlloc.Program.exec (Γ := Γ) (Δ := Γ) Lets.nil R = R := by
  simp [RegAlloc.Program.exec, StateT.exec]


-- Evaluating a register yields a new register file whose value has been modified at R.
@[simp]
def RegAlloc.Program.exec_cons_eq (body : Program Γ Δ) (er : Expr RegAlloc.dialect Δ EffectKind.impure .unit) :
    RegAlloc.Program.exec (Lets.var body er) R = RegAlloc.Expr.exec er (RegAlloc.Program.exec body R) := by
  simp [RegAlloc.Program.exec, StateT.exec, RegAlloc.Expr.exec]

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

/-- A register is free if no variable maps to it. -/
def Var2Reg.registerDead (f : Var2Reg Γ) (r : RegAlloc.Reg) : Prop :=
  ∀ (v : Γ.Var Pure.Ty.int), r ∉ f.toFun v


/-- A register is live if some variable maps to the register. -/
def Var2Reg.registerLive (f : Var2Reg Γ) (r : RegAlloc.Reg) : Prop :=
  ¬ f.registerDead r

structure LawfulVar2Reg (Γ : Ctxt Pure.Ty) extends Var2Reg Γ where
  /-- every register in the set of dead registers is in fact dead. -/
  hdead : ∀ r ∈ dead, Var2Reg.registerDead toVar2Reg r
  /-- our mapping from variables to registers is injective. -/
  hinj : Function.Injective toVar2Reg.toFun

 /--
 A correspondence between variables 'v ∈ Γ' and registers in the register file.
 This correspondence is witnessed by 'f'.
 -/
 def complete_mapping {Γ : Ctxt Pure.Ty} (V : Γ.Valuation) (f : Var2Reg Γ) (R : RegAlloc.RegisterFile) : Prop :=
  ∀ (v : Γ.Var Pure.Ty.int), ∃ r ∈ f.toFun v, R r = V v

/-- All register files correspond to the start of the program. -/
theorem correspondVar2Reg_nil (R : RegAlloc.RegisterFile) :
    complete_mapping (Γ := []) V f R := by
  intros v
  exact v.emptyElim

/--
All live registers correspond to correct values.
This says that the register file is correct at the start of the program.
-/
def sound_mapping {Γ : Ctxt Pure.Ty} (V : Γ.Valuation) (v2reg : Var2Reg Γ) (R : RegAlloc.RegisterFile) : Prop :=
  ∀ (r : RegAlloc.Reg) (v : Γ.Var Pure.Ty.int) (hlive : v2reg.toFun v = .some r), R r = V v

/-- Every complete mapping (which maps every live variable) is also sound (it correctly maps each register soundly.)-/
theorem sound_mapping.of_complete {Γ : Ctxt Pure.Ty} {V : Γ.Valuation} {f : Var2Reg Γ} {R : RegAlloc.RegisterFile}
  (hcomplete : complete_mapping V f R) : sound_mapping V f R := by
    intros r v hlive
    obtain ⟨r', hr', hR⟩ := hcomplete v
    rw [hlive] at hr'
    injection hr'
    subst r'
    exact hR

/--
NOTE: Reg2Val does not imply Val2Reg!
For example, consider the  mapping that maps every variable to a dead register.
This satisfies Reg2Val (since trivially, every 'live' register (ie, none of them) maps right), but not Val2Reg.
-/

structure AllocateDeadRegisterResult (fold : Var2Reg Γ) where
  r : RegAlloc.Reg
  f : Var2Reg Γ
  -- hr : f.registerDead r

def Var2Reg.allocateDeadRegister {Γ : Ctxt Pure.Ty} (f : Var2Reg Γ) : Option (AllocateDeadRegisterResult f) :=
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
    {fold : Var2Reg Γ}
    (f : AllocateDeadRegisterResult fold) {v : Γ.Var t} (hv : fold.toFun v = .none) : RegAlloc.Reg × Var2Reg Γ :=
  (f.r, {
    toFun := fun v' => if v' = v then .some f.r else fold.toFun v'
    dead := f.f.dead
  })

def Var2Reg.lookupOrInsert {Γ : Ctxt Pure.Ty} (f : Var2Reg Γ) (v : Γ.Var int) : Option (RegAlloc.Reg × Var2Reg Γ) :=
  match hv : f.toFun v with
  | .some r => (r, f)
  | .none =>
      match f.allocateDeadRegister with
      | .none => .none
      | .some result =>
        some (result.consume hv)

/-- Lookup an argument in a register map, where the variable is defined in the register map. -/
def Var2Reg.lookupOrInsertArg {Γ : Ctxt Pure.Ty} (f : Var2Reg <| Γ.snoc t) (v : Γ.Var int) :
  Option (RegAlloc.Reg × Var2Reg (Γ.snoc t)) :=
  match hv : f.toFun v with
  | .some r => (r, f)
  | .none =>
      match f.allocateDeadRegister with
      | .none => .none
      | .some result =>
        some (result.consume hv)

def Var2Reg.lookupOrInsertResult {Γ : Ctxt Pure.Ty} (f : Var2Reg (Γ.snoc t)) : Option (RegAlloc.Reg × Var2Reg (Γ.snoc t)) :=
  f.lookupOrInsert (Ctxt.Var.last Γ t)

/-- Delete the last register from the register map. -/
def Var2Reg.deleteLast {Γ : Ctxt Pure.Ty} (f : Var2Reg (Γ.snoc t)) : Var2Reg Γ :=
  let toFun := fun v => f.toFun v.toSnoc
  match f.toFun (Ctxt.Var.last Γ t) with
  | .none => { toFun := toFun, dead := f.dead }
  | .some r =>  { toFun := toFun, dead := f.dead.erase r }


@[simp]
def doRegAllocCtx_cons : doCtxt (Γ.snoc s) = (doCtxt Γ).snoc RegAlloc.Ty.unit := rfl

def doExpr (f : Var2Reg (Γ.snoc s))
  (e : Expr Pure.dialect Γ EffectKind.pure .int) :
  Option (Expr RegAlloc.dialect (doCtxt Γ) EffectKind.impure .unit × Var2Reg Γ) :=
  match e with
  | Expr.mk (.const i) .. => do
      let (rout, f) ← f.lookupOrInsertResult
      some (Expr.mk (RegAlloc.Op.const i rout) rfl (by simp) .nil .nil, f.deleteLast)
  | Expr.mk .increment rfl _heff args .. => do
      let arg := args.getN 0
      let (rout, f) ← f.lookupOrInsertResult
      let (r₁, f) ← f.lookupOrInsertArg arg
      some (Expr.mk (RegAlloc.Op.increment rout r₁) rfl (by simp) .nil .nil, f.deleteLast)

-- theorem eq_of_doRegAllocExpr_eq (f : Var2Reg Γ.snoc s)
--   (e : Expr Pure.dialect Γ EffectKind.pure .int)

/--
TODO: we will get stuck in showing that 'nregs > 0' when we decrement it when a variable is defined (ie, dies in reverse order).
This might have us actually need to compute liveness anyway to prove correctness.
-/
def doLets (p : Pure.Program Γ Δ) (fΔ : Var2Reg Δ) :
  Option (RegAlloc.Program (doCtxt Γ) (doCtxt Δ) × Var2Reg Γ) :=
  match  p with
  | .nil => some (.nil, fΔ)
  | .var ps e (Γ_out := Ξ) (t := t) => by
    -- stop
    exact match doExpr fΔ e with
    | none => none
    | some (er, fΞ) =>
      match doLets ps fΞ with
      | none => none
      | some (bodyr, fΓ) => some (.var bodyr er, fΓ)
termination_by structural p

/-- Equation theorem for doLets when argument is nil. -/
@[simp]
theorem Var2Reg.doLets_nil (f : Var2Reg Γ) : doLets .nil f = some (.nil, f) := rfl


/-- Inversion equation theorem for doLets when argument is cons. -/
@[simp]
theorem Var2Reg.eq_of_doRegAllocLets_var_eq_some {ps : Pure.Program Γ Δ}
    {fΔ : Var2Reg (Δ.snoc .int)}
    {fΓ : Var2Reg Γ}
    {rsout : RegAlloc.Program (doCtxt Γ) (doCtxt (Δ.snoc .int))}
    (h : doLets (.var ps e) fΔ = some (rsout, fΓ)) :
    ∃ bodyr er fΞ, rsout = .var bodyr er ∧
       doExpr fΔ e = some (er, fΞ) ∧
       doLets ps fΞ = some (bodyr, fΓ) := by
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
      simp [ih]


theorem Lets.nil_of_eq [DialectSignature d] {Γ Δ : Ctxt d.Ty} (p : Lets d Γ eff Δ) (hΔ : Δ = Γ) : p = hΔ ▸ .nil :=
  match Δ, p with
  | .(Γ), .nil  => rfl
  | _, .var body e (Γ_out := Ξ) (t := t) => by
    have hbody := Lets.nil_of_eq body
    by_contra hcontra
    sorry

#check sound_mapping

/- Evaluating an expression will return an expression whose value equals the -/
theorem doExpr_sound {Γs2reg : Var2Reg (Γ.snoc s)}
  {e : Expr Pure.dialect Γ EffectKind.pure .int}
  (h : doExpr Γs2reg e = some (er, Γ2reg)) -- we got an expression
  : e.denote V = runExpr er R (RegAlloc.Expr.outRegister er) := rfl



/-
Given a valuation of `V` for a pure program `p` and a register file `R`such that `V ~fΓ~ R`,
then it must be that `(p V) ~ fΔ ~ (regalloc p) R`. That is, the valuation after executing `p`
is in correspondence with the register file after executing the register allocated program.

Note that this is not literally true, since a variable that has
-/
theorem doRegAllocLets_correct
    (p : Lets Pure.dialect Γ .pure Δ)
    (Δ2reg : Var2Reg Δ)
    (q : RegAlloc.Program (doCtxt Γ) (doCtxt Δ))
    (Γ2reg : Var2Reg Γ)
    (hq : doLets p Δ2reg = some (q, Γ2reg))
    (R : RegAlloc.RegisterFile)
    (V : Γ.Valuation)
    /- When we start out, all values we need are in registers. -/
    (hRV : complete_mapping V Γ2reg R)  :
    /- At the end, All live out registers have the same value -/
    sound_mapping (p.denote V) Δ2reg ((show StateM _ _ from (q.denote (doValuation (doCtxt Γ)))).exec R) :=
  match hmatch : p, h₁ : Δ2reg,  q with
  | .nil, f, q => by
    rename_i h
    subst h
    simp_all only [Var2Reg.doLets_nil, Option.some.injEq, Prod.mk.injEq, heq_eq_eq,
      Lets.denote_nil, EffectKind.toMonad_pure, Id.pure_eq]
    subst hmatch
    -- have hq := Lets.nil_of_eq q rfl
    subst h₁
    simp_all only [hq.1.symm, true_and, Lets.denote_nil, EffectKind.toMonad_impure,
      EffectKind.return_impure_toMonad_eq, StateT.run_pure, Id.pure_eq]
    simp [pure, StateT.pure]
    apply sound_mapping.of_complete hRV
  | .var body e (Γ_out := Ξ) (t := t), f, q => by
    rename_i h
    obtain ⟨bodyr, er, Ξ2reg, hq, he, hbody⟩ := Var2Reg.eq_of_doRegAllocLets_var_eq_some hq
    subst hq
    subst h
    subst h₁
    have ih := doRegAllocLets_correct (hq := hbody) R V hRV
    subst hmatch
    -- he: doExpr Δ2reg e = (er, Ξ2reg)
    -- hbody: doLets body Ξ2reg = (bodyr, Γ2reg))
    -- ih : sound_mapping (body.denote V)  Ξ2reg
    -- V ~Γ2reg~> R
    simp [sound_mapping]
    intros r v hlive
    simp [StateT.exec]
    /-
    case intro.intro.intro.intro.intro
    Γ : Ctxt Pure.dialect.Ty
    Γ2reg : Var2Reg Γ
    R : RegAlloc.RegisterFile
    V : Γ.Valuation
    hRV : complete_mapping V Γ2reg R
    Ξ : Ctxt Pure.dialect.Ty
    t : Pure.dialect.Ty
    body : Lets Pure.dialect Γ EffectKind.pure Ξ
    e : Expr Pure.dialect Ξ EffectKind.pure t
    bodyr : Lets RegAlloc.dialect (doCtxt Γ) EffectKind.impure (List.map (fun x => RegAlloc.Ty.unit) Ξ)
    er : Expr RegAlloc.dialect (List.map (fun x => RegAlloc.Ty.unit) Ξ) EffectKind.impure
      ((fun x => RegAlloc.Ty.unit) Pure.Ty.int)
    Ξ2reg : Var2Reg Ξ
    hbody : doLets body Ξ2reg = some (bodyr, Γ2reg)
    Δ2reg : Var2Reg (Ξ.snoc t)
    q : RegAlloc.Program (doCtxt Γ) (doCtxt (Ξ.snoc t))
    he : doExpr Δ2reg e = some (er, Ξ2reg)
    hq : doLets (body.var e) Δ2reg = some (bodyr.var er, Γ2reg)
    ih : sound_mapping (body.denote V) Ξ2reg
      (StateT.exec
        (let_fun this := bodyr.denote (doValuation Γ);
        this)
        R)
    r : RegAlloc.Reg
    v : (Ξ.snoc t).Var Pure.Ty.int
    hlive : Δ2reg.toFun v = some r
    ⊢ StateT.exec
        (do
          let V_out ← bodyr.denote (doValuation Γ)
          let x ← er.denote V_out
          pure (V_out::ᵥx))
        R r =
      (body.denote V::ᵥe.denote (body.denote V)) v
    -/
    sorry
