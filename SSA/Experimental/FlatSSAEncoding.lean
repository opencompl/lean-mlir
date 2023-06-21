import Mathlib.Tactic.Linarith

open Lean

-- Things that are inexpressible in pure expression tree / AST form;
-- (1) sharing
-- %x = <something large>
-- %y = add %x, %x

-- (2) basic block with no arguments
-- func @foo() {
--  ^entry:
--     br entry
-- }

-- (3) basic block arguments / function calls.
-- func @foo() {
--   ^entry(%x):
--      %x2 = add %x, 1
--      br entry(%x2)
-- }

inductive Op where
  | Constant : Nat → Op
  | Add : Op → Op → Op
  | Mul : Op → Op → Op
deriving Repr

def test : Op :=
  let c1 := Op.Constant 1
  let c2 := Op.Constant 2
  .Add c1 c2

  -- I want to replace 'c2' in test with '(.Add (.Constant 1) (.Constant 1))'
  -- However, to lean / as far as we can tell by inspecting 'test', 
  --   test = Op.Add (Op.Constant 1) (Op.Constant 2)
  --
  -- The names 'c1'/'c2' have vanished, since they are not part
  -- of the Op language.
  --
  -- We are unable to study the notion of a "name", and all that comes
  -- with it (rewriting at names, dominance of names, etc.)
#reduce test
  

open Op

def sem : Op → Nat
| .Constant c => c
| .Add a b => sem a + sem b
| .Mul a b => sem a * sem b


/---
#define double(x) = x + x
int foo = double(printf("10")); 
-/

/-
inductive Bound (a: Type) :=
| Named: a -> (a -> Bound r) -> Bound r
-/

inductive OpM (a: Type) :=
| Print_ : Int -> OpM a -> OpM a
| Random_ : (kontinuation : Int -> OpM a) -> OpM a -- (a -> m b)
| Return_ : a -> OpM a

-- https://github.com/leanprover/lean4/blob/35ccf7b1637f758b36bfa90af1dbd135ac372946/src/Lean/Expr.lean#LL418C7-L418C7



-- OffsetOp, indexed by naturals
inductive OffsetOp : Nat -> Type
| Add: OffsetOp 2
| Const : Nat -> OffsetOp 0


-- (v : OffsetOp 2)
-- induction on (OffsetOp 2), you need to 'deduce' that Const can never happen, 
-- v = Add

abbrev FinVec (n: Nat) (α : Type) := Fin n → α  

structure BasicBlock where
  len : Nat
  -- | TODO: generalize index to k-tuples for nesting.
  insts : (ix: Fin len) -> Σ (noperands : Nat), OffsetOp noperands × FinVec noperands (Fin ix)
  
def emptyBB : BasicBlock := {
   len := 0,
   insts := fun ix => Fin.elim0 ix
}


def appendBB (bb: BasicBlock) (inst: OffsetOp noperands)
  (v: FinVec noperands (Fin bb.len)) : BasicBlock := {
    len := bb.len + 1
    insts := fun ix =>
      if H : ix < bb.len
      then bb.insts ⟨ix.val, H⟩
      else 
        have H : Fin bb.len = Fin ix := by 
          have : ix = bb.len := by linarith[ix.isLt]
          simp [this]
        ⟨noperands, inst, H ▸ v⟩  
  }

-- 0 -> Const 2
-- 1 +1 / 2
-- (let x = v in e) <-> (fun x => e)  v
open Lean in 

instance : Pure OpM where
 pure a := .Return_ a
  
def OpM.bind (ma: OpM a) (a2mb: a -> OpM b): OpM b :=
  match ma with
  | .Return_ a => a2mb a
  | .Random_ ka => .Random_ (fun r => bind (ka r) a2mb)
  | .Print_ v opa => .Print_ v (bind opa a2mb)

def OpM.map (f: a -> b) (ma: OpM a) : OpM b := 
  match ma with
  | .Return_ a => .Return_ (f a)
  | .Random_ ka => .Random_ (fun r => OpM.map f (ka r))
  | .Print_ v ma => .Print_ v (OpM.map f ma)

