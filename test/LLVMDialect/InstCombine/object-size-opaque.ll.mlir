"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"opaque", opaque>>, %arg1: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.bitcast"(%arg0) : (!llvm.ptr<struct<"opaque", opaque>>) -> !llvm.ptr<i8>
    %2 = "llvm.call"(%1, %0, %0, %0) {callee = @llvm.objectsize.i64.p0i8, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i1, i1, i1) -> i64
    "llvm.store"(%2, %arg1) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<void (ptr<struct<"opaque", opaque>>, ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.objectsize.i64.p0i8", type = !llvm.func<i64 (ptr<i8>, i1, i1, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
