import SSA.Projects.InstCombine.LLVM.Transform
import SSA.Projects.InstCombine.LLVM.Signature
import Std
import Lean.Environment
import Cli

open Lean Goedel

/-- Parse a tuple -/
instance instParseableTuple [A : Cli.ParseableType α] [B : Cli.ParseableType β] :
  Cli.ParseableType (α × β) where
    name :=  s!"({A.name} × {B.name})"
    parse? str := do
      let str := str.trim.splitOn ","
      match str with
      | [a, b] => do
        let a ← A.parse? a.trim
        let b ← B.parse? b.trim
        return (a, b)
      | _ => .none

structure CliTest where
  name : Name
  mvars : Nat
  context : MLIR.AST.Context mvars
  ty : InstCombine.MTy mvars
  code : MLIR.AST.Com context ty
  signature : CliSignature

-- We add a special case for 1 because Nat × Unit ≠ Nat
private def natParams : Nat → Type
  | 0 => Unit
  | 1 => Nat
  | n + 1 => Nat × (natParams n)

theorem natParamsTup : ∀ n : Nat, n > 0 → natParams (n + 1) = (Nat × natParams n) := by
  intro n
  induction n <;> simp [natParams]

def instParseableNatParams {n : Nat} : Cli.ParseableType (natParams n) where
  name := s!"{n} nat(s)."
  parse? str :=
  match n with
    | 0 =>
      let inst : Cli.ParseableType Unit := inferInstance
      inst.parse? str
    | 1 =>
      let inst : Cli.ParseableType Nat := inferInstance
      inst.parse? str
    -- this feels unnecessarily complicated
    | (n + 1) + 1 =>
      let inst1 : Cli.ParseableType Nat := inferInstance
      let instn : Cli.ParseableType (natParams (n + 1)) := @instParseableNatParams (n + 1)
      let instTup : Cli.ParseableType (Nat × (natParams <| n + 1)) := @instParseableTuple Nat (natParams (n + 1)) inst1 instn
      let hn1gt0 : (n + 1) > 0 := by
        simp_all only [gt_iff_lt, add_pos_iff, or_true] -- aesop?
      let hn1eq := natParamsTup (n + 1) hn1gt0
      hn1eq ▸ instTup.parse? str

instance {n : Nat} : Cli.ParseableType (natParams n) := instParseableNatParams


/- These will parse the types/signature themselves -/
instance : Cli.ParseableType CliType where
  name := "CliType"
  parse? str := do
    let n ← Cli.instParseableTypeNat.parse? str
    return CliType.width n

instance : Cli.ParseableType CliSignature where
  name := "Signature"
  parse? str := do
    let str := str.trim.splitOn "->"
    match str with
      | [inpStr, retStr] => do
        let inpArr : Array CliType ← Cli.ParseableType.parse? inpStr
        let retTy : CliType ← Cli.ParseableType.parse? retStr
        return { args := inpArr.toList, returnTy := retTy}
      | _ => none

instance : Goedel CliType where toType
  | .width n => Std.BitVec n
  | .varw => (n : Nat) → Std.BitVec n

private def toTypeList : List CliType → Type
  | [] => Unit
  | [ty] => toType ty
  | ty::tys => (toType ty) × (toTypeList tys)

instance : Goedel (List CliType) := ⟨toTypeList⟩

instance : Goedel CliSignature where
  toType sig :=
    (toType sig.args → toType sig.returnTy)

open InstCombine in
def CliType.toTy : CliType → (Σ n : Nat, MTy n)
  | .width n => Sigma.mk 0 (MTy.bitvec (ConcreteOrMVar.concrete n))
  | .varw => Sigma.mk 1 (MTy.bitvec (ConcreteOrMVar.mvar ⟨0, by aesop⟩))

inductive CliType.isConcrete (cty : CliType) : Prop
  | width : (n : Nat) → cty = .width n → CliType.isConcrete cty

open InstCombine in
def CliType.toTy' (cty : CliType) (hConcrete : cty.isConcrete) : MTy 0 :=
  match cty with
  | .width n => (MTy.bitvec (ConcreteOrMVar.concrete n))
  | cty@varw => by
    exfalso
    cases hConcrete
    contradiction
    -- not sure how to make this using toTy

