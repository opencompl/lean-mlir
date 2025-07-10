import SSA.Projects.InstCombine.tests.proofs.gxor2_proof
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
section gxor2_statements

def test0_before := [llvm|
{
^0(%arg123 : i32):
  %0 = llvm.mlir.constant(-2147483648 : i32) : i32
  %1 = llvm.mlir.constant(-1 : i32) : i32
  %2 = llvm.xor %arg123, %0 : i32
  %3 = llvm.icmp "sgt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test0_after := [llvm|
{
^0(%arg123 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg123, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test0_proof : test0_before ⊑ test0_after := by
  unfold test0_before test0_after
  simp_alive_peephole
  intros
  ---BEGIN test0
  apply test0_thm
  ---END test0



def test1_before := [llvm|
{
^0(%arg121 : i32):
  %0 = llvm.mlir.constant(12345 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.xor %arg121, %0 : i32
  %3 = llvm.icmp "slt" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def test1_after := [llvm|
{
^0(%arg121 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg121, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test1_proof : test1_before ⊑ test1_after := by
  unfold test1_before test1_after
  simp_alive_peephole
  intros
  ---BEGIN test1
  apply test1_thm
  ---END test1



def test2_before := [llvm|
{
^0(%arg120 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(145 : i32) : i32
  %2 = llvm.mlir.constant(153 : i32) : i32
  %3 = llvm.and %arg120, %0 : i32
  %4 = llvm.add %3, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test2_after := [llvm|
{
^0(%arg120 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg120, %0 : i32
  %3 = llvm.or disjoint %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test2_proof : test2_before ⊑ test2_after := by
  unfold test2_before test2_after
  simp_alive_peephole
  intros
  ---BEGIN test2
  apply test2_thm
  ---END test2



def test3_before := [llvm|
{
^0(%arg119 : i32):
  %0 = llvm.mlir.constant(145 : i32) : i32
  %1 = llvm.mlir.constant(177 : i32) : i32
  %2 = llvm.mlir.constant(153 : i32) : i32
  %3 = llvm.or %arg119, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test3_after := [llvm|
{
^0(%arg119 : i32):
  %0 = llvm.mlir.constant(32 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.and %arg119, %0 : i32
  %3 = llvm.or disjoint %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test3_proof : test3_before ⊑ test3_after := by
  unfold test3_before test3_after
  simp_alive_peephole
  intros
  ---BEGIN test3
  apply test3_thm
  ---END test3



def test5_before := [llvm|
{
^0(%arg118 : i32):
  %0 = llvm.mlir.constant(1234 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.mlir.constant(1 : i32) : i32
  %3 = llvm.xor %arg118, %0 : i32
  %4 = llvm.lshr %3, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  %6 = llvm.add %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg118 : i32):
  %0 = llvm.mlir.constant(1234 : i32) : i32
  %1 = llvm.mlir.constant(8 : i32) : i32
  %2 = llvm.mlir.constant(5 : i32) : i32
  %3 = llvm.xor %arg118, %0 : i32
  %4 = llvm.lshr %arg118, %1 : i32
  %5 = llvm.xor %4, %2 : i32
  %6 = llvm.add %5, %3 : i32
  "llvm.return"(%6) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test5_proof : test5_before ⊑ test5_after := by
  unfold test5_before test5_after
  simp_alive_peephole
  intros
  ---BEGIN test5
  apply test5_thm
  ---END test5



def test6_before := [llvm|
{
^0(%arg117 : i32):
  %0 = llvm.mlir.constant(1234 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.xor %arg117, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  %4 = llvm.add %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg117 : i32):
  %0 = llvm.mlir.constant(1234 : i32) : i32
  %1 = llvm.mlir.constant(16 : i32) : i32
  %2 = llvm.xor %arg117, %0 : i32
  %3 = llvm.lshr %arg117, %1 : i32
  %4 = llvm.add %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test6_proof : test6_before ⊑ test6_after := by
  unfold test6_before test6_after
  simp_alive_peephole
  intros
  ---BEGIN test6
  apply test6_thm
  ---END test6



def test7_before := [llvm|
{
^0(%arg115 : i32, %arg116 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.or %arg115, %arg116 : i32
  %2 = llvm.xor %arg115, %0 : i32
  %3 = llvm.xor %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test7_after := [llvm|
{
^0(%arg115 : i32, %arg116 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg116, %0 : i32
  %2 = llvm.or %arg115, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test7_proof : test7_before ⊑ test7_after := by
  unfold test7_before test7_after
  simp_alive_peephole
  intros
  ---BEGIN test7
  apply test7_thm
  ---END test7



def test8_before := [llvm|
{
^0(%arg113 : i32, %arg114 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg113, %0 : i32
  %2 = llvm.or %arg113, %arg114 : i32
  %3 = llvm.xor %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test8_after := [llvm|
{
^0(%arg113 : i32, %arg114 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg114, %0 : i32
  %2 = llvm.or %arg113, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test8_proof : test8_before ⊑ test8_after := by
  unfold test8_before test8_after
  simp_alive_peephole
  intros
  ---BEGIN test8
  apply test8_thm
  ---END test8



def test9_before := [llvm|
{
^0(%arg111 : i32, %arg112 : i32):
  %0 = llvm.and %arg111, %arg112 : i32
  %1 = llvm.xor %arg111, %arg112 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test9_after := [llvm|
{
^0(%arg111 : i32, %arg112 : i32):
  %0 = llvm.or %arg111, %arg112 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test9_proof : test9_before ⊑ test9_after := by
  unfold test9_before test9_after
  simp_alive_peephole
  intros
  ---BEGIN test9
  apply test9_thm
  ---END test9



def test9b_before := [llvm|
{
^0(%arg109 : i32, %arg110 : i32):
  %0 = llvm.and %arg109, %arg110 : i32
  %1 = llvm.xor %arg110, %arg109 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test9b_after := [llvm|
{
^0(%arg109 : i32, %arg110 : i32):
  %0 = llvm.or %arg109, %arg110 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test9b_proof : test9b_before ⊑ test9b_after := by
  unfold test9b_before test9b_after
  simp_alive_peephole
  intros
  ---BEGIN test9b
  apply test9b_thm
  ---END test9b



def test10_before := [llvm|
{
^0(%arg107 : i32, %arg108 : i32):
  %0 = llvm.xor %arg107, %arg108 : i32
  %1 = llvm.and %arg107, %arg108 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test10_after := [llvm|
{
^0(%arg107 : i32, %arg108 : i32):
  %0 = llvm.or %arg107, %arg108 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test10_proof : test10_before ⊑ test10_after := by
  unfold test10_before test10_after
  simp_alive_peephole
  intros
  ---BEGIN test10
  apply test10_thm
  ---END test10



def test10b_before := [llvm|
{
^0(%arg105 : i32, %arg106 : i32):
  %0 = llvm.xor %arg105, %arg106 : i32
  %1 = llvm.and %arg106, %arg105 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test10b_after := [llvm|
{
^0(%arg105 : i32, %arg106 : i32):
  %0 = llvm.or %arg105, %arg106 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test10b_proof : test10b_before ⊑ test10b_after := by
  unfold test10b_before test10b_after
  simp_alive_peephole
  intros
  ---BEGIN test10b
  apply test10b_thm
  ---END test10b



def test11_before := [llvm|
{
^0(%arg103 : i32, %arg104 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg104, %arg103 : i32
  %2 = llvm.xor %arg103, %0 : i32
  %3 = llvm.xor %2, %arg104 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test11_after := [llvm|
{
^0(%arg103 : i32, %arg104 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg104, %arg103 : i32
  %2 = llvm.xor %arg103, %arg104 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test11_proof : test11_before ⊑ test11_after := by
  unfold test11_before test11_after
  simp_alive_peephole
  intros
  ---BEGIN test11
  apply test11_thm
  ---END test11



def test11b_before := [llvm|
{
^0(%arg101 : i32, %arg102 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg102, %arg101 : i32
  %2 = llvm.xor %arg101, %0 : i32
  %3 = llvm.xor %2, %arg102 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test11b_after := [llvm|
{
^0(%arg101 : i32, %arg102 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg102, %arg101 : i32
  %2 = llvm.xor %arg101, %arg102 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test11b_proof : test11b_before ⊑ test11b_after := by
  unfold test11b_before test11b_after
  simp_alive_peephole
  intros
  ---BEGIN test11b
  apply test11b_thm
  ---END test11b



def test11c_before := [llvm|
{
^0(%arg99 : i32, %arg100 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg99, %arg100 : i32
  %2 = llvm.xor %arg99, %0 : i32
  %3 = llvm.xor %2, %arg100 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test11c_after := [llvm|
{
^0(%arg99 : i32, %arg100 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg99, %arg100 : i32
  %2 = llvm.xor %arg99, %arg100 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test11c_proof : test11c_before ⊑ test11c_after := by
  unfold test11c_before test11c_after
  simp_alive_peephole
  intros
  ---BEGIN test11c
  apply test11c_thm
  ---END test11c



def test11d_before := [llvm|
{
^0(%arg97 : i32, %arg98 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg97, %arg98 : i32
  %2 = llvm.xor %arg97, %0 : i32
  %3 = llvm.xor %2, %arg98 : i32
  %4 = llvm.and %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test11d_after := [llvm|
{
^0(%arg97 : i32, %arg98 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg97, %arg98 : i32
  %2 = llvm.xor %arg97, %arg98 : i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.and %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test11d_proof : test11d_before ⊑ test11d_after := by
  unfold test11d_before test11d_after
  simp_alive_peephole
  intros
  ---BEGIN test11d
  apply test11d_thm
  ---END test11d



def test11e_before := [llvm|
{
^0(%arg94 : i32, %arg95 : i32, %arg96 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mul %arg95, %arg96 : i32
  %2 = llvm.xor %1, %arg94 : i32
  %3 = llvm.xor %arg94, %0 : i32
  %4 = llvm.xor %1, %3 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test11e_after := [llvm|
{
^0(%arg94 : i32, %arg95 : i32, %arg96 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mul %arg95, %arg96 : i32
  %2 = llvm.xor %1, %arg94 : i32
  %3 = llvm.xor %arg94, %1 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test11e_proof : test11e_before ⊑ test11e_after := by
  unfold test11e_before test11e_after
  simp_alive_peephole
  intros
  ---BEGIN test11e
  apply test11e_thm
  ---END test11e



def test11f_before := [llvm|
{
^0(%arg91 : i32, %arg92 : i32, %arg93 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mul %arg92, %arg93 : i32
  %2 = llvm.xor %1, %arg91 : i32
  %3 = llvm.xor %arg91, %0 : i32
  %4 = llvm.xor %1, %3 : i32
  %5 = llvm.and %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def test11f_after := [llvm|
{
^0(%arg91 : i32, %arg92 : i32, %arg93 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mul %arg92, %arg93 : i32
  %2 = llvm.xor %1, %arg91 : i32
  %3 = llvm.xor %arg91, %1 : i32
  %4 = llvm.xor %3, %0 : i32
  %5 = llvm.and %2, %4 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test11f_proof : test11f_before ⊑ test11f_after := by
  unfold test11f_before test11f_after
  simp_alive_peephole
  intros
  ---BEGIN test11f
  apply test11f_thm
  ---END test11f



def test12_before := [llvm|
{
^0(%arg89 : i32, %arg90 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg90, %0 : i32
  %2 = llvm.and %arg89, %1 : i32
  %3 = llvm.xor %arg89, %0 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test12_after := [llvm|
{
^0(%arg89 : i32, %arg90 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg89, %arg90 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test12_proof : test12_before ⊑ test12_after := by
  unfold test12_before test12_after
  simp_alive_peephole
  intros
  ---BEGIN test12
  apply test12_thm
  ---END test12



def test12commuted_before := [llvm|
{
^0(%arg87 : i32, %arg88 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg88, %0 : i32
  %2 = llvm.and %1, %arg87 : i32
  %3 = llvm.xor %arg87, %0 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test12commuted_after := [llvm|
{
^0(%arg87 : i32, %arg88 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg87, %arg88 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test12commuted_proof : test12commuted_before ⊑ test12commuted_after := by
  unfold test12commuted_before test12commuted_after
  simp_alive_peephole
  intros
  ---BEGIN test12commuted
  apply test12commuted_thm
  ---END test12commuted



def test13_before := [llvm|
{
^0(%arg85 : i32, %arg86 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg85, %0 : i32
  %2 = llvm.xor %arg86, %0 : i32
  %3 = llvm.and %arg85, %2 : i32
  %4 = llvm.xor %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test13_after := [llvm|
{
^0(%arg85 : i32, %arg86 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg85, %arg86 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test13_proof : test13_before ⊑ test13_after := by
  unfold test13_before test13_after
  simp_alive_peephole
  intros
  ---BEGIN test13
  apply test13_thm
  ---END test13



def test13commuted_before := [llvm|
{
^0(%arg83 : i32, %arg84 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg83, %0 : i32
  %2 = llvm.xor %arg84, %0 : i32
  %3 = llvm.and %2, %arg83 : i32
  %4 = llvm.xor %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def test13commuted_after := [llvm|
{
^0(%arg83 : i32, %arg84 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.and %arg83, %arg84 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test13commuted_proof : test13commuted_before ⊑ test13commuted_after := by
  unfold test13commuted_before test13commuted_after
  simp_alive_peephole
  intros
  ---BEGIN test13commuted
  apply test13commuted_thm
  ---END test13commuted



def xor_or_xor_common_op_commute1_before := [llvm|
{
^0(%arg80 : i32, %arg81 : i32, %arg82 : i32):
  %0 = llvm.xor %arg80, %arg82 : i32
  %1 = llvm.or %arg80, %arg81 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute1_after := [llvm|
{
^0(%arg80 : i32, %arg81 : i32, %arg82 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg80, %0 : i32
  %2 = llvm.and %arg81, %1 : i32
  %3 = llvm.xor %2, %arg82 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_or_xor_common_op_commute1_proof : xor_or_xor_common_op_commute1_before ⊑ xor_or_xor_common_op_commute1_after := by
  unfold xor_or_xor_common_op_commute1_before xor_or_xor_common_op_commute1_after
  simp_alive_peephole
  intros
  ---BEGIN xor_or_xor_common_op_commute1
  apply xor_or_xor_common_op_commute1_thm
  ---END xor_or_xor_common_op_commute1



def xor_or_xor_common_op_commute2_before := [llvm|
{
^0(%arg77 : i32, %arg78 : i32, %arg79 : i32):
  %0 = llvm.xor %arg79, %arg77 : i32
  %1 = llvm.or %arg77, %arg78 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute2_after := [llvm|
{
^0(%arg77 : i32, %arg78 : i32, %arg79 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg77, %0 : i32
  %2 = llvm.and %arg78, %1 : i32
  %3 = llvm.xor %2, %arg79 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_or_xor_common_op_commute2_proof : xor_or_xor_common_op_commute2_before ⊑ xor_or_xor_common_op_commute2_after := by
  unfold xor_or_xor_common_op_commute2_before xor_or_xor_common_op_commute2_after
  simp_alive_peephole
  intros
  ---BEGIN xor_or_xor_common_op_commute2
  apply xor_or_xor_common_op_commute2_thm
  ---END xor_or_xor_common_op_commute2



def xor_or_xor_common_op_commute3_before := [llvm|
{
^0(%arg74 : i32, %arg75 : i32, %arg76 : i32):
  %0 = llvm.xor %arg74, %arg76 : i32
  %1 = llvm.or %arg75, %arg74 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute3_after := [llvm|
{
^0(%arg74 : i32, %arg75 : i32, %arg76 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg74, %0 : i32
  %2 = llvm.and %arg75, %1 : i32
  %3 = llvm.xor %2, %arg76 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_or_xor_common_op_commute3_proof : xor_or_xor_common_op_commute3_before ⊑ xor_or_xor_common_op_commute3_after := by
  unfold xor_or_xor_common_op_commute3_before xor_or_xor_common_op_commute3_after
  simp_alive_peephole
  intros
  ---BEGIN xor_or_xor_common_op_commute3
  apply xor_or_xor_common_op_commute3_thm
  ---END xor_or_xor_common_op_commute3



def xor_or_xor_common_op_commute4_before := [llvm|
{
^0(%arg71 : i32, %arg72 : i32, %arg73 : i32):
  %0 = llvm.xor %arg73, %arg71 : i32
  %1 = llvm.or %arg72, %arg71 : i32
  %2 = llvm.xor %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute4_after := [llvm|
{
^0(%arg71 : i32, %arg72 : i32, %arg73 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg71, %0 : i32
  %2 = llvm.and %arg72, %1 : i32
  %3 = llvm.xor %2, %arg73 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_or_xor_common_op_commute4_proof : xor_or_xor_common_op_commute4_before ⊑ xor_or_xor_common_op_commute4_after := by
  unfold xor_or_xor_common_op_commute4_before xor_or_xor_common_op_commute4_after
  simp_alive_peephole
  intros
  ---BEGIN xor_or_xor_common_op_commute4
  apply xor_or_xor_common_op_commute4_thm
  ---END xor_or_xor_common_op_commute4



def xor_or_xor_common_op_commute5_before := [llvm|
{
^0(%arg68 : i32, %arg69 : i32, %arg70 : i32):
  %0 = llvm.xor %arg68, %arg70 : i32
  %1 = llvm.or %arg68, %arg69 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute5_after := [llvm|
{
^0(%arg68 : i32, %arg69 : i32, %arg70 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg68, %0 : i32
  %2 = llvm.and %arg69, %1 : i32
  %3 = llvm.xor %2, %arg70 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_or_xor_common_op_commute5_proof : xor_or_xor_common_op_commute5_before ⊑ xor_or_xor_common_op_commute5_after := by
  unfold xor_or_xor_common_op_commute5_before xor_or_xor_common_op_commute5_after
  simp_alive_peephole
  intros
  ---BEGIN xor_or_xor_common_op_commute5
  apply xor_or_xor_common_op_commute5_thm
  ---END xor_or_xor_common_op_commute5



def xor_or_xor_common_op_commute6_before := [llvm|
{
^0(%arg65 : i32, %arg66 : i32, %arg67 : i32):
  %0 = llvm.xor %arg67, %arg65 : i32
  %1 = llvm.or %arg65, %arg66 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute6_after := [llvm|
{
^0(%arg65 : i32, %arg66 : i32, %arg67 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg65, %0 : i32
  %2 = llvm.and %arg66, %1 : i32
  %3 = llvm.xor %2, %arg67 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_or_xor_common_op_commute6_proof : xor_or_xor_common_op_commute6_before ⊑ xor_or_xor_common_op_commute6_after := by
  unfold xor_or_xor_common_op_commute6_before xor_or_xor_common_op_commute6_after
  simp_alive_peephole
  intros
  ---BEGIN xor_or_xor_common_op_commute6
  apply xor_or_xor_common_op_commute6_thm
  ---END xor_or_xor_common_op_commute6



def xor_or_xor_common_op_commute7_before := [llvm|
{
^0(%arg62 : i32, %arg63 : i32, %arg64 : i32):
  %0 = llvm.xor %arg62, %arg64 : i32
  %1 = llvm.or %arg63, %arg62 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute7_after := [llvm|
{
^0(%arg62 : i32, %arg63 : i32, %arg64 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg62, %0 : i32
  %2 = llvm.and %arg63, %1 : i32
  %3 = llvm.xor %2, %arg64 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_or_xor_common_op_commute7_proof : xor_or_xor_common_op_commute7_before ⊑ xor_or_xor_common_op_commute7_after := by
  unfold xor_or_xor_common_op_commute7_before xor_or_xor_common_op_commute7_after
  simp_alive_peephole
  intros
  ---BEGIN xor_or_xor_common_op_commute7
  apply xor_or_xor_common_op_commute7_thm
  ---END xor_or_xor_common_op_commute7



def xor_or_xor_common_op_commute8_before := [llvm|
{
^0(%arg59 : i32, %arg60 : i32, %arg61 : i32):
  %0 = llvm.xor %arg61, %arg59 : i32
  %1 = llvm.or %arg60, %arg59 : i32
  %2 = llvm.xor %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def xor_or_xor_common_op_commute8_after := [llvm|
{
^0(%arg59 : i32, %arg60 : i32, %arg61 : i32):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.xor %arg59, %0 : i32
  %2 = llvm.and %arg60, %1 : i32
  %3 = llvm.xor %2, %arg61 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_or_xor_common_op_commute8_proof : xor_or_xor_common_op_commute8_before ⊑ xor_or_xor_common_op_commute8_after := by
  unfold xor_or_xor_common_op_commute8_before xor_or_xor_common_op_commute8_after
  simp_alive_peephole
  intros
  ---BEGIN xor_or_xor_common_op_commute8
  apply xor_or_xor_common_op_commute8_thm
  ---END xor_or_xor_common_op_commute8



def test15_before := [llvm|
{
^0(%arg44 : i8, %arg45 : i8):
  %0 = llvm.mlir.constant(33 : i8) : i8
  %1 = llvm.xor %arg45, %arg44 : i8
  %2 = llvm.xor %arg44, %0 : i8
  %3 = llvm.xor %2, %arg45 : i8
  %4 = llvm.and %1, %3 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def test15_after := [llvm|
{
^0(%arg44 : i8, %arg45 : i8):
  %0 = llvm.mlir.constant(33 : i8) : i8
  %1 = llvm.xor %arg45, %arg44 : i8
  %2 = llvm.xor %arg44, %arg45 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.and %1, %3 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test15_proof : test15_before ⊑ test15_after := by
  unfold test15_before test15_after
  simp_alive_peephole
  intros
  ---BEGIN test15
  apply test15_thm
  ---END test15



def test16_before := [llvm|
{
^0(%arg42 : i8, %arg43 : i8):
  %0 = llvm.mlir.constant(33 : i8) : i8
  %1 = llvm.xor %arg43, %arg42 : i8
  %2 = llvm.xor %arg42, %0 : i8
  %3 = llvm.xor %2, %arg43 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
def test16_after := [llvm|
{
^0(%arg42 : i8, %arg43 : i8):
  %0 = llvm.mlir.constant(33 : i8) : i8
  %1 = llvm.xor %arg43, %arg42 : i8
  %2 = llvm.xor %arg42, %arg43 : i8
  %3 = llvm.xor %2, %0 : i8
  %4 = llvm.and %3, %1 : i8
  %5 = llvm.mul %4, %3 : i8
  "llvm.return"(%5) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test16_proof : test16_before ⊑ test16_after := by
  unfold test16_before test16_after
  simp_alive_peephole
  intros
  ---BEGIN test16
  apply test16_thm
  ---END test16



def not_xor_to_or_not1_before := [llvm|
{
^0(%arg39 : i3, %arg40 : i3, %arg41 : i3):
  %0 = llvm.mlir.constant(-1 : i3) : i3
  %1 = llvm.or %arg40, %arg41 : i3
  %2 = llvm.and %arg39, %arg41 : i3
  %3 = llvm.xor %2, %1 : i3
  %4 = llvm.xor %3, %0 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def not_xor_to_or_not1_after := [llvm|
{
^0(%arg39 : i3, %arg40 : i3, %arg41 : i3):
  %0 = llvm.mlir.constant(-1 : i3) : i3
  %1 = llvm.or %arg40, %arg41 : i3
  %2 = llvm.and %arg39, %arg41 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_xor_to_or_not1_proof : not_xor_to_or_not1_before ⊑ not_xor_to_or_not1_after := by
  unfold not_xor_to_or_not1_before not_xor_to_or_not1_after
  simp_alive_peephole
  intros
  ---BEGIN not_xor_to_or_not1
  apply not_xor_to_or_not1_thm
  ---END not_xor_to_or_not1



def not_xor_to_or_not2_before := [llvm|
{
^0(%arg36 : i3, %arg37 : i3, %arg38 : i3):
  %0 = llvm.mlir.constant(-1 : i3) : i3
  %1 = llvm.or %arg38, %arg37 : i3
  %2 = llvm.and %arg36, %arg38 : i3
  %3 = llvm.xor %2, %1 : i3
  %4 = llvm.xor %3, %0 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def not_xor_to_or_not2_after := [llvm|
{
^0(%arg36 : i3, %arg37 : i3, %arg38 : i3):
  %0 = llvm.mlir.constant(-1 : i3) : i3
  %1 = llvm.or %arg38, %arg37 : i3
  %2 = llvm.and %arg36, %arg38 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_xor_to_or_not2_proof : not_xor_to_or_not2_before ⊑ not_xor_to_or_not2_after := by
  unfold not_xor_to_or_not2_before not_xor_to_or_not2_after
  simp_alive_peephole
  intros
  ---BEGIN not_xor_to_or_not2
  apply not_xor_to_or_not2_thm
  ---END not_xor_to_or_not2



def not_xor_to_or_not3_before := [llvm|
{
^0(%arg33 : i3, %arg34 : i3, %arg35 : i3):
  %0 = llvm.mlir.constant(-1 : i3) : i3
  %1 = llvm.or %arg35, %arg34 : i3
  %2 = llvm.and %arg35, %arg33 : i3
  %3 = llvm.xor %2, %1 : i3
  %4 = llvm.xor %3, %0 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def not_xor_to_or_not3_after := [llvm|
{
^0(%arg33 : i3, %arg34 : i3, %arg35 : i3):
  %0 = llvm.mlir.constant(-1 : i3) : i3
  %1 = llvm.or %arg35, %arg34 : i3
  %2 = llvm.and %arg35, %arg33 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_xor_to_or_not3_proof : not_xor_to_or_not3_before ⊑ not_xor_to_or_not3_after := by
  unfold not_xor_to_or_not3_before not_xor_to_or_not3_after
  simp_alive_peephole
  intros
  ---BEGIN not_xor_to_or_not3
  apply not_xor_to_or_not3_thm
  ---END not_xor_to_or_not3



def not_xor_to_or_not4_before := [llvm|
{
^0(%arg30 : i3, %arg31 : i3, %arg32 : i3):
  %0 = llvm.mlir.constant(-1 : i3) : i3
  %1 = llvm.or %arg31, %arg32 : i3
  %2 = llvm.and %arg32, %arg30 : i3
  %3 = llvm.xor %2, %1 : i3
  %4 = llvm.xor %3, %0 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def not_xor_to_or_not4_after := [llvm|
{
^0(%arg30 : i3, %arg31 : i3, %arg32 : i3):
  %0 = llvm.mlir.constant(-1 : i3) : i3
  %1 = llvm.or %arg31, %arg32 : i3
  %2 = llvm.and %arg32, %arg30 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
set_option debug.skipKernelTC true in
theorem not_xor_to_or_not4_proof : not_xor_to_or_not4_before ⊑ not_xor_to_or_not4_after := by
  unfold not_xor_to_or_not4_before not_xor_to_or_not4_after
  simp_alive_peephole
  intros
  ---BEGIN not_xor_to_or_not4
  apply not_xor_to_or_not4_thm
  ---END not_xor_to_or_not4



def xor_notand_to_or_not1_before := [llvm|
{
^0(%arg18 : i3, %arg19 : i3, %arg20 : i3):
  %0 = llvm.mlir.constant(-1 : i3) : i3
  %1 = llvm.or %arg19, %arg20 : i3
  %2 = llvm.and %arg18, %arg20 : i3
  %3 = llvm.xor %2, %0 : i3
  %4 = llvm.xor %3, %1 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def xor_notand_to_or_not1_after := [llvm|
{
^0(%arg18 : i3, %arg19 : i3, %arg20 : i3):
  %0 = llvm.mlir.constant(-1 : i3) : i3
  %1 = llvm.or %arg19, %arg20 : i3
  %2 = llvm.and %arg18, %arg20 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_notand_to_or_not1_proof : xor_notand_to_or_not1_before ⊑ xor_notand_to_or_not1_after := by
  unfold xor_notand_to_or_not1_before xor_notand_to_or_not1_after
  simp_alive_peephole
  intros
  ---BEGIN xor_notand_to_or_not1
  apply xor_notand_to_or_not1_thm
  ---END xor_notand_to_or_not1



def xor_notand_to_or_not2_before := [llvm|
{
^0(%arg15 : i3, %arg16 : i3, %arg17 : i3):
  %0 = llvm.mlir.constant(-1 : i3) : i3
  %1 = llvm.or %arg17, %arg16 : i3
  %2 = llvm.and %arg15, %arg17 : i3
  %3 = llvm.xor %2, %0 : i3
  %4 = llvm.xor %3, %1 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def xor_notand_to_or_not2_after := [llvm|
{
^0(%arg15 : i3, %arg16 : i3, %arg17 : i3):
  %0 = llvm.mlir.constant(-1 : i3) : i3
  %1 = llvm.or %arg17, %arg16 : i3
  %2 = llvm.and %arg15, %arg17 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_notand_to_or_not2_proof : xor_notand_to_or_not2_before ⊑ xor_notand_to_or_not2_after := by
  unfold xor_notand_to_or_not2_before xor_notand_to_or_not2_after
  simp_alive_peephole
  intros
  ---BEGIN xor_notand_to_or_not2
  apply xor_notand_to_or_not2_thm
  ---END xor_notand_to_or_not2



def xor_notand_to_or_not3_before := [llvm|
{
^0(%arg12 : i3, %arg13 : i3, %arg14 : i3):
  %0 = llvm.mlir.constant(-1 : i3) : i3
  %1 = llvm.or %arg14, %arg13 : i3
  %2 = llvm.and %arg14, %arg12 : i3
  %3 = llvm.xor %2, %0 : i3
  %4 = llvm.xor %3, %1 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def xor_notand_to_or_not3_after := [llvm|
{
^0(%arg12 : i3, %arg13 : i3, %arg14 : i3):
  %0 = llvm.mlir.constant(-1 : i3) : i3
  %1 = llvm.or %arg14, %arg13 : i3
  %2 = llvm.and %arg14, %arg12 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_notand_to_or_not3_proof : xor_notand_to_or_not3_before ⊑ xor_notand_to_or_not3_after := by
  unfold xor_notand_to_or_not3_before xor_notand_to_or_not3_after
  simp_alive_peephole
  intros
  ---BEGIN xor_notand_to_or_not3
  apply xor_notand_to_or_not3_thm
  ---END xor_notand_to_or_not3



def xor_notand_to_or_not4_before := [llvm|
{
^0(%arg9 : i3, %arg10 : i3, %arg11 : i3):
  %0 = llvm.mlir.constant(-1 : i3) : i3
  %1 = llvm.or %arg10, %arg11 : i3
  %2 = llvm.and %arg11, %arg9 : i3
  %3 = llvm.xor %2, %0 : i3
  %4 = llvm.xor %3, %1 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
def xor_notand_to_or_not4_after := [llvm|
{
^0(%arg9 : i3, %arg10 : i3, %arg11 : i3):
  %0 = llvm.mlir.constant(-1 : i3) : i3
  %1 = llvm.or %arg10, %arg11 : i3
  %2 = llvm.and %arg11, %arg9 : i3
  %3 = llvm.xor %1, %0 : i3
  %4 = llvm.or %2, %3 : i3
  "llvm.return"(%4) : (i3) -> ()
}
]
set_option debug.skipKernelTC true in
theorem xor_notand_to_or_not4_proof : xor_notand_to_or_not4_before ⊑ xor_notand_to_or_not4_after := by
  unfold xor_notand_to_or_not4_before xor_notand_to_or_not4_after
  simp_alive_peephole
  intros
  ---BEGIN xor_notand_to_or_not4
  apply xor_notand_to_or_not4_thm
  ---END xor_notand_to_or_not4


