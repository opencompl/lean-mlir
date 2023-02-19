inductive Kind where
| k_a : Kind
| k_b : Kind
| k_c : Kind 
| k_d : Kind
| k_e : Kind
| k_f : Kind
deriving Inhabited, DecidableEq, BEq

@[reducible, simp]
def Kind.eval: Kind -> Type
| .k_a => Int
| .k_b => Int
| .k_c => Int
| .k_d => Int
| .k_e => Int
| .k_f => Int

structure Val where
  kind: Kind
  val: kind.eval

inductive Op where
| mk (name : String) (argval : List Val)

def sem: (o: Op) → Val
| .mk "a" [⟨.k_a, _⟩] => ⟨.k_a, 0⟩
| .mk "b" [⟨.k_a, _⟩] => ⟨.k_a, 0⟩
| .mk "c" [⟨.k_a, _⟩] => ⟨.k_a, 0⟩
| .mk "d" [⟨.k_a, _⟩] => ⟨.k_a, 0⟩
| .mk "e" [⟨.k_a, _⟩] => ⟨.k_a, 0⟩
| .mk "f" [⟨.k_a, _⟩] => ⟨.k_a, 0⟩
| .mk "g" [⟨.k_a, _⟩] => ⟨.k_a, 0⟩
| .mk "h" [⟨.k_a, _⟩] => ⟨.k_a, 0⟩
| _ => ⟨.k_a, 0⟩

set_option maxHeartbeats 200000
theorem Fail: sem (.mk "x" [⟨.k_a, 0⟩]) = output  := by {
  -- ERROR:
  -- tactic 'simp' failed, nested error:
  -- (deterministic) timeout at 'whnf', maximum number of heartbeats (200000) has been reached (use 'set_option maxHeartbeats <num>' to set the limit)
  
  simp only[sem]; -- SLOW, but not timeout level slow

}