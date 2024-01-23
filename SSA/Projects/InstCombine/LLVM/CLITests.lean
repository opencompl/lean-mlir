import SSA.Projects.InstCombine.LLVM.Transform
import SSA.Projects.InstCombine.LLVM.Signature
import Lean.Environment
import Cli

open Lean

/-- Parse a triple -/
instance [A : Cli.ParseableType α] [B : Cli.ParseableType β] [C : Cli.ParseableType γ] :
  Cli.ParseableType (α × β × γ) where
    name :=  s!"({A.name} × {B.name} × {C.name})"
    parse? str := do
      let str := str.trim.splitOn ","
      match str with
      | [a, b, c] => do
        let a ← A.parse? a.trim
        let b ← B.parse? b.trim
        let c ← C.parse? c.trim
        return (a, b, c)
      | _ => .none


structure CliTest where
  name : Name
  mvars : Nat
  context : MLIR.AST.Context mvars
  ty : InstCombine.MTy mvars
  code : MLIR.AST.Com context ty
  signature : CliSignature

/-- unify this with CliTest -/
structure Test where
  name : String
  params : Type
  paramsParseable : Cli.ParseableType params
  testFn : params → IO Bool

def Test.ofFn (name : String) ⦃params : Type⦄ [Cli.ParseableType params]
  (testFn : params → IO Bool) : Test where
  name := name
  params := _
  paramsParseable := inferInstance
  testFn := testFn


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
