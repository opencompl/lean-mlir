; LLVM IR file containing various other operations (naming frm LLVM reference manual) used to test wether we can parse the
; generic MLIR dialect form of this in Lean-MLIR

; run : mlir-translate -import-llvm otherLLVM.ll | mlir-opt --mlir-print-op-generic > otherLLVM.mlir
; to the nrun the opt tool run: cd ../../../../ && lake exe opt SSA/Projects/LLVMRiscV/tests/Parsing/arithbb0.mlir 

;copy paste your mlir basic block and run lake exe opt SSA/Projects/LLVMRiscV/tests/Parsing/arithbb0.mlir
; from the root folder.

define i32 @select32(i32 %a, i32 %b, i1 %cond) {
entry:
  %res = select i1 %cond, i32 %a, i32 %b
  ret i32 %res
}

define i64 @select64(i64 %a, i64 %b, i1 %cond) {
entry:
  %res = select i1 %cond, i64 %a, i64 %b
  ret i64 %res
}

define i1 @icmp64(i64 %a, i64 %b) {
entry:
  %res = icmp eq i64 %a, %b
  %res1 = icmp ne i64 %a, %b
  %res2 = icmp ugt i64 %a, %b
  %res3 =  icmp uge i64 %a, %b
  %res4 =  icmp ult i64 %a, %b
  %res5 =  icmp ule i64 %a, %b
  %res6 =  icmp sgt i64 %a, %b
  %res7 =  icmp sge i64 %a, %b
  %res8 =  icmp slt i64 %a, %b
  %res9 =  icmp sle i64 %a, %b
  ret i1 %res
}


 define i32 @main(i64 %arg0, i64 %arg1, i32 %arg2, i32 %arg3, i1 %cond) {
  %out = call i32 @select32(i32 %arg2, i32 %arg3, i1 %cond)
  %out1 = call i64 @select64(i64 %arg0, i64 %arg1, i1 %cond)
  %out2 = call i64 @icmp64(i64 %arg0, i64 %arg1)
  ret i32 %out
}