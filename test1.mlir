{ 
^entry(%0 : i32):
 %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
 %2 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
 %3 = "llvm.ashr"(%0, %2) : (i32, i32) -> i32
 %4 = "llvm.and"(%3, %1) : (i32, i32) -> i32
 %5 = "llvm.add"(%4, %3) : (i32, i32) -> i32
"llvm.return"(%5) : (i32) -> ()
 }
