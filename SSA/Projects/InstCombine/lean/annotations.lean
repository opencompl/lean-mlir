
def do_not_add_annotation_to_existing_instr_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 0 : i32}> : () -> i32
  %1 = llvm.add %arg0, %arg1 : i32
  %2 = llvm.add %0, %1 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def do_not_add_annotation_to_existing_instr_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = llvm.add %arg0, %arg1 : i32
  "llvm.return"(%0) : (i32) -> ()
}
]
theorem do_not_add_annotation_to_existing_instr_proof : do_not_add_annotation_to_existing_instr_before ⊑ do_not_add_annotation_to_existing_instr_after := by
  sorry


