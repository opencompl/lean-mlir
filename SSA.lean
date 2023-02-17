namespace AST

/-
Kinds of values. We must have 'pair' to take multiple arguments.
-/
inductive Kind where
| int : Kind
| float : Kind
| pair : Kind -> Kind -> Kind
| unit: Kind
deriving Inhabited, DecidableEq

instance : ToString Kind where
  toString k := 
    let rec go : Kind →String  
    | .int => "int"
    | .float => "float"
    | .unit => "unit"
    | .pair p q => s!"({go p}, {go q})"
    go k

-- A binding of 'name' with kind 'Kind'
structure Var where
  name : String
  kind : Kind
deriving Inhabited, DecidableEq 

def Var.unit : Var := { name := "<unit>", kind := .unit }

-- compile time constant values.
inductive Const where
| int: Int → Const
| float: Float → Const 
| unit: Const
| pair: Const → Const → Const

-- Tag for variants of Op/Region hybrid
inductive OR: Type
| O -- Single Op
| Os -- Multiple Ops
| R -- Single Region
| Rs -- Multiple Regions

-- Tagged expressiontrees
inductive Expr: OR -> Type where
| opsone: Expr .O -> Expr .Os -- terminator in a sequence of Ops
| opscons: Expr .O -> Expr .Os -> Expr .Os -- cons cell 'op :: ops'
| regionsnil : Expr .Rs -- empty sequence of regions
| regionscons: Expr .R -> Expr .Rs -> Expr .Rs -- cons cell 'region :: regions'
| op (ret : Var)
   (name : String)
   (arg : Var)
   (regions : Expr .Rs)
   (const: Const): Expr .O -- '%ret:retty = 'name'(%var:varty) [regions*] {const}'
| region (arg : Var) (ops : Expr .Os): Expr .R -- '{ ^entry(arg:argty) ops* }'

abbrev Op := Expr .O
abbrev Region := Expr .R
abbrev Ops := Expr .Os
  
def Op.Ret : Op → Var
| .op ret _ _ _ _ => ret  



-- Lean type that corresponds to kind.
@[reducible, simp]
def Kind.eval: Kind -> Type
| .int => Int
| .unit => Unit
| .float => Float
| .pair p q => p.eval × q.eval

end AST

section Semantics
open AST

-- A kind and a value of that kind.
structure Val where
  kind: Kind
  val: kind.eval

-- The retun value of an SSA operation, with a name, kind, and value of that kind.
structure NamedVal extends Val where
  name : String  

-- Given a 'Var' of kind 'kind', and a value of type 〚kind⟧, build a 'Val'
def AST.Var.toNamedVal (var: Var) (value: var.kind.eval): NamedVal := 
 { kind := var.kind, val := value, name := var.name }

def NamedVal.var (nv: NamedVal): Var :=
  { name := nv.name, kind := nv.kind }

-- Well typed environments; cons cells of
-- bindings of variables to values of type ⟦var.kind⟧
inductive Env where
| empty: Env
| cons (var: Var) (val: var.kind.eval) (rest: Env): Env 


abbrev ErrorKind := String
abbrev TopM α := ReaderT Env (Except ErrorKind) α

def Env.set (var: Var) (val: var.kind.eval): Env → Env
| env => (.cons var val env)

def Env.get (var: Var): Env → TopM var.kind.eval  
| .empty => Except.error s!"unknown var {var.name}"
| .cons var' val env' => 
    if H : var = var'
    then pure (H ▸ val) 
    else env'.get var 

def ReaderT.get [Monad m]: ReaderT ρ m ρ := fun x => pure x
def ReaderT.withEnv [Monad m] (f: ρ → ρ) (reader: ReaderT ρ m α): ReaderT ρ m α :=
  reader ∘ f 

def TopM.get (var: Var): TopM var.kind.eval := ReaderT.get >>= Env.get var
def TopM.set (nv: NamedVal)  (k: TopM α): TopM α := 
  ReaderT.withEnv (Env.set nv.var nv.val) k

def TopM.error (e: ErrorKind) : TopM α := Except.error e

def Val.cast (val: Val) (t: Kind): TopM t.eval :=
  if H : val.kind = t
  then pure (H ▸ val.val)
  else TopM.error s!"mismatched type {val.kind} ≠ {t}"

-- Runtime denotation of an Op, that has evaluated its arguments,
-- and expects a return value of type ⟦retkind⟧ 
structure Op' where
  name : String
  argval : Val := ⟨.unit, ()⟩
  regions: List (Val → TopM NamedVal) := []
  const: Const := .unit
  retkind: Kind 

@[reducible]
def AST.OR.denoteType: OR -> Type
| .O => TopM NamedVal
| .Os => TopM NamedVal
| .R => Val → TopM NamedVal
| .Rs => List (Val → TopM NamedVal) -- TODO: is 'List' here correct?


