import Init.Data.BitVec.Basic
import Init.Data.BitVec.Lemmas
import Init.Data.BitVec.Bitblast

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
 deriving DecidableEq, Repr, Inhabited, BEq

abbrev RegisterFile : Type := Reg → Int
@[simp]
def RegisterFile.get (R : RegisterFile) (r : Reg) : Int := R r

def RegisterFile.set (R : RegisterFile) (r : Reg) (v : Int) : RegisterFile :=
  fun r' => if r = r' then v else R r'

theorem RegisterFile.get_set_of_eq (R : RegisterFile) (r s : Reg) (v : Int) (hs : r = s) :
  (R.set r v) s = v := by
  simp [RegisterFile.set, hs]


theorem RegisterFile.get_set_of_neq (R : RegisterFile) (r s : Reg) (v : Int) (hs : r ≠ s) :
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
 @[simp]
 theorem Expr.const_eq {Γ : Ctxt Ty} {i : Int}
    {ty_eq : Ty.unit = DialectSignature.outTy (d := dialect) (Op.const i out)}
    {eff_le : DialectSignature.effectKind (d := dialect) (Op.const i out) ≤ EffectKind.impure}
    {args : HVector Γ.Var [] }
    {regArgs : HVector (fun t => Com dialect t.1 EffectKind.impure t.2) (DialectSignature.regSig (Op.const i out)) } :
    (Expr.mk (d := dialect) (Γ := Γ) (Op.const i out) (ty := .unit) ty_eq eff_le args regArgs) =
    (Expr.mk (d := dialect) (Γ := Γ) (eff := EffectKind.impure) (Op.const i out) (ty := .unit) (by rfl) (by simp) .nil .nil) := by
  unfold DialectSignature.regSig signature Signature.regSig at regArgs
  simp_all [DialectSignature.regSig, DialectSignature, DialectSignature.regSig, Op.signature]
  sorry




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

/-- A register is free if no variable maps to it. -/
def Var2Reg.registerDead (V2R : Var2Reg Γ) (r : RegAlloc.Reg) : Prop :=
  ∀ (v : Γ.Var Pure.Ty.int), r ∉ V2R.toFun v

/-- A register 'r' is live for a variable 'v' if 'v' maps to 'r'. -/
def Var2Reg.registerLiveFor (V2R : Var2Reg Γ) (r : RegAlloc.Reg) (v : Γ.Var .int) : Prop :=
  V2R.toFun v = some r

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

/-- RegisterLiveFor is injective -/
theorem eq_of_registerLiveFor_of_registerLiveFor {V2R : Var2Reg Γ} {r s : RegAlloc.Reg}
    {v : Γ.Var .int}
    (h₁ : V2R.registerLiveFor r v)
    (h₂ : V2R.registerLiveFor s v) : r = s := by
  simp [Var2Reg.registerLiveFor] at h₁ h₂
  rw [h₁] at h₂
  simpa using h₂

/-
theorem elim_of_registerLiveFor_of_registerLiveFor_of_neq
  {V2R : Var2Reg Γ}
  (h₁ : V2R.registerLiveFor r v)
  (h₂ : V2R.registerLiveFor r w)
  (hneq : v ≠ w) : (α : Prop) := by
  exfalso
  simp [Var2Reg.registerLiveFor] at h₁ h₂
  -- TODO: I need injective in the definition of Var2Reg.
  sorry
-/

/-- RegisterLiveFor is injective -/
theorem registerLiveFor_inj {f : Var2Reg Γ} {r s : RegAlloc.Reg}
    {v : Γ.Var .int}
    (h₁ : f.registerLiveFor r v)
    (h₂ : f.registerLiveFor s v) : r = s :=
  eq_of_registerLiveFor_of_registerLiveFor h₁ h₂


/-- A register is live if some variable maps to the register. -/
def Var2Reg.registerLive (f : Var2Reg Γ) (r : RegAlloc.Reg) : Prop :=
  ∃ (v : Γ.Var .int), f.registerLiveFor r v

