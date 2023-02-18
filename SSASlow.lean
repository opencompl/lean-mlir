import Mathlib.Data.Int.Basic
import Mathlib.Data.Int.Lemmas
open Mathlib
open Std 
open Int
open Nat

namespace AST


/-
Kinds of values. We must have 'pair' to take multiple arguments.
-/
inductive Kind where
| int : Kind
| nat: Kind 
| float : Kind
| tensor1d: Kind
| tensor2d: Kind
| pair : Kind -> Kind -> Kind
| unit: Kind
deriving Inhabited, DecidableEq, BEq

instance : ToString Kind where
  toString k := 
    let rec go : Kind →String  
    | .int => "int"
    | .nat => "nat"
    | .float => "float"
    | .unit => "unit"
    | .tensor1d => "tensor1d"
    | .tensor2d => "tensor2d"
    | .pair p q => s!"({go p}, {go q})"
    go k

-- A binding of 'name' with kind 'Kind'
structure Var where
  name : String
  kind : Kind
deriving Inhabited, DecidableEq, BEq

instance : ToString Var where 
  toString x := "%" ++ x.name ++ ":" ++ toString x.kind 

@[match_pattern]
def Var.unit : Var := { name := "_", kind := .unit }

-- compile time constant values.
inductive Const where
| int: Int → Const
| float: Float → Const 
| unit: Const
| pair: Const → Const → Const
deriving BEq 

instance : ToString Const where
  toString :=
    let rec go : Const → String  
    | .int i => toString i
    | .float f => toString f
    | .unit => "()"
    | .pair p q => s!"({go p}, {go q})"
    go

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
   (arg : List Var)
   (regions : Expr .Rs)
   (const: List Const): Expr .O -- '%ret:retty = 'name'(%var:varty) [regions*] {const}'
| tuple (ret: String) (a1 a2: Var): Expr .O -- %out = tuple (%v1, %v2)
| region (arg : List Var) (ops : Expr .Os): Expr .R -- '{ ^entry(arg:argty) ops* }'

abbrev Op := Expr .O
abbrev Region := Expr .R
abbrev Regions := Expr .Rs
abbrev Ops := Expr .Os

def Op.mk (ret: Var := Var.unit)
  (name: String)
  (arg: Var := Var.unit)
  (regions := Expr.regionsnil)
  (const := Const.unit) : Op := Expr.op ret name [arg] regions [const]
-- Append an 'Op' to the end of the 'Ops' list.
def Ops.snoc: Ops → Op → Ops
| .opsone o, o' => .opscons o (.opsone o')
| .opscons o os, o' => .opscons o (Ops.snoc os o')

def Op.Ret : Op → Var
| .op ret _ _ _ _ => ret 
| .tuple retname arg1 arg2 => 
   { name := retname,
     kind := .pair arg1.kind arg2.kind : Var}

def Regions.isEmpty: Regions → Bool
| .regionsnil => True
| .regionscons _ _ => False


def Expr.format : Expr k → Format 
| .opsone o => o.format
| .opscons o os => o.format ++ .line ++ os.format
| .regionsnil => Format.nil
| .regionscons r rs => r.format ++ .line ++ rs.format
| .op ret name arg rs const => 
    let constfmt : Format := 
      if const == [] then ""
      else "{" ++ toString const ++ "}"
    let argfmt : Format :=
      if arg == [] then ""
      else "(" ++ toString arg ++ ")"
    let rsfmt : Format := 
      if Regions.isEmpty rs then ""
      else (Format.nest 1 <| "[" ++ .line ++ Expr.format rs) ++ "]"
    .text (toString ret ++ " = " ++ name) ++ 
    argfmt ++ rsfmt ++ constfmt
| .tuple ret a1 a2 => 
    .text <|
      "%" ++ toString ret ++ " = " ++ 
      "(" ++ toString a1 ++ ", " ++ toString a2 ++ ")"
| .region arg ops => 
    let argfmt : Format :=
    if arg == [] then "" else "^(" ++ toString arg ++ ")"
    "{" ++ argfmt ++ 
      Format.nest 2 (.line ++ ops.format) ++ .line ++ "}"
instance ⦃k: OR⦄: ToFormat (Expr k) where
  format := Expr.format

instance : ToString (Expr k) where
   toString := Format.pretty ∘ format



-- Lean type that corresponds to kind.
@[reducible, simp]
def Kind.eval: Kind -> Type
| .int => Int
| .nat => Nat
| .unit => Unit
| .float => Float
| .tensor1d => Nat → Int
| .tensor2d => Nat → Nat → Int  
| .pair p q => p.eval × q.eval

