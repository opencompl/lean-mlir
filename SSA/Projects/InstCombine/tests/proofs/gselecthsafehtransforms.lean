import SSA.Projects.InstCombine.tests.proofs.gselecthsafehtransforms_proof
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
section gselecthsafehtransforms_statements

def bools_logical_commute0_before := [llvm|
{
^0(%arg108 : i1, %arg109 : i1, %arg110 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg110, %0 : i1
  %3 = "llvm.select"(%2, %arg108, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg110, %arg109, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools_logical_commute0_after := [llvm|
{
^0(%arg108 : i1, %arg109 : i1, %arg110 : i1):
  %0 = "llvm.select"(%arg110, %arg109, %arg108) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools_logical_commute0_proof : bools_logical_commute0_before ⊑ bools_logical_commute0_after := by
  unfold bools_logical_commute0_before bools_logical_commute0_after
  simp_alive_peephole
  ---BEGIN bools_logical_commute0
  apply bools_logical_commute0_thm
  ---END bools_logical_commute0



def bools_logical_commute0_and1_before := [llvm|
{
^0(%arg105 : i1, %arg106 : i1, %arg107 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg107, %0 : i1
  %3 = llvm.and %2, %arg105 : i1
  %4 = "llvm.select"(%arg107, %arg106, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools_logical_commute0_and1_after := [llvm|
{
^0(%arg105 : i1, %arg106 : i1, %arg107 : i1):
  %0 = "llvm.select"(%arg107, %arg106, %arg105) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools_logical_commute0_and1_proof : bools_logical_commute0_and1_before ⊑ bools_logical_commute0_and1_after := by
  unfold bools_logical_commute0_and1_before bools_logical_commute0_and1_after
  simp_alive_peephole
  ---BEGIN bools_logical_commute0_and1
  apply bools_logical_commute0_and1_thm
  ---END bools_logical_commute0_and1



def bools_logical_commute0_and2_before := [llvm|
{
^0(%arg102 : i1, %arg103 : i1, %arg104 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg104, %0 : i1
  %3 = "llvm.select"(%2, %arg102, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.and %arg104, %arg103 : i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools_logical_commute0_and2_after := [llvm|
{
^0(%arg102 : i1, %arg103 : i1, %arg104 : i1):
  %0 = "llvm.select"(%arg104, %arg103, %arg102) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools_logical_commute0_and2_proof : bools_logical_commute0_and2_before ⊑ bools_logical_commute0_and2_after := by
  unfold bools_logical_commute0_and2_before bools_logical_commute0_and2_after
  simp_alive_peephole
  ---BEGIN bools_logical_commute0_and2
  apply bools_logical_commute0_and2_thm
  ---END bools_logical_commute0_and2



def bools_logical_commute0_and1_and2_before := [llvm|
{
^0(%arg99 : i1, %arg100 : i1, %arg101 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg101, %0 : i1
  %2 = llvm.and %1, %arg99 : i1
  %3 = llvm.and %arg101, %arg100 : i1
  %4 = "llvm.select"(%2, %0, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def bools_logical_commute0_and1_and2_after := [llvm|
{
^0(%arg99 : i1, %arg100 : i1, %arg101 : i1):
  %0 = "llvm.select"(%arg101, %arg100, %arg99) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools_logical_commute0_and1_and2_proof : bools_logical_commute0_and1_and2_before ⊑ bools_logical_commute0_and1_and2_after := by
  unfold bools_logical_commute0_and1_and2_before bools_logical_commute0_and1_and2_after
  simp_alive_peephole
  ---BEGIN bools_logical_commute0_and1_and2
  apply bools_logical_commute0_and1_and2_thm
  ---END bools_logical_commute0_and1_and2



def bools_logical_commute1_before := [llvm|
{
^0(%arg96 : i1, %arg97 : i1, %arg98 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg98, %0 : i1
  %3 = "llvm.select"(%arg96, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg98, %arg97, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools_logical_commute1_after := [llvm|
{
^0(%arg96 : i1, %arg97 : i1, %arg98 : i1):
  %0 = "llvm.select"(%arg98, %arg97, %arg96) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools_logical_commute1_proof : bools_logical_commute1_before ⊑ bools_logical_commute1_after := by
  unfold bools_logical_commute1_before bools_logical_commute1_after
  simp_alive_peephole
  ---BEGIN bools_logical_commute1
  apply bools_logical_commute1_thm
  ---END bools_logical_commute1



def bools_logical_commute1_and2_before := [llvm|
{
^0(%arg91 : i1, %arg92 : i1, %arg93 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg93, %0 : i1
  %3 = "llvm.select"(%arg91, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.and %arg93, %arg92 : i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools_logical_commute1_and2_after := [llvm|
{
^0(%arg91 : i1, %arg92 : i1, %arg93 : i1):
  %0 = "llvm.select"(%arg93, %arg92, %arg91) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools_logical_commute1_and2_proof : bools_logical_commute1_and2_before ⊑ bools_logical_commute1_and2_after := by
  unfold bools_logical_commute1_and2_before bools_logical_commute1_and2_after
  simp_alive_peephole
  ---BEGIN bools_logical_commute1_and2
  apply bools_logical_commute1_and2_thm
  ---END bools_logical_commute1_and2



def bools_logical_commute3_and2_before := [llvm|
{
^0(%arg69 : i1, %arg70 : i1, %arg71 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg71, %0 : i1
  %3 = "llvm.select"(%arg69, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.and %arg70, %arg71 : i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools_logical_commute3_and2_after := [llvm|
{
^0(%arg69 : i1, %arg70 : i1, %arg71 : i1):
  %0 = "llvm.select"(%arg71, %arg70, %arg69) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools_logical_commute3_and2_proof : bools_logical_commute3_and2_before ⊑ bools_logical_commute3_and2_after := by
  unfold bools_logical_commute3_and2_before bools_logical_commute3_and2_after
  simp_alive_peephole
  ---BEGIN bools_logical_commute3_and2
  apply bools_logical_commute3_and2_thm
  ---END bools_logical_commute3_and2



def bools2_logical_commute0_before := [llvm|
{
^0(%arg64 : i1, %arg65 : i1, %arg66 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg66, %0 : i1
  %3 = "llvm.select"(%arg66, %arg64, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %arg65, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute0_after := [llvm|
{
^0(%arg64 : i1, %arg65 : i1, %arg66 : i1):
  %0 = "llvm.select"(%arg66, %arg64, %arg65) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools2_logical_commute0_proof : bools2_logical_commute0_before ⊑ bools2_logical_commute0_after := by
  unfold bools2_logical_commute0_before bools2_logical_commute0_after
  simp_alive_peephole
  ---BEGIN bools2_logical_commute0
  apply bools2_logical_commute0_thm
  ---END bools2_logical_commute0



def bools2_logical_commute0_and1_before := [llvm|
{
^0(%arg61 : i1, %arg62 : i1, %arg63 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg63, %0 : i1
  %3 = llvm.and %arg63, %arg61 : i1
  %4 = "llvm.select"(%2, %arg62, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute0_and1_after := [llvm|
{
^0(%arg61 : i1, %arg62 : i1, %arg63 : i1):
  %0 = "llvm.select"(%arg63, %arg61, %arg62) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools2_logical_commute0_and1_proof : bools2_logical_commute0_and1_before ⊑ bools2_logical_commute0_and1_after := by
  unfold bools2_logical_commute0_and1_before bools2_logical_commute0_and1_after
  simp_alive_peephole
  ---BEGIN bools2_logical_commute0_and1
  apply bools2_logical_commute0_and1_thm
  ---END bools2_logical_commute0_and1



def bools2_logical_commute0_and2_before := [llvm|
{
^0(%arg58 : i1, %arg59 : i1, %arg60 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg60, %0 : i1
  %3 = "llvm.select"(%arg60, %arg58, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.and %2, %arg59 : i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute0_and2_after := [llvm|
{
^0(%arg58 : i1, %arg59 : i1, %arg60 : i1):
  %0 = "llvm.select"(%arg60, %arg58, %arg59) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools2_logical_commute0_and2_proof : bools2_logical_commute0_and2_before ⊑ bools2_logical_commute0_and2_after := by
  unfold bools2_logical_commute0_and2_before bools2_logical_commute0_and2_after
  simp_alive_peephole
  ---BEGIN bools2_logical_commute0_and2
  apply bools2_logical_commute0_and2_thm
  ---END bools2_logical_commute0_and2



def bools2_logical_commute0_and1_and2_before := [llvm|
{
^0(%arg55 : i1, %arg56 : i1, %arg57 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg57, %0 : i1
  %2 = llvm.and %arg57, %arg55 : i1
  %3 = llvm.and %1, %arg56 : i1
  %4 = "llvm.select"(%2, %0, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def bools2_logical_commute0_and1_and2_after := [llvm|
{
^0(%arg55 : i1, %arg56 : i1, %arg57 : i1):
  %0 = "llvm.select"(%arg57, %arg55, %arg56) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools2_logical_commute0_and1_and2_proof : bools2_logical_commute0_and1_and2_before ⊑ bools2_logical_commute0_and1_and2_after := by
  unfold bools2_logical_commute0_and1_and2_before bools2_logical_commute0_and1_and2_after
  simp_alive_peephole
  ---BEGIN bools2_logical_commute0_and1_and2
  apply bools2_logical_commute0_and1_and2_thm
  ---END bools2_logical_commute0_and1_and2



def bools2_logical_commute1_before := [llvm|
{
^0(%arg52 : i1, %arg53 : i1, %arg54 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg54, %0 : i1
  %3 = "llvm.select"(%arg52, %arg54, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%2, %arg53, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute1_after := [llvm|
{
^0(%arg52 : i1, %arg53 : i1, %arg54 : i1):
  %0 = "llvm.select"(%arg54, %arg52, %arg53) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools2_logical_commute1_proof : bools2_logical_commute1_before ⊑ bools2_logical_commute1_after := by
  unfold bools2_logical_commute1_before bools2_logical_commute1_after
  simp_alive_peephole
  ---BEGIN bools2_logical_commute1
  apply bools2_logical_commute1_thm
  ---END bools2_logical_commute1



def bools2_logical_commute1_and1_before := [llvm|
{
^0(%arg49 : i1, %arg50 : i1, %arg51 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg51, %0 : i1
  %3 = llvm.and %arg49, %arg51 : i1
  %4 = "llvm.select"(%2, %arg50, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute1_and1_after := [llvm|
{
^0(%arg49 : i1, %arg50 : i1, %arg51 : i1):
  %0 = "llvm.select"(%arg51, %arg49, %arg50) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools2_logical_commute1_and1_proof : bools2_logical_commute1_and1_before ⊑ bools2_logical_commute1_and1_after := by
  unfold bools2_logical_commute1_and1_before bools2_logical_commute1_and1_after
  simp_alive_peephole
  ---BEGIN bools2_logical_commute1_and1
  apply bools2_logical_commute1_and1_thm
  ---END bools2_logical_commute1_and1



def bools2_logical_commute1_and2_before := [llvm|
{
^0(%arg46 : i1, %arg47 : i1, %arg48 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg48, %0 : i1
  %3 = "llvm.select"(%arg46, %arg48, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.and %2, %arg47 : i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute1_and2_after := [llvm|
{
^0(%arg46 : i1, %arg47 : i1, %arg48 : i1):
  %0 = "llvm.select"(%arg48, %arg46, %arg47) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools2_logical_commute1_and2_proof : bools2_logical_commute1_and2_before ⊑ bools2_logical_commute1_and2_after := by
  unfold bools2_logical_commute1_and2_before bools2_logical_commute1_and2_after
  simp_alive_peephole
  ---BEGIN bools2_logical_commute1_and2
  apply bools2_logical_commute1_and2_thm
  ---END bools2_logical_commute1_and2



def bools2_logical_commute1_and1_and2_before := [llvm|
{
^0(%arg43 : i1, %arg44 : i1, %arg45 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg45, %0 : i1
  %2 = llvm.and %arg43, %arg45 : i1
  %3 = llvm.and %1, %arg44 : i1
  %4 = "llvm.select"(%2, %0, %3) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%4) : (i1) -> ()
}
]
def bools2_logical_commute1_and1_and2_after := [llvm|
{
^0(%arg43 : i1, %arg44 : i1, %arg45 : i1):
  %0 = "llvm.select"(%arg45, %arg43, %arg44) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools2_logical_commute1_and1_and2_proof : bools2_logical_commute1_and1_and2_before ⊑ bools2_logical_commute1_and1_and2_after := by
  unfold bools2_logical_commute1_and1_and2_before bools2_logical_commute1_and1_and2_after
  simp_alive_peephole
  ---BEGIN bools2_logical_commute1_and1_and2
  apply bools2_logical_commute1_and1_and2_thm
  ---END bools2_logical_commute1_and1_and2



def bools2_logical_commute2_before := [llvm|
{
^0(%arg40 : i1, %arg41 : i1, %arg42 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg42, %0 : i1
  %3 = "llvm.select"(%arg42, %arg40, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg41, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute2_after := [llvm|
{
^0(%arg40 : i1, %arg41 : i1, %arg42 : i1):
  %0 = "llvm.select"(%arg42, %arg40, %arg41) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools2_logical_commute2_proof : bools2_logical_commute2_before ⊑ bools2_logical_commute2_after := by
  unfold bools2_logical_commute2_before bools2_logical_commute2_after
  simp_alive_peephole
  ---BEGIN bools2_logical_commute2
  apply bools2_logical_commute2_thm
  ---END bools2_logical_commute2



def bools2_logical_commute2_and1_before := [llvm|
{
^0(%arg37 : i1, %arg38 : i1, %arg39 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg39, %0 : i1
  %3 = llvm.and %arg39, %arg37 : i1
  %4 = "llvm.select"(%arg38, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute2_and1_after := [llvm|
{
^0(%arg37 : i1, %arg38 : i1, %arg39 : i1):
  %0 = "llvm.select"(%arg39, %arg37, %arg38) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools2_logical_commute2_and1_proof : bools2_logical_commute2_and1_before ⊑ bools2_logical_commute2_and1_after := by
  unfold bools2_logical_commute2_and1_before bools2_logical_commute2_and1_after
  simp_alive_peephole
  ---BEGIN bools2_logical_commute2_and1
  apply bools2_logical_commute2_and1_thm
  ---END bools2_logical_commute2_and1



def bools2_logical_commute3_nopoison_before := [llvm|
{
^0(%arg27 : i1, %arg28 : i1, %arg29 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg29, %0 : i1
  %3 = "llvm.select"(%arg27, %arg29, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = "llvm.select"(%arg28, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute3_nopoison_after := [llvm|
{
^0(%arg27 : i1, %arg28 : i1, %arg29 : i1):
  %0 = "llvm.select"(%arg29, %arg27, %arg28) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools2_logical_commute3_nopoison_proof : bools2_logical_commute3_nopoison_before ⊑ bools2_logical_commute3_nopoison_after := by
  unfold bools2_logical_commute3_nopoison_before bools2_logical_commute3_nopoison_after
  simp_alive_peephole
  ---BEGIN bools2_logical_commute3_nopoison
  apply bools2_logical_commute3_nopoison_thm
  ---END bools2_logical_commute3_nopoison



def bools2_logical_commute3_and1_before := [llvm|
{
^0(%arg24 : i1, %arg25 : i1, %arg26 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg26, %0 : i1
  %3 = llvm.and %arg24, %arg26 : i1
  %4 = "llvm.select"(%arg25, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %5 = "llvm.select"(%3, %0, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%5) : (i1) -> ()
}
]
def bools2_logical_commute3_and1_after := [llvm|
{
^0(%arg24 : i1, %arg25 : i1, %arg26 : i1):
  %0 = "llvm.select"(%arg26, %arg24, %arg25) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%0) : (i1) -> ()
}
]
theorem bools2_logical_commute3_and1_proof : bools2_logical_commute3_and1_before ⊑ bools2_logical_commute3_and1_after := by
  unfold bools2_logical_commute3_and1_before bools2_logical_commute3_and1_after
  simp_alive_peephole
  ---BEGIN bools2_logical_commute3_and1
  apply bools2_logical_commute3_and1_thm
  ---END bools2_logical_commute3_and1


