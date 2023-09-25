"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 24 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = -4 : i64} : () -> i64
    %2 = "llvm.mul"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.add"(%2, %0) : (i64, i64) -> i64
    %4 = "llvm.alloca"(%3) : (i64) -> !llvm.ptr<i8>
    %5 = "llvm.bitcast"(%4) : (!llvm.ptr<i8>) -> !llvm.ptr<i32>
    "llvm.call"(%5) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<void (i64)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