private def List.toHVector : List CliType → Σ ns : List Nat, HVector (fun n : Nat => InstCombine.MTy n) ns
  | [] => Sigma.mk [] []ₕ
  | cty::ctys => match cty.toTy, toHVector ctys with
    | Sigma.mk n mty, Sigma.mk ns mtys =>
      Sigma.mk (n :: ns) (mty ::ₕ mtys)

def CliTest.params : CliTest → Type
| test => natParams test.mvars

def CliTest.paramsParseable (test : CliTest) : Cli.ParseableType (test.params) :=
  instParseableNatParams

instance {n : Nat} : Cli.ParseableType (Std.BitVec n) where
  name := s!"BitVec {n}"
  parse? str := do
   let intVal ← Cli.instParseableTypeInt.parse? str
   return Std.BitVec.ofInt n intVal

private def List.allZeroes : List Nat → Prop
  | [] => True
  | 0::ns => ns.allZeroes
  | _::_ => False

def CliTest.concreteSignature (test : CliTest) : Prop :=
   match test.signature.args.toHVector with
  | Sigma.mk ns _ => match test.signature.returnTy.toTy with
    | Sigma.mk 0 _ => ns.allZeroes
    | _ => False

/-- There is no reason why the `CliTest.signature` of a test has
    to agree with its context (even if that's how we build them in principle)<
    because they're not dependedently typed here.

    This proposition ensures this consistency via a confluence property:
    both should evaluate to the same type.
-/
--def CliTest.consistentSignature (test : CliTest) : Prop :=
--   match test.signature.args.toHVector with
--  | Sigma.mk _ ms => match test.signature.returnTy.toTy with
--    | Sigma.mk 0 _ =>

--def CliTest.buildCtxtValuation
--  (test : CliTest) (vals : HVector toType test.signature.args)
--  (hMvars : test.mvars = 0 := by rfl)
--  (hConcrete : test. .map CliType.isConcrete)
--  (hVals : test.signature.args.map CliType.toTy = test.context := by rfl) :
--  test.context.Valuation :=
--  sorry

/-

  sorry



  (hRet : toType test.signature.returnTy = toType test.ty := by rfl) :
  toType test.ty :=
  test.code

def CliTest.testFn (test : CliTest) :  ⟦test.signature.args⟧ → IO ⟦test.signature.returnTy⟧ :=


 sorry
-/
-- Define an attribute to add up all LLVM tests
-- https://leanprover.zulipchat.com/#narrow/stream/270676-lean4/topic/.E2.9C.94.20Stateful.2FAggregating.20Macros.3F/near/301067121
abbrev NameExt := SimplePersistentEnvExtension (Name × Name) (NameMap Name)

private def mkExt (name attr : Name) (descr : String) : IO NameExt := do
  let addEntryFn | m, (n3, n4) => m.insert n3 n4
  let ext ← registerSimplePersistentEnvExtension {
    name, addEntryFn
    addImportedFn := mkStateFromImportedEntries addEntryFn {}
  }
  registerBuiltinAttribute {
    name := attr
    descr
    add := fun declName stx attrKind => do
      let s := ext.getState (← getEnv)
      let ns ← stx[1].getArgs.mapM fun stx => do
        let n := stx.getId
        if s.contains n then throwErrorAt stx "test {n} already declared"
        pure n
      modifyEnv $ ns.foldl fun env n =>
        ext.addEntry env (n, declName)
  }
  pure ext


private def mkElab (ext : NameExt) (ty : Lean.Expr) : Elab.Term.TermElabM Lean.Expr := do
  let mut stx := #[]
  for (_, n4) in ext.getState (← getEnv) do
    stx := stx.push $ ← `($(mkIdent n4):ident)
  let listStx := (← `([$stx,*]))
  --let sorted ← `(Array.toList $ Array.qsort ($listStx).toArray (λ x y => Nat.ble x.weightedSize y.weightedSize))
  let list ← `($listStx)
  Elab.Term.elabTerm list (some ty)

syntax (name := llvmTest) "llvmTest " ident+ : attr
initialize llvmExtension : NameExt ←
  mkExt `MLIR.testExtension `llvmTest
    (descr := "LLVM Tests")

elab "llvmTests!" : term <= ty => do
  mkElab llvmExtension ty
