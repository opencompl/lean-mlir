"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "cond", type = !llvm.func<i1 ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use_and_return", type = !llvm.func<ptr<i32> (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.stacksave", type = !llvm.func<ptr<i8> ()>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.stackrestore", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 13 : i32} : () -> i32
    %1 = "llvm.call"() {callee = @cond, fastmathFlags = #llvm.fastmath<>} : () -> i1
    "llvm.cond_br"(%1)[^bb3, ^bb1] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb1:  // pred: ^bb0
    %2 = "llvm.alloca"(%arg0) : (i32) -> !llvm.ptr<i32>
    %3 = "llvm.call"() {callee = @llvm.stacksave, fastmathFlags = #llvm.fastmath<>} : () -> !llvm.ptr<i8>
    %4 = "llvm.call"() {callee = @cond, fastmathFlags = #llvm.fastmath<>} : () -> i1
    "llvm.cond_br"(%4)[^bb3, ^bb2] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %5 = "llvm.call"(%2) {callee = @use_and_return, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i32>) -> !llvm.ptr<i32>
    "llvm.store"(%0, %5) : (i32, !llvm.ptr<i32>) -> ()
    "llvm.call"(%3) {callee = @llvm.stackrestore, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    %6 = "llvm.call"(%5) {callee = @use_and_return, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i32>) -> !llvm.ptr<i32>
    "llvm.br"()[^bb3] : () -> ()
  ^bb3:  // 3 preds: ^bb0, ^bb1, ^bb2
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<void (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