end AST

section Semantics
open AST

-- A kind and a value of that kind.
structure Val where
  kind: Kind
  val: kind.eval

instance : BEq Val where
  beq a b := 
    let rec go a b := 
    match a, b with
    | {kind := .int, val := a}, {kind := .int, val := b} => a == b
    | {kind := .float, val := a}, {kind := .float, val := b} => a == b
    | {kind := .unit, val := a}, {kind := .unit, val := b} => a == b
    | {kind := .pair p q, val := ⟨a, a'⟩}, {kind := .pair r s, val := ⟨b, b'⟩ } => 
      go ⟨p, a⟩ ⟨r, b⟩ && go ⟨q, a'⟩ ⟨s, b'⟩
    | _, _ => False
    go a b
 
def Val.unit : Val := { kind := Kind.unit, val := () }

def Val.toString (v: Val): String :=
  match v  with
  | { kind := .nat, val := v} => "nat"
  | { kind := .tensor2d, val := v} => "tensor2d"
  | { kind := .tensor1d, val := _ } => "<tensor1d.val>"
  | {kind := .int, val := val } => 
      let S : ToString Int := inferInstance
      S.toString val
  | {kind := .float, val := val } => 
      let S : ToString Float := inferInstance
      S.toString val
  | {kind := .unit, val := () } => "()"
  | {kind := .pair p q, val := (x, y) } => 
      let xstr := Val.toString ({ kind := p, val := x})
      let ystr := Val.toString { kind := q, val := y}
      s!"({xstr}, {ystr})"

instance : ToString Val where
  toString := Val.toString

-- The retun value of an SSA operation, with a name, kind, and value of that kind.
structure NamedVal extends Val where
  name : String  
deriving BEq

def NamedVal.toString (nv: NamedVal): String :=
 s!"{nv.name} := {Val.toString nv.toVal}"


instance : ToString NamedVal where
  toString := NamedVal.toString

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

inductive OpM (a: Type) where 
| Ret: a →OpM a
| Get: Var → (NamedVal → OpM a) → OpM a
| Set: (v: NamedVal) → (rest: OpM a) → OpM a   
-- | RunRegion: (List Val → OpM a) → OpM a
| Error: String → OpM a 

def OpM.bind: OpM α → (α → OpM β) → OpM β
| .Ret a, f => f a
| .Error s, _f => .Error s
| .Get v k, f => .Get v (fun w => (k w).bind f)
| .Set v rest, f => .Set v (rest.bind f)
-- | .RunRegion g args, f=> .RunRegion (fun a => (g a).bind f) args

instance : Monad OpM where
  pure := .Ret
  bind := OpM.bind

abbrev ErrorKind := String
abbrev TopM (α : Type) : Type := StateT Env (Except ErrorKind) α


def Env.set (var: Var) (val: var.kind.eval): Env → Env
| env => (.cons var val env)

def Env.get (var: Var): Env → Except ErrorKind NamedVal 
| .empty => Except.error s!"unknown var {var.name}"
| .cons var' val env' => 
    if H : var = var'
    then pure <| var.toNamedVal (H ▸ val) 
    else env'.get var 

def TopM.get (var: Var): TopM NamedVal := do 
  let e ← StateT.get 
  Env.get var e
def OpM.get (var: Var): OpM NamedVal := OpM.Get var pure

def TopM.set (nv: NamedVal)  (k: TopM α): TopM α := do 
  let e ← StateT.get
  let e' := Env.set nv.var nv.val e
  StateT.set e'
  let out ← k
  StateT.set e 
  return out 
def OpM.set (nv: NamedVal)  (k: OpM α): OpM α := OpM.Set nv k
def OpM.set' (nv: NamedVal) : OpM Unit := OpM.Set nv (pure ())

def TopM.error (e: ErrorKind) : TopM α := Except.error e
def OpM.error (e: ErrorKind): OpM α := OpM.Error e

def OpM.toTopM: OpM a → TopM a
| OpM.Ret a => return a
| OpM.Error e => TopM.error e
| OpM.Get var k => do 
    let out ← TopM.get var
    (k out).toTopM 
| OpM.Set nv rest => do
   TopM.set nv (rest.toTopM)
-- | OpM.RunRegion k args =>  (k args).toTopM

def Val.cast (val: Val) (t: Kind): OpM t.eval :=
  if H : val.kind = t
  then pure (H ▸ val.val)
  else OpM.error s!"mismatched type {val.kind} ≠ {t}"

