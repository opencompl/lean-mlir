"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %3 = "llvm.load"(%arg0) : (!llvm.ptr<i32>) -> i32
    %4 = "llvm.bitcast"(%3) : (i32) -> i32
    %5 = "llvm.lshr"(%4, %2) : (i32, i32) -> i32
    %6 = "llvm.bitcast"(%5) : (i32) -> i32
    %7 = "llvm.and"(%6, %1) : (i32, i32) -> i32
    %8 = "llvm.icmp"(%7, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    %9 = "llvm.zext"(%8) : (i1) -> i32
    "llvm.return"(%9) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i32 (ptr<i32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
