import SSA.Projects.InstCombine.tests.proofs.gsignext_proof
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
section gsignext_statements

def sextinreg_before := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mlir.constant(-32768 : i32) : i32
  %2 = llvm.mlir.constant(32768 : i32) : i32
  %3 = llvm.and %arg14, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def sextinreg_after := [llvm|
{
^0(%arg14 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.shl %arg14, %0 : i32
  %2 = llvm.ashr exact %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sextinreg_proof : sextinreg_before ⊑ sextinreg_after := by
  unfold sextinreg_before sextinreg_after
  simp_alive_peephole
  intros
  ---BEGIN sextinreg
  apply sextinreg_thm
  ---END sextinreg



def sextinreg_alt_before := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mlir.constant(32768 : i32) : i32
  %2 = llvm.mlir.constant(-32768 : i32) : i32
  %3 = llvm.and %arg11, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def sextinreg_alt_after := [llvm|
{
^0(%arg11 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.shl %arg11, %0 : i32
  %2 = llvm.ashr exact %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sextinreg_alt_proof : sextinreg_alt_before ⊑ sextinreg_alt_after := by
  unfold sextinreg_alt_before sextinreg_alt_after
  simp_alive_peephole
  intros
  ---BEGIN sextinreg_alt
  apply sextinreg_alt_thm
  ---END sextinreg_alt



def sext_before := [llvm|
{
^0(%arg9 : i16):
  %0 = llvm.mlir.constant(32768 : i32) : i32
  %1 = llvm.mlir.constant(-32768 : i32) : i32
  %2 = llvm.zext %arg9 : i16 to i32
  %3 = llvm.xor %2, %0 : i32
  %4 = llvm.add %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def sext_after := [llvm|
{
^0(%arg9 : i16):
  %0 = llvm.sext %arg9 : i16 to i32
  "llvm.return"(%0) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_proof : sext_before ⊑ sext_after := by
  unfold sext_before sext_after
  simp_alive_peephole
  intros
  ---BEGIN sext
  apply sext_thm
  ---END sext



def sextinreg2_before := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(255 : i32) : i32
  %1 = llvm.mlir.constant(128 : i32) : i32
  %2 = llvm.mlir.constant(-128 : i32) : i32
  %3 = llvm.and %arg6, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def sextinreg2_after := [llvm|
{
^0(%arg6 : i32):
  %0 = llvm.mlir.constant(24 : i32) : i32
  %1 = llvm.shl %arg6, %0 : i32
  %2 = llvm.ashr exact %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sextinreg2_proof : sextinreg2_before ⊑ sextinreg2_after := by
  unfold sextinreg2_before sextinreg2_after
  simp_alive_peephole
  intros
  ---BEGIN sextinreg2
  apply sextinreg2_thm
  ---END sextinreg2



def test5_before := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.shl %arg4, %0 : i32
  %2 = llvm.ashr %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test5_after := [llvm|
{
^0(%arg4 : i32):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.shl %arg4, %0 : i32
  %2 = llvm.ashr exact %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
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
^0(%arg3 : i16):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.zext %arg3 : i16 to i32
  %2 = llvm.shl %1, %0 : i32
  %3 = llvm.ashr %2, %0 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def test6_after := [llvm|
{
^0(%arg3 : i16):
  %0 = llvm.sext %arg3 : i16 to i32
  "llvm.return"(%0) : (i32) -> ()
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



def ashr_before := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.mlir.constant(67108864 : i32) : i32
  %2 = llvm.mlir.constant(-67108864 : i32) : i32
  %3 = llvm.lshr %arg1, %0 : i32
  %4 = llvm.xor %3, %1 : i32
  %5 = llvm.add %4, %2 : i32
  "llvm.return"(%5) : (i32) -> ()
}
]
def ashr_after := [llvm|
{
^0(%arg1 : i32):
  %0 = llvm.mlir.constant(5 : i32) : i32
  %1 = llvm.ashr %arg1, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ashr_proof : ashr_before ⊑ ashr_after := by
  unfold ashr_before ashr_after
  simp_alive_peephole
  intros
  ---BEGIN ashr
  apply ashr_thm
  ---END ashr


