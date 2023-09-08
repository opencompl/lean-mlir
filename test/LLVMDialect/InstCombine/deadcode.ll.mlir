"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = false} : () -> i1
    %2 = "llvm.or"(%1, %1) : (i1, i1) -> i1
    "llvm.cond_br"(%2, %arg0)[^bb1, ^bb2] {operand_segment_sizes = dense<[1, 0, 1]> : vector<3xi32>} : (i1, i32) -> ()
  ^bb1:  // pred: ^bb0
    %3 = "llvm.add"(%arg0, %0) : (i32, i32) -> i32
    "llvm.br"(%3)[^bb2] : (i32) -> ()
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.call"() {callee = @llvm.stacksave, fastmathFlags = #llvm.fastmath<>} : () -> !llvm.ptr<i8>
    %1 = "llvm.alloca"(%arg0) : (i32) -> !llvm.ptr<i32>
    "llvm.return"(%1) : (!llvm.ptr<i32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<ptr<i32> (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.stacksave", type = !llvm.func<ptr<i8> ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.lifetime.start.p0i8", type = !llvm.func<void (i64, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.lifetime.end.p0i8", type = !llvm.func<void (i64, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.undef"() : () -> !llvm.ptr<i8>
    %1 = "llvm.mlir.constant"() {value = -1 : i64} : () -> i64
    "llvm.call"(%1, %0) {callee = @llvm.lifetime.start.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> ()
    "llvm.call"(%1, %0) {callee = @llvm.lifetime.end.p0i8, fastmathFlags = #llvm.fastmath<>} : (i64, !llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
