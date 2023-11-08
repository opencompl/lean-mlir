"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<array<100 x struct<(i8, i8, i8)>>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -4 : i32} : () -> i32
    %1 = "llvm.bitcast"(%arg0) : (!llvm.ptr<array<100 x struct<(i8, i8, i8)>>>) -> !llvm.ptr<i8>
    %2 = "llvm.getelementptr"(%1, %0) : (!llvm.ptr<i8>, i32) -> !llvm.ptr<i8>
    "llvm.return"(%2) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<ptr<i8> (ptr<array<100 x struct<(i8, i8, i8)>>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
