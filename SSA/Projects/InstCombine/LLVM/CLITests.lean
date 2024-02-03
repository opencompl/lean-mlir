import SSA.Projects.InstCombine.LLVM.Transform
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

def CliTest.signature (test : CliTest) :
  List (InstCombine.MTy test.mvars) × (InstCombine.MTy test.mvars) :=
  (test.context, test.ty)

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

def CliTest.params : CliTest → Type
| test => natParams test.mvars

def CliTest.paramsParseable (test : CliTest) : Cli.ParseableType (test.params) :=
  instParseableNatParams

instance {n : Nat} : Cli.ParseableType (Std.BitVec n) where
  name := s!"BitVec {n}"
  parse? str := do
   let intVal ← Cli.instParseableTypeInt.parse? str
   return Std.BitVec.ofInt n intVal


/--
We can only execute tests that are concrete.
This property ensures that they are concrete, i.e. have no metavariables
(`mvars = 0`)
-/
def CliTest.concrete : CliTest → Prop := fun test => test.mvars = 0

instance {test : CliTest} : Decidable test.concrete :=
 inferInstanceAs (DecidableEq Nat) test.mvars 0


structure ConcreteCliTest where
  name : Name
  context : MLIR.AST.Context 0
  ty : InstCombine.MTy 0
  code : MLIR.AST.Com context ty


def InstCombine.MTy.cast_concrete (mvars : Nat) (ty : InstCombine.MTy mvars) (hMvars : mvars = 0) : InstCombine.MTy 0 :=
    hMvars ▸ ty

def InstCombine.MTy.cast_concrete? (mvars : Nat) (ty : InstCombine.MTy mvars) : Option <| InstCombine.MTy 0 :=
  if h : mvars = 0 then
    some <| cast_concrete mvars ty h
   else
     none

def MLIR.AST.Context.cast_concrete (mvars : Nat) (ctxt : MLIR.AST.Context mvars)
  (hMVars : mvars = 0) : MLIR.AST.Context 0 := hMVars ▸ ctxt

def MLIR.AST.Context.cast_concrete? (mvars : Nat) (ctxt : MLIR.AST.Context mvars) :
Option <| MLIR.AST.Context 0 :=
  if h : mvars = 0 then
    some <| cast_concrete mvars ctxt h
   else
     none

mutual
def Com.cast_concrete (mvars : Nat) (ctxt : MLIR.AST.Context mvars) (ty : InstCombine.MTy mvars)
   (code : MLIR.AST.Com ctxt ty) (hMvars : mvars = 0) :
    Σ new : MLIR.AST.Context 0 × InstCombine.MTy 0, MLIR.AST.Com new.1 new.2 :=
   match code with
   | .ret v =>
       let f := fun t => InstCombine.MTy.cast_concrete mvars t hMvars
       let ty' := f ty
       let ctxt' := (ctxt.map f)
       let v' : Ctxt.Var ctxt' ty' := v.toMap
       Sigma.mk (ctxt', ty') (Com.ret v')
    | .lete (ty₁  := t) e b =>
       let Sigma.mk (ctxt', ty') e' := Expr.cast_concrete mvars ctxt t e hMvars
       let Sigma.mk (ctxt'', ty'') b' := Com.cast_concrete mvars (t::ctxt) ty b hMvars
       by
        simp at e'
        simp at b'
        have hTy' : ty'' = ty' := by sorry
        have hCtxt' : ty' :: (ctxt', ty'').1 = ctxt'' := by sorry
        --rw [hCtxt']
        exact Sigma.mk (ctxt', ty') <| .lete e' (hTy' ▸ hCtxt' ▸ b')

def Expr.cast_concrete (mvars : Nat) (ctxt : MLIR.AST.Context mvars) (ty : InstCombine.MTy mvars)
   (code : MLIR.AST.Expr ctxt ty) (hMvars : mvars = 0) :
    Σ new : MLIR.AST.Context 0 × InstCombine.MTy 0, MLIR.AST.Expr new.1 new.2 := sorry

end

def Code.cast_concrete? (mvars : Nat) (ctxt : MLIR.AST.Context mvars) (ty : InstCombine.MTy mvars) (code : MLIR.AST.Com ctxt ty)  :
    Option <| Σ new : MLIR.AST.Context 0 × InstCombine.MTy 0, MLIR.AST.Com new.1 new.2 :=
    if h : mvars = 0 then
      some <| Code.cast_concrete mvars ctxt ty code h
    else
      none

/--
TODO: This instantiates the parameters in a test. So far we assume al parameters are `Nat`s.
-/
def CliTest.instantiateParameters (test : CliTest) (params : Vector Nat test.mvars) : ConcreteCliTest :=
  if h : test.concrete then
    let context : MLIR.AST.Context 0 := h ▸ test.context
    let ty : InstCombine.MTy 0 := h ▸ test.ty
    let test' : CliTest := { name := test.name, mvars := 0, context := context, ty := ty, code := test.code}
    -- is this the one that's impossible (becaue of the non-theorem of `HEq.congr`?)
    let hContext : HEq context test.context := by sorry --rfl
    let ty : InstCombine.MTy 0 := h ▸ test.ty
    let hTy : HEq ty test.ty := by sorry --rfl
    let code : MLIR.AST.Com context ty := HEq.rec hContext <| HEq.rec hTy test.code
   { name := test.name, context := context, ty := ty, code := code}
  else
  sorry

#check Ctxt.Valuation
def CliTest.buildCtxtValuation :
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
