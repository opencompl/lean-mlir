import SSA.Projects.InstCombine.tests.proofs.gAddOverFlow_proof
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
section gAddOverFlow_statements

def oppositesign_before := [llvm|
{
^0(%arg32 : i16, %arg33 : i16):
  %0 = llvm.mlir.constant(-32768 : i16) : i16
  %1 = llvm.mlir.constant(32767 : i16) : i16
  %2 = llvm.or %arg32, %0 : i16
  %3 = llvm.and %arg33, %1 : i16
  %4 = llvm.add %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def oppositesign_after := [llvm|
{
^0(%arg32 : i16, %arg33 : i16):
  %0 = llvm.mlir.constant(-32768 : i16) : i16
  %1 = llvm.mlir.constant(32767 : i16) : i16
  %2 = llvm.or %arg32, %0 : i16
  %3 = llvm.and %arg33, %1 : i16
  %4 = llvm.add %2, %3 overflow<nsw> : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem oppositesign_proof : oppositesign_before ⊑ oppositesign_after := by
  unfold oppositesign_before oppositesign_after
  simp_alive_peephole
  intros
  ---BEGIN oppositesign
  apply oppositesign_thm
  ---END oppositesign



def zero_sign_bit_before := [llvm|
{
^0(%arg31 : i16):
  %0 = llvm.mlir.constant(32767 : i16) : i16
  %1 = llvm.mlir.constant(512 : i16) : i16
  %2 = llvm.and %arg31, %0 : i16
  %3 = llvm.add %2, %1 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def zero_sign_bit_after := [llvm|
{
^0(%arg31 : i16):
  %0 = llvm.mlir.constant(32767 : i16) : i16
  %1 = llvm.mlir.constant(512 : i16) : i16
  %2 = llvm.and %arg31, %0 : i16
  %3 = llvm.add %2, %1 overflow<nuw> : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zero_sign_bit_proof : zero_sign_bit_before ⊑ zero_sign_bit_after := by
  unfold zero_sign_bit_before zero_sign_bit_after
  simp_alive_peephole
  intros
  ---BEGIN zero_sign_bit
  apply zero_sign_bit_thm
  ---END zero_sign_bit



def zero_sign_bit2_before := [llvm|
{
^0(%arg29 : i16, %arg30 : i16):
  %0 = llvm.mlir.constant(32767 : i16) : i16
  %1 = llvm.and %arg29, %0 : i16
  %2 = llvm.and %arg30, %0 : i16
  %3 = llvm.add %1, %2 : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def zero_sign_bit2_after := [llvm|
{
^0(%arg29 : i16, %arg30 : i16):
  %0 = llvm.mlir.constant(32767 : i16) : i16
  %1 = llvm.and %arg29, %0 : i16
  %2 = llvm.and %arg30, %0 : i16
  %3 = llvm.add %1, %2 overflow<nuw> : i16
  "llvm.return"(%3) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zero_sign_bit2_proof : zero_sign_bit2_before ⊑ zero_sign_bit2_after := by
  unfold zero_sign_bit2_before zero_sign_bit2_after
  simp_alive_peephole
  intros
  ---BEGIN zero_sign_bit2
  apply zero_sign_bit2_thm
  ---END zero_sign_bit2



def ripple_nsw1_before := [llvm|
{
^0(%arg23 : i16, %arg24 : i16):
  %0 = llvm.mlir.constant(1 : i16) : i16
  %1 = llvm.mlir.constant(-16385 : i16) : i16
  %2 = llvm.and %arg24, %0 : i16
  %3 = llvm.and %arg23, %1 : i16
  %4 = llvm.add %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def ripple_nsw1_after := [llvm|
{
^0(%arg23 : i16, %arg24 : i16):
  %0 = llvm.mlir.constant(1 : i16) : i16
  %1 = llvm.mlir.constant(-16385 : i16) : i16
  %2 = llvm.and %arg24, %0 : i16
  %3 = llvm.and %arg23, %1 : i16
  %4 = llvm.add %2, %3 overflow<nsw,nuw> : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ripple_nsw1_proof : ripple_nsw1_before ⊑ ripple_nsw1_after := by
  unfold ripple_nsw1_before ripple_nsw1_after
  simp_alive_peephole
  intros
  ---BEGIN ripple_nsw1
  apply ripple_nsw1_thm
  ---END ripple_nsw1



def ripple_nsw2_before := [llvm|
{
^0(%arg21 : i16, %arg22 : i16):
  %0 = llvm.mlir.constant(1 : i16) : i16
  %1 = llvm.mlir.constant(-16385 : i16) : i16
  %2 = llvm.and %arg22, %0 : i16
  %3 = llvm.and %arg21, %1 : i16
  %4 = llvm.add %3, %2 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def ripple_nsw2_after := [llvm|
{
^0(%arg21 : i16, %arg22 : i16):
  %0 = llvm.mlir.constant(1 : i16) : i16
  %1 = llvm.mlir.constant(-16385 : i16) : i16
  %2 = llvm.and %arg22, %0 : i16
  %3 = llvm.and %arg21, %1 : i16
  %4 = llvm.add %3, %2 overflow<nsw,nuw> : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ripple_nsw2_proof : ripple_nsw2_before ⊑ ripple_nsw2_after := by
  unfold ripple_nsw2_before ripple_nsw2_after
  simp_alive_peephole
  intros
  ---BEGIN ripple_nsw2
  apply ripple_nsw2_thm
  ---END ripple_nsw2



def ripple_nsw3_before := [llvm|
{
^0(%arg19 : i16, %arg20 : i16):
  %0 = llvm.mlir.constant(-21845 : i16) : i16
  %1 = llvm.mlir.constant(21843 : i16) : i16
  %2 = llvm.and %arg20, %0 : i16
  %3 = llvm.and %arg19, %1 : i16
  %4 = llvm.add %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def ripple_nsw3_after := [llvm|
{
^0(%arg19 : i16, %arg20 : i16):
  %0 = llvm.mlir.constant(-21845 : i16) : i16
  %1 = llvm.mlir.constant(21843 : i16) : i16
  %2 = llvm.and %arg20, %0 : i16
  %3 = llvm.and %arg19, %1 : i16
  %4 = llvm.add %2, %3 overflow<nsw,nuw> : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ripple_nsw3_proof : ripple_nsw3_before ⊑ ripple_nsw3_after := by
  unfold ripple_nsw3_before ripple_nsw3_after
  simp_alive_peephole
  intros
  ---BEGIN ripple_nsw3
  apply ripple_nsw3_thm
  ---END ripple_nsw3



def ripple_nsw4_before := [llvm|
{
^0(%arg17 : i16, %arg18 : i16):
  %0 = llvm.mlir.constant(-21845 : i16) : i16
  %1 = llvm.mlir.constant(21843 : i16) : i16
  %2 = llvm.and %arg18, %0 : i16
  %3 = llvm.and %arg17, %1 : i16
  %4 = llvm.add %3, %2 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def ripple_nsw4_after := [llvm|
{
^0(%arg17 : i16, %arg18 : i16):
  %0 = llvm.mlir.constant(-21845 : i16) : i16
  %1 = llvm.mlir.constant(21843 : i16) : i16
  %2 = llvm.and %arg18, %0 : i16
  %3 = llvm.and %arg17, %1 : i16
  %4 = llvm.add %3, %2 overflow<nsw,nuw> : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ripple_nsw4_proof : ripple_nsw4_before ⊑ ripple_nsw4_after := by
  unfold ripple_nsw4_before ripple_nsw4_after
  simp_alive_peephole
  intros
  ---BEGIN ripple_nsw4
  apply ripple_nsw4_thm
  ---END ripple_nsw4



def ripple_nsw5_before := [llvm|
{
^0(%arg15 : i16, %arg16 : i16):
  %0 = llvm.mlir.constant(-21845 : i16) : i16
  %1 = llvm.mlir.constant(-10923 : i16) : i16
  %2 = llvm.or %arg16, %0 : i16
  %3 = llvm.or %arg15, %1 : i16
  %4 = llvm.add %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def ripple_nsw5_after := [llvm|
{
^0(%arg15 : i16, %arg16 : i16):
  %0 = llvm.mlir.constant(-21845 : i16) : i16
  %1 = llvm.mlir.constant(-10923 : i16) : i16
  %2 = llvm.or %arg16, %0 : i16
  %3 = llvm.or %arg15, %1 : i16
  %4 = llvm.add %2, %3 overflow<nsw> : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ripple_nsw5_proof : ripple_nsw5_before ⊑ ripple_nsw5_after := by
  unfold ripple_nsw5_before ripple_nsw5_after
  simp_alive_peephole
  intros
  ---BEGIN ripple_nsw5
  apply ripple_nsw5_thm
  ---END ripple_nsw5



def ripple_nsw6_before := [llvm|
{
^0(%arg13 : i16, %arg14 : i16):
  %0 = llvm.mlir.constant(-21845 : i16) : i16
  %1 = llvm.mlir.constant(-10923 : i16) : i16
  %2 = llvm.or %arg14, %0 : i16
  %3 = llvm.or %arg13, %1 : i16
  %4 = llvm.add %3, %2 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def ripple_nsw6_after := [llvm|
{
^0(%arg13 : i16, %arg14 : i16):
  %0 = llvm.mlir.constant(-21845 : i16) : i16
  %1 = llvm.mlir.constant(-10923 : i16) : i16
  %2 = llvm.or %arg14, %0 : i16
  %3 = llvm.or %arg13, %1 : i16
  %4 = llvm.add %3, %2 overflow<nsw> : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ripple_nsw6_proof : ripple_nsw6_before ⊑ ripple_nsw6_after := by
  unfold ripple_nsw6_before ripple_nsw6_after
  simp_alive_peephole
  intros
  ---BEGIN ripple_nsw6
  apply ripple_nsw6_thm
  ---END ripple_nsw6



def ripple_no_nsw2_before := [llvm|
{
^0(%arg9 : i16, %arg10 : i16):
  %0 = llvm.mlir.constant(1 : i16) : i16
  %1 = llvm.mlir.constant(32767 : i16) : i16
  %2 = llvm.and %arg10, %0 : i16
  %3 = llvm.and %arg9, %1 : i16
  %4 = llvm.add %2, %3 : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
def ripple_no_nsw2_after := [llvm|
{
^0(%arg9 : i16, %arg10 : i16):
  %0 = llvm.mlir.constant(1 : i16) : i16
  %1 = llvm.mlir.constant(32767 : i16) : i16
  %2 = llvm.and %arg10, %0 : i16
  %3 = llvm.and %arg9, %1 : i16
  %4 = llvm.add %2, %3 overflow<nuw> : i16
  "llvm.return"(%4) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem ripple_no_nsw2_proof : ripple_no_nsw2_before ⊑ ripple_no_nsw2_after := by
  unfold ripple_no_nsw2_before ripple_no_nsw2_after
  simp_alive_peephole
  intros
  ---BEGIN ripple_no_nsw2
  apply ripple_no_nsw2_thm
  ---END ripple_no_nsw2



def PR38021_before := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(-63 : i8) : i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.add %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def PR38021_after := [llvm|
{
^0(%arg0 : i8):
  %0 = llvm.mlir.constant(3 : i8) : i8
  %1 = llvm.mlir.constant(-63 : i8) : i8
  %2 = llvm.lshr %arg0, %0 : i8
  %3 = llvm.add %2, %1 overflow<nsw,nuw> : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem PR38021_proof : PR38021_before ⊑ PR38021_after := by
  unfold PR38021_before PR38021_after
  simp_alive_peephole
  intros
  ---BEGIN PR38021
  apply PR38021_thm
  ---END PR38021


