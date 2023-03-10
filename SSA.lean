import Mathlib.Tactic.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LibrarySearch
import Mathlib.Tactic.Cases
import Mathlib.Data.Quot
import Std.Data.Int.Basic

open Std

#check RBMap
namespace AST

/-
Kinds of values. We must have 'pair' to take multiple arguments.
TODO: Does it make sense to make this a typeclass?
-/
inductive Kind where
| int : Kind
| nat : Kind
| float : Kind
| pair : Kind -> Kind -> Kind
| unit: Kind
deriving Inhabited, DecidableEq, BEq

instance : ToString Kind where
  toString k :=
    let rec go : Kind →String
    | .nat => "nat"
    | .int => "int"
    | .float => "float"
    | .unit => "unit"
    | .pair p q => s!"({go p}, {go q})"
    go k

-- A binding of 'name' with kind 'Kind'
structure Var where
  name : String
  kind : Kind
deriving Inhabited, DecidableEq, BEq

instance : ToString Var where
  toString x := "%" ++ x.name ++ ":" ++ toString x.kind

abbrev Var.unit : Var := { name := "_", kind := .unit }

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

inductive OpName where
| arith.constant
| arith.add
| arith.sub
| arith.mul
| scf.if
| scf.for
| scf.twice
| scf.run
| unknown
deriving DecidableEq

instance : ToString OpName where
  toString
    | .arith.constant => "arith.constant"
    | .arith.add => "arith.add"
    | .arith.sub => "arith.sub"
    | .arith.mul => "arith.mul"
    | .scf.if => "scf.if"
    | .scf.for => "scf.for"
    | .scf.twice => "scf.twice"
    | .scf.run => "scf.run"
    | .unknown => "<unknown>"

@[simp]
def OpName.fromString : String -> OpName
  | "arith.constant" => OpName.arith.constant
  | "arith.add" => OpName.arith.add
  | "arith.sub" => OpName.arith.sub
  | "arith.mul" => OpName.arith.mul
  | "scf.if" => OpName.scf.if
  | "scf.for" => OpName.scf.for
  | "scf.twice" => OpName.scf.twice
  | "scf.run" => OpName.scf.run
  | _ => OpName.unknown

-- Tagged expressiontrees
inductive Expr: OR -> Type where
| opsone: Expr .O -> Expr .Os -- terminator in a sequence of Ops
| opscons: Expr .O -> Expr .Os -> Expr .Os -- cons cell 'op :: ops'
| regionsnil : Expr .Rs -- empty sequence of regions
| regionscons: Expr .R -> Expr .Rs -> Expr .Rs -- cons cell 'region :: regions'
| op (ret : Var)
   (name : OpName)
   (arg : Var)
   (regions : Expr .Rs)
   (const: Const): Expr .O -- '%ret:retty = 'name'(%var:varty) [regions*] {const}'
| tuple (ret: String) (a1 a2: Var): Expr .O -- %out = tuple (%v1, %v2)
| region (arg : Var) (ops : Expr .Os): Expr .R -- '{ ^entry(arg:argty) ops* }'

abbrev Op := Expr .O
abbrev Region := Expr .R
abbrev Regions := Expr .Rs
abbrev Ops := Expr .Os

abbrev Op.mk (ret: Var := Var.unit)
  (name: OpName)
  (arg: Var := Var.unit)
  (regions := Expr.regionsnil)
  (const := Const.unit): Op := Expr.op ret name arg regions const
-- Append an 'Op' to the end of the 'Ops' list.
def Ops.snoc: Ops → Op → Ops
| .opsone o, o' => .opscons o (.opsone o')
| .opscons o os, o' => .opscons o (Ops.snoc os o')

@[simp]
def Op.ret : Op → Var
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
      if const == .unit then ""
      else "{" ++ toString const ++ "}"
    let argfmt : Format :=
      if arg == Var.unit then ""
      else "(" ++ toString arg ++ ")"
    let rsfmt : Format :=
      if Regions.isEmpty rs then ""
      else (Format.nest 1 <| "[" ++ .line ++ Expr.format rs) ++ "]"
    .text (toString ret ++ " = " ++ toString name) ++
    argfmt ++ rsfmt ++ constfmt
| .tuple ret a1 a2 =>
    .text <|
      "%" ++ toString ret ++ " = " ++
      "(" ++ toString a1 ++ ", " ++ toString a2 ++ ")"
| .region arg ops =>
    let argfmt : Format :=
    if arg == Var.unit then "" else "^(" ++ toString arg ++ ")"
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
| .pair p q => p.eval × q.eval

instance Kind.bEqEval: (k : Kind) → BEq k.eval
| .int => inferInstanceAs (BEq Int)
| .nat => inferInstanceAs (BEq Nat)
| .unit => inferInstanceAs (BEq Unit)
| .float => inferInstanceAs (BEq Float)
| .pair p q => by
    letI : BEq p.eval := Kind.bEqEval _
    letI : BEq q.eval := Kind.bEqEval _
    infer_instance

def Kind.default (k: Kind): k.eval :=
  match k with
  | .int => 0
  | .nat => 0
  | .unit => ()
  | .float => 0.0
  | .pair p q => (p.default, q.default)

instance KindDefault (k: Kind) : Inhabited (k.eval) where
  default := Kind.default _

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
  | {kind := .nat, val := val } =>
      let S : ToString Nat := inferInstance
      S.toString val
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
@[simp]
def AST.Var.toNamedVal (var: Var) (value: var.kind.eval): NamedVal :=
 { kind := var.kind, val := value, name := var.name }

@[simp]
def NamedVal.var (nv: NamedVal): Var :=
  { name := nv.name, kind := nv.kind }

-- Well typed environments; cons cells of
-- bindings of variables to values of type ⟦var.kind⟧
inductive Env where
| empty: Env
| cons (var: Var) (val: var.kind.eval) (rest: Env): Env


-- truncation of a type that smashes everything into a single equivalence class.
inductive trunc (α: Type): α → α → Prop
| trunc: trunc α a a' -- smash everthing.

instance EquivalenceTrunc : Equivalence (trunc α) where
  refl _ := .trunc
  symm _  := .trunc
  trans _ _ := .trunc

instance SetoidTrunc (α : Type) : Setoid α where
   r := trunc α
   iseqv := EquivalenceTrunc

/-
The type of Error is computationally 'String', but logically just a point.
this allows us to ignore error states in proofs [they are all identified as equal],
while still allowing computationally relevant errors.
-/
abbrev ErrorKind : Type := Trunc String

/-
Cursed: We cast from 'ErrorKind' which is a quotient of 'String' into 'String'
since we know that these have the same RuntimeRep.
-/
unsafe def ErrorKind.toStringImpl (e: ErrorKind): String := unsafeCast e
@[implemented_by ErrorKind.toStringImpl]
partial def ErrorKind.toString (_: ErrorKind): String := "<<error>>"
instance : ToString ErrorKind where
  toString := ErrorKind.toString

abbrev ErrorKind.mk (s: String) : ErrorKind := Trunc.mk s

-- Coerce from regular strings into errors.
instance : Coe String ErrorKind where
  coe := ErrorKind.mk

@[simp]
def ErrorKind.subsingleton (e: ErrorKind) (e': ErrorKind): e = e' := by {
  apply Quotient.ind;
  intros a;
  apply Eq.symm;
  apply Quotient.ind;
  intros b;
  apply Quotient.sound;
  constructor;
}


-- Env → Except ErrorKind α
abbrev TopM (α : Type) : Type := ReaderT Env Id α

abbrev Env.set (var: Var) (val: var.kind.eval): Env → Env
| env => (.cons var val env)

-- We need to produce values of type '()' for eg. ops with zero agruments.
-- Here, we ensure that Env.get for a var of type 'Unit' will always succeed and return '()',
-- becuse there is not need not to. This allows us to use 'Unit' to signal zero arguments,
-- wthout have to make up a fake name for a variable of type 'Unit'
def Env.get (var: Var): Env → var.kind.eval
| .empty => match var.kind with
            | .unit =>  ()
            | _ =>  default
| .cons var' val env' =>
      if H : var = var'
      then (H ▸ val)
      else env'.get var

theorem Env.get_unit (name: String) (e: Env): e.get ⟨name, .unit⟩ = () :=
  match e with
  | .empty => by rfl
  | .cons var' val' env' =>
       if H :⟨name, .unit⟩ = var'
       then by {
        simp[get];
       }
       else by {
        simp[Env.get, H];
      }

theorem Env.get_set_eq (env: Env) (var: Var)  (val: var.kind.eval):
  (env.set var val).get var = val := by {
    induction env <;> simp[get, set, Env.set, Env.get, pure, Except.pure];
}


abbrev ReaderT.get [Monad m]: ReaderT ρ m ρ := fun x => pure x
abbrev ReaderT.withEnv [Monad m] (f: ρ → ρ) (reader: ReaderT ρ m α): ReaderT ρ m α :=
  reader ∘ f

def TopM.get (var: Var): TopM var.kind.eval := ReaderT.get >>= (fun _ => (Env.get var))

-- the unit type will always successfully return '()'
theorem TopM.get_unit (name: String) (env: Env): TopM.get ⟨name, .unit⟩ env = () := by {
  simp[get, ReaderT.get, bind, ReaderT.bind, Except.bind, pure, Except.pure];
}

def TopM.set (nv: NamedVal)  (k: TopM α): TopM α :=
  ReaderT.withEnv (Env.set nv.var nv.val) k

def Val.cast (val: Val) (t: Kind): t.eval :=
  if H : val.kind = t
  then .(H ▸ val.val)
  else default
-- Runtime values of arguments to an Op, This is the argument value,
-- the evaluated regions, and the constant.
structure Op' where
  argval : Val := ⟨.unit, ()⟩
  regions: List (Val → TopM Val) := []
  const: Const := .unit
  retkind: Kind

-- The single semantic unit, where the user provides the semantics
-- of a single op of a given 'name'.
structure Semantic where
  name: OpName
  run: (o : Op') → TopM o.retkind.eval


-- TODO: consider this design.
-- partial finitely supported function.
-- abbrev Semantics := (name: String) → Option (Semantic name)

inductive Semantics where
| nil
| cons: Semantic → Semantics → Semantics

@[simp]
def Semantics.append: Semantics → Semantics → Semantics
| .nil, sems => sems
| .cons sem sems, sems' => .cons sem (Semantics.append sems sems')

def Semantics.run: (name: OpName) → (o : Op') → Semantics → TopM o.retkind.eval
| oname, o, .nil => return default
| oname, o, .cons sem sems =>
    if oname = sem.name
    then sem.run o
    else Semantics.run oname o sems

theorem Semantics.run.eq
  {name: OpName}
  {o: Op'}
  {sems: Semantics}
  {sem: Semantic}
  (NAME_EQ: sem.name = name):
  Semantics.run name o (Semantics.cons sem sems) = sem.run o := by {
    simp[Semantics.run, Semantics.cons];
    intros H;
    simp[NAME_EQ] at H;
  }

theorem Semantics.run.neq
  {name: OpName}
  {o: Op'}
  {sems: Semantics}
  {sem: Semantic}
  (NAME_NEQ: sem.name ≠ name):
  Semantics.run name o (Semantics.cons sem sems) = sems.run name o := by {
    simp[Semantics.run, Semantics.cons];
    intros H;
    simp [H] at NAME_NEQ;
  }


instance : ToString Op' where
  toString x := "(" ++ toString x.argval ++ ")" ++
    " [" ++ "#" ++ toString x.regions.length ++ "]" ++
    " {" ++ toString x.const ++ "}" ++ " → " ++ toString x.retkind

@[reducible]
def AST.OR.denoteType: OR -> Type
| .O => TopM NamedVal
| .Os => TopM NamedVal
| .R => Val → TopM Val
| .Rs => List (Val → TopM Val) -- TODO: is 'List' here correct?


def AST.Expr.denote {kind: OR}
 (sem: Semantics): Expr kind → kind.denoteType
| .opsone o => AST.Expr.denote (kind := .O) sem o
| .opscons o os => do
    let retv ← AST.Expr.denote (kind := .O) sem o
    TopM.set retv (os.denote sem)
| .regionsnil => []
| .regionscons r rs => r.denote sem :: (rs.denote sem)
| .tuple ret arg1 arg2 => do
   let val1 ←TopM.get arg1
   let val2 ← TopM.get arg2
   return { name := ret,
            kind := .pair arg1.kind arg2.kind,
            val := (val1, val2)
          } -- build a pair
| .op ret name arg rs const => do
    let val ← TopM.get arg
    let op' : Op' :=
      { argval := ⟨arg.kind, val⟩
      , regions := rs.denote sem
      , const := const
      , retkind := ret.kind }
    let out ← sem.run name op'
    return ret.toNamedVal out
| .region arg ops => fun val => do
    -- TODO: improve dependent typing here
    let val' := val.cast arg.kind
    TopM.set (arg.toNamedVal val') (NamedVal.toVal <$> (ops.denote sem))


-- Write this separately for defEq purposes.
def Op'.fromOp (sem: Semantics)
  (ret: Var) (arg: Var) (argval: arg.kind.eval) (rs: Regions) (const: Const) : Op' :=
      { argval := ⟨arg.kind, argval⟩
      , regions := rs.denote sem
      , const := const
      , retkind := ret.kind
  }


def runRegion (sem : Semantics) (expr: AST.Expr .R)
(env :  Env := Env.empty)
(arg : Val := Val.unit) : Val :=
  (expr.denote sem arg).run env


theorem TopM_idempotent: ∀ (ma: TopM α) (k: α → α → TopM β),
 ma >>= (fun a => ma >>= (fun a' => k a a')) =
 ma >>= (fun a => k a a) := by {
  intros ma k;
  funext env;
  simp[ReaderT.bind];
  simp[bind];
  simp[ReaderT.bind];
}

theorem TopM_commutative: ∀ (ma: TopM α) (mb: TopM β) (k: α → β → TopM γ),
 ma >>= (fun a => mb >>= (fun b => k a b)) =
 mb >>= (fun b => ma >>= (fun a => k a b)) := by {
  intros ma mb k;
  funext env;
  simp[ReaderT.bind];
  simp[bind];
  simp[ReaderT.bind];
}

-- unfold Expr.denote for opscons
theorem Expr.denote_opscons:
  (Expr.opscons o os).denote sem =
    (o.denote sem >>= fun retv => TopM.set retv (os.denote sem)) := by { rfl; }

-- unfold Expr.denote for opsone
theorem Expr.denote_opsone:
  (Expr.opsone o).denote sem = o.denote sem := by { rfl; }

-- unfold Expr.denote for op
theorem Expr.denote_op:
  (Op.mk ret name arg rs const ).denote sem =
  TopM.get arg >>= fun val =>
    let op' : Op' := -- TODO: use Op'.fromOp
      { argval := ⟨arg.kind, val⟩
      , regions := rs.denote sem
      , const := const
      , retkind := ret.kind }
    sem.run name op' >>= fun out => fun env => ret.toNamedVal out
  := by { rfl; }

-- how to simply Expr.denote_op, assuming the environment lookup is correct.
theorem Expr.denote_op_success (ret: Var) (name: OpName) (arg: Var) (rs: Regions) (const: Const)
  (sem: Semantics)
  (env: Env)
  (argval: arg.kind.eval)
  (ARGVAL: env.get arg = argval)
  (outval : ret.kind.eval)
  (SEM: sem.run name (Op'.fromOp sem ret arg argval rs const) env = outval) :
  (Op.mk ret name arg rs const).denote sem env = (ret.toNamedVal outval)
  := by {
      rw[Expr.denote_op];
      simp[Op'.fromOp] at SEM;
      simp[Op'.fromOp, TopM.get, ReaderT.get, pure, bind, ReaderT.bind, Except.pure, Except.bind, ARGVAL, SEM];
      aesop
   }


-- 'opscons o os' @ env is the same as 'os @ (env[o.ret = o.val])'.
-- That is, if 'o' succeeds, the 'os' proceeds evaluation with 'env' which
-- has been updated for 'o.ret' with 'o.val'.
theorem Expr.denote_opscons_success_op (o: Op) (outval: (Op.ret o).kind.eval)
  (sem : Semantics) (env: Env)
  (OVAL: o.denote sem env =  (o.ret.toNamedVal outval)) :
  (Expr.opscons o os).denote sem env = os.denote sem (env.set o.ret outval) := by {
    rw[Expr.denote_opscons];
    simp[bind, ReaderT.bind, OVAL, Except.bind, TopM.set];
    sorry
}


-- If tuple succeeds, then:
-- 1. The arguments exists in 'env'.
-- 2. The value in 'env' is that of the tuple arguments, tupled up.
theorem Expr.denote_tuple_inv
  (SUCCESS: Expr.denote sem (Expr.tuple retname arg1 arg2) env = outval) :
    ∃ argval1, env.get arg1 = argval1 ∧
    ∃ argval2, env.get arg2 = argval2 ∧
    outval = { name := retname, kind := .pair arg1.kind arg2.kind, val := ⟨argval1, argval2 ⟩} := by {
    simp[Expr.denote, bind, ReaderT.bind, Except.bind] at SUCCESS;

      simp[TopM.get, bind, ReaderT.bind, Except.bind, ReaderT.get, pure, Except.pure] at SUCCESS ⊢;
      simp[pure, ReaderT.pure, Except.pure] at SUCCESS ⊢  ;
      aesop;
}


-- If op succeeds, then:
-- 1. the arguments exists in 'env'.
-- 2. 'sem' succeeded
-- 3. The value returned by 'Expr.denote' is the boxed value in 'sem'.
theorem Expr.denote_op_assign_inv
  (SUCCESS: Expr.denote sem (Expr.op ret name arg regions const) env = outval) :
    ∃ argval, env.get arg = argval ∧
    ∃ (outval_val : ret.kind.eval),
      (sem.run name (Op'.fromOp sem ret arg argval regions const) env = pure outval_val /\
       outval = ret.toNamedVal outval_val)   := by {
    -- rw[Expr.denote_op] at SUCCESS; -- TODO: find out why 'rw' does not work here.

    simp[Expr.denote, bind, ReaderT.bind, Except.bind] at SUCCESS;
      simp[TopM.get, bind, ReaderT.bind, Except.bind] at SUCCESS ⊢;
      simp[ReaderT.get, pure, Except.pure] at SUCCESS ⊢;
      simp[SUCCESS];
      simp[pure, Except.pure];
      simp[pure, Except.pure, ReaderT.pure] at SUCCESS;
      simp[SUCCESS];
      aesop
}

-- What we can say about a op in general. Note that this is a good deal weaker
-- than what we can say if we know what kind of op it is.
theorem Expr.denote_op_inv {op: Op}
  (SUCCESS: Expr.denote sem op env = Except.ok outval) :
  ∃ (retval : (Op.ret op).kind.eval),
    outval = { name := (Op.ret op).name, kind := (Op.ret op).kind, val := retval}  := by {
    cases op;
    case op ret name arg regions const => {
      have ⟨argval, ⟨argsucc, ⟨outval_val, ⟨OUTVAL_SEM, OUTVAL⟩ ⟩⟩⟩ := Expr.denote_op_assign_inv SUCCESS;
      exists outval_val;
    }
    case tuple ret arg1 arg2 => {
      have ⟨argval1, ⟨ARGVAL1, ⟨argval2, ⟨ARGVAL2, OUTVAL⟩⟩⟩⟩ := Expr.denote_tuple_inv SUCCESS;
      simp[Op.ret];
      exists argval1, argval2;
    }
  }

-- inversion for 'opsone' is the same as denote_op_inv.
theorem Expr.denote_opsone_inv {op: Op}
  (SUCCESS: Expr.denote sem (.opsone op) env = Except.ok outval) :
  ∃ (retval : (Op.ret op).kind.eval),
    outval = { name := (Op.ret op).name, kind := (Op.ret op).kind, val := retval}  := by {
    cases op;
    case op ret name arg regions const => {
      have ⟨argval, ⟨argsucc, ⟨outval_val, ⟨OUTVAL_SEM, OUTVAL⟩ ⟩⟩⟩ := Expr.denote_op_assign_inv SUCCESS;
      exists outval_val;
    }
    case tuple ret arg1 arg2 => {
      have ⟨argval1, ⟨ARGVAL1, ⟨argval2, ⟨ARGVAL2, OUTVAL⟩⟩⟩⟩ := Expr.denote_tuple_inv SUCCESS;
      simp[Op.ret];
      exists argval1, argval2;
    }
  }

-- inversion for 'opsone (Expr.op ...)' is the same as denote_op_assign_inv.
theorem Expr.denote_opsone_assign_inv
  (SUCCESS: Expr.denote sem (Expr.opsone (Expr.op ret name arg regions const)) env = Except.ok outval) :
 ∃ argval, env.get arg = .ok argval ∧
    ∃ (outval_val : ret.kind.eval),
      (sem.run name (Op'.fromOp sem ret arg argval regions const) env = pure outval_val /\
       outval = ret.toNamedVal outval_val)  := by {
        simp[Expr.denote_opsone] at SUCCESS;
        apply Expr.denote_op_assign_inv SUCCESS;
}



-- If opscons succeeds, then 'o' succeded and 'os' succeeded
-- (inversion principle).
-- TODO: this is a super ugly proof. Learn how to make it small.
theorem Expr.denote_opscons_inv
(SUCCESS: Expr.denote sem (Expr.opscons o os) env = Except.ok finalval) :
∃ (oval: (Op.ret o).kind.eval),
  (o.denote sem env = Except.ok ((Op.ret o).toNamedVal oval)) ∧
  (os.denote sem (env.set (Op.ret o) oval) = Except.ok finalval) := by {
    rw[Expr.denote_opscons] at SUCCESS;
    dsimp only[bind, ReaderT.bind, Except.bind, TopM.set] at SUCCESS;
    simp[Expr.denote_op] at SUCCESS;
    cases H:(Expr.denote sem o env) <;> simp[H] at SUCCESS;
    case ok oval => {
      cases o;
      case tuple ret a1 a2 => { -- TODO: refactor this as an inversion principle for tuples
        simp[Expr.denote] at H;
        simp[bind, ReaderT.bind, Except.bind] at H;
        cases A1VAL:(TopM.get a1 env) <;> simp[A1VAL] at H;
        case ok a1val => {
          cases A2VAL:(TopM.get a2 env) <;> simp[A2VAL] at H;
          case ok a2val => {
            simp[pure, ReaderT.pure, Except.pure] at H;
            induction H;
            case refl => {
              simp[SUCCESS] at *;
              exact SUCCESS;
            }
          }
        }
      }
      case op ret name arg regions const => { -- TODO: refactor this as inversion for Ops.
        dsimp only[Expr.denote] at H;
        dsimp only[TopM.get, ReaderT.get, bind, ReaderT.bind, Except.bind, pure, Except.pure] at H;
        cases ENV_AT_ARG:(Env.get arg env) <;> simp[ENV_AT_ARG] at H;
        case ok argval => {
        cases SEM:sem.run name
                          { argval := { kind := arg.kind, val := argval },
                            regions := Expr.denote sem regions, const := const,
                            retkind := ret.kind } env <;> simp[SEM] at H;
        case ok oval' => {
          dsimp only at oval';
          dsimp only[ReaderT.pure, pure, Except.pure] at H;
          injection H with oval'_EQ;
          induction oval'_EQ;
          simp[SUCCESS] at *;
          exact SUCCESS;
          }
        }
      }
    }
}

-- Forded version of denote_opscons_inv
theorem Expr.denote_opscons_inv'
(SUCCESS: Expr.denote sem (Expr.opscons o os) env = Except.ok finalval) :
∃ (oval: (Op.ret o).kind.eval),
  (o.denote sem env = Except.ok ((Op.ret o).toNamedVal oval)) ∧
∃ (env': Env),
  (env' = (env.set (Op.ret o) oval)) ∧
  (os.denote sem env' = Except.ok finalval) := by {
    rw[Expr.denote_opscons] at SUCCESS;
    dsimp only[bind, ReaderT.bind, Except.bind, TopM.set] at SUCCESS;
    simp[Expr.denote_op] at SUCCESS;
    cases H:(Expr.denote sem o env) <;> simp[H] at SUCCESS;
    case ok oval => {
      cases o;
      case tuple ret a1 a2 => { -- TODO: refactor this as an inversion principle for tuples
        simp[Expr.denote] at H;
        simp[bind, ReaderT.bind, Except.bind] at H;
        cases A1VAL:(TopM.get a1 env) <;> simp[A1VAL] at H;
        case ok a1val => {
          cases A2VAL:(TopM.get a2 env) <;> simp[A2VAL] at H;
          case ok a2val => {
            simp[pure, ReaderT.pure, Except.pure] at H;
            induction H;
            case refl => {
              simp[SUCCESS] at *;
              exact SUCCESS;
            }
          }
        }
      }
      case op ret name arg regions const => { -- TODO: refactor this as inversion for Ops.
        dsimp only[Expr.denote] at H;
        dsimp only[TopM.get, ReaderT.get, bind, ReaderT.bind, Except.bind, pure, Except.pure] at H;
        cases ENV_AT_ARG:(Env.get arg env) <;> simp[ENV_AT_ARG] at H;
        case ok argval => {
        cases SEM:sem.run name
                          { argval := { kind := arg.kind, val := argval },
                            regions := Expr.denote sem regions, const := const,
                            retkind := ret.kind } env <;> simp[SEM] at H;
        case ok oval' => {
          dsimp only at oval';
          dsimp only[ReaderT.pure, pure, Except.pure] at H;
          injection H with oval'_EQ;
          induction oval'_EQ;
          simp[SUCCESS] at *;
          exact SUCCESS;
          }
        }
      }
    }
}



-- unfold denote for tuple.
theorem Expr.denote_tuple:  (Expr.tuple ret o o').denote sem =
    (TopM.get o >>= fun oval => TopM.get o' >>= fun o'val =>
      fun _ => Except.ok
        { name := ret,
          kind := .pair o.kind o'.kind,
          val := (oval, o'val)
        }) := by { rfl; }

theorem Expr.denote_regionsnil: Expr.regionsnil.denote sem = [] := rfl

theorem Expr.denote_regionscons:
  Expr.denote sem (.regionscons r rs) = r.denote sem :: rs.denote sem := rfl


-- Get the value of 'TopM.get' that matches the current 'Env.cons' cell
theorem TopM.get.cons_eq:  TopM.get v (Env.cons v val env') = Except.ok val := by {
  simp only[TopM.get, ReaderT.get, bind, ReaderT.bind, pure, Except.bind, Except.pure, Env.get];
  simp;
}

theorem TopM.get.Var.unit: TopM.get Var.unit e = Except.ok () := by {
  simp only[TopM.get, bind, ReaderT.bind, Except.bind, ReaderT.get, pure, Except.ok, Except.pure];
  simp[AST.Var.unit];
  apply Env.get_unit;
}


theorem Expr.denote_opscons_tuple_inv'
(SUCCESS: Expr.denote sem (Expr.opscons (Expr.tuple ret a1 a2) os) env = Except.ok finalval) :
∃ (a1v: a1.kind.eval)
  (a2v: a2.kind.eval)
  (env': Env),
  (env.get a1 = Except.ok a1v) ∧
  (env.get a2 = Except.ok a2v) ∧
  (env' = env.cons {name := ret, kind := .pair a1.kind a2.kind} ⟨a1v, a2v⟩) ∧
  (os.denote sem env' = Except.ok finalval) := by {
    have ⟨oval, OVAL, env', ENV', OS⟩ := Expr.denote_opscons_inv' SUCCESS
    simp at oval;
    simp at OVAL;
    simp at ENV';
    simp at OS;
    have ⟨oval1, OVAL1, oval2, OVAL2, OVAL'⟩ := Expr.denote_tuple_inv OVAL;
    simp at oval1;
    simp at OVAL1;
    simp at oval2;
    simp at OVAL2;
    simp at OVAL';
    exists oval1;
    exists oval2;
    cases OVAL'; case refl => {
      simp;
      rw[ENV'] at OS;
      simp[OVAL1, OVAL2];
      exact OS;
    }
}

theorem Expr.denote_opscons_op_assign_inv'
(SUCCESS: Expr.denote sem (Expr.opscons (Expr.op ret name arg regions const) os) env = Except.ok finalval) :
∃ (argval: arg.kind.eval)
  (retval: ret.kind.eval)
  (env': Env),
  (env.get arg = Except.ok argval) ∧
  (sem.run name (Op'.fromOp sem ret arg argval regions const) env = pure retval) ∧
  (env' = env.cons {name := ret.name, kind := ret.kind} retval) ∧
  (os.denote sem env' = Except.ok finalval) := by {
    have ⟨oval, OVAL, env', ENV', OS⟩ := Expr.denote_opscons_inv' SUCCESS
    simp at oval;
    simp at OVAL;
    simp at ENV';
    simp at OS;
    have ⟨argval, ARGVAL, retval, RETVAL, OVAL_EQ_RETVAL⟩ := Expr.denote_op_assign_inv OVAL;
    simp at OVAL_EQ_RETVAL;
    cases OVAL_EQ_RETVAL; case refl => {
      simp at argval;
      simp at ARGVAL;
      exists argval;
      exists oval;
      simp[Env.set] at ENV';
      rw[ENV'] at OS;
      simp[ARGVAL, RETVAL, OS, ENV'];
      exact OS;
    }
}


end Semantics

namespace DSL
open AST

declare_syntax_cat dsl_op
declare_syntax_cat dsl_type
declare_syntax_cat dsl_ops
declare_syntax_cat dsl_region
declare_syntax_cat dsl_var
declare_syntax_cat dsl_var_name
declare_syntax_cat dsl_const
declare_syntax_cat dsl_kind

syntax sepBy1(ident, "×") :dsl_kind
syntax ident : dsl_var_name
syntax "%" dsl_var_name ":" dsl_kind : dsl_var
syntax dsl_var "="
      str
      ("("dsl_var ")")?
      ("[" dsl_region,* "]")?
      ("{" dsl_const "}")? ";": dsl_op
syntax "%" dsl_var_name "=" "tuple" "(" dsl_var "," dsl_var ")" ";": dsl_op
syntax num : dsl_const
syntax "{" ("^(" dsl_var ")" ":")?  dsl_op dsl_op*  "}" : dsl_region
syntax "[dsl_op|" dsl_op "]" : term
syntax "[dsl_ops|" dsl_op dsl_op* "]" : term
syntax "[dsl_region|" dsl_region "]" : term
syntax "[dsl_var|" dsl_var "]" : term
syntax "[dsl_kind|" dsl_kind "]" : term
syntax "[dsl_const|" dsl_const "]" : term
syntax "[dsl_var_name|" dsl_var_name "]" : term


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
  | "nat" => `(AST.Kind.nat)
  | unk => (Macro.throwErrorAt k s!"unknown kind '{unk}'")


open Lean Macro in
macro_rules
| `([dsl_kind| $[ $ks ]×* ]) => do
    if ks.isEmpty
    then `(AST.Kind.unit)
    else
      let mut out ← parseKind ks[ks.size - 1]!
      for k in ks.pop.reverse do
        let cur ← parseKind k
        out ← `(AST.Kind.pair $cur $out)
      return out
| `([dsl_kind| $$($q:term)]) => `(($q : Kind))

open Lean Macro in
macro_rules
| `([dsl_var_name| $name:ident ]) =>
      return (Lean.quote name.getId.toString : TSyntax `term)
| `([dsl_var_name| $$($q:term)]) => `(($q : String))

macro_rules
| `([dsl_var| %$name:dsl_var_name : $kind:dsl_kind]) => do
    `({ name := [dsl_var_name| $name],
        kind := [dsl_kind| $kind] : Var})
| `([dsl_var| $$($q:term)]) => `(($q : Var))

macro_rules
| `([dsl_ops| $op $ops*]) => do
   let op_term ← `([dsl_op| $op])
   let ops_term ← ops.mapM (fun op => `([dsl_op| $op ]))
   `(AST.Ops.fromList $op_term [ $ops_term,* ])

macro_rules
| `([dsl_ops| $$($q)]) => `(($q : Ops))

macro_rules
| `([dsl_region| { $[ ^( $arg:dsl_var ): ]? $op $ops* } ]) => do
   let ops ← `([dsl_ops| $op $ops*])
   match arg with
   | .none => `(Expr.region Var.unit $ops)
   | .some arg => do
      let arg_term ← `([dsl_var| $arg ])
      `(Expr.region $arg_term $ops)
| `([dsl_region| $$($q)]) => `(($q : Region))

macro_rules
| `([dsl_const| $x:num ]) => `(Const.int $x)
| `([dsl_const| $$($q)]) => `(($q : Const))

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
      let name_term := name
      let rgns_term ← match rgns with
        | .none => `(.regionsnil)
        | .some rgns =>
           let rgns ← rgns.getElems.mapM (fun stx => `([dsl_region| $stx]))
           `(AST.Regions.fromList [ $rgns,* ])
      let const_term ←
        match const with
        | .none => `(Const.unit)
        | .some c => `([dsl_const| $c])
      `(Expr.op $res_term (OpName.fromString ($name_term : String)) $arg_term $rgns_term $const_term)
| `([dsl_op| $$($q)]) => `(($q : Op))

macro_rules
| `([dsl_op| %$res:dsl_var_name = tuple ( $arg1:dsl_var , $arg2:dsl_var) ; ]) => do
    let res_term ← `([dsl_var_name| $res])
    let arg1_term ← `([dsl_var| $arg1 ])
    let arg2_term ← `([dsl_var| $arg2 ])
    `(Expr.tuple $res_term $arg1_term $arg2_term)

def eg_kind_int := [dsl_kind| int]
#reduce eg_kind_int

def eg_kind_int_times_nat := [dsl_kind| int × nat]
#reduce eg_kind_int_times_nat

def eg_kind_int_times_nat_times_nat := [dsl_kind| int × nat × nat]
#reduce eg_kind_int_times_nat_times_nat



def eg_var : AST.Var := [dsl_var| %y : int]
#reduce eg_var

def eg_var_2 : AST.Var := [dsl_var| %$("y") : int ]
#reduce eg_var_2

def eg_var_3 : AST.Var :=
  let name := "name";  let ty := Kind.int;  [dsl_var| %$(name) : $(ty) ]
#reduce eg_var_3

def eg_op : AST.Op :=
  let name := "name";  let ty := Kind.int;
  [dsl_op| %res : int = "arith.sub" ( %$(name) : $(ty) ); ]
#reduce eg_var_3

section Unexpander

/-
Support for pretty printing our AST.Expr to make writing proofs easier.
-/
/-
@[app_unexpander Var.mk] def unexpandVar: Lean.PrettyPrinter.Unexpander
| `($_ $nm $kind) => `($nm $kind)
| _ => throw ()

@[app_unexpander Val.mk] def unexpandVal: Lean.PrettyPrinter.Unexpander
| `($_ $kind $val) => `($val $kind)
| _ => throw ()

@[app_unexpander Kind.pair] def unexpandKindPair: Lean.PrettyPrinter.Unexpander
| `($_ $l $r) => `($l × $r)
| _ => throw ()

@[app_unexpander Expr.tuple] def unexpandExprTuple: Lean.PrettyPrinter.Unexpander
| `($_ $ret $l $r) => `($ret = "tuple" ( $l , $r ))
| _ => throw ()

open Lean Macro PrettyPrinter in
@[app_unexpander Expr.op] def unexpandExprOp: Lean.PrettyPrinter.Unexpander
| `($_ $ret $name $arg regionsnil $const) => `($ret = "op" $name ( $arg ) $const)
-- | `($_ $ret $name $arg $regions Const.unit) => `($ret = "op" $name ( $arg ) $regions)
| `($_ $ret $name $arg $regions $const) => `($ret = "op" $name ( $arg ) $regions  $const)
| _ => sorry

@[app_unexpander Expr.opscons] def unexpandExprOpscons: Lean.PrettyPrinter.Unexpander
| `($_ $o $os) => `($o / $os)
| _ => throw ()

@[app_unexpander Expr.opsone] def unexpandExprOpsone: Lean.PrettyPrinter.Unexpander
| `($_ $o) => `($o)
| _ => throw ()

@[app_unexpander Expr.regionscons] def unexpandRegionsnil : Lean.PrettyPrinter.Unexpander
| `($_ ) => `(())


@[app_unexpander Expr.regionscons] def unexpandRegionsCons : Lean.PrettyPrinter.Unexpander
| `($_ $r Expr.regionsnil) => `($r)
| _ => throw ()

@[app_unexpander Const.unit] def unexpandConstUnit : Lean.PrettyPrinter.Unexpander
| `($_) => `(())

@[app_unexpander Const.int] def unexpandConstInt : Lean.PrettyPrinter.Unexpander
| `($_ $i:num)  => `($i)
| _ => throw ()
-/
end Unexpander


end DSL

namespace Arith

def const : Semantic := {
  name := .arith.constant
  run := fun o => match o with
  | { const := .int x, retkind := .int} => return x
  | _ => default
}

def add : Semantic := {
  name := .arith.add
  run := fun o => match o with
  | { retkind := .int,
      argval := ⟨.pair .int .int, (x, y)⟩ } => return x + y
  | _ => default
}

def sub : Semantic := {
  name := .arith.sub
  run := fun o => match o with
  | { retkind := .int,
      argval := ⟨.pair .int .int, (x, y)⟩ } => return x - y
  | _ => default
}

def sem: Semantics :=
  .cons const (.cons add (.cons sub .nil))

def eg_region_sub :=
 [dsl_region| {
   %one : int = "arith.constant" {1};
   %two : int = "arith.constant" {2};
   %t = tuple(%one : int , %two : int);
   %x : int = "arith.sub"(%t : int × int);
 }]
#reduce eg_region_sub


end Arith

namespace Scf -- 'structured control flow'

def repeatM (n: Nat) (f: Val → TopM Val) : Val → TopM Val :=
  n.repeat (f >=> .) pure


theorem repeatM.peel_left: ∀ (n: Nat) (f: Val → TopM Val),
  repeatM (n+1) f = f >=> repeatM n f := by {
    intros n f;
    simp[repeatM, Nat.repeat];
}
-- This theorem is now useless
-- theorem repeatM.peel_left: repeatM (n+1) f = f >=> repeatM n f := rfl

-- kleisli arrow is associative.
theorem kleisliRight.assoc {m: Type → Type}
  [M: Monad m] [LM: LawfulMonad m]
  {α β γ δ: Type}
  (f: α → m β) (g: β → m γ) (h: γ → m δ) :
  (f >=> g) >=> h = f >=> (g >=> h) := by {
  funext x;
  simp[Bind.kleisliRight];
}

-- pure is left identity
@[simp]
theorem kleisliRight.pure_id_left {m: Type → Type}
  [M: Monad m] [LM: LawfulMonad m]
  {α β: Type}
  (f: α → m β) :
  pure >=> f = f := by {
  funext x;
  simp[Bind.kleisliRight];
}

-- pure is left identity
@[simp]
theorem kleisliRight.pure_id_right {m: Type → Type}
  [M: Monad m] [LM: LawfulMonad m]
  {α β: Type}
  (f: α → m β) :
  f >=> pure = f:= by {
  funext x;
  simp[Bind.kleisliRight];
}

-- The above shows that (>=>, pure) forms a category.

@[simp] theorem repeatM.zero: repeatM 0 f = pure := rfl
@[simp] theorem repeatM.one: repeatM 1 f = f := by simp [repeatM, Nat.repeat]
@[simp] theorem repeatM.succ: repeatM (Nat.succ n) f = f >=> repeatM n f := rfl

-- composing repeatM is the same as adding the repeat
-- counter.
theorem repeatM.compose: (repeatM n f) >=> (repeatM m f) = repeatM (n+m) f := by
  revert m
  induction n <;> intros m <;> simp
  case succ n' IH =>
    simp [Nat.succ_add, kleisliRight.assoc, IH]

theorem repeatM.peel_right: repeatM (n+1) f = repeatM n f >=> f := by
  induction n <;> simp at *
  case succ _ IH => rw [kleisliRight.assoc, IH]

theorem repeatM.commute_f: repeatM n f >=> f = f >=> repeatM n f := by
  simp [←peel_right]

-- pull a function that commutes with f to the left of repeatM
@[simp] -- pull simple stuff to the left.
theorem repeatM.commuting_pull_left
  {f g: Val → TopM Val} (COMMUTES: f >=> g = g >=> f) :
  (repeatM n f) >=> g = g >=> repeatM n f := by
  induction n <;> simp
  case succ n' IH =>
    simp [kleisliRight.assoc, IH]
    simp [←kleisliRight.assoc, COMMUTES]

theorem repeatM.commuting_pull_right
  {f g: Val → TopM Val} (COMMUTES: f >=> g = g >=> f) :
  g >=> repeatM n f = repeatM n f >=> g := (commuting_pull_left COMMUTES).symm

-- TODO: decision procedure for free theory of
-- commuting functions?
theorem repeatM.commuting_commute
  {f g: Val → TopM Val} (COMMUTES: f >=> g = g >=> f) :
  repeatM n f >=> repeatM m g = repeatM m g >=> repeatM n f := by
  induction n <;> simp
  case succ n' IH =>
    rw [kleisliRight.assoc, IH]
    simp [←kleisliRight.assoc]
    rw [commuting_pull_left COMMUTES.symm]

-- to show (f >=> k) = (f >=> h), it suffices to show that k = h
theorem kleisli.cancel_left [M: Monad m] (f: α → m β) (k h : β → m γ) (H: k = h) :
  f >=> k = f >=> h := by {
    rw[H];
}

theorem repeatM.commuting_compose
  {f g: Val → TopM Val} (COMMUTES: f >=> g = g >=> f) :
  (repeatM n f) >=> repeatM n g = repeatM n (f >=> g) := by
  induction n <;> simp
  case succ n' IH =>
    rw [←kleisliRight.assoc _ g _, kleisliRight.assoc _ _ g]
    rw [commuting_pull_left COMMUTES]
    rw [←kleisliRight.assoc f g _, kleisliRight.assoc (f >=> g) _ _, IH]


def if_ : Semantic := {
  name := .scf.if
  run := fun o => match o with
  | { argval := ⟨.int, cond⟩,
      regions := [rthen, relse],
      retkind := .int -- hack: we assume that we always return ints.
    } => do
      let rrun := if cond ≠ 0 then rthen else relse
      let v ← rrun Val.unit
      return .int
  | _ => default
}

def twice : Semantic := {
  name := .scf.twice
  run := fun o => match o with
  | { regions := [r],
      retkind := .int
    } => do
      let v ← r Val.unit
      let w ← r Val.unit -- run a region twice, check that it is same as running once.
      return w.cast .int
  | _ => default
}

def for_ : Semantic := {
  name := .scf.for
  run := fun o => match o with
  | { regions := [r],
      retkind := .int,
      argval := ⟨.pair .nat .int, ⟨niters, init⟩⟩
    } =>
      repeatM niters r ⟨.int, init⟩ >=> Val.cast (t := .int)
  | _ => TopM.error "unknown op"
}

def for_.run:
  Semantic.run
    Scf.for_
    { argval := ⟨.pair .nat .int, ⟨niters, init ⟩⟩,
      regions := [r]
      const := .unit,
      retkind := .int
    } = ((do
    repeatM niters r ⟨.int, init⟩ >=> Val.cast (t := .int)) :
      TopM Int) := rfl

def sem : Semantics :=
  .cons Scf.for_ (.cons Scf.twice (.cons Scf.if_ .nil))

end Scf

namespace Examples
open AST
def eg_arith_shadow : Region := [dsl_region| {
  %x : int = "arith.constant"{0};
  %x : int = "arith.constant"{1};
  %x : int = "arith.constant"{2};
  %x : int = "arith.constant"{3};
  %x : int = "arith.constant"{4};
}]

def eg_scf_ite_true : Region := [dsl_region| {
  %cond : int = "arith.constant"{1};
  %out : int = "scf.if" (%cond : int) [{
    %out_then : int = "arith.constant"{42};
  }, {
    %out_else : int = "arith.constant"{0};
  }];
}]



-- f: Unit → a ∼ a
def eg_scf_ite_false : Region := [dsl_region| {
  %cond : int = "arith.constant"{0};
  %out : int = "scf.if" (%cond : int) [{
    %out_then : int = "arith.constant"{42};
  }, {
    %out_else : int = "arith.constant"{0};
  }];
}]

#print eg_scf_ite_false

def eg_scf_run_twice : Region := [dsl_region| {
  %x : int = "arith.constant"{41};
  %x : int = "scf.twice" [{
      %one : int = "arith.constant"{1};
      %xone = tuple(%x : int, %one : int);
      %x : int = "arith.add"(%xone : int × int);
  }];
}]

def eg_scf_well_scoped : Region := [dsl_region| {
  %x : int = "arith.constant"{41};
  %one : int = "arith.constant"{1}; -- one is outside.
  %x : int = "scf.twice" [{
      %xone = tuple(%x : int, %one : int); -- one is accessed here.
      %x : int = "arith.add"(%xone : int × int);
  }];
}]

def eg_scf_ill_scoped : Region := [dsl_region| {
  %x : int = "arith.constant"{41};
  %x : int = "scf.twice" [{
      %y : int = "arith.constant"{42};
  }];
  -- %y should NOT be accessible here
  %out = tuple(%y : int, %y : int);
}]

def eg_scf_for: Region := [dsl_region| {
  %x : int = "arith.constant"{10};  -- 10 iterations
  %init : int = "arith.constant"{32}; -- start value
  %xinit = tuple(%x : int, %init : int);
  %out : int = "scf.for"(%xinit : int × int)[{
    ^(%xcur : int):
      %one : int = "arith.constant"{1};
      %xcur_one = tuple(%xcur : int, %one : int);
      %xnext : int = "arith.add"(%xcur_one : int × int);
  }];
}]



end Examples

namespace Rewriting
open AST

inductive TypingCtx
| nil: TypingCtx
| cons: Var → TypingCtx → TypingCtx


inductive TypingContextInEnv: Env → TypingCtx → Prop where
| Nil: (e: Env) → TypingContextInEnv e .nil
| Cons: (e: Env) →
  (e.get var).isOk → -- current
  TypingContextInEnv e ctx' → -- rest
  TypingContextInEnv e (.cons v ctx')

/- Replace the final Op with the new seqence of Ops -/
def Ops.replaceOne (os: Ops) (new: Ops) : Ops :=
  match os with
  | .opsone o => new
  | .opscons o os => .opscons o (Ops.replaceOne os new)

structure Peephole where
  -- findbegin: TypingCtx -- free variables.
  find : Ops -- stuff in the pattern. The last op is to be replaced.
  replace : Ops -- replacement ops. can use 'findbegin'.
  sem: Semantics
  -- TODO: Once again, we need to reason 'upto error'.
  replaceCorrect: ∀ (env: Env),
      find.denote sem env = replace.denote sem env

      -- (FIND: find.denote sem env = origval),
      -- (replace.denote sem) env =  origval
end Rewriting

namespace RewritingHoare
open AST
open Rewriting
/-
A theory of rewriting, plus helper lemmas phrased along a hoare logic.
-/
-- https://softwarefoundations.cis.upenn.edu/plf-current/Hoare.html
def assertion (t: Type) : Type := t → Prop
def assertion.implies (P Q: assertion T) : Prop := ∀ (e: T), P e → Q e


notation P:80 "->>" Q:80 => assertion.implies P Q

abbrev assertion.iff (P Q: assertion T) : Prop := P ->> Q ∧ Q ->> P
notation P:80 "<<->>" Q:80 => assertion.iff P Q

def assertion.and (P Q: assertion T) : assertion T := fun (v: T) => P v ∧ Q v
notation P:80 "h∧" Q:80 => assertion.and P Q -- how does this work?

def assertion.prop (p: Prop): assertion T := fun (_v: T) => p

def assertion.mapsto (v: Var) (val: v.kind.eval): assertion Env :=
  fun (e: Env) => e.get v =  val

def assertion.maps (v: Var): assertion Env :=
  fun (e: Env) => ∃ (val: v.kind.eval), (e.get v) = val

notation "h[" v:80 "↦" val:80 "]" => assertion.mapsto v val
notation "hprop(" p:80 ")" => assertion.prop p
notation "h[" v:80 "↦" "?" "]" => assertion.maps v
-- def hoare_triple_region (P: assertion Env) (r: Expr .R) (Q: assertion (Except ErrorKind NamedVal)) : Prop :=
--  ∀ (e: Env) (sem : (o : Op') → TopM o.retkind.eval) (v: Val), P e -> Q (r.denote sem v e)



-- more conceptual proof, still does not use full hoare logic machinery, only a fragment.
section SubXXHoare
-- x - x ~= 0

theorem Int.sub_n_n (n: Int) : n - n = 0 := by {
  linarith
}


def sub_x_x_equals_zero (res: String) (arg: String) (pairname: String) : Peephole := {
  find := [dsl_ops|
    % $(pairname) = tuple( %$(arg) : int, %$(arg) : int);
    % $(res) : int = "arith.sub" ( %$(pairname) : int × int);
  ]
  replace := [dsl_ops|
    % $(res) : int = "arith.constant" {0};
  ]
  sem := Arith.sem,
  replaceCorrect := fun env => by {
    simp[Expr.denote, TopM.get, TopM.set, ReaderT.get, bind, Env.get, ReaderT.bind, pure, ReaderT.pure, Semantics.run, Semantic.run,
      Arith.sub, Arith.const] at *;
    }
 }


end SubXXHoare


section ForFusionHoare
-- peel loop iterations out.


-- e with x as subexpr
-- (fun v => e' v) x = e
def pure_rewrite [M: Monad m] [LM: LawfulMonad m]
  (ma: m α)
  (maval: α)
  (MAVAL: ma = pure maval)
  (compute: α -> m β) :
  compute maval = ma >>= compute := by {
    simp[MAVAL];
}

def for_fusion (r: Region) (n m : String)
  (n_plus_m n_m: String)
  (out1 out2: String)
  (n_init m_out1: String)
  (init n_plus_m_init: String) : Peephole := {
  find := [dsl_ops|
    % $(n_init) = tuple( %$(n) : nat, %$(init) : int);
    % $(out1) : int = "for" ( %$(n_init) : nat × int) [$(r)];
    % $(m_out1) = tuple( %$(m) : nat, %$(out1) : int);
    % $(out2) : int = "for" ( %$(m_out1) : nat × int) [$(r)];
  ]
  replace := [dsl_ops|
    % $(n_m) = tuple( %$(n) : nat, %$(m) : nat);
    % $(n_plus_m) : nat = "add" ( %$(n_m) : nat × nat);
    % $(n_plus_m_init) = tuple( %$(n_plus_m) : nat, %$(init) : int);
    % $(out2) : int = "for" ( %$(n_plus_m_init) : nat × int) [$(r)];
  ]
  sem := Semantics.append Scf.sem Arith.sem,
  replaceCorrect := fun env1 => by {
     simp[Expr.denote, TopM.get, TopM.set, ReaderT.get, bind, Env.get, ReaderT.bind, pure, ReaderT.pure, Semantics.run, Semantic.run,
      Arith.sub, Arith.const, Scf.sem, Scf.for_] at *;
      constructor;
  }
}
end ForFusionHoare


end RewritingHoare


namespace Theorems

end Theorems

namespace Test
def runRegionTest :
  (sem: Semantics) →
  (r: AST.Region) →
  (expected: Val) →
  (arg: Val := Val.unit ) →
  (env: Env := Env.empty) → IO Bool :=
  fun sem r expected arg env => do
    IO.println r
    let v? := (r.denote sem arg).run env
    match v? with
    | .ok v =>
      if v == expected
      then
        IO.println s!"{v}. OK"; return True
      else
        IO.println s!"ERROR: computed '{v}', expected '{expected}'."
        return False
    | .error e =>
      IO.println s!"ERROR: '{e}'. Expected '{expected}'."
      return False

def runRegionTestXfail :
  (sem: Semantics) →
  (r: AST.Region) →
  (arg: Val := Val.unit ) →
  (env: Env := Env.empty) → IO Bool :=
  fun sem r arg env => do
    IO.println r
    let v? := (r.denote sem arg).run env
    match v? with
    | .ok v =>
        IO.println s!"ERROR: expected failure, but succeeded with '{v}'.";
        return False
    | .error e =>
      IO.println s!"OK: Succesfully xfailed '{e}'."
      return True

end Test


open Arith Scf DSL Examples Test in
def main : IO UInt32 := do
  let tests :=
  [runRegionTest
    (sem := Arith.sem)
    (r := eg_region_sub)
    (expected := { kind := .int, val := -1}),
  runRegionTest
    (sem := Arith.sem)
    (r := eg_arith_shadow)
    (expected := { kind := .int, val := 4}),
   runRegionTest
    (sem := Semantics.append Scf.sem Arith.sem)
    (r := eg_scf_ite_true)
    (expected := { kind := .int, val := 42}),
  runRegionTest
    (sem := Semantics.append Scf.sem Arith.sem)
    (r := eg_scf_ite_false)
    (expected := { kind := .int, val := 0}),
  runRegionTest
    (sem := Semantics.append Scf.sem Arith.sem)
    (r := eg_scf_run_twice)
    (expected := { kind := .int, val := 42}),
  runRegionTest
    (sem := Semantics.append Scf.sem Arith.sem)
    (r := eg_scf_well_scoped)
    (expected := { kind := .int, val := 42}),
  runRegionTestXfail
    (sem := Semantics.append Scf.sem Arith.sem)
    (r := eg_scf_ill_scoped),
  runRegionTest
    (sem := Semantics.append Scf.sem Arith.sem)
    (r := eg_scf_for)
    (expected := { kind := .int, val := 42})]
  let mut total := 0
  let mut correct := 0
  for t in tests do
    total := total + 1
    IO.println s!"---Test {total}---"
    let pass? ← t
    if pass? then correct := correct + 1
  IO.println "---"
  IO.println s!"Tests: {correct} successful/{total}"
  return (if correct == total then 0 else 1)