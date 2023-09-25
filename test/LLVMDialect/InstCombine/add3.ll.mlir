"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -16 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = -12 : i32} : () -> i32
    %3 = "llvm.add"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.inttoptr"(%3) : (i32) -> !llvm.ptr<i32>
    "llvm.store"(%1, %4) : (i32, !llvm.ptr<i32>) -> ()
    %5 = "llvm.add"(%arg0, %0) : (i32, i32) -> i32
    %6 = "llvm.inttoptr"(%5) : (i32) -> !llvm.ptr<i32>
    %7 = "llvm.getelementptr"(%6, %1) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    %8 = "llvm.load"(%7) : (!llvm.ptr<i32>) -> i32
    %9 = "llvm.call"(%8) {callee = @callee, fastmathFlags = #llvm.fastmath<>} : (i32) -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<void (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "callee", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
