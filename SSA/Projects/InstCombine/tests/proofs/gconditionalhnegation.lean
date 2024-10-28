import SSA.Projects.InstCombine.tests.proofs.gconditionalhnegation_proof
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
section gconditionalhnegation_statements

def t0_before := [llvm|
{
^0(%arg32 : i8, %arg33 : i1):
  %0 = llvm.sext %arg33 : i1 to i8
  %1 = llvm.add %0, %arg32 : i8
  %2 = llvm.xor %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t0_after := [llvm|
{
^0(%arg32 : i8, %arg33 : i1):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg32 : i8
  %2 = "llvm.select"(%arg33, %1, %arg32) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem t0_proof : t0_before ⊑ t0_after := by
  unfold t0_before t0_after
  simp_alive_peephole
  ---BEGIN t0
  apply t0_thm
  ---END t0



def t1_before := [llvm|
{
^0(%arg28 : i8, %arg29 : i1):
  %0 = llvm.sext %arg29 : i1 to i8
  %1 = llvm.sext %arg29 : i1 to i8
  %2 = llvm.add %0, %arg28 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def t1_after := [llvm|
{
^0(%arg28 : i8, %arg29 : i1):
  %0 = "llvm.mlir.constant"() <{value = 0 : i8}> : () -> i8
  %1 = llvm.sub %0, %arg28 : i8
  %2 = "llvm.select"(%arg29, %1, %arg28) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem t1_proof : t1_before ⊑ t1_after := by
  unfold t1_before t1_after
  simp_alive_peephole
  ---BEGIN t1
  apply t1_thm
  ---END t1



def t2_before := [llvm|
{
^0(%arg25 : i8, %arg26 : i1, %arg27 : i1):
  %0 = llvm.sext %arg26 : i1 to i8
  %1 = llvm.sext %arg27 : i1 to i8
  %2 = llvm.add %0, %arg25 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def t2_after := [llvm|
{
^0(%arg25 : i8, %arg26 : i1, %arg27 : i1):
  %0 = llvm.sext %arg26 : i1 to i8
  %1 = llvm.sext %arg27 : i1 to i8
  %2 = llvm.add %arg25, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem t2_proof : t2_before ⊑ t2_after := by
  unfold t2_before t2_after
  simp_alive_peephole
  ---BEGIN t2
  apply t2_thm
  ---END t2



def t3_before := [llvm|
{
^0(%arg23 : i8, %arg24 : i2):
  %0 = llvm.sext %arg24 : i2 to i8
  %1 = llvm.add %0, %arg23 : i8
  %2 = llvm.xor %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
def t3_after := [llvm|
{
^0(%arg23 : i8, %arg24 : i2):
  %0 = llvm.sext %arg24 : i2 to i8
  %1 = llvm.add %arg23, %0 : i8
  %2 = llvm.xor %1, %0 : i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem t3_proof : t3_before ⊑ t3_after := by
  unfold t3_before t3_after
  simp_alive_peephole
  ---BEGIN t3
  apply t3_thm
  ---END t3


