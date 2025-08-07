import Init.System.IO
import Std.Tactic.BVDecide
-- x x1 : BitVec 64
-- ht : x.smod x1 = 0#64
-- hf : ¬x1 = 0#64 ∧ (x = BitVec.intMin 64 → ¬x1 = 18446744073709551615#64)
-- ⊢ x.toInt.tmod x1.toInt = (x - x1 * x.sdiv x1).toInt
-- def toInt_smod (x y : BitVec w) := x.toInt.fmod (y.toInt)

-- theorem test_lemma (x x1 : BitVec 16) (ht : x.smod x1 = 0#16) (hf : ¬x1 = 0#16 ∧ (x = BitVec.intMin 16 → ¬x1 = -1#16))
--   :  x.srem x1 = (x - x1 * x.sdiv x1):= by bv_decide

def test : IO Unit :=
  have w := 4
  have s := 2^(w-1)
  for xx in [0 : s ] do
    for yy in [0 : s] do
      have x := BitVec.ofInt w (-1)* xx
      have y := BitVec.ofInt w yy*(-1)

      IO.print f!"{ x.toInt.tmod y.toInt} = {(x - y * x.sdiv y).toInt}"

      if x.toInt.tmod y.toInt ≠ (x - y * x.sdiv y).toInt then
        IO.println "FAIL"

      IO.println ""
    IO.println ""
    for xx in [0: s] do
    for yy in [0 : s] do
      have x := BitVec.ofInt w  xx
      have y := BitVec.ofInt w yy*(-1)

      IO.print f!"{ x.toInt.tmod y.toInt} = {(x - y * x.sdiv y).toInt}"

      if x.toInt.tmod y.toInt ≠ (x - y * x.sdiv y).toInt then
        IO.println "FAIL"

      IO.println ""
    IO.println ""