theorem dead_iff_not_live {f : Var2Reg Γ} {r : RegAlloc.Reg} :
  f.registerDead r ↔ ¬ f.registerLive r := by
  simp [Var2Reg.registerDead, Var2Reg.registerLive, Var2Reg.registerLiveFor]

theorem live_iff_not_dead {f : Var2Reg Γ} {r : RegAlloc.Reg} :
  f.registerLive r ↔ ¬ f.registerDead r := by
  simp [Var2Reg.registerDead, Var2Reg.registerLive, Var2Reg.registerLiveFor]

structure LawfulVar2Reg (Γ : Ctxt Pure.Ty) extends Var2Reg Γ where
  /-- every register in the set of dead registers is in fact dead. -/
  hdead : ∀ r ∈ dead, Var2Reg.registerDead toVar2Reg r
  /-- our mapping from variables to registers is injective. -/
  hinj : Function.Injective toVar2Reg.toFun

 /--
 A correspondence between variables 'v ∈ Γ' and registers in the register file.
 This correspondence is witnessed by 'f'.
 -/
 def complete_mapping {Γ : Ctxt Pure.Ty} (V : Γ.Valuation) (V2R : Var2Reg Γ) (R : RegAlloc.RegisterFile) : Prop :=
  ∀ (v : Γ.Var Pure.Ty.int), ∃ r, V2R.registerLiveFor r v ∧ R r = V v

/-- All register files correspond to the start of the program. -/
theorem correspondVar2Reg_nil (R : RegAlloc.RegisterFile) :
    complete_mapping (Γ := []) V f R := by
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

/--
NOTE: Reg2Val does not imply Val2Reg!
For example, consider the  mapping that maps every variable to a dead register.
This satisfies Reg2Val (since trivially, every 'live' register (ie, none of them) maps right), but not Val2Reg.
-/

/-
Allocate a dead register to a variable 'v', returning the allocated register
if allocation succeeds.
-/
def Var2Reg.allocateDeadRegister {Γ : Ctxt Pure.Ty}
  (f : Var2Reg Γ)
  (v : Γ.Var .int): Option (RegAlloc.Reg × Var2Reg Γ) :=
  match f.dead with
  | [] => none
  | r :: rs =>
    .some ⟨r, {
      toFun := fun v' => if v' = v then .some r else f.toFun v',
      dead := rs
    }⟩

/--
If allocateDeadRegister succeeds, then the new register is live for the variable.
-/
theorem registerLiveFor_of_allocateDeadRegister
    {Γ₁ : Ctxt Pure.Ty} {Γ₁2R₁ Γ₁2R₂ : Var2Reg Γ₁} {v : Γ₁.Var .int}
    {r : RegAlloc.Reg}
    (halloc : Γ₁2R₁.allocateDeadRegister v = some (r, Γ₁2R₂)) :
    Γ₁2R₂.registerLiveFor r v := by
  simp [Var2Reg.allocateDeadRegister] at halloc
  split at halloc
  · case h_1 => simp at halloc
  · case h_2 r rs _hdead =>
    simp only [Option.some.injEq, Prod.mk.injEq] at halloc
    obtain ⟨hr, hΓ2R'⟩ := halloc
    subst hr
    subst hΓ2R'
    apply Var2Reg.registerLiveFor_of_toFun_eq
    simp

/--
All previously live registers will continue to be live.
-/
theorem registerLiveFor_of_allocateDeadRegister_of_registerLiveFor
    {Γ₁ : Ctxt Pure.Ty} {Γ₁2R₁ Γ₁2R₂ : Var2Reg Γ₁} {v : Γ₁.Var .int}
    {r : RegAlloc.Reg}
    (halloc : Γ₁2R₁.allocateDeadRegister v = some (r, Γ₁2R₂))
    (hlive : Γ₁2R₁.registerLiveFor r v) :
    Γ₁2R₂.registerLiveFor r v := by
  simp [Var2Reg.allocateDeadRegister] at halloc
  split at halloc
  · case h_1 => simp at halloc
  · case h_2 r rs _hdead =>
    simp only [Option.some.injEq, Prod.mk.injEq] at halloc
    obtain ⟨hr, hΓ2R'⟩ := halloc
    subst hr
    subst hΓ2R'
    apply Var2Reg.registerLiveFor_of_toFun_eq
    simp

