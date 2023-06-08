import SSA.Core.Framework
import Mathlib.Data.Option.Basic
import Mathlib.Data.List.AList

/-- Typeclass for a `baseType` which is a Gödel code of
Lean types. -/
class Goedel (β : Type) : Type 1 where
  toType : β → Type
open Goedel /- make toType publically visible in module. -/

notation "⟦" x "⟧" => Goedel.toType x

instance : Goedel Unit where toType := fun _ => Unit

namespace SSA

/-- A `UserType` is a type of user-defined values in `SSA` programs.
    The main objective of `UserType` is to be able to have decidability
    properties, like decidable equality, for the restricted set of types
    in the user-defined semantics, since Lean's `Type` does not have these
    properties. -/
inductive UserType (β : Type) : Type where
  | base : β → UserType β
  | pair : UserType β → UserType β → UserType β
  | triple : UserType β → UserType β → UserType β → UserType β
  | unit : UserType β
  | region : UserType β → UserType β → UserType β
  deriving DecidableEq

namespace UserType

instance: Inhabited (UserType β) where default := UserType.unit

@[reducible]
def toType [Goedel β] : UserType β → Type
  | .base t =>  ⟦t⟧
  | .pair k₁ k₂ => (toType k₁) × (toType k₂)
  | .triple k₁ k₂ k₃ => toType k₁ × toType k₂ × toType k₃
  | .unit => Unit
  | .region k₁ k₂ => toType k₁ →toType k₂

instance [Goedel β] : Goedel (UserType β) where
  toType := toType

def mkPair [Goedel β] {k₁ k₂ : UserType β}: ⟦k₁⟧ → ⟦k₂⟧ → ⟦k₁.pair k₂⟧
  | k₁, k₂ => (k₁, k₂)

def mkTriple [Goedel β] {k₁ k₂ k₃ : UserType β}: ⟦k₁⟧ → ⟦k₂⟧ → ⟦k₃⟧ → ⟦k₁.triple k₂ k₃⟧
  | k₁, k₂, k₃ => (k₁, k₂, k₃)

def fstPair [Goedel β] {k₁ k₂ : UserType β} : ⟦k₁.pair k₂⟧ → ⟦k₁⟧
  | (k₁, _) => k₁

def sndPair [Goedel β] {k₁ k₂ : UserType β} : ⟦k₁.pair k₂⟧ → ⟦k₂⟧
  | (_, k₂) => k₂

def fstTriple [Goedel β] {k₁ k₂ k₃ : UserType β} : ⟦k₁.triple k₂ k₃⟧ → ⟦k₁⟧
  | (k₁, _, _) => k₁

def sndTriple [Goedel β] {k₁ k₂ k₃ : UserType β} : ⟦k₁.triple k₂ k₃⟧ → ⟦k₂⟧
  | (_, k₂, _) => k₂

def trdTriple [Goedel β] {k₁ k₂ k₃ : UserType β} : ⟦k₁.triple k₂ k₃⟧ → ⟦k₃⟧
  | (_, _, k₃) => k₃

end UserType



/-- Typeclass for a user semantics of `Op`, with base type `β`.
    The type β has to implement the `Goedel` typeclass, mapping into `Lean` types.
    This typeclass has several arguments that have to be defined to give semantics to
    the operations of type `Op`:
    * `argUserType` and `outUserType`, functions of type `Op → UserType β`, give the type of the
      arguments and the output of the operation.
    * `rgnDom` and `rgnCod`, functions of type `Op → UserType β`, give the type of the
      domain and codomain of regions within the operation.
    * `eval` gives the actual evaluation semantics of the operation, by defining a function for
      every operation `o : Op` of type `toType (argUserType o) → (toType (rgnDom o) → toType (rgnCod o)) → toType (outUserType o)`.
-/
class OperationTypes (Op : Type) (β : outParam Type) where
  argUserType : Op → UserType β
  rgnDom : Op → UserType β
  rgnCod : Op → UserType β
  outUserType : Op → UserType β

class TypedUserSemantics (Op : Type) (β : outParam Type) [Goedel β] extends OperationTypes Op β where
  eval : ∀ (o : Op), toType (argUserType o) → (toType (rgnDom o) →
    toType (rgnCod o)) → toType (outUserType o)

inductive Context (β : Type) : Type
  | empty : Context β
  | snoc : Context β → Var → (UserType β) → Context β

