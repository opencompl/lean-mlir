import SSA.Projects.LLVMRiscV.Pipeline.InstructionLowering
/-! in this file I write all the LLVM instructions in generic syntax and heck wether they are correctly
lowered by my pipeline.
First I check wether when written in generic syntax in Lean it gets lowered,
then I check when written in LLVM IR that it gets lowered,
 -/


-- tested add incl. flags
def llvm_add_test := [LV| {
    ^entry (%lhs: i64, %rhs: i64):
    %1 = "llvm.add"(%lhs, %rhs) <{overflowFlags = #llvm.overflow<"nuw","nsw">}> : (i64, i64) -> (i64)
    "llvm.return" (%1) : (i64) -> ()
  }]
#eval! (selectionPipeFuelSafe llvm_add_test)

-- tested sub incl. flags
def llvm_sub_test := [LV| {
    ^entry (%lhs: i64, %rhs: i64):
    %1 = "llvm.sub"(%lhs, %rhs) <{overflowFlags = #llvm.overflow<"nsw","nuw">}> : (i64, i64) -> (i64)
    "llvm.return" (%1) : (i64) -> ()
  }]
#eval! (selectionPipeFuelSafe llvm_sub)