/--
If a register is live for allocateDeadRegister,
then it must either have been live
previously, or is the register that was allocated.
-/
theorem registerLiveFor_or_eq_of_registerLiveFor_of_allocateDeadRegister -- inversion lemma.
    {Γ₁ : Ctxt Pure.Ty} {Γ₁2R₁ Γ₁2R₂ : Var2Reg Γ₁} {v w : Γ₁.Var .int}
    {r s : RegAlloc.Reg}
    (halloc : Γ₁2R₁.allocateDeadRegister v = some (r, Γ₁2R₂))
    (hlive : Γ₁2R₂.registerLiveFor s w) :
    (Γ₁2R₁.registerLiveFor s w) ∨ (v = w ∧ r = s) := by
  simp [Var2Reg.allocateDeadRegister] at halloc
  split at halloc
  · case h_1 => simp at halloc
  · case h_2 r rs _hdead =>
    simp at halloc
    obtain ⟨hr, hΓ2R'⟩ := halloc
    subst hr
    subst hΓ2R'
    simp [Var2Reg.registerLiveFor] at hlive
    split at hlive
    case isTrue h =>
      subst h
      simp only [Option.some.injEq] at hlive
      subst hlive
      simp
    case isFalse h =>
      left
      apply Var2Reg.registerLiveFor_of_toFun_eq hlive

-- /--
-- Allocating a dead register preserves soundness of the mapping.
-- -/
-- theorem sound_mapping_of_allocateDeadRegister_of_sound_mapping
--     {Γ₁ : Ctxt Pure.Ty} {Γ₁2R₁ Γ₁2R₂ : Var2Reg Γ₁} {v : Γ₁.Var .int}
--     {V : Γ₁.Valuation}
--     {r : RegAlloc.Reg}
--     (halloc : Γ₁2R₁.allocateDeadRegister v = some (r, Γ₁2R₂))
--     (hsound₁ : sound_mapping V Γ₁2R₁ R) :
--     sound_mapping V Γ₁2R₂ R := by
--   simp [sound_mapping]
--   intros s w hlive₂
--   have := registerLiveFor_or_eq_of_registerLiveFor_of_allocateDeadRegister halloc hlive₂
--   cases this
--   case inl hlive₁ =>
--     apply hsound₁ s w hlive₁
--   case inr eq =>
--     obtain ⟨eq₁, eq₂⟩ := eq
--     subst eq₁ eq₂
--     apply eq_of_sound_mapping_of_registerLiveFor hsound₁
--     apply hlive₂

/--
If allocateDeadRegister works, and the mapping is sound,
then we get the right value in the register file.
-/
theorem eq_of_allocateDeadRegisterResult_eq_of_sound_mapping
    {Γ₁ : Ctxt Pure.Ty} {V : Γ₁.Valuation} {Γ₁2R₁ Γ₁2R₂: Var2Reg Γ₁} {v : Γ₁.Var .int}
    (halloc : Γ₁2R₁.allocateDeadRegister v = some (r, Γ₁2R₂)) -- this tells me that the register will be live.
    (hsound  : sound_mapping V Γ₁2R₂ R₂) -- this deduces that the value is equal.
    : R₂ r = V v := by
  apply eq_of_sound_mapping_of_registerLiveFor hsound
  apply registerLiveFor_of_allocateDeadRegister halloc

def Var2Reg.lookupOrInsert {Γ : Ctxt Pure.Ty} (f : Var2Reg Γ) (v : Γ.Var int) :
  Option (RegAlloc.Reg × Var2Reg Γ) :=
  match f.toFun v with
  | .some r => (r, f)
  | .none => f.allocateDeadRegister v

