"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %2 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<struct<"struct.Key", (struct<(i32, i32)>)>>
    %3 = "llvm.alloca"(%1) : (i32) -> !llvm.ptr<i32>
    %4 = "llvm.bitcast"(%0) : (i32) -> i32
    %5 = "llvm.getelementptr"(%2, %0, %0) : (!llvm.ptr<struct<"struct.Key", (struct<(i32, i32)>)>>, i32, i32) -> !llvm.ptr<struct<(i32, i32)>>
    %6 = "llvm.getelementptr"(%5, %0, %0) : (!llvm.ptr<struct<(i32, i32)>>, i32, i32) -> !llvm.ptr<i32>
    "llvm.store"(%0, %6) : (i32, !llvm.ptr<i32>) -> ()
    %7 = "llvm.getelementptr"(%5, %0, %1) : (!llvm.ptr<struct<(i32, i32)>>, i32, i32) -> !llvm.ptr<i32>
    "llvm.store"(%0, %7) : (i32, !llvm.ptr<i32>) -> ()
    %8 = "llvm.getelementptr"(%2, %0, %0) : (!llvm.ptr<struct<"struct.Key", (struct<(i32, i32)>)>>, i32, i32) -> !llvm.ptr<struct<(i32, i32)>>
    %9 = "llvm.bitcast"(%8) : (!llvm.ptr<struct<(i32, i32)>>) -> !llvm.ptr<i64>
    "llvm.store"(%arg0, %9) : (i64, !llvm.ptr<i64>) -> ()
    %10 = "llvm.call"(%2, %3) {callee = @foo, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<"struct.Key", (struct<(i32, i32)>)>>, !llvm.ptr<i32>) -> i32
    %11 = "llvm.load"(%3) : (!llvm.ptr<i32>) -> i32
    "llvm.return"(%11) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<i32 (i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<i32 (...)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
