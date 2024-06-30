"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "g_127", type = i32} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i16):  // no predecessors
    %0 = "llvm.mlir.undef"() : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @g_127} : () -> !llvm.ptr<i32>
    %2 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %3 = "llvm.mlir.constant"() {value = -1734012817166602727 : i64} : () -> i64
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.call"(%arg2, %4) {callee = @rshift_s_s, fastmathFlags = #llvm.fastmath<>} : (i32, i32) -> i32
    %6 = "llvm.sext"(%5) : (i32) -> i64
    %7 = "llvm.or"(%3, %6) : (i64, i64) -> i64
    %8 = "llvm.srem"(%7, %2) : (i64, i64) -> i64
    %9 = "llvm.icmp"(%8, %2) {predicate = 0 : i64} : (i64, i64) -> i1
    %10 = "llvm.zext"(%9) : (i1) -> i32
    "llvm.store"(%10, %1) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.return"(%0) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "func_56", type = !llvm.func<i32 (i32, i32, i32, i16)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "rshift_s_s", type = !llvm.func<i32 (...)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
