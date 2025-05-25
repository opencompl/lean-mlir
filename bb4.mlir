{ 
^entry(%0 : i32):
  %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> (i32)
  %2 = "llvm.add true true"(%0, %1) : (i32, i32) -> (i32)
  "return"(%2) : (i32) -> ()
 }
