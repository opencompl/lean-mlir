import SSA.Projects.LLVMRiscV.ParseAndTransform
import SSA.Projects.RISCV64.ParseAndTransform
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open LLVM
open BitVec

/-!
CHeck that
^bb0(%arg0: i64, %arg1: i64, %arg2: i1):
"llvm.return"(%arg0) : (i64) -> ()

is parsed correctly.
-/

/--
builtin.module {
^bb0(%0 : i64, %1 : i64, %2 : i1):
  "llvm.return"(%0) : (i64) -> ()
 }
-/

def test_multi_args := [llvm|
{
^0(%arg0 : i64):
  %0 = llvm.trunc %arg0 : i64 to i32
  %1 = llvm.zext %0 : i32 to i64
  "llvm.return"(%1) : (i64) -> ()
}
]

#eval Com.toPrint test_multi_args
