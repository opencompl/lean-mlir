
-- TODO: move these tests to a separate file.
---- Failing Tests
import Medusa.BitVec.BVGeneralize

-- set_option trace.profiler true
-- set_option trace.profiler.threshold 1
-- set_option trace.Generalize true


variable {x y : BitVec 32}

/--
info: Processing constants assignment: {}
---
info: Performing deductive search
---
info: Could not find a generalized form from just deductive search
---
info: Performing enumerative search using a sketch of the LHS
---
info: Performing bottom-up enumerative search one level at a time
---
info: Running with 0 allowed conjunctions
---
info: Negative examples for ((signExtend 8 (zeroExtend 7 var1#7})}) == (zeroExtend 8 var1#7})) : [{1 → 0x40#7},
 {1 → 0x7f#7},
 {1 → 0x5f#7}]
---
info: Precondition Synthesis: Processing level 0
---
info: Raw generalization result: (if (((true && (var9482#8 <u var9481#8)) && (var9483#8 <u var9481#8)) && (var9482#8 == var9483#8)) ((signExtend 8 (zeroExtend 7 var1#7})}) == (zeroExtend 8 var1#7})) false) ⏎
 Input expression: BitVec.signExtend 34 (BitVec.zeroExtend 33 x) =
  BitVec.zeroExtend 34
    x has generalization: (h : (((w2 <u w)) && (w3 <u w)) && (w2 = w3)) : (BitVec.signExtend w BitVec.zeroExtend w3 x = BitVec.zeroExtend w x)
-/
#guard_msgs in #generalize BitVec.signExtend 34 (BitVec.zeroExtend 33 x) = BitVec.zeroExtend 34 x

def generalized : Prop := ∀ (w w2 w3 : Nat) (x : BitVec w), (h : (((w2 < w)) ∧ (w3 < w)) ∧ (w2 = w3)) →
    (BitVec.signExtend w (BitVec.zeroExtend w3 x) = BitVec.zeroExtend w x)

/-- Show that hydra produces an incorrect generalization. -/
theorem generalized_false : ¬ generalized := by 
  simp [generalized]
  exists 1 

/-- info: 'generalized_false' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in#print axioms generalized_false