inductive Context.Var {β : Type} : (Γ : Context β) → UserType β → Type
  | prev {Γ : Context β} :
      Context.Var Γ a → Context.Var (Context.snoc Γ v' a') a
  | last {Γ : Context β} {v : SSA.Var} {a : UserType β} :
      Context.Var (Context.snoc Γ v a) a

instance {α : Type} : EmptyCollection (Context α) :=
  ⟨Context.empty⟩

def EnvC [Goedel β] (c : Context β)  :=
  ∀ ⦃a : UserType β⦄, c.Var a → ⟦a⟧

def Context.Var.emptyElim {β : Type} {a : UserType β} 
  (v : Context.Var Context.empty a) : P := by {
    cases v;
}

def EnvC.empty [Goedel β] : EnvC (Context.empty (β := β)) :=
  fun _a v => v.emptyElim

inductive TSSAIndex (β : Type) : Type
/-- LHS := RHS. LHS is a `Var` and RHS is an `SSA Op .EXPR` -/
| STMT : Context β → TSSAIndex β
/-- Ways of making an RHS -/
| EXPR : UserType β → TSSAIndex β
/-- The final instruction in a region. Must be a return -/
| TERMINATOR : UserType β → TSSAIndex β
/-- a lambda -/
| REGION : UserType β → UserType β → TSSAIndex β

@[simp]
def TSSAIndex.eval [Goedel β] : TSSAIndex β → Type
  | .STMT Γ => EnvC Γ
  | .EXPR T => toType T
  | .TERMINATOR T => toType T
  | .REGION dom cod => toType dom → toType cod

open OperationTypes UserType