-- Runtime denotation of an Op, that has evaluated its arguments,
-- and expects a return value of type ⟦retkind⟧ 
inductive Op' where
| mk
  (name : String)
  (argval : List Val)
  (regions: List (List Val → OpM NamedVal))
  (const: List Const)

def Op'.name: Op' → String 
| .mk name argval regions const => name 

def Op'.argval: Op' → List Val 
| .mk name argval regions const => argval

def Op'.regions: Op' → List (List Val → OpM NamedVal) 
| .mk name argval regions const => regions

def Op'.const: Op' → List Const 
| .mk name argval regions const => const



instance : ToString Op' where
  toString x := 
    x.name ++ "(" ++ toString x.argval ++ ")" ++
    " [" ++ "#" ++ toString x.regions.length ++ "]" ++
    " {" ++ toString x.const ++ "}"

@[reducible]
def AST.OR.denoteType: OR -> Type
| .O => OpM NamedVal
| .Os => OpM NamedVal
| .R => List Val → OpM NamedVal
| .Rs => List (List Val → OpM NamedVal) -- TODO: is 'List' here correct?


def AST.Expr.denote {kind: OR}
 (sem: (o: Op') → OpM Val): Expr kind → kind.denoteType 
| .opsone o => AST.Expr.denote (kind := .O) sem o
| .opscons o os => do
    let retv ← AST.Expr.denote (kind := .O) sem o
    OpM.set retv (os.denote sem)
| .regionsnil => []
| .regionscons r rs => r.denote sem :: (rs.denote sem)
| .tuple ret arg1 arg2 => do
   let val1 ←OpM.get arg1
   let val2 ← OpM.get arg2
   return { name := ret,
            kind := .pair val1.kind val2.kind,
            val := (val1.val, val2.val)
          } -- build a pair
| .op ret name args rs const => do 
    let vals ← args.mapM OpM.get
    let op' : Op' := .mk
      name
      (vals.map NamedVal.toVal)
      (rs.denote sem)
      const
    let out ← sem op'
    if ret.kind = out.kind
    then return { name := ret.name,  kind := out.kind, val := out.val : NamedVal }
    else OpM.error "unexpected return kind '{}', expected {}"
    -- return ret.toNamedVal out
| .region args ops => fun vals => do
    -- TODO: improve dependent typing here
    -- let val' ← val.cast arg.kind
    -- OpM.set (arg.toNamedVal val') (ops.denote sem)
    for argval in (args.zip vals) do
      let arg := argval.fst
      let val := argval.snd
      OpM.set' { name := arg.name, kind := val.kind, val := val.val}
    ops.denote sem

def runRegion (sem : (o: Op') → OpM Val) (expr: AST.Expr .R)
(env :  Env := Env.empty)
(args : List Val := []) : Except ErrorKind (NamedVal × Env) := 
  (expr.denote sem args).toTopM.run env


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

syntax sepBy1(ident, "×") :dsl_kind
syntax "%"ident ":" dsl_kind : dsl_var
syntax dsl_var "="
      str
      ("(" dsl_var ")")?
      ("[" dsl_region,* "]")?
      ("{" dsl_const "}")? ";": dsl_op
syntax "%" ident "="  "(" dsl_var "," dsl_var ")" ";": dsl_op
syntax num : dsl_const 
syntax "{" ("^(" dsl_var "):")?  dsl_op dsl_op*  "}" : dsl_region
syntax "[dsl_op|" dsl_op "]" : term 
syntax "[dsl_ops|" dsl_op dsl_op* "]" : term 
syntax "[dsl_region|" dsl_region "]" : term 
syntax "[dsl_var|" dsl_var "]" : term
syntax "[dsl_kind|" dsl_kind "]" : term
syntax "[dsl_const|" dsl_const "]" : term 


@[simp]
def AST.Ops.fromList: Op → List Op → Ops
| op, [] => .opsone op
| op, op'::ops => .opscons op (AST.Ops.fromList op' ops)

@[simp]
def AST.Regions.fromList: List Region → Regions
| [] => .regionsnil
| r :: rs => .regionscons r (AST.Regions.fromList rs)

open Lean Macro in 
def parseKind (k: TSyntax `ident) : MacroM (TSyntax `term) := 
  match k.getId.toString with 
  | "int" => `(AST.Kind.int)
  | unk => (Macro.throwErrorAt k s!"unknown kind '{unk}'")


open Lean Macro in 
macro_rules
| `([dsl_kind| $[ $ks ]×* ]) => do
    if ks.isEmpty 
    then `(AST.Kind.unit)
    else 
      let mut out ← parseKind ks[0]!
      for k in ks.pop do
        let cur ← parseKind k
        out ← `(AST.Kind.pair $out $cur) 
      return out

macro_rules
| `([dsl_var| %$name:ident : $kind:dsl_kind]) => do 
    `({ name := $(Lean.quote name.getId.toString),
        kind := [dsl_kind| $kind] : Var})

macro_rules
| `([dsl_ops| $op $ops*]) => do 
   let op_term ← `([dsl_op| $op])
   let ops_term ← ops.mapM (fun op => `([dsl_op| $op ]))
   `(AST.Ops.fromList $op_term [ $ops_term,* ])

macro_rules
| `([dsl_region| { $[ ^( $arg:dsl_var ): ]? $op $ops* } ]) => do
   let ops ← `([dsl_ops| $op $ops*]) 
   match arg with 
   | .none => `(Expr.region [] $ops)
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
      ;
      ]) => do
      let res_term ← `([dsl_var| $res])
      let arg_term ← match arg with 
          | .some arg => `([dsl_var| $arg])
          | .none => `(AST.Var.unit)
      let name_term := Lean.quote name.getString
      let rgns_term ← match rgns with
        | .none => `(.regionsnil)
        | .some rgns => 
           let rgns ← rgns.getElems.mapM (fun stx => `([dsl_region| $stx]))
           `(AST.Regions.fromList [ $rgns,* ])
      let const_term ←
        match const with
        | .none => `(Const.unit)
        | .some c => `([dsl_const| $c])
      `(Expr.op $res_term $name_term [$arg_term] $rgns_term [$const_term])

macro_rules
| `([dsl_op| %$res:ident = ( $arg1:dsl_var , $arg2:dsl_var) ; ]) => do
    let res_term := Lean.quote res.getId.toString
    let arg1_term ← `([dsl_var| $arg1 ])
    let arg2_term ← `([dsl_var| $arg2 ])
    `(Expr.tuple $res_term $arg1_term $arg2_term)

def eg_kind_int := [dsl_kind| int]
#reduce eg_kind_int

def eg_var : AST.Var := [dsl_var| %y : int]
#reduce eg_var
end DSL

 /-
  (name : String)
  (argval : Val)
  (regions: List (Val → TopM NamedVal))
  (const: Const)
  (retkind: Kind): Op'
-/

namespace Arith

def sem: (o: Op') → OpM Val
| .mk "constant" [] _ [(.int x)]  => return ⟨.int, x⟩
| .mk "float" [] _ [(.float x)] => return ⟨.float, x+1⟩
| .mk "float2" [⟨.float, x⟩] _ [] => return ⟨.float, x + x⟩
| .mk "int2" [⟨.int, x⟩] _ [] => return ⟨.int, x + x⟩
| .mk "nat2" [⟨.nat, x⟩] _ [] => return ⟨.nat, x + x⟩
| .mk "add" [⟨.int, x⟩, ⟨.int, y⟩]  _ []  => 
      return ⟨.int, (x + y)⟩
| .mk "sub" [⟨.int, x⟩, ⟨.int, y⟩] _ [] => 
      return ⟨.int, (x - y)⟩
| .mk "tensor1d" [⟨.tensor1d, t⟩, ⟨.nat, ix⟩] [] [] => 
    return ⟨.int, (t 0 + t 1 + t ix)⟩
| .mk "pair" [⟨.pair .int .nat, ⟨x, y⟩⟩] _ _ => return ⟨.nat, y⟩ 
| .mk "tensor2d" [⟨.tensor2d, t⟩, ⟨.int, i⟩, ⟨.nat, j⟩] [] [] => 
    let i := t 0 0
    let j := t 1 1
    return ⟨.int, i + i⟩
| op => OpM.error s!"unknown op: {op}"

open AST in 
def eg_region_sub : Region :=
 [dsl_region| {
   %one : int = "constant" {1};
   %two : int = "constant" {2};
   %t = (%one : int , %two : int);
   %x : int = "sub"(%t : int × int);
 }]
#reduce eg_region_sub

open AST in 
theorem Fail: runRegion sem eg_region_sub   = .ok output  := by {
  simp[eg_region_sub];
  -- ERROR: failed to generate equality theorems for `match` expression `Arith.sem.match_1`
  simp[sem]; -- SLOW, but not timeout level slow
  simp[runRegion];
  simp[StateT.run]
  simp[Expr.denote];
  simp[bind];
  simp[StateT.bind];
}

end Arith


def main : IO Unit := return ()