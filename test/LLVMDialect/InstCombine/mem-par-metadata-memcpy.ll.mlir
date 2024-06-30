"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 2 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    "llvm.br"(%2)[^bb1] : (i64) -> ()
  ^bb1(%3: i64):  // 2 preds: ^bb0, ^bb3
    %4 = "llvm.icmp"(%3, %arg1) {predicate = 2 : i64} : (i64, i64) -> i1
    "llvm.cond_br"(%4)[^bb2, ^bb4] {operand_segment_sizes = dense<[1, 0, 0]> : vector<3xi32>} : (i1) -> ()
  ^bb2:  // pred: ^bb1
    %5 = "llvm.getelementptr"(%arg0, %3) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %6 = "llvm.add"(%3, %arg1) : (i64, i64) -> i64
    %7 = "llvm.getelementptr"(%arg0, %6) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.call"(%5, %7, %1, %0) {callee = @llvm.memcpy.p0i8.p0i8.i64, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64, i1) -> ()
    "llvm.br"()[^bb3] : () -> ()
  ^bb3:  // pred: ^bb2
    %8 = "llvm.add"(%3, %1) : (i64, i64) -> i64
    "llvm.br"(%8)[^bb1] : (i64) -> ()
  ^bb4:  // pred: ^bb1
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "_Z4testPcl", type = !llvm.func<void (ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memcpy.p0i8.p0i8.i64", type = !llvm.func<void (ptr<i8>, ptr<i8>, i64, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