def AST.Expr.denote {kind: OR}
 (sem: (o: Op') → TopM (o.retkind.eval)): Expr kind → kind.denoteType 
| .opsone o => AST.Expr.denote (kind := .O) sem o
| .opscons o os => do
    let retv ← AST.Expr.denote (kind := .O) sem o
    TopM.set retv (os.denote sem)
| .regionsnil => []
| .regionscons r rs => r.denote sem :: (rs.denote sem)
| .op ret name arg rs const => do 
    let val ← TopM.get arg 
    let op' : Op' :=
      { name := name
      , argval := ⟨arg.kind, val⟩
      , regions := rs.denote sem
      , const := const
      , retkind := ret.kind }
    let out ← sem op'
    return ret.toNamedVal out
| .region arg ops => fun val => do
    -- TODO: improve dependent typing here
    let val' ← val.cast arg.kind
    TopM.set (arg.toNamedVal val') (ops.denote sem)
end Semantics

namespace DSL
open AST

declare_syntax_cat dsl_op
declare_syntax_cat dsl_type
declare_syntax_cat dsl_ops
declare_syntax_cat dsl_region
declare_syntax_cat dsl_var
declare_syntax_cat dsl_const
declare_syntax_cat dsl_kind

syntax sepBy1(ident, ",") :dsl_kind
syntax "%"ident ":" dsl_kind : dsl_var
syntax dsl_var "=" str ("(" dsl_var ")")? ("[" dsl_region,* "]")? ("{" dsl_const "}")? : dsl_op
syntax num : dsl_const 
syntax "{" ("^(" dsl_var "):")?  dsl_op dsl_op*  "}" : dsl_region
syntax "[dsl_op|" dsl_op "]" : term 
syntax "[dsl_region|" dsl_region "]" : term 
syntax "[dsl_var|" dsl_var "]" : term
syntax "[dsl_kind|" dsl_kind "]" : term
syntax "[dsl_const|" dsl_const "]" : term 


@[simp]
def AST.Ops.fromList: Op → List Op → Ops
| op, [] => .opsone op
| op, op'::ops => .opscons op (AST.Ops.fromList op' ops)


open Lean Macro in 
macro_rules
| `([dsl_kind| $[ $ks ],* ]) => do
    let mut out ← `(AST.Kind.unit)
    for k in ks do
      let cur ← match k.getId.toString with 
          | "int" => `(AST.Kind.int)
          | unk => (throwErrorAt k s!"unknown kind '{unk}'")
      out ← `(AST.Kind.pair $out $cur) 
    return out

macro_rules
| `([dsl_var| %$name:ident : $kind]) => do 
    `({ name := $(Lean.quote name.getId.toString),
        kind := `([dsl_kind| $kind]) : Var})

macro_rules
| `([dsl_region| { $[ ^( $arg:dsl_var ): ]? $op $ops* } ]) => do
   let op_term ← `([dsl_op| $op])
   let ops_term ← ops.mapM (fun op => `([dsl_op| $op ]))
   let ops ← `(AST.Ops.fromList $op_term [ $ops_term,* ])
   match arg with 
   | .none => `(Expr.region Var.unit $ops)
   | .some arg => do
      let arg_term ← `([dsl_var| $arg ])
      `(Expr.region $arg_term $ops)

macro_rules
| `([dsl_const| $x:num ]) => `(Const.int $x)

open Lean Syntax in 
macro_rules
| `([dsl_op| $res:dsl_var = $name:str
      $[ ( $arg:dsl_var ) ]?
      $[ [ $rgns,* ] ]? 
      $[ { $const } ]?
      ]) => do
      let res_term ← `([dsl_var| $res])
      let arg_term ← match arg with 
          | .some arg => `([dsl_var| $arg])
          | .none => `(AST.Var.unit)
      let name_term := Lean.quote name.getString
      let rgns_term ← match rgns with
        | .none => `([])
        | .some rgns => 
           let rgns ← rgns.getElems.mapM (fun stx => `([dsl_region| $stx]))
           `([ $rgns,* ])
      let const_term ←
        match const with
        | .none => `(Const.Unit)
        | .some c => `([dsl_const| $c])
      `(Expr.op $res_term $name_term $arg_term $rgns_term $const_term)


end DSL

namespace Arith
def sem: (o: Op') → TopM (o.retkind.eval)
| { name := "unit",
    retkind := .unit} => return () 
| { name := "constant",
    const := .int x,
    retkind := .int} => return x 
| { name := "add",
    retkind := .int,
    argval := ⟨.pair .int .int, (x, y)⟩ } => 
      return (x + y)
| { name := "sub",
    retkind := .int,
    argval := ⟨.pair .int .int, (x, y)⟩ } => 
      return (x - y)

| op => TopM.error s!"unknown op: {op.name}"
end Arith

def example1 : Region :=
 [dsl_region| {
   %one : int = "constant" {1}
   %two : int = "constant" {2}
 }]
namespace Scf
end Scf

def main : IO Unit := return ()