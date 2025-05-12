{
  ^bb0(%arg0: i32):
    %0 = "llvm.mlir.constant"() {value = 20 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %2 = "llvm.ashr"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.and"(%2, %0) : (i32, i32) -> i32
    %4 = "llvm.add"(%3, %2) : (i32, i32) -> i32
    %5 = "llvm.add"(%4, %3) : (i32, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
}