/--
Lookup an argument in a register map, where the variable is defined in the register map.
See that the variable comes from Γ, but the register map is for (Γ.snoc t).
This tells us that this is happening at the phase of the algorithm
where we are allocating registers for the arguments of a `let` binding.
TODO: delete all occurrences of 'Option'.
-/
def Var2Reg.lookupOrInsertArg {Γ : Ctxt Pure.Ty} (f : Var2Reg <| Γ.snoc t)
    (v : Γ.Var int) : Option (RegAlloc.Reg × Var2Reg (Γ.snoc t)) :=
  match f.toFun v with
  | .some r => (r, f)
  | .none => f.allocateDeadRegister v


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
  · case h_2 _hv =>
    apply registerLiveFor_of_allocateDeadRegister hlookup

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
  · case h_2 _hv =>
    apply registerLiveFor_of_allocateDeadRegister hlookup


-- /-- The register map after lookupOrInsertArg is sound. -/
-- theorem Var2Reg.sound_mapping_of_lookupOrInsertArg_of_sound_mapping {Γ : Ctxt Pure.Ty}
--     {Γ₁2R₁ Γ₁2R₂: Var2Reg (Γ.snoc t)} {V : (Γ.snoc t).Valuation} {R : RegAlloc.RegisterFile}
--     (hsound : sound_mapping V Γ₁2R₁ R) {r : RegAlloc.Reg} {v : Γ.Var int}
--     (hlookup : Γ₁2R₁.lookupOrInsertArg v = some (r, Γ₁2R₂)) :
--     sound_mapping V Γ₁2R₂ R := by
--   unfold lookupOrInsertArg at hlookup
--   split at hlookup
--   · case h_1 r hv =>
--     simp [hv] at hlookup
--     obtain ⟨req, Γ2Req⟩ := hlookup
--     subst req
--     subst Γ2Req
--     apply hsound
--   · case h_2 hv =>
--     apply sound_mapping_of_allocateDeadRegister_of_sound_mapping hlookup hsound


/-- Delete the last register from the register map. -/
def Var2Reg.deleteLast {Γ : Ctxt Pure.Ty} (f : Var2Reg (Γ.snoc t)) : Var2Reg Γ :=
  let toFun := fun v => f.toFun v.toSnoc
  match f.toFun (Ctxt.Var.last Γ t) with
  | .none => { toFun := toFun, dead := f.dead }
  | .some r =>  { toFun := toFun, dead := f.dead.erase r }

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
       doExpr Γ₃2Reg e = some (er, Γ₂2Reg) ∧
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

@[simp]
theorem Var2Reg.toFun_allocateDeadRegister
    {Γ₁ : Ctxt Pure.Ty}
    {Γ₁2R₁ : Var2Reg Γ₁}
    {v : Γ₁.Var .int}
    {r : RegAlloc.Reg}
    {Γ₁2R₂ : Var2Reg Γ₁}
    (h : Γ₁2R₁.allocateDeadRegister v = some (r, Γ₁2R₂)) :
    Γ₁2R₂.toFun = fun v' => if v' = v then .some r else Γ₁2R₁.toFun v' := by
  simp [Var2Reg.allocateDeadRegister] at h
  split at h
  · case h_1 r hv =>
    simp [hv] at h
  · case h_2 r rs _hdead =>
    simp at h
    simp_all [h.1]
    simp_all [← h]

theorem Var2Reg.registerLiveFor_of_allocateDeadRegister
    {Γ₁ : Ctxt Pure.Ty}
    {Γ₁2Reg : Var2Reg (Γ₁.snoc t)}
    {s : RegAlloc.Reg}
    {Γ₂2Reg : Var2Reg (Γ₁.snoc t)}
    {v : Γ₁.Var .int}
    (h : Γ₁2Reg.allocateDeadRegister ↑v = some (s, Γ₂2Reg)) :
    Γ₂2Reg.registerLiveFor s v := by
  apply Var2Reg.registerLiveFor_of_toFun_eq
  simp [toFun_allocateDeadRegister h]

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
  · case h_2 r _  =>
    rw [toFun_allocateDeadRegister h]

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
  · case h_2 s _  =>
    simp [toFun_allocateDeadRegister h]

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
          apply Var2Reg.registerLiveFor_of_lookupOrInsertArg
          rw [hresult₂]

@[simp]
theorem effectKind_const :
  DialectSignature.effectKind (d := Pure.dialect)
    (Pure.Op.const i) = EffectKind.pure := rfl