instance : Seq OpM where
  seq m_a2b unit2ma := 
    let ma := unit2ma (); OpM.bind m_a2b (fun a2b => OpM.map a2b ma)

  -- seqLeft : {α β : Type u} → f α → (Unit → f β) → f α
instance : SeqLeft OpM where
  seqLeft ma unit2mb := OpM.bind ma (fun a => OpM.map (fun _ => a) (unit2mb ()) )


-- seqRight : {α β : Type u} → f α → (Unit → f β) → f β
instance : SeqRight OpM where
  seqRight ma unit2mb := OpM.bind ma (fun _ => unit2mb () )
instance : Functor OpM where
  map := OpM.map 

instance : Bind OpM where 
  bind := OpM.bind
  
instance : Applicative OpM := ⟨⟩
instance : Monad OpM := ⟨⟩

#check Expr


def print (v: Int): OpM Unit := .Print_ v (.Return_ ())
def random : OpM Int := .Random_ (fun r => .Return_ r)

def testPrint1 : OpM Unit := do
  print 10
  return ()

-- .Print_ 10 (.Return_ PUnit.Unit)
#reduce testPrint1

def testPrint2 : OpM Unit := do
  print 10
  print 11
  return ()

#reduce testPrint2


def testRandom1 : OpM Unit := do
  let x <- random
  print x
  print x
  return ()

-- OpM. Random_
#reduce testRandom1
--  OpM.Random_ fun r => OpM.Print_ r (OpM.Print_ r (OpM.Return_ PUnit.unit))
--  OpM.Random_ fun r => OpM.Print_ r (OpM.Print_ r (OpM.Return_ PUnit.unit))

def testRandom2 : OpM Unit := do
  let r <- random
  let s <- random
  print r
  print s
  return ()
  
#reduce testRandom2

-- OpM.Random_ fun r => OpM.Random_ fun s => OpM.Print_ r (OpM.Print_ s (OpM.Return_ PUnit.unit))

def testRandom3 : OpM Unit := do
  let r <- random
  print r
  print r
  return ()
  
#reduce testRandom3

def testPerverse : OpM Unit := 
 OpM.Random_ fun r => (if r == 10 then print 42 else print 100)
 
#reduce testPerverse
/-
def program : Foo Op := 
  let c1 ← .Constant 1
  return .Add c1 c1 -- /=  .Add (.Constant 1) (.Constant 1)
-/

-- Our processor is unable to represent the constant 42, because the
-- bit pattern leads to the ALU failing.
def semBadALU : Op → Option Nat
| .Constant c => if c == 42 then .none else .some c
| .Add a b => do 
    let va ← semBadALU a
    let vb ← semBadALU b
    return va + vb
| .Mul a b => do 
    let vb ← semBadALU b
    let va ← semBadALU a
    return va * vb
    
#reduce semBadALU

-- Follows trivially from commutativity of addition.
theorem op_comm : sem (.Add a b) = sem (.Add b a) := by
  simp [sem, Nat.add_comm]

-- (a + b) + c = a + (b + c)
theorem op_assoc : sem (.Add (.Add a b) c) = sem (.Add a (.Add b c)) := by
  simp [sem, Nat.add_assoc]

namespace comm

def test1 : Op :=
  let c1 := Op.Constant 1
  let c2 := Op.Constant 2
  Add c1 c2

def test2 : Op :=
  let c1 := Op.Constant 1
  let c2 := Op.Constant 2
  Add c2 c1

theorem sem_comm : sem test1 = sem test2 := by
  simp [sem, test1, test2]

end comm

namespace assoc

def test1 : Op :=
  let c1 := Constant 1
  let c2 := Constant 2
  let c3 := Constant 3
  let sum := Add c1 c2
  Op.Add sum c3

def test2 : Op :=
  let c1 := Constant 1
  let c2 := Constant 2
  let c3 := Constant 3
  let sum := Add c2 c3
  Op.Add c1 sum

theorem sem_assoc : sem test1 = sem test2 := by
  simp [sem, test1, test2]

end assoc

namespace fold

def test1 : Op :=
  let c1 := Constant 1
  let c2 := Constant 2
  Add c1 c2

def test2 : Op := Constant 3

theorem sem_comm : sem test1 = sem test2 := by simp

end fold