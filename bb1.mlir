{ 
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() <{value = 1 : i32}> : () -> i32
    %1 = "llvm.add"(%arg0, %0) <{overflowFlags = #llvm.overflow<nsw,nuw>}> : (i32, i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
 }
