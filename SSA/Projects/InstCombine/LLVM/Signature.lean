import Lean
import Qq
import SSA.Projects.InstCombine.Base

open Qq Lean Elab Command Meta Elab Term

inductive CliType
| varw -- variable width
| width (n : Nat) -- concrete width given by n
deriving Inhabited, Repr

instance : ToString CliType where
 toString
 | .varw => "w"
 | .width (n : Nat) => s!"{n}"

structure CliSignature where
 args : List CliType
 returnTy  : CliType
 deriving Inhabited, Repr

instance : ToString CliSignature where
 toString
 | sig => toString sig.args ++ " → " ++ toString sig.returnTy

opaque k : Nat
opaque m : Nat
opaque e : Expr


def concrete? (e : Expr) : Option (Nat → ConcreteOrMVar ℕ 0) := do
  guard <| e.isAppOfArity ``ConcreteOrMVar.concrete 3
  -- It should be possible to ensure the array accesses from the guard above
  let args := e.getAppArgs

  -- first argument sholud be Nat
  let mvarsExpr ← args[0]?
  guard (mvarsExpr.isConstOf `Nat)

  -- second argument sholud be 0
  let mvarsExpr ← args[1]?
  guard (mvarsExpr.isNatLit)
  guard (mvarsExpr.natLit! = 0)

  -- third argument is value, either literal or bound variable
  let widthExpr ← args[2]?
  if widthExpr.isBVar then
    some <| fun w => .concrete w
  else if widthExpr.isNatLit then
    some <| fun _ => .concrete (widthExpr.natLit!)
  else
    none

def mty? (e : Expr) : Option (Nat → InstCombine.MTy 0) := do
  guard <| e.isAppOfArity ``InstCombine.MTy.bitvec 2
  -- It should be possible to ensure the array accesses from the guard above
  let args := e.getAppArgs

  -- first argument sholud be 0, otherwise it still has metavars
  let mvarsExpr ← args[0]?
  guard (mvarsExpr.isNatLit)
  guard (mvarsExpr.natLit! = 0)

  -- second argument should be a concrete value, extract it
  let widthExpr ← args[1]?
  let width ← concrete? widthExpr
  pure <| fun w => .bitvec <| width w

def Lean.Expr.isListLit (e : Expr) : Bool :=
  e.isAppOf ``List.nil || e.isAppOf ``List.cons

def concreteToCliType? (e : Expr) : Option CliType := do
  guard <| e.isAppOfArity ``ConcreteOrMVar.concrete 3
  -- It should be possible to ensure the array accesses from the guard above
  let args := e.getAppArgs

  -- first argument sholud be Nat
  let mvarsExpr ← args[0]?
  guard (mvarsExpr.isConstOf `Nat)

  -- second argument sholud be 0
  let mvarsExpr ← args[1]?
  guard (mvarsExpr.isNatLit)
  guard (mvarsExpr.natLit! = 0)

  -- third argument is value, either literal or bound variable
  let widthExpr ← args[2]?
  if widthExpr.isBVar then
    some <| .varw
  else if widthExpr.isNatLit then
    some <| .width (widthExpr.natLit!)
  else
    none

def mtyToCliType? (e : Expr) : Option CliType := do
  guard <| e.isAppOfArity ``InstCombine.MTy.bitvec 2
  -- It should be possible to ensure the array accesses from the guard above
  let args := e.getAppArgs

  -- first argument sholud be 0, otherwise it still has metavars
  let mvarsExpr ← args[0]?
  guard (mvarsExpr.isNatLit)
  guard (mvarsExpr.natLit! = 0)

  -- second argument should be a concrete value, extract it
  let widthExpr ← args[1]?
  concreteToCliType? widthExpr

-- panic versions
def concrete!  (e : Expr) : Nat → ConcreteOrMVar ℕ 0 := concrete? e |>.get!
def mty! (e : Expr) : Nat → InstCombine.MTy 0 := mty? e |>.get!
def concreteToCliType!  (e : Expr) : CliType := concreteToCliType? e |>.get!
def mtyToCliType! (e : Expr) : CliType := mtyToCliType? e |>.get!

def comToCliSignature (e : Expr) : MetaM CliSignature := do
  guard <| e.isAppOfArity ``Com 5
  let args := (Expr.getAppArgs e)
  let llvmArgTys := args[3]!
  let llvmRetTy := args[4]!
  guard llvmArgTys.isListLit
  let (_,llvmArgsExprs) := llvmArgTys.listLit?.get!
  let llvmArgs? := llvmArgsExprs.mapM mtyToCliType?
  let llvmRetTy? := mtyToCliType? llvmRetTy
  match llvmArgs?, llvmRetTy? with
    | .some args, some returnTy => return { args := args, returnTy := returnTy }
    | _, _ => throw <| Exception.error default "unable to convert signature"

def getSignature (ty0 : Expr) : MetaM CliSignature := do
  match ty0 with
  | .forallE _ t ty1 _ =>
    -- Ensure it is the correct type of Expr
    guard <| t.isConstOf `Nat
    comToCliSignature ty1
  | (.app _ _) =>
    comToCliSignature ty0
  |_ => throw <| Exception.error default "unable to convert signature (unsupported term pattern)"

instance : Quote CliType where
  quote ty := match ty with
    | .width n => Syntax.mkCApp ``CliType.width #[(quote n)]
    | .varw => mkCIdent ``CliType.varw

instance : Quote CliSignature where
  quote sig :=
    let args : Term := quote sig.args
    Syntax.mkCApp ``CliSignature.mk #[args, (quote sig.returnTy)]

-- There should be a typeclass or something for this, but I don't know
-- which one it is.
def CliType.reflect : CliType → Lean.Expr
  | .width n => .app (Lean.mkConst `CliType.width) (mkLit <| .natVal n)
  | .varw => Lean.mkConst `CliType.varw
def CliType.listReflect : List CliType → Lean.Expr
  | [] => .app (.const `List.nil [levelZero]) (Lean.mkConst `CliType)
  | ty::tys => mkApp3 (.const `List.cons [levelZero]) (Lean.mkConst `CliType)
      ty.reflect (listReflect tys)

def CliSignature.reflect : CliSignature → Lean.Expr
  | sig =>
    let args := CliType.listReflect sig.args
    mkApp2 (Lean.mkConst `CliSignature.mk) args sig.returnTy.reflect

elab "#printSignature" ssaTerm:ident : command => liftTermElabM do
  let e : Environment ← getEnv
  let names ← resolveGlobalConstWithInfos ssaTerm
  for name in names do
    let defn :=
      Option.get! <| Environment.find? e name
    let ty0 ← reduceAll (← inferType defn.value!)
    let sig ← getSignature ty0
    logInfo m!"signature {name}: {toString sig}"
  return ()

elab "getSignature!" ssaTerm:term : term => do
  let e ← Term.elabTerm ssaTerm none
  let ty0 ← reduceAll (← inferType e)
  let sig ← getSignature ty0
  return sig.reflect