@[simp]
theorem Ctxt.Var.toSnoc_neq_last {Γ : Ctxt Ty} {t : Ty} {v : Γ.Var t} :
    v.toSnoc ≠ Ctxt.Var.last Γ t := by
  unfold Ctxt.Var.toSnoc Ctxt.Var.last
  rcases v with ⟨v, hv⟩
  simp only []
  have heq : v + 1 ≠ 0 := by omega
  simp [heq]
  intros hcontra
  unfold last at hcontra
  obtain ⟨h₁, h₂⟩ := hcontra


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
If we started with a sound mapping Δ2Reg,
then we will keep the mapping sound after Ξ.
-/
theorem sound_mapping_of_doExpr_const_of_sound (hsound : sound_mapping V Γ₁2Reg R) :
    sound_mapping (V.snoc (t := Pure.Ty.int) i) Γ₂2Reg₁ (R.set r i) := by
  unfold sound_mapping
  intros s w hlive
  simp [doExpr, hresult₁] at he
  obtain ⟨he₁, he₂⟩ := he
  have he₂ := he₂.symm
  subst he₂
  -- We are characterizing what the result of running an increment looks like.
  sorry -- HERE HERE HERE


-- unfold sound_mapping at hsound ⊢
-- intros s w hlive
-- unfold Var2Reg.registerLiveFor at *
-- apply hsound
-- have := toFun_const (Δ2Reg := Δ2Reg) (Ξ2reg := Ξ2reg) (hlast := hlast) (heff := heff) (er := er) (he := he)
-- rw [this] at hlive
-- simp at hlive

-- /--
-- If we started with a sound mapping Δ2Reg,
-- then we will keep the mapping sound after Ξ.
-- -/
-- theorem sound_mapping_of_doExpr_const {v : Ξ.Var Pure.Ty.int}
--   (hsound : sound_mapping V Δ2Reg R) :
-- sound_mapping V Ξ2reg R := by -- sorry
-- unfold sound_mapping at hsound ⊢
-- intros s w hlive
-- unfold Var2Reg.registerLiveFor at *
-- apply hsound
-- have := toFun_const (Δ2Reg := Δ2Reg) (Ξ2reg := Ξ2reg) (hlast := hlast) (heff := heff) (er := er) (he := he)
-- rw [this] at hlive
-- simp at hlive

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

end DoExprIncrement

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
    sound_mapping (p.denote V) Δ2reg (RegAlloc.Program.exec q R) :=
  match hmatch : p, h₁ : Δ2reg,  q with
  | .nil, f, q => by
    rename_i h
    subst h
    simp_all only [Var2Reg.doLets_nil, Option.some.injEq, Prod.mk.injEq, heq_eq_eq,
      Lets.denote_nil, EffectKind.toMonad_pure, Id.pure_eq]
    subst hmatch
    subst h₁
    simp only [← hq.1, RegAlloc.Program.exec_nil_eq]
    apply sound_mapping.of_complete hRV
  | .var body e (Γ_out := Ξ) (t := t), f, q => by
    rename_i h
    obtain ⟨bodyr, er, Ξ2reg, hq, he, hbody⟩ := Var2Reg.eq_of_doRegAllocLets_var_eq_some hq
    subst hq
    subst h
    subst h₁
    subst hmatch
    -- I know that er corresponds to e from
    -- doLets (body.var e) Δ2reg = some (bodyr.var er, Γ2reg)
    -- note that Ξ2reg is sound for all registers taht came from Δ2reg.
    have ih := doRegAllocLets_correct (hq := hbody) R V hRV
    simp [sound_mapping] at ih ⊢
    intros r v hlive
    -- how do I know that 'r' is the outRegister for er?
    -- Since I have doExpr Δ2reg e = some (er, Ξ2reg),
    -- it must be that (Ctxt.Var.Last Ξ .int) ~ er.outRegister.
    have hsound := doExpr_sound (hsound := ih) he
    cases v using Ctxt.Var.casesOn
    case toSnoc v =>
      simp
      rw [← ih]
      sorry
    case last =>
      simp
      rw [hsound]
      congr
      sorry

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
