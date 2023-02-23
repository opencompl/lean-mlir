import Mathlib.Tactic.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LibrarySearch
import Mathlib.Tactic.Cases
import Std.Data.Int.Basic

open Std


namespace AST

/-
Kinds of values. We must have 'pair' to take multiple arguments.
-/
inductive Kind where
| int : Kind
| float : Kind
| pair : Kind -> Kind -> Kind
| unit: Kind
deriving Inhabited, DecidableEq, BEq

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
| tuple (ret: String) (a1 a2: Var): Expr .O -- %out = tuple (%v1, %v2)
| region (arg : Var) (ops : Expr .Os): Expr .R -- '{ ^entry(arg:argty) ops* }'

abbrev Op := Expr .O
abbrev Region := Expr .R
abbrev Regions := Expr .Rs
abbrev Ops := Expr .Os

abbrev Op.mk (ret: Var := Var.unit)
  (name: String)
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
    .text (toString ret ++ " = " ++ name) ++
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
abbrev ErrorKind : Type := Quotient (SetoidTrunc String)

/-
Cursed: We cast from 'ErrorKind' which is a quotient of 'String' into 'String'
since we know that these have the same RuntimeRep.
-/
unsafe def ErrorKind.toStringImpl (e: ErrorKind): String := unsafeCast e
@[implemented_by ErrorKind.toStringImpl]
partial def ErrorKind.toString (_: ErrorKind): String := "<<error>>"
instance : ToString ErrorKind where
  toString := ErrorKind.toString

abbrev ErrorKind.mk (s: String) : Quotient (SetoidTrunc String) :=
  Quotient.mk' s

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


abbrev TopM (α : Type) : Type := ReaderT Env (Except ErrorKind) α

abbrev Env.set (var: Var) (val: var.kind.eval): Env → Env
| env => (.cons var val env)

-- We need to produce values of type '()' for eg. ops with zero agruments.
-- Here, we ensure that Env.get for a var of type 'Unit' will always succeed and return '()',
-- becuse there is not need not to. This allows us to use 'Unit' to signal zero arguments,
-- wthout have to make up a fake name for a variable of type 'Unit'
def Env.get (var: Var): Env → Except ErrorKind var.kind.eval
| .empty => match var.kind with
            | .unit => Except.ok ()
            | _ =>  Except.error s!"unknown var {var.name}"
| .cons var' val env' =>
      if H : var = var'
      then pure (H ▸ val)
      else env'.get var

theorem Env.get_unit (name: String) (e: Env): e.get ⟨name, .unit⟩ = Except.ok () :=
  match e with
  | .empty => by rfl
  | .cons var' val' env' =>
       if H :⟨name, .unit⟩ = var'
       then by {
        simp[get];
        simp[H];
        simp only [pure, Except.pure];
       }
       else by {
        simp[Env.get, H];
        exact (Env.get_unit name env')
      }

theorem Env.get_set_eq (env: Env) (var: Var)  (val: var.kind.eval):
  (env.set var val).get var = Except.ok val := by {
    induction env <;> simp[get, set, Env.set, Env.get, pure, Except.pure];
}


abbrev ReaderT.get [Monad m]: ReaderT ρ m ρ := fun x => pure x
abbrev ReaderT.withEnv [Monad m] (f: ρ → ρ) (reader: ReaderT ρ m α): ReaderT ρ m α :=
  reader ∘ f

def TopM.get (var: Var): TopM var.kind.eval := ReaderT.get >>= (fun _ => (Env.get var))

-- the unit type will always successfully return '()'
theorem TopM.get_unit (name: String) (env: Env): TopM.get ⟨name, .unit⟩ env = Except.ok () := by {
  simp[get, ReaderT.get, bind, ReaderT.bind, Except.bind, pure, Except.pure];
  simp[Env.get_unit];
}

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

instance : ToString Op' where
  toString x :=
    x.name ++ "(" ++ toString x.argval ++ ")" ++
    " [" ++ "#" ++ toString x.regions.length ++ "]" ++
    " {" ++ toString x.const ++ "}" ++ " → " ++ toString x.retkind

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


-- Write this separately for defEq purposes.
def Op'.fromOp (sem: (o: Op') → TopM (o.retkind.eval))
  (ret: Var) (name: String) (arg: Var) (argval: arg.kind.eval) (rs: Regions) (const: Const) : Op' :=
      { name := name
      , argval := ⟨arg.kind, argval⟩
      , regions := rs.denote sem
      , const := const
      , retkind := ret.kind
  }