inductive TSSA (Op : Type) {β : Type} [Goedel β] [OperationTypes Op β] :
    (Γ : Context β) → TSSAIndex β → Type where
  /-- lhs := rhs; rest of the program -/
  | assign {T : UserType β}
      (rest : TSSA Op Γ (.STMT Γ'))
      (lhs : Var) (rhs : TSSA Op Γ' (.EXPR T)) : TSSA Op Γ (.STMT (Γ'.snoc lhs T))
  /-- build a unit value -/
  | unit : TSSA Op Γ (.EXPR .unit)
  /-- no operation. -/
  | nop : TSSA Op Γ (.STMT Γ)
  /-- above; ret v -/
  | ret (above : TSSA Op Γ (.STMT Γ')) (v : Γ'.Var T) : TSSA Op Γ  (.TERMINATOR T)
  /-- (fst, snd) -/
  | pair (fst : Γ.Var T₁) (snd : Γ.Var T₂) : TSSA Op Γ (.EXPR (.pair T₁ T₂))
  /-- (fst, snd, third) -/
  | triple (fst : Γ.Var T₁) (snd : Γ.Var T₂) (third : Γ.Var T₃) : TSSA Op Γ (.EXPR (.triple T₁ T₂ T₃))
  /-- op (arg) { rgn } rgn is an argument to the operation -/
  | op (o : Op) (arg : Γ.Var (argUserType o)) (rgn : TSSA Op Context.empty (.REGION (rgnDom o) (rgnCod o))) :
      TSSA Op Γ (.EXPR (outUserType o))
  /- fun arg => body -/
  | rgn (arg : Var) {dom cod : UserType β} (body : TSSA Op (Γ.snoc arg dom) (.TERMINATOR cod)) :
      TSSA Op Γ (.REGION dom cod)
  /- no function / non-existence of region. -/
  | rgn0 : TSSA Op Γ (.REGION unit unit)
  /- a region variable. --/
  | rgnvar (v : Γ.Var (.region T₁ T₂)) : TSSA Op Γ (.REGION T₁ T₂)
  /-- a variable. -/
  | var (v : Γ.Var T) : TSSA Op Γ (.EXPR T)

@[simp]
def TSSA.eval {Op β : Type} [Goedel β] [TUS : TypedUserSemantics Op β] :
  {Γ : Context β} → {i : TSSAIndex β} → TSSA Op Γ i → (e : EnvC Γ) → i.eval
| Γ, _, .assign rest lhs rhs => fun e T v =>
    match v with
    | Context.Var.prev v => rest.eval e v
    | Context.Var.last => rhs.eval (rest.eval e)
  | _, _, .nop => fun e => e
  | _, _, .ret above v => fun e => above.eval e v
  | _, _, .pair fst snd => fun e => mkPair (e fst) (e snd)
  | _, _, .triple fst snd third => fun e => mkTriple (e fst) (e snd) (e third)
  | _, _, TSSA.op o arg rg => fun e =>
    TypedUserSemantics.eval o (e arg) (rg.eval EnvC.empty)
  | _, _, .rgn _arg body => fun e arg =>
      body.eval (fun _ v =>
        match v with
        | Context.Var.prev v' => e v'
        | Context.Var.last => arg)
  | _, _, .rgn0 => fun _ => id
  | _, _, .rgnvar v => fun e => e v
  | _, _, .var v => fun e => e v
  | _, _, .unit => fun _ => ()

-- TODO: understand synthesization order.
class TypedUserSemanticsM (Op : Type) (β : outParam Type) (M : outParam (Type → Type)) [Goedel β] extends OperationTypes Op β where
  evalM (o : Op)
    (arg: UserType.toType (argUserType o))
    (rgn : UserType.toType (rgnDom o) → M (UserType.toType (rgnCod o))) : M (UserType.toType (outUserType o))

@[simp]
def TSSAIndex.evalM [Goedel β] (M : Type → Type): TSSAIndex β → Type
  | .STMT Γ => M (EnvC Γ)
  | .EXPR T => M (UserType.toType T)
  | .TERMINATOR T => M (UserType.toType T)
  | .REGION dom cod => UserType.toType dom → M (UserType.toType cod)



@[simp]
def TSSA.evalM {Op β : Type} {M : Type → Type} [Goedel β] [TUSM : TypedUserSemanticsM Op β M] [Monad M] :
  {Γ : Context β} → {i : TSSAIndex β} → TSSA Op Γ i → (e : EnvC Γ) → (i.evalM M)
  | Γ, _, .assign rest lhs rhs => fun e => do
    let e' ← rest.evalM e
    let rhsv ← rhs.evalM e'
    return fun T v => 
      match v with
      | Context.Var.prev v => e' v
      | Context.Var.last => rhsv
  | _, _, .nop => fun e => return e
  | _, _, .ret above v => fun e => do 
    let e' ← TSSA.evalM above e 
    return e' v
  | _, _, .pair fst snd => fun e => do 
    return mkPair (e fst) (e snd)
  | _, _, .triple fst snd third => fun e => do 
    return mkTriple (e fst) (e snd) (e third)
  | _, _, TSSA.op o arg rg => fun e => do 
    let rgv := rg.evalM EnvC.empty
    TypedUserSemanticsM.evalM o (e arg) rgv
  | _, _, .rgn _arg body => fun e arg => do
      body.evalM (fun _ v =>
        match v with
        | Context.Var.prev v' => e v'
        | Context.Var.last => arg)
  | _, _, .rgn0 => fun _ => fun x => return x
  -- TODO: this forces all uses of `rgnvar` to be pure. Rather, we should allow impure `rgnvar`.
  | _, _, .rgnvar v => fun e => fun x => return (e v x)
  | _, _, .var v => fun e => return (e v)
  | _, _, .unit => fun _ => return ()

-- We can recover the case with the TypeSemantics as an instance
def TypeSemantics : Type 1 :=
  ℕ → Type

inductive NatBaseType (TS : TypeSemantics) : Type
  | ofNat : ℕ → NatBaseType TS
deriving DecidableEq

instance : Goedel (NatBaseType TS) where toType :=
  fun n => match n with
    | .ofNat m => TS m

variable {TS : TypeSemantics}
abbrev NatUserType := UserType (NatBaseType TS)

end SSA

namespace EDSL2
open Lean Elab Macro


/-- syntax extension point for users. -/
declare_syntax_cat dsl_op2

scoped syntax "[dsl_op2|" dsl_op2 "]" : term
syntax dsl_var2 := "%v" num

/-- nonterminal for expresions. -/
declare_syntax_cat dsl_expr2
declare_syntax_cat dsl_region2


/-
This is a fancier syntax, which allows expressions in the
intermediate nodes. This is elaborated into SSA, with temporary
variable names.
-/
syntax dsl_var2 : dsl_expr2
scoped syntax "()" : dsl_expr2
scoped syntax "(" dsl_expr2 "," dsl_expr2 ")" : dsl_expr2
scoped syntax "(" dsl_expr2 "," dsl_expr2 "," dsl_expr2 ")" : dsl_expr2
scoped syntax "op:" dsl_op2 dsl_expr2 ("," dsl_region2)? : dsl_expr2 
syntax dsl_assign2 := dsl_var2 ":= " dsl_expr2 ";"
syntax dsl_bb2 := (dsl_assign2)* "return " dsl_expr2 

scoped syntax "{" dsl_var2 "=>" dsl_bb2 "}" : dsl_region2
scoped syntax "rgn2$(" term ")" : dsl_region2

structure SSAElabContext where
  vars : Array Nat -- list of variables, in order of occurrence
  
abbrev SSAElabM (α : Type) := StateT SSAElabContext MacroM α

def SSAElabContext.addVar (var : Nat) : SSAElabM Unit := do
  modify fun ctx => { ctx with vars := ctx.vars.push var }

/- generate a fresh variable for temporary use. -/
def SSAElabContext.freshSyntheticVar : SSAElabM Nat := do
  -- This is a hack. We assign fresh variables an index > 99999.
  -- Ideally, we should have two different scopes, one for
  -- user defined variables, and one for synthetic variables.
  let synthv := 9999 + (← get).vars.size 
  SSAElabContext.addVar synthv
  return synthv 

-- given an array [x, y, z], the index of 'z' is '0' (though its index is '2' in the array),
-- since we cound from the back.
def SSAElabContext.getIndex? (var : Nat) : SSAElabM (Option Nat) := do
  match (← get).vars.findIdx? (fun v => v == var) with
  | .some ixFromFront => return ((← get).vars.size - 1) - ixFromFront
  | .none => return none

/-- extract out the index (nat) of the dsl_var -/
def dslVarToIx : TSyntax ``dsl_var2 → MacroM Nat
| `(dsl_var2| %v $ix) => return ix.getNat
| stx => Macro.throwErrorAt stx s!"expected variable %v<n>, found {stx}"

/-- convert a de-bruijn into a intrinsically well typed context variable -/
def idxToContextVar : Nat → MacroM (TSyntax `term)
| 0 => `(SSA.Context.Var.last)
| n+1 => do `(SSA.Context.Var.prev $(← idxToContextVar n))

def elabStxVar : TSyntax ``EDSL2.dsl_var2 → SSAElabM (TSyntax `term)
| `(dsl_var2| %v $var) => do
  match ← SSAElabContext.getIndex? var.getNat with
  | .some ix => idxToContextVar ix
  | .none => Macro.throwErrorAt var s!"variable '{var}' not in scope"
| stx => Macro.throwErrorAt stx s!"expected variable, found {stx}"



structure ElabWithTemporaries (α : Type) where 
  temporaries : Array (TSyntax `term)
  val : α
deriving Inhabited 

def ElabWithTemporaries.of (val : α) : ElabWithTemporaries α where 
  temporaries := #[]
  val := val

def ElabWithTemporaries.fromTemporaries (temporaries : Array (TSyntax `term)) :
   ElabWithTemporaries Unit := { temporaries := temporaries, val := Unit.unit }

def composeStmts (fs : Array (TSyntax `term)) : SSAElabM (TSyntax `term) := do 
      let mut out ← `(id)
      for f in fs do
        out ← `($f ∘ $out)
      return out

def ElabWithTemporaries.composeStmts (e : ElabWithTemporaries α) : SSAElabM (TSyntax `term) :=
  EDSL2.composeStmts e.temporaries

-- returns the syntax to access a variable.
def ElabWithTemporaries.toAssign (e : ElabWithTemporaries (TSyntax `term))
  : SSAElabM (ElabWithTemporaries (TSyntax `term)) := do 
  let v : ℕ ← SSAElabContext.freshSyntheticVar
  let vstx : TSyntax `term ← idxToContextVar 0
  let assign : TSyntax `term ← `(fun prev => SSA.TSSA.assign prev $vstx $(e.val))
  return {
    temporaries := e.temporaries.push assign,
    val := vstx
  }

mutual
partial def elabRgn : TSyntax `dsl_region2 → SSAElabM (TSyntax `term)
| `(dsl_region2| rgn2$($v)) => return v
| `(dsl_region2| { $v:dsl_var2 => $bb:dsl_bb2 }) => do
  let velab := Lean.quote (← dslVarToIx v) -- natural number.
  SSAElabContext.addVar (← dslVarToIx v) -- add variable.
  let bb ← elabBB bb
  `(SSA.TSSA.rgn $velab $bb)
| _ => Macro.throwUnsupported

partial def elabAssign : TSyntax ``dsl_assign2 → SSAElabM (ElabWithTemporaries Unit)
| `(dsl_assign2| $v:dsl_var2 := $rhs:dsl_expr2 ;) => do
  let rhselab : ElabWithTemporaries (TSyntax `term) ← elabStxExpr rhs
  SSAElabContext.addVar (← dslVarToIx v) -- add variable.
  let velab := Lean.quote (← dslVarToIx v) -- natural number.
  let assign ← `(fun prev => SSA.TSSA.assign prev $velab $(rhselab.val))
  return { temporaries := rhselab.temporaries.push assign, val := Unit.unit }
| _ => Macro.throwUnsupported



-- TSSA.assign (TSSA.assign (TSSA.assign (TSSA.assign TSSA.nop) <s1data>) <s2data>) <s3data>)
-- s1 : (fun prev1 => SSA.assign (<prev1>) <s1data>)
-- s2 : (fun prev2 => SSA.assign (<prev2>) <s2data>)
-- s3 : (fun prev3 => SSA.assign (<prev3>) <s3data>)
-- fun x => s3 ( s2 (s1 x) )
-- (s3 ∘ (s2 ∘ (s1 ∘ id)))
partial def elabStmts (ss : Array (TSyntax `EDSL2.dsl_assign2)) : SSAElabM (ElabWithTemporaries Unit) := do
  let mut fs : Array (TSyntax `term) := #[]
  for s in ss do
    let selab : ElabWithTemporaries Unit ← elabAssign s
    fs := fs ++ selab.temporaries 
  return .fromTemporaries fs

partial def elabBB : TSyntax `EDSL2.dsl_bb2 → SSAElabM (TSyntax `term)
| `(dsl_bb2| $[ $ss:dsl_assign2 ]* return $rete:dsl_expr2) => do
    let selab : ElabWithTemporaries Unit ← elabStmts ss
    let retElab : ElabWithTemporaries (TSyntax `term) ← elabStxExpr rete
    let retv : ElabWithTemporaries (TSyntax `term) ← retElab.toAssign
    let selab ← composeStmts (selab.temporaries ++ retv.temporaries)
    `(SSA.TSSA.ret ($selab SSA.TSSA.nop) $(retv.val))
| _ => Macro.throwUnsupported

/-- insert intermediate let bindings to produce -/
-- partial def exprToVar : TSyntax ``dsl_expr2 → SSAElabM (TSyntax `term)

-- e → (stmts, e)
partial def elabStxExpr : TSyntax `dsl_expr2 → SSAElabM (ElabWithTemporaries (TSyntax `term))
| `(dsl_expr2| ()) => do
  return ElabWithTemporaries.of (← `(SSA.TSSA.unit))
| `(dsl_expr2| ($a, $b)) => do
    let aelab ← elabStxExpr a
    let belab ← elabStxExpr b
    return { 
        temporaries := aelab.temporaries ++ belab.temporaries,
        val := ← `(SSA.TSSA.pair $(aelab.val) $(belab.val))
      : ElabWithTemporaries _
    }
| `(dsl_expr2| ($a, $b, $c)) => do
  let aelab ← elabStxExpr a
  let belab ← elabStxExpr b
  let celab ← elabStxExpr c
  return {
      temporaries := aelab.temporaries ++ belab.temporaries ++ celab.temporaries,
      val := ← `(SSA.TSSA.triple $(aelab.val) $(belab.val) $(celab.val))
    : ElabWithTemporaries _
  }
| `(dsl_expr2| $v:dsl_var2) => do 
  return {
    temporaries := #[],
    val := ← elabStxVar v
    : ElabWithTemporaries _
  }
| `(dsl_expr2| op: $o:dsl_op2 $arg:dsl_expr2 $[, $r?:dsl_region2 ]? ) => do
  let argelab ← elabStxExpr arg
  let rgn ← match r? with
    | none => `(SSA.TSSA.rgn0)
    | some r => elabRgn r -- TODO: can a region affect stuff outside?
  let val ← `(SSA.TSSA.op [dsl_op2| $o] $(argelab.val) $rgn)
  return {
    temporaries := argelab.temporaries,
    val := val
  }
| _ => Macro.throwUnsupported
end

scoped syntax "[dsl_bb2|" dsl_bb2 "]" : term
macro_rules
| `([dsl_bb2| $bb:dsl_bb2]) => do
  let ctx : SSAElabContext := {  vars := #[] }
  let (outTerm, _outCtx) ← (elabBB bb).run ctx
  return outTerm

scoped syntax "[dsl_region2|" dsl_region2 "]" : term
macro_rules
| `([dsl_region2| $r:dsl_region2]) => do
  let ctx : SSAElabContext := {  vars := #[] }
  let (outTerm, _outCtx) ← (elabRgn r).run ctx
  return outTerm

end EDSL2

namespace EDSL
open Lean HashMap Macro


declare_syntax_cat dsl_region
declare_syntax_cat dsl_bb
declare_syntax_cat dsl_op
declare_syntax_cat dsl_expr
declare_syntax_cat dsl_stmt
declare_syntax_cat dsl_assign
-- declare_syntax_cat dsl_terminator
declare_syntax_cat dsl_var
declare_syntax_cat dsl_val
declare_syntax_cat dsl_rgnvar

-- ops are defined by someone else
scoped syntax "[dsl_op|" dsl_op "]" : term

-- DSL variables
scoped syntax "%v" num : dsl_var


scoped syntax "op:" dsl_op dsl_var ("," dsl_region)? : dsl_expr
scoped syntax "unit:"  : dsl_expr
scoped syntax "pair:"  dsl_var dsl_var : dsl_expr
scoped syntax "triple:"  dsl_var dsl_var dsl_var : dsl_expr
scoped syntax dsl_var : dsl_expr
scoped syntax dsl_var " := " dsl_expr : dsl_assign
scoped syntax sepBy(dsl_assign, ";") : dsl_stmt
-- | this sucks, it becomes super global.
-- scoped syntax "dsl_ret " dsl_var : dsl_terminator
scoped syntax "rgn{" dsl_var "=>" dsl_bb "}" : dsl_region
scoped syntax "^bb"  (dsl_stmt)?  "dsl_ret " dsl_var : dsl_bb

scoped syntax "rgn$(" term ")" : dsl_region

open Lean Elab Macro in

-- TODO: keep track of types of the variables, and use this to throw correct errors.

structure SSAElabContext where
  vars : Array Nat -- list of variables, in order of occurrence

abbrev SSAElabM (α : Type) := StateT SSAElabContext MacroM α

def SSAElabContext.addVar (var : Nat): SSAElabM Unit := do
  modify fun ctx => { ctx with vars := ctx.vars.push var }

-- given an array [x, y, z], the index of 'z' is '0' (though its index is '2' in the array),
-- since we cound from the back.
def SSAElabContext.getIndex? (var : Nat) : SSAElabM (Option Nat) := do
  match (← get).vars.findIdx? (fun v => v == var) with
  | .some ixFromFront => return ((← get).vars.size - 1) - ixFromFront
  | .none => return none

/-- extract out the index (nat) of the dsl_var -/
def dslVarToIx : TSyntax `dsl_var → MacroM Nat
| `(dsl_var| %v $ix) => return ix.getNat
| stx => Macro.throwErrorAt stx s!"expected variable %v<n>, found {stx}"

/-- convert a de-bruijn into a intrinsically well typed context variable -/
def idxToContextVar : Nat → MacroM (TSyntax `term)
| 0 => `(SSA.Context.Var.last)
| n+1 => do `(SSA.Context.Var.prev $(← idxToContextVar n))

def elabStxVar : TSyntax `dsl_var → SSAElabM (TSyntax `term)
| `(dsl_var| %v $var) => do
  match ← SSAElabContext.getIndex? var.getNat with
  | .some ix => idxToContextVar ix
  | .none => Macro.throwErrorAt var s!"variable '{var}' not in scope"
| stx => Macro.throwErrorAt stx s!"expected variable, found {stx}"


mutual
partial def elabRgn : TSyntax `dsl_region → SSAElabM (TSyntax `term)
| `(dsl_region| rgn$($v)) => return v
| `(dsl_region| rgn{ $v:dsl_var => $bb:dsl_bb }) => do
  let velab := Lean.quote (← dslVarToIx v) -- natural number.
  SSAElabContext.addVar (← dslVarToIx v) -- add variable.
  let bb ← elabBB bb
  `(SSA.TSSA.rgn $velab $bb)
| _ => Macro.throwUnsupported

partial def elabAssign : TSyntax `dsl_assign → SSAElabM (TSyntax `term)
| `(dsl_assign| $v:dsl_var := $e:dsl_expr) => do
  let e ← elabStxExpr e
  SSAElabContext.addVar (← dslVarToIx v) -- add variable.
  let velab := Lean.quote (← dslVarToIx v) -- natural number.
  `(fun prev => SSA.TSSA.assign prev $velab $e)
| _ => Macro.throwUnsupported


-- TSSA.assign (TSSA.assign (TSSA.assign (TSSA.assign TSSA.nop) <s1data>) <s2data>) <s3data>)
-- s1 : (fun prev1 => SSA.assign (<prev1>) <s1data>)
-- s2 : (fun prev2 => SSA.assign (<prev2>) <s2data>)
-- s3 : (fun prev3 => SSA.assign (<prev3>) <s3data>)
-- fun x => s3 ( s2 (s1 x) )
-- (s3 ∘ (s2 ∘ (s1 ∘ id)))
partial def elabStmt : TSyntax `dsl_stmt → SSAElabM (TSyntax `term)
| `(dsl_stmt| $ss:dsl_assign;*) => do
  let mut out ← `(id)
  for s in ss.getElems do
    let selab ← elabAssign s
    out ← `($selab ∘ $out)
  return out
| _ => Macro.throwUnsupported


partial def elabBB : TSyntax `dsl_bb → SSAElabM (TSyntax `term)
| `(dsl_bb| ^bb $[ $s?:dsl_stmt ]? dsl_ret $retv:dsl_var) => do
    let selab : Lean.Syntax ←
        match s? with
        | .none => `(fun x => x)
        | .some s => elabStmt s
    let retv ← elabStxVar retv
    `(SSA.TSSA.ret ($selab SSA.TSSA.nop) $retv)
| _ => Macro.throwUnsupported

partial def elabStxExpr : TSyntax `dsl_expr → SSAElabM (TSyntax `term)
| `(dsl_expr| unit:) => `(SSA.TSSA.unit)
| `(dsl_expr| pair: $a $b) => do
    let aelab ← elabStxVar a
    let belab ← elabStxVar b
    `(SSA.TSSA.pair $aelab $belab)
| `(dsl_expr| triple: $a $b $c) => do
  let aelab ← elabStxVar a
  let belab ← elabStxVar b
  let celab ← elabStxVar c
  `(SSA.TSSA.triple $aelab $belab $celab)
| `(dsl_expr| $v:dsl_var) => elabStxVar v
| `(dsl_expr| op: $o:dsl_op $arg:dsl_var $[, $r? ]? ) => do
  let arg ← elabStxVar arg
  let rgn ← match r? with
    | none => `(SSA.TSSA.rgn0)
    | some r => elabRgn r -- TODO: can a region affect stuff outside?
  `(SSA.TSSA.op [dsl_op| $o] $arg $rgn)
| _ => Macro.throwUnsupported
end

scoped syntax "[dsl_bb|" dsl_bb "]" : term
macro_rules
| `([dsl_bb| $bb:dsl_bb]) => do
  let ctx : SSAElabContext := {  vars := #[] }
  let (outTerm, _outCtx) ← (elabBB bb).run ctx
  return outTerm

scoped syntax "[dsl_region|" dsl_region "]" : term
macro_rules
| `([dsl_region| $r:dsl_region]) => do
  let ctx : SSAElabContext := {  vars := #[] }
  let (outTerm, _outCtx) ← (elabRgn r).run ctx
  return outTerm

-- TODO: consider allowing users to build pieces of syntax.
-- scoped syntax "[dsl_expr|" dsl_expr "]" : term
-- scoped syntax "[dsl_stmt|" dsl_stmt "]" : term
-- scoped syntax "[dsl_terminator|" dsl_terminator "]" : term
-- scoped syntax "[dsl_val|" dsl_val "]" : term
-- scoped syntax "[dsl_assign| " dsl_assign "]" : term

end EDSL


register_simp_attr Bind.bind
register_simp_attr Option.bind
register_simp_attr TypedUserSemantics.eval
register_simp_attr TypedUserSemantics.argUserType
register_simp_attr TypedUserSemantics.outUserType
register_simp_attr TypedUserSemantics.regionDom
register_simp_attr TypedUserSemantics.regionCod
