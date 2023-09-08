"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "g", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "g_addr1", type = !llvm.func<void (ptr<i8, 1>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.invariant.start.p0i8", type = !llvm.func<ptr<struct<()>> (i64, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.invariant.start.p1i8", type = !llvm.func<ptr<struct<()>> (i64, ptr<i8, 1>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<i8>
    "llvm.store"(%1, %3) : (i8, !llvm.ptr<i8>) -> ()
    %4 = "llvm.call"(%0, %3) {callee = @llvm.invariant.start.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> !llvm.ptr<struct<()>>
    "llvm.call"(%3) {callee = @g, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    %5 = "llvm.load"(%3) : (!llvm.ptr<i8>) -> i8
    "llvm.return"(%5) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "f", type = !llvm.func<i8 ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8, 1>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i8} : () -> i8
    "llvm.store"(%1, %arg0) : (i8, !llvm.ptr<i8, 1>) -> ()
    %2 = "llvm.call"(%0, %arg0) {callee = @llvm.invariant.start.p1i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8, 1>) -> !llvm.ptr<struct<()>>
    "llvm.call"(%arg0) {callee = @g_addr1, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8, 1>) -> ()
    %3 = "llvm.load"(%arg0) : (!llvm.ptr<i8, 1>) -> i8
    "llvm.return"(%3) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "f_addrspace1", type = !llvm.func<i8 (ptr<i8, 1>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
