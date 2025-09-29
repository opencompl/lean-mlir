
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import LeanMLIR.Dialects.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem demorgan_nor_use2c_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬((x_1 ^^^ -1#8 ||| x) * 23#8 == 0 ||
          8 != 1 && (x_1 ^^^ -1#8 ||| x) ^^^ -1#8 == intMin 8 && (x_1 ^^^ -1#8 ||| x) * 23#8 == -1) =
        true →
    ¬((x ||| x_1 ^^^ -1#8) * 23#8 == 0 ||
            8 != 1 && (x ||| x_1 ^^^ -1#8) ^^^ -1#8 == intMin 8 && (x ||| x_1 ^^^ -1#8) * 23#8 == -1) =
          true →
      ((x_1 ^^^ -1#8 ||| x) ^^^ -1#8).sdiv ((x_1 ^^^ -1#8 ||| x) * 23#8) =
        ((x ||| x_1 ^^^ -1#8) ^^^ -1#8).sdiv ((x ||| x_1 ^^^ -1#8) * 23#8) :=
sorry