import SSA.Projects.InstCombine.tests.LLVM.grem_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open LLVM
open BitVec

open MLIR AST
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
section grem_statements

def test1_before := [llvm|
{
^0(%arg92 : i32):
  %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
  %1 = llvm.srem %arg92, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg92 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test1
  apply test1_thm
  ---END test1



def test3_before := [llvm|
{
^0(%arg91 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = llvm.urem %arg91, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg91 : i32):
  %0 = "llvm.mlir.constant"() <{value = 7 : i32}> : () -> i32
  %1 = llvm.and %arg91, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test3
  apply test3_thm
  ---END test3



def test7_before := [llvm|
{
^0(%arg81 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %2 = llvm.mul %arg81, %0 : i32
  %3 = llvm.srem %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg81 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test7_proof : test7_before ⊑ test7_after := by
  unfold test7_before test7_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test7
  apply test7_thm
  ---END test7



def test8_before := [llvm|
{
^0(%arg80 : i32):
  %0 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %2 = llvm.shl %arg80, %0 : i32
  %3 = llvm.srem %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg80 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test8_proof : test8_before ⊑ test8_after := by
  unfold test8_before test8_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test8
  apply test8_thm
  ---END test8



def test9_before := [llvm|
{
^0(%arg79 : i32):
  %0 = "llvm.mlir.constant"() <{value = 64 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 32 : i32}> : () -> i32
  %2 = llvm.mul %arg79, %0 : i32
  %3 = llvm.urem %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg79 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test9_proof : test9_before ⊑ test9_after := by
  unfold test9_before test9_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test9
  apply test9_thm
  ---END test9



def test11_before := [llvm|
{
^0(%arg77 : i32):
  %0 = "llvm.mlir.constant"() <{value = -2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %3 = llvm.and %arg77, %0 : i32
  %4 = llvm.mul %3, %1 : i32
  %5 = llvm.urem %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg77 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test11_proof : test11_before ⊑ test11_after := by
  unfold test11_before test11_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test11
  apply test11_thm
  ---END test11



def test12_before := [llvm|
{
^0(%arg76 : i32):
  %0 = "llvm.mlir.constant"() <{value = -4 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %2 = llvm.and %arg76, %0 : i32
  %3 = llvm.srem %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg76 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test12_proof : test12_before ⊑ test12_after := by
  unfold test12_before test12_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test12
  apply test12_thm
  ---END test12



def test13_before := [llvm|
{
^0(%arg75 : i32):
  %0 = llvm.srem %arg75, %arg75 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg75 : i32):
  %0 = "llvm.mlir.constant"() <{value = 0 : i32}> : () -> i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem test13_proof : test13_before ⊑ test13_after := by
  unfold test13_before test13_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test13
  apply test13_thm
  ---END test13



def test16_before := [llvm|
{
^0(%arg69 : i32, %arg70 : i32):
  %0 = "llvm.mlir.constant"() <{value = 11 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %2 = llvm.lshr %arg70, %0 : i32
  %3 = llvm.and %2, %1 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.urem %arg69, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test16_after := [llvm|
{
^0(%arg69 : i32, %arg70 : i32):
  %0 = "llvm.mlir.constant"() <{value = 11 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 4 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 3 : i32}> : () -> i32
  %3 = llvm.lshr %arg70, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.or %4, %2 : i32
  %6 = llvm.and %5, %arg69 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
theorem test16_proof : test16_before ⊑ test16_after := by
  unfold test16_before test16_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test16
  apply test16_thm
  ---END test16



def test22_before := [llvm|
{
^0(%arg43 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2147483647 : i32}> : () -> i32
  %1 = llvm.and %arg43, %0 : i32
  %2 = llvm.srem %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test22_after := [llvm|
{
^0(%arg43 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2147483647 : i32}> : () -> i32
  %1 = llvm.and %arg43, %0 : i32
  %2 = llvm.urem %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem test22_proof : test22_before ⊑ test22_after := by
  unfold test22_before test22_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  intros
  try simp
  ---BEGIN test22
  apply test22_thm
  ---END test22
