import SSA.Projects.InstCombine.tests.proofs.gicmphtopbitssame_proof
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
section gicmphtopbitssame_statements

def testi16i8_before := [llvm|
{
^0(%arg12 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.lshr %arg12, %0 : i16
  %3 = llvm.trunc %2 : i16 to i8
  %4 = llvm.trunc %arg12 : i16 to i8
  %5 = llvm.ashr %4, %1 : i8
  %6 = llvm.icmp "eq" %5, %3 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
def testi16i8_after := [llvm|
{
^0(%arg12 : i16):
  %0 = llvm.mlir.constant(128 : i16) : i16
  %1 = llvm.mlir.constant(256 : i16) : i16
  %2 = llvm.add %arg12, %0 : i16
  %3 = llvm.icmp "ult" %2, %1 : i16
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem testi16i8_proof : testi16i8_before ⊑ testi16i8_after := by
  unfold testi16i8_before testi16i8_after
  simp_alive_peephole
  intros
  ---BEGIN testi16i8
  apply testi16i8_thm
  ---END testi16i8



def testi16i8_com_before := [llvm|
{
^0(%arg11 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.lshr %arg11, %0 : i16
  %3 = llvm.trunc %2 : i16 to i8
  %4 = llvm.trunc %arg11 : i16 to i8
  %5 = llvm.ashr %4, %1 : i8
  %6 = llvm.icmp "eq" %3, %5 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
def testi16i8_com_after := [llvm|
{
^0(%arg11 : i16):
  %0 = llvm.mlir.constant(128 : i16) : i16
  %1 = llvm.mlir.constant(256 : i16) : i16
  %2 = llvm.add %arg11, %0 : i16
  %3 = llvm.icmp "ult" %2, %1 : i16
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem testi16i8_com_proof : testi16i8_com_before ⊑ testi16i8_com_after := by
  unfold testi16i8_com_before testi16i8_com_after
  simp_alive_peephole
  intros
  ---BEGIN testi16i8_com
  apply testi16i8_com_thm
  ---END testi16i8_com



def testi16i8_ne_before := [llvm|
{
^0(%arg10 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.lshr %arg10, %0 : i16
  %3 = llvm.trunc %2 : i16 to i8
  %4 = llvm.trunc %arg10 : i16 to i8
  %5 = llvm.ashr %4, %1 : i8
  %6 = llvm.icmp "ne" %5, %3 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
def testi16i8_ne_after := [llvm|
{
^0(%arg10 : i16):
  %0 = llvm.mlir.constant(-128 : i16) : i16
  %1 = llvm.mlir.constant(-256 : i16) : i16
  %2 = llvm.add %arg10, %0 : i16
  %3 = llvm.icmp "ult" %2, %1 : i16
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem testi16i8_ne_proof : testi16i8_ne_before ⊑ testi16i8_ne_after := by
  unfold testi16i8_ne_before testi16i8_ne_after
  simp_alive_peephole
  intros
  ---BEGIN testi16i8_ne
  apply testi16i8_ne_thm
  ---END testi16i8_ne



def testi16i8_ne_com_before := [llvm|
{
^0(%arg9 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.mlir.constant(7 : i8) : i8
  %2 = llvm.lshr %arg9, %0 : i16
  %3 = llvm.trunc %2 : i16 to i8
  %4 = llvm.trunc %arg9 : i16 to i8
  %5 = llvm.ashr %4, %1 : i8
  %6 = llvm.icmp "ne" %3, %5 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
def testi16i8_ne_com_after := [llvm|
{
^0(%arg9 : i16):
  %0 = llvm.mlir.constant(-128 : i16) : i16
  %1 = llvm.mlir.constant(-256 : i16) : i16
  %2 = llvm.add %arg9, %0 : i16
  %3 = llvm.icmp "ult" %2, %1 : i16
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem testi16i8_ne_com_proof : testi16i8_ne_com_before ⊑ testi16i8_ne_com_after := by
  unfold testi16i8_ne_com_before testi16i8_ne_com_after
  simp_alive_peephole
  intros
  ---BEGIN testi16i8_ne_com
  apply testi16i8_ne_com_thm
  ---END testi16i8_ne_com



def testi64i32_before := [llvm|
{
^0(%arg8 : i64):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.lshr %arg8, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  %4 = llvm.trunc %arg8 : i64 to i32
  %5 = llvm.ashr %4, %1 : i32
  %6 = llvm.icmp "eq" %5, %3 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
def testi64i32_after := [llvm|
{
^0(%arg8 : i64):
  %0 = llvm.mlir.constant(2147483648) : i64
  %1 = llvm.mlir.constant(4294967296) : i64
  %2 = llvm.add %arg8, %0 : i64
  %3 = llvm.icmp "ult" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem testi64i32_proof : testi64i32_before ⊑ testi64i32_after := by
  unfold testi64i32_before testi64i32_after
  simp_alive_peephole
  intros
  ---BEGIN testi64i32
  apply testi64i32_thm
  ---END testi64i32



def testi64i32_ne_before := [llvm|
{
^0(%arg7 : i64):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.lshr %arg7, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  %4 = llvm.trunc %arg7 : i64 to i32
  %5 = llvm.ashr %4, %1 : i32
  %6 = llvm.icmp "ne" %5, %3 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
def testi64i32_ne_after := [llvm|
{
^0(%arg7 : i64):
  %0 = llvm.mlir.constant(-2147483648) : i64
  %1 = llvm.mlir.constant(-4294967296) : i64
  %2 = llvm.add %arg7, %0 : i64
  %3 = llvm.icmp "ult" %2, %1 : i64
  "llvm.return"(%3) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem testi64i32_ne_proof : testi64i32_ne_before ⊑ testi64i32_ne_after := by
  unfold testi64i32_ne_before testi64i32_ne_after
  simp_alive_peephole
  intros
  ---BEGIN testi64i32_ne
  apply testi64i32_ne_thm
  ---END testi64i32_ne



def wrongimm2_before := [llvm|
{
^0(%arg4 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.lshr %arg4, %0 : i16
  %3 = llvm.trunc %2 : i16 to i8
  %4 = llvm.trunc %arg4 : i16 to i8
  %5 = llvm.ashr %4, %1 : i8
  %6 = llvm.icmp "eq" %5, %3 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
def wrongimm2_after := [llvm|
{
^0(%arg4 : i16):
  %0 = llvm.mlir.constant(8 : i16) : i16
  %1 = llvm.mlir.constant(6 : i8) : i8
  %2 = llvm.lshr %arg4, %0 : i16
  %3 = llvm.trunc %2 overflow<nuw> : i16 to i8
  %4 = llvm.trunc %arg4 : i16 to i8
  %5 = llvm.ashr %4, %1 : i8
  %6 = llvm.icmp "eq" %5, %3 : i8
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem wrongimm2_proof : wrongimm2_before ⊑ wrongimm2_after := by
  unfold wrongimm2_before wrongimm2_after
  simp_alive_peephole
  intros
  ---BEGIN wrongimm2
  apply wrongimm2_thm
  ---END wrongimm2



def slt_before := [llvm|
{
^0(%arg3 : i64):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.lshr %arg3, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  %4 = llvm.trunc %arg3 : i64 to i32
  %5 = llvm.ashr %4, %1 : i32
  %6 = llvm.icmp "slt" %5, %3 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
def slt_after := [llvm|
{
^0(%arg3 : i64):
  %0 = llvm.mlir.constant(32) : i64
  %1 = llvm.mlir.constant(31 : i32) : i32
  %2 = llvm.lshr %arg3, %0 : i64
  %3 = llvm.trunc %2 overflow<nuw> : i64 to i32
  %4 = llvm.trunc %arg3 : i64 to i32
  %5 = llvm.ashr %4, %1 : i32
  %6 = llvm.icmp "slt" %5, %3 : i32
  "llvm.return"(%6) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem slt_proof : slt_before ⊑ slt_after := by
  unfold slt_before slt_after
  simp_alive_peephole
  intros
  ---BEGIN slt
  apply slt_thm
  ---END slt


