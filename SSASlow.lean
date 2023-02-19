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

-- Runtime denotation of an Op, that has evaluated its arguments,
-- and expects a return value of type ⟦retkind⟧ 
inductive Op' where
| mk (name : String) (argval : List Val)

def Op.denote 
 (sem: (o: Op') → Val) : Op  → NamedVal 
| .op ret name args  => 
    let vals := args.map (λ _ => { name := "<unk>", kind := .kind_a, val := 0 : NamedVal })
    let op' : Op' := .mk name (vals.map NamedVal.toVal)
    let out := sem op'
    { name := ret.name, kind := out.kind, val := out.val : NamedVal }

def runOp (sem : (o: Op') → Val) (Op: Op) : NamedVal  := 
  (Op.denote sem)

def sem: (o: Op') → Val
| .mk "a" [⟨.kind_a, _⟩] => ⟨.kind_a, 0⟩
| .mk "b" [⟨.kind_a, _⟩] => ⟨.kind_a, 0⟩
| .mk "c" [⟨.kind_a, _⟩] => ⟨.kind_a, 0⟩
| .mk "d" [⟨.kind_a, _⟩] => ⟨.kind_a, 0⟩
| .mk "e" [⟨.kind_a, _⟩] => ⟨.kind_a, 0⟩
| .mk "f" [⟨.kind_a, _⟩] => ⟨.kind_a, 0⟩
| .mk "g" [⟨.kind_a, _⟩] => ⟨.kind_a, 0⟩
| .mk "h" [⟨.kind_a, _⟩] => ⟨.kind_a, 0⟩
| _ => ⟨.kind_a, 0⟩

set_option maxHeartbeats 200000
theorem Fail: runOp sem (Op.op  Var.unit "float" [Var.unit]) = output  := by {
  -- ERROR:
  -- tactic 'simp' failed, nested error:
  -- (deterministic) timeout at 'whnf', maximum number of heartbeats (200000) has been reached (use 'set_option maxHeartbeats <num>' to set the limit)
  
  simp only[sem]; -- SLOW, but not timeout level slow

}