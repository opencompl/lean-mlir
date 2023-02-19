/-
Kinds of values.
-/
inductive Kind where
| kind_a : Kind
| kind_b : Kind
| kind_c : Kind 
| kind_d : Kind
| kind_e : Kind
| kind_f : Kind
| kind_g : Kind
deriving Inhabited, DecidableEq, BEq

-- A binding of 'name' with kind 'Kind'
structure Var where
  name : String
  kind : Kind
deriving Inhabited, DecidableEq, BEq

def Var.unit : Var := { name := "_", kind := .kind_a }

inductive Op: Type where
| op (ret : Var)
   (name : String)
   (arg : List Var): Op 


-- Lean type that corresponds to kind.
@[reducible, simp]
def Kind.eval: Kind -> Type
| .kind_a => Int
| .kind_b => Int
| .kind_c => Int
| .kind_d => Int
| .kind_e => Int
| .kind_f => Int
| .kind_g => Int

-- A kind and a value of that kind.
structure Val where
  kind: Kind
  val: kind.eval
 
-- The return value of an SSA operation, with a name, kind, and value of that kind.
structure NamedVal extends Val where
  name : String  

-- Given a 'Var' of kind 'kind', and a value of type 〚kind⟧, build a 'Val'
def Var.toNamedVal (var: Var) (value: var.kind.eval): NamedVal := 
 { kind := var.kind, val := value, name := var.name }

def NamedVal.var (nv: NamedVal): Var :=
  { name := nv.name, kind := nv.kind }

-- Well typed environments; cons cells of
-- bindings of variables to values of type ⟦var.kind⟧
inductive Env where
| empty: Env
| cons (var: Var) (val: var.kind.eval) (rest: Env): Env 

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

def TopM.set (nv: NamedVal)  (k: TopM α): TopM α := do 
  let e ← StateT.get
  let e' := Env.set nv.var nv.val e
  StateT.set e'
  let out ← k
  StateT.set e 
  return out 

def TopM.error (e: ErrorKind) : TopM α := Except.error e

-- Runtime denotation of an Op, that has evaluated its arguments,
-- and expects a return value of type ⟦retkind⟧ 
inductive Op' where
| mk (name : String) (argval : List Val)

def Op.denote 
 (sem: (o: Op') → TopM Val): Op  → TopM NamedVal 
| .op ret name args  => do 
    let vals ← args.mapM TopM.get
    let op' : Op' := .mk name (vals.map NamedVal.toVal)
    let out ← sem op'
    if ret.kind = out.kind
    then return { name := ret.name,  kind := out.kind, val := out.val : NamedVal }
    else TopM.error "unexpected return kind '{}', expected {}"

def runOp (sem : (o: Op') → TopM Val) (Op: Op)
(env :  Env := Env.empty) : Except ErrorKind (NamedVal × Env) := 
  (Op.denote sem).run env

def sem: (o: Op') → TopM Val
| .mk "a" [⟨.kind_a, _⟩] => return ⟨.kind_a, 0⟩
| .mk "b" [⟨.kind_a, _⟩] => return ⟨.kind_a, 0⟩
| .mk "c" [⟨.kind_a, _⟩] => return ⟨.kind_a, 0⟩
| .mk "d" [⟨.kind_a, _⟩] => return ⟨.kind_a, 0⟩
| .mk "e" [⟨.kind_a, _⟩] => return ⟨.kind_a, 0⟩
| .mk "f" [⟨.kind_a, _⟩] => return ⟨.kind_a, 0⟩
| .mk "g" [⟨.kind_a, _⟩] => return ⟨.kind_a, 0⟩
| .mk "h" [⟨.kind_a, _⟩] => return ⟨.kind_a, 0⟩
| _ => return ⟨.kind_a, 0⟩

set_option maxHeartbeats 200000
theorem Fail: runOp sem (Op.op  Var.unit "float" [Var.unit])   = .ok output  := by {
  -- ERROR:
  -- tactic 'simp' failed, nested error:
  -- (deterministic) timeout at 'whnf', maximum number of heartbeats (200000) has been reached (use 'set_option maxHeartbeats <num>' to set the limit)
  
  simp only[sem]; -- SLOW, but not timeout level slow

}