def runRegion (sem : (o: Op') → TopM o.retkind.eval) (expr: AST.Expr .R)
(env :  Env := Env.empty)
(arg : Val := Val.unit) : Except ErrorKind NamedVal :=
  (expr.denote sem arg).run env


theorem TopM_idempotent: ∀ (ma: TopM α) (k: α → α → TopM β),
 ma >>= (fun a => ma >>= (fun a' => k a a')) =
 ma >>= (fun a => k a a) := by {
  intros ma k;
  funext env;
  simp[ReaderT.bind];
  simp[bind];
  simp[ReaderT.bind];
  simp[bind];
  simp[Except.bind];
  cases H:(ma env) <;> simp;
}

theorem TopM_commutative: ∀ (ma: TopM α) (mb: TopM β) (k: α → β → TopM γ),
 ma >>= (fun a => mb >>= (fun b => k a b)) =
 mb >>= (fun b => ma >>= (fun a => k a b)) := by {
  intros ma mb k;
  funext env;
  simp[ReaderT.bind];
  simp[bind];
  simp[ReaderT.bind];
  simp[bind];
  simp[Except.bind];
  cases H:(ma env) <;> simp;
  case h.error e => {
    cases H':(mb env) <;> simp;
    case error e' => {
      apply ErrorKind.subsingleton;
    }
  }
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
      { name := name
      , argval := ⟨arg.kind, val⟩
      , regions := rs.denote sem
      , const := const
      , retkind := ret.kind }
    sem op' >>= fun out => fun env => Except.ok <| ret.toNamedVal out
  := by { rfl; }

-- how to simply Expr.denote_op, assuming the environment lookup is correct.
theorem Expr.denote_op_success (ret: Var) (name: String) (arg: Var) (rs: Regions) (const: Const)
  (sem: (o' : Op') → TopM o'.retkind.eval)
  (env: Env)
  (argval: arg.kind.eval)
  (ARGVAL: env.get arg = .ok argval)
  (outval : ret.kind.eval)
  (SEM: sem (Op'.fromOp sem ret name arg argval rs const) env = Except.ok outval) :
  (Op.mk ret name arg rs const).denote sem env = Except.ok (ret.toNamedVal outval)
  := by {
      rw[Expr.denote_op];
      simp[Op'.fromOp] at SEM;
      simp[Op'.fromOp, TopM.get, ReaderT.get, pure, bind, ReaderT.bind, Except.pure, Except.bind, ARGVAL, SEM];
   }


-- 'opscons o os' @ env is the same as 'os @ (env[o.ret = o.val])'.
-- That is, if 'o' succeeds, the 'os' proceeds evaluation with 'env' which
-- has been updated for 'o.ret' with 'o.val'.
theorem Expr.denote_opscons_success_op (o: Op) (outval: (Op.ret o).kind.eval)
  (sem : (o' : Op') → TopM o'.retkind.eval) (env: Env)
  (OVAL: o.denote sem env = Except.ok (o.ret.toNamedVal outval)) :
  (Expr.opscons o os).denote sem env = os.denote sem (env.set o.ret outval) := by {
    rw[Expr.denote_opscons];
    simp[bind, ReaderT.bind, OVAL, Except.bind, TopM.set];
}


-- If tuple succeeds, then:
-- 1. The arguments exists in 'env'.
-- 2. The value in 'env' is that of the tuple arguments, tupled up.
theorem Expr.denote_tuple_inv
  (SUCCESS: Expr.denote sem (Expr.tuple retname arg1 arg2) env = Except.ok outval) :
    ∃ argval1, env.get arg1 = .ok argval1 ∧
    ∃ argval2, env.get arg2 = .ok argval2 ∧
    outval = { name := retname, kind := .pair arg1.kind arg2.kind, val := ⟨argval1, argval2 ⟩} := by {
    simp[Expr.denote, bind, ReaderT.bind, Except.bind] at SUCCESS;
    cases ARGVAL1:TopM.get arg1 env <;> simp[ARGVAL1] at SUCCESS;
    case ok argval1 => {
      simp[TopM.get, bind, ReaderT.bind, Except.bind, ReaderT.get, pure, Except.pure] at ARGVAL1;
      simp[ARGVAL1];

      cases ARGVAL2:TopM.get arg2 env <;> simp[ARGVAL2] at SUCCESS;
      case ok argval2 => {
        simp[TopM.get, bind, ReaderT.bind, Except.bind, ReaderT.get, pure, Except.pure] at ARGVAL2;
        simp[ARGVAL2];
        simp[pure, ReaderT.pure, Except.pure] at SUCCESS;
        simp[SUCCESS];
      }
    }
}


-- If op succeeds, then:
-- 1. the arguments exists in 'env'.
-- 2. 'sem' succeeded
-- 3. The value returned by 'Expr.denote' is the boxed value in 'sem'.
theorem Expr.denote_op_assign_inv
  (SUCCESS: Expr.denote sem (Expr.op ret name arg regions const) env = Except.ok outval) :
    ∃ argval, env.get arg = .ok argval ∧
    ∃ (outval_val : ret.kind.eval),
      (sem (Op'.fromOp sem ret name arg argval regions const) env = pure outval_val /\
       outval = ret.toNamedVal outval_val)   := by {
    -- rw[Expr.denote_op] at SUCCESS; -- TODO: find out why 'rw' does not work here.

    simp[Expr.denote, bind, ReaderT.bind, Except.bind] at SUCCESS;
    cases ARGVAL:TopM.get arg env <;> simp[ARGVAL] at SUCCESS;
    case ok argval => {
      exists argval;
      simp[TopM.get, bind, ReaderT.bind, Except.bind] at ARGVAL;
      simp[ReaderT.get, pure, Except.pure] at ARGVAL;
      simp[ARGVAL];

      cases SEMVAL:sem { name := name,
                          argval := { kind := arg.kind, val := argval },
                          regions := Expr.denote sem regions, const := const,
                          retkind := ret.kind } env;
      case error ERROR => {
        simp[SEMVAL] at SUCCESS;
      }
      case ok semval => {
        simp at semval;
        exists semval;
        simp[pure, Except.pure];
        simp[SEMVAL] at SUCCESS;
        simp[pure, Except.pure, ReaderT.pure] at SUCCESS;
        simp[SUCCESS];
      }
    }
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
      (sem (Op'.fromOp sem ret name arg argval regions const) env = pure outval_val /\
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
        cases SEM:sem { name := name,
                        argval := { kind := arg.kind, val := argval },
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
        cases SEM:sem { name := name,
                        argval := { kind := arg.kind, val := argval },
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
      `(Expr.op $res_term $name_term $arg_term $rgns_term $const_term)
| `([dsl_op| $$($q)]) => `(($q : Op))

macro_rules
| `([dsl_op| %$res:dsl_var_name = tuple ( $arg1:dsl_var , $arg2:dsl_var) ; ]) => do
    let res_term ← `([dsl_var_name| $res])
    let arg1_term ← `([dsl_var| $arg1 ])
    let arg2_term ← `([dsl_var| $arg2 ])
    `(Expr.tuple $res_term $arg1_term $arg2_term)

def eg_kind_int := [dsl_kind| int]
#reduce eg_kind_int

def eg_var : AST.Var := [dsl_var| %y : int]
#reduce eg_var

def eg_var_2 : AST.Var := [dsl_var| %$("y") : int ]
#reduce eg_var_2

def eg_var_3 : AST.Var :=
  let name := "name";  let ty := Kind.int;  [dsl_var| %$(name) : $(ty) ]
#reduce eg_var_3

def eg_op : AST.Op :=
  let name := "name";  let ty := Kind.int;
  [dsl_op| %res : int = "foo" ( %$(name) : $(ty) ); ]
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
def sem: (o: Op') → TopM (o.retkind.eval)
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

| op => TopM.error s!"unknown op: {op}"

def eg_region_sub :=
 [dsl_region| {
   %one : int = "constant" {1};
   %two : int = "constant" {2};
   %t = tuple(%one : int , %two : int);
   %x : int = "sub"(%t : int × int);
 }]
#reduce eg_region_sub


end Arith

namespace Scf

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


def sem: (o: Op') → TopM (o.retkind.eval)
| { name := "if",
    argval := ⟨.int, cond⟩,
    regions := [rthen, relse],
    retkind := .int -- hack: we assume that we always return ints.
  } => do
    let rrun := if cond ≠ 0 then rthen else relse
    let v ← rrun Val.unit
    v.cast .int
| { name := "twice",
    regions := [r],
    retkind := .int
  } => do
    let v ← r Val.unit
    let w ← r Val.unit -- run a region twice, check that it is same as running once.
    w.cast .int
| { name := "for",
    regions := [r],
    retkind := .int,
    argval := ⟨.pair .int .int, ⟨init, niters⟩⟩
  } => do
    let niters : Nat :=
      match niters with
      | .ofNat n => n
      | _ => 0
    let loopEffect := (fun v => NamedVal.toVal <$> (r v))
    let w ← repeatM niters loopEffect ⟨.int, init⟩
    w.cast .int
| op => TopM.error s!"unknown op {op}"
end Scf

namespace Combine

/-
This is a poor way to combine semantics.
Instead, refactor semantics to be such that we only define
the semantics on a per-op basis. Then, we dispatch
the semantics via a hash map. This allows us to simplify
the dispatch (not via opaque functions), and also give us the
niceness of semantics-per-op.
-/
def combineSem: (s1 s2: (o: Op') → TopM o.retkind.eval) →
    (x: Op') → TopM x.retkind.eval :=
  fun s1 s2 o =>
     let f1 := (s1 o)
     let f2 := (s2 o)
     fun env => (f1 env).orElseLazy (fun () => f2 env)


theorem combineSem.run_left {s1 s2: (o: Op') → TopM o.retkind.eval} {env: Env}
  {o: Op'} {v: o.retkind.eval} (S1: s1 o env = Except.ok v) :
  combineSem s1 s2 o env = Except.ok v := by {
    simp [combineSem, S1, Except.orElseLazy];
  }


end Combine

namespace Examples
open AST
def eg_arith_shadow : Region := [dsl_region| {
  %x : int = "constant"{0};
  %x : int = "constant"{1};
  %x : int = "constant"{2};
  %x : int = "constant"{3};
  %x : int = "constant"{4};
}]

def eg_scf_ite_true : Region := [dsl_region| {
  %cond : int = "constant"{1};
  %out : int = "if" (%cond : int) [{
    %out_then : int = "constant"{42};
  }, {
    %out_else : int = "constant"{0};
  }];
}]

def eg_scf_ite_false : Region := [dsl_region| {
  %cond : int = "constant"{0};
  %out : int = "if" (%cond : int) [{
    %out_then : int = "constant"{42};
  }, {
    %out_else : int = "constant"{0};
  }];
}]

def eg_scf_run_twice : Region := [dsl_region| {
  %x : int = "constant"{41};
  %x : int = "twice" [{
      %one : int = "constant"{1};
      %xone = tuple(%x : int, %one : int);
      %x : int = "add"(%xone : int × int);
  }];
}]

def eg_scf_well_scoped : Region := [dsl_region| {
  %x : int = "constant"{41};
  %one : int = "constant"{1}; -- one is outside.
  %x : int = "twice" [{
      %xone = tuple(%x : int, %one : int); -- one is accessed here.
      %x : int = "add"(%xone : int × int);
  }];
}]

def eg_scf_ill_scoped : Region := [dsl_region| {
  %x : int = "constant"{41};
  %x : int = "twice" [{
      %y : int = "constant"{42};
  }];
  -- %y should NOT be accessible here
  %out = tuple(%y : int, %y : int);
}]

def eg_scf_for: Region := [dsl_region| {
  %x : int = "constant"{10};  -- 10 iterations
  %init : int = "constant"{32}; -- start value
  %xinit = tuple(%x : int, %init : int);
  %out : int = "for"(%xinit : int × int)[{
    ^(%xcur : int):
      %one : int = "constant"{1};
      %xcur_one = tuple(%xcur : int, %one : int);
      %xnext : int = "add"(%xcur_one : int × int);
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
  findbegin: TypingCtx -- free variables.
  findmid : Ops -- stuff in the pattern. The last op is to be replaced.
  replace : Ops -- replacement ops. can use 'findbegin'.
  sem: (o : Op') → TopM (Kind.eval o.retkind)
  -- TODO: Once again, we need to reason 'upto error'.
  replaceCorrect: ∀ (env: Env) (findval : NamedVal)
      (FIND: findmid.denote sem env = .ok findval),
      (replace.denote sem) env = .ok findval
end Rewriting

namespace RewriteExamples
open Rewriting
open AST
section SubXX
-- x - x ~= 0

theorem Int.sub_n_n (n: Int) : n - n = 0 := by {
  linarith
}

def sub_x_x_equals_zero (res: String) (arg: String) (pairname: String) : Peephole := {
  findbegin := .cons ⟨arg, .int⟩ .nil,
  findmid :=
      let pair := Expr.tuple pairname ⟨arg, .int⟩ ⟨arg, .int⟩
      let sub := Op.mk
                  (name := "sub")
                  (ret := ⟨res, .int⟩)
                  (arg := ⟨pairname, .pair .int .int⟩)
      .opscons pair (.opsone sub),
  replace :=
    let const := Op.mk
                  (name := "constant")
                  (ret := ⟨res, .int⟩)
                  (const := Const.int 0)
    .opsone (const),
  sem := Arith.sem,
  replaceCorrect := fun env findval  => by {
    simp only;
    rw[Expr.denote_opscons];
    rw[Expr.denote_tuple];
    simp  only [Kind.eval._eq_1, bind_assoc];
    simp[bind, ReaderT.bind];
    cases ARG:TopM.get { name := arg, kind := Kind.int } env <;> simp;
    case error e => {
      simp only [Except.isOk, Except.toBool, Except.bind, IsEmpty.forall_iff]
    }
    case ok v => {
      simp only [Except.bind, TopM.set, NamedVal.var, Function.comp_apply]
      rw[Expr.denote_opsone];
      rw[Expr.denote_op];
      simp only[bind, ReaderT.bind, Except.bind];
      simp only[Kind.eval, Kind.eval._eq_1, Var.toNamedVal]
      simp only[Env.set];
      rw[TopM.get.cons_eq];
      simp only;
      rw[Expr.denote_opsone];
      rw[Expr.denote_op];
      simp[bind, ReaderT.bind, Except.bind]
      rw[TopM.get.Var.unit];
      simp only;
      simp only [Expr.denote_regionsnil];
      -- simp only bug:
      -- simp only [Arith.sem, Kind.eval._eq_1, Arith.sem.match_1.eq_3, sub_self, Arith.sem.match_1.eq_1]
      simp[Arith.sem];
      simp only[Int.sub_n_n, pure, ReaderT.pure, Except.pure];
      intros FINDVAL;
      simp[FINDVAL];
    }
  }
 }

end SubXX

section ForFusion
-- peel loop iterations out.

def for_fusion (r: Region) (n m : String)
  (n_plus_m n_m: String)
  (out1 out2: String)
  (n_init m_out1: String)
  (init init_n_plus_m: String) : Peephole := {
  findbegin := .cons ⟨out1, .int⟩ (TypingCtx.cons ⟨out2, .int⟩
               (.cons ⟨init, .int⟩
               (.cons ⟨n, .int⟩
               (.cons ⟨m, .int⟩ .nil))))
  findmid :=
      let n_init_op := Expr.tuple n_init ⟨n, .int⟩ ⟨out1, .int⟩
      let loop1 := Op.mk
                  (name := "for")
                  (ret := ⟨out1, .int⟩)
                  (arg := ⟨n_init, .pair .int .int⟩)
                  (regions := .regionscons r .regionsnil)
      let m_out1_op := Expr.tuple m_out1 ⟨m, .int⟩ ⟨out2, .int⟩
      let loop2 := Op.mk
                  (name := "for")
                  (ret := ⟨out2, .int⟩)
                  (arg := ⟨m_out1, .pair .int .int⟩)
                  (regions := .regionscons r .regionsnil)
      .opscons n_init_op (.opscons loop1 (.opscons m_out1_op (.opsone loop2))),
  replace :=
    let n_m_op := Expr.tuple n_m ⟨n, .int⟩ ⟨m, .int⟩
    let n_plus_m_op := Op.mk (ret := ⟨n_plus_m, .int⟩) (name := "add") (arg := ⟨n_m, .int⟩)
    let init_n_plus_m_op := Expr.tuple init_n_plus_m ⟨init, .int⟩ ⟨n_plus_m, .int⟩
    let loop_nm_op :=
        Op.mk
          (name := "for")
          (ret := ⟨out1, .int⟩)
          (arg := ⟨init_n_plus_m, .pair .int .int⟩)
          (regions := .regionscons r .regionsnil)
    .opsone (loop_nm_op),
  sem := Combine.combineSem Scf.sem Arith.sem,
  replaceCorrect := fun env findval => by {
    dsimp only;
    dsimp only [Except.bind, TopM.set, NamedVal.var, Function.comp_apply];
    rw[Expr.denote_opscons];
    rw[Expr.denote_tuple];
    dsimp only [bind, ReaderT.bind, Except.bind, TopM.set, NamedVal.var, Function.comp_apply];
    cases NVAL:TopM.get { name := n, kind := Kind.int } env;
    case error => simp only[Except.isOk, Except.toBool, IsEmpty.forall_iff];
    case ok nval =>
    dsimp only;
    cases OUT_ONE_VAL:TopM.get { name := out1, kind := Kind.int } env;
    case error => simp only[Except.isOk, Except.toBool, IsEmpty.forall_iff];
    case ok out1_val =>
    dsimp only;
    repeat rw[Expr.denote_opscons];
    repeat rw[Expr.denote_tuple];
    repeat rw[Expr.denote_regionscons];
    repeat rw[Expr.denote_regionsnil];
    repeat rw[Expr.denote_opsone];
    repeat rw[Expr.denote_op];
    dsimp only;

    dsimp only[Combine.combineSem, Arith.sem, Scf.sem, Except.orElseLazy];
    sorry
  }
}
end ForFusion

end RewriteExamples


namespace RewritingHoare
open AST
open Rewriting
/-
A theory of rewriting, plus helper lemmas phrased along a hoare logic.
-/
-- https://softwarefoundations.cis.upenn.edu/plf-current/Hoare.html
def assertion (t: Type) : Type := t → Prop
def assertion_implies (P Q: assertion T) : Prop := ∀ (e: T), P e → Q e

notation P:80 "->>" Q:80 => assertion_implies P Q

abbrev assertion_iff (P Q: assertion T) : Prop := P ->> Q ∧ Q ->> P
notation P:80 "<<->>" Q:80 => assertion_iff P Q

-- def hoare_triple_region (P: assertion Env) (r: Expr .R) (Q: assertion (Except ErrorKind NamedVal)) : Prop :=
--  ∀ (e: Env) (sem : (o : Op') → TopM o.retkind.eval) (v: Val), P e -> Q (r.denote sem v e)

-- P op Q: for all environments where P env holds, so does Q (env[op.name := op.val]).
def hoare_triple_op (P: assertion Env) (r: Expr .O) (Q: assertion Env) : Prop :=
 ∀ (e: Env) (nv: NamedVal) (sem : (o : Op') → TopM o.retkind.eval) (SEM: r.denote sem e = .ok nv),
   P e -> Q (e.set { name := nv.name, kind := nv.kind} nv.val)

-- P ops Q: for all environments where 'P env' holds, 'Q returnval' holds.
def hoare_triple_ops (P: assertion Env) (r: Expr .Os) (Q: assertion NamedVal) : Prop :=
 ∀ (e: Env) (retval: NamedVal) (sem : (o : Op') → TopM o.retkind.eval) (SEM: r.denote sem e = .ok retval),
   P e -> Q retval

def assertion_and (P Q: assertion T) : assertion T := fun (v: T) => P v ∧ Q v
notation P:80 "h∧" Q:80 => assertion_and P Q -- how does this work?

-- lift an assertion about values into ones about environments.
def assertion.val2env (var: Var) (Q: assertion NamedVal) :  assertion Env :=
  fun env => ∃ (val: var.kind.eval), env.get var = .ok val ∧ Q (var.toNamedVal val)

-- for (P (ops_single op) Q) to hold, we need (P op (fun env => Q(env[op.ret]) to hold.
-- In more words, for Q to hold at the value of 'op', we create the assertion
-- on the full environment that 'Q' holds at 'op.ret' of the environment.
theorem hoare_triple_ops.single (P: assertion Env) (Q: assertion NamedVal)
 (op: Op)
 (PQ: hoare_triple_op P op (Q.val2env op.ret)) :
  hoare_triple_ops P (Expr.opsone op) Q := by {
    simp[hoare_triple_op, hoare_triple_ops] at *;
    intros e retval sem EVAL_OPSONE PEWITNESS;
    have ⟨retval_val, RETVAL⟩:= Expr.denote_opsone_inv EVAL_OPSONE;
    specialize PQ e retval sem EVAL_OPSONE PEWITNESS;
    cases RETVAL;
    case refl => {
      simp at PQ;
      simp[assertion.val2env] at PQ;
      have ⟨val, ⟨ENV_AT_RET, QVAL⟩⟩ := PQ
      simp[Env.get, pure, Except.pure] at ENV_AT_RET;
      cases ENV_AT_RET <;> simp[QVAL];
    }
  }

-- hoare triple for sequencing o with os.
theorem hoare_triple_ops.cons (P Q R) (o: Op) (os: Ops) (PQ: hoare_triple_op P o Q)
 (QR: hoare_triple_ops Q os R) : hoare_triple_ops P (.opscons o os) R := by {
  dsimp only[hoare_triple_ops];
  intros envbegin outval sem DENOTECONS;
  have ⟨oval', OSEM, OS_SEM⟩ := Expr.denote_opscons_inv DENOTECONS;
  dsimp only[hoare_triple_ops] at QR;
  dsimp only[hoare_triple_op] at PQ;
  intros P_AT_ENVBEGIN;
  apply QR (SEM := OS_SEM);
  specialize PQ envbegin (Var.toNamedVal (Op.ret o) oval') sem;
  apply PQ (SEM := OSEM);
  apply P_AT_ENVBEGIN;
 }


-- Weaken precondition: (P' ->> P) /\ P c Q => P' c Q
theorem hoare_triple_op.precondition (P P' Q) (o: Op) (PQ: hoare_triple_op P o Q) (P'P: P' ->> P) :
  hoare_triple_op P' o Q := by {
    simp[hoare_triple_op] at *;
    simp[assertion_implies] at *;
    intros e nv sem EVAL P'e_HOLDS;
    apply PQ (sem := sem) (nv := nv) (e := e) (SEM := EVAL)
    simp[P'P,P'e_HOLDS];
}

-- Strengthen postcondition
theorem hoare_triple_op.postcondition (P Q Q') (o: Op) (PQ: hoare_triple_op P o Q) (QQ': Q ->> Q') :
  hoare_triple_op P o Q' := by {
    simp[hoare_triple_op] at *;
    simp[assertion_implies] at *;
    intros e nv sem EVAL Pe_HOLDS;
    apply QQ';
    apply PQ (sem := sem) (nv := nv) (e := e) (SEM := EVAL);
    apply Pe_HOLDS;
}


-- more conceptual proof, still does not use full hoare logic machinery, only a fragment.
section SubXXHoare
-- x - x ~= 0

theorem Int.sub_n_n (n: Int) : n - n = 0 := by {
  linarith
}

def rewriteCorrect' (find : Ops) -- stuff in the pattern. The last op is to be replaced.
  (replace : Ops) -- replacement ops. can use 'findbegin'.
  (sem: (o : Op') → TopM (Kind.eval o.retkind)) : Prop :=
  ∀ (findnv: NamedVal), -- for all values ...
  hoare_triple_ops
    (fun env => find.denote sem env = .ok findnv) -- that find produces...
    replace
    (fun replacenv => findnv = replacenv) -- replace must produce the same value.


def sub_x_x_equals_zero (res: String) (arg: String) (pairname: String) : Peephole := {
  findbegin := .cons ⟨arg, .int⟩ .nil,
  findmid := [dsl_ops|
    % $(pairname) = tuple( %$(arg) : int, %$(arg) : int);
    % $(res) : int = "sub"( %$(pairname) : int × int);
  ]
  replace := [dsl_ops|
    % $(res) : int = "constant" {0};
  ]
  sem := Arith.sem,
  replaceCorrect := fun env findval S0 => by {
    dsimp only at *;
    have ⟨x0, ⟨S1, S2⟩⟩ := Expr.denote_opscons_inv S0;
    simp [Op.ret] at *;
    have ⟨x1, ⟨X1, ⟨x2, ⟨X2, S3⟩⟩⟩⟩ := Expr.denote_tuple_inv S1;
    simp at S3;
    cases S3; case refl => {
      have ⟨x3, X3⟩ := Expr.denote_opsone_assign_inv S2;
      simp[Env.get, pure, Except.pure] at X3;
      have ⟨x1x2_eq_x3, ⟨x4, ⟨X4, X5⟩⟩⟩ := X3
      simp at *;
      cases x1x2_eq_x3; case refl => {
        cases X5; case refl => {
          simp[Op.ret, Op.mk] at *;
          -- now simplify RHS
          dsimp only[Expr.denote_opsone];
          dsimp only[Expr.denote_op];
          dsimp only[bind, ReaderT.bind, Except.bind, TopM.get_unit];
          simp only[TopM.get_unit]; -- TODO: Example where 'simp' is necessary!
          simp only[Arith.sem, Expr.denote, pure, ReaderT.pure, Except.pure];
          simp only[Op'.fromOp, Arith.sem, Expr.denote] at X4;
          simp[pure, ReaderT.pure, Except.pure] at X4;
          simp[X4];
          have X1_EQ_X2 : Except.ok x1 = Except.ok x2 := by {
            rw [<- X1, <- X2];
          }
          injection X1_EQ_X2 with X1_EQ_X2;
          simp[X1_EQ_X2] at X4;
          simp[X4];
        }
      }
    }
    }
 }

end SubXXHoare


section ForFusionHoare
-- peel loop iterations out.

def for_fusion (r: Region) (n m : String)
  (n_plus_m n_m: String)
  (out1 out2: String)
  (n_init m_out1: String)
  (init n_plus_m_init: String) : Peephole := {
  findbegin :=
    .cons ⟨out1, .int⟩ (TypingCtx.cons ⟨out2, .int⟩
               (.cons ⟨init, .int⟩
               (.cons ⟨n, .int⟩
               (.cons ⟨m, .int⟩ .nil))))
  findmid := [dsl_ops|
    % $(n_init) = tuple( %$(n) : int, %$(init) : int);
    % $(out1) : int = "for" ( %$(n_init) : int × int) [$(r)];
    % $(m_out1) = tuple( %$(m) : int, %$(out1) : int);
    % $(out2) : int = "for" ( %$(m_out1) : int × int) [$(r)];
  ]
  replace := [dsl_ops|
    % $(n_m) = tuple( %$(n) : int, %$(m) : int);
    % $(n_plus_m) : int = "add" ( %$(n_m) : int × int);
    % $(n_plus_m_init) = tuple( %$(n_plus_m) : int, %$(init) : int);
    % $(out2) : int = "for" ( %$(n_plus_m_init) : int × int) [$(r)];
  ]
  sem := Combine.combineSem Scf.sem Arith.sem,
  replaceCorrect := fun env1 findval S1_ => by {
    simp at *; -- simplify builders.
    have ⟨x1, S1, env2, ENV2, S2_⟩ := Expr.denote_opscons_inv' S1_;
    clear S1_;
    -- how to clear shadowed vars, so I don't need the jank S2_?
    have ⟨x2, S2, env3, ENV3, S3_⟩ := Expr.denote_opscons_inv' S2_;
    clear S2_;
    have ⟨x3, S3, env4, ENV4, S4_⟩ := Expr.denote_opscons_inv' S3_;
    clear S3_;
    simp at x1; simp at x2; simp at x3;
    have ⟨x11, X11, x12, X12, S11⟩ := Expr.denote_tuple_inv S1;
    clear S1;
    -- instruction 1: n_init
    simp at S11;
    cases S11; case refl => -- exploit 'Eq' type in dependent pattern matches as well.
    simp at x11; simp at x12;
    simp at ENV2;
    -- instruction 2: out1
    -- -- extract out input
    have ⟨x2in, X2in, x2out, X2OUT, S21⟩ := Expr.denote_op_assign_inv S2;
    simp at x2in; simp at X2in; simp at x2out; simp at X2OUT;
    simp[ENV2] at X2in;
    simp[Env.get_set_eq] at X2in;
    cases X2in; case refl =>
    -- -- reason about computation
    simp at S21;
    cases S21; case refl =>
    dsimp[Op'.fromOp] at X2OUT;
    rw[Expr.denote_regionscons] at X2OUT;
    rw[Expr.denote_regionsnil] at X2OUT;
    -- | this needs to be a 'simp', not a 'dsimp', because the match
    -- is complex?
    sorry
  }
}
end ForFusionHoare


end RewritingHoare


namespace Theorems

end Theorems

namespace Test
def runRegionTest :
  (sem: (o: Op') → TopM o.retkind.eval) →
  (r: AST.Region) →
  (expected: NamedVal) →
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
  (sem: (o: Op') → TopM o.retkind.eval) →
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


open Arith Scf Combine DSL Examples Test in
def main : IO UInt32 := do
  let tests :=
  [runRegionTest
    (sem := Arith.sem)
    (r := eg_region_sub)
    (expected := { name := "x", kind := .int, val := -1}),
  runRegionTest
    (sem := Arith.sem)
    (r := eg_arith_shadow)
    (expected := { name := "x", kind := .int, val := 4}),
   runRegionTest
    (sem := Combine.combineSem Scf.sem Arith.sem)
    (r := eg_scf_ite_true)
    (expected := { name := "out", kind := .int, val := 42}),
  runRegionTest
    (sem := Combine.combineSem Scf.sem Arith.sem)
    (r := eg_scf_ite_false)
    (expected := { name := "out", kind := .int, val := 0}),
  runRegionTest
    (sem := Combine.combineSem Scf.sem Arith.sem)
    (r := eg_scf_run_twice)
    (expected := { name := "x", kind := .int, val := 42}),
  runRegionTest
    (sem := Combine.combineSem Scf.sem Arith.sem)
    (r := eg_scf_well_scoped)
    (expected := { name := "x", kind := .int, val := 42}),
  runRegionTestXfail
    (sem := Combine.combineSem Scf.sem Arith.sem)
    (r := eg_scf_ill_scoped),
  runRegionTest
    (sem := Combine.combineSem Scf.sem Arith.sem)
    (r := eg_scf_for)
    (expected := { name := "out", kind := .int, val := 42})]
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