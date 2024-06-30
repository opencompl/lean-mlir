"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: i32):  // no predecessors
    %0 = "llvm.getelementptr"(%arg0, %arg1) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    %1 = "llvm.load"(%0) : (!llvm.ptr<i32>) -> i32
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<void (ptr<i32>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: i32):  // no predecessors
    %0 = "llvm.zext"(%arg1) : (i32) -> i64
    %1 = "llvm.getelementptr"(%arg0, %0) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %2 = "llvm.load"(%1) : (!llvm.ptr<i32>) -> i32
    "llvm.call"(%2) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<void (ptr<i32>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 48 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 40 : i64} : () -> i64
    %2 = "llvm.getelementptr"(%arg0, %1) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %3 = "llvm.getelementptr"(%2, %0) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %4 = "llvm.load"(%3) : (!llvm.ptr<i32>) -> i32
    %5 = "llvm.getelementptr"(%2, %4) : (!llvm.ptr<i32>, i32) -> !llvm.ptr<i32>
    %6 = "llvm.load"(%5) : (!llvm.ptr<i32>) -> i32
    "llvm.call"(%6) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<void (ptr<i32>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 48 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 40 : i64} : () -> i64
    %2 = "llvm.getelementptr"(%arg0, %1) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %3 = "llvm.getelementptr"(%2, %0) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %4 = "llvm.load"(%3) : (!llvm.ptr<i32>) -> i32
    %5 = "llvm.sext"(%4) : (i32) -> i64
    %6 = "llvm.getelementptr"(%2, %5) : (!llvm.ptr<i32>, i64) -> !llvm.ptr<i32>
    %7 = "llvm.load"(%6) : (!llvm.ptr<i32>) -> i32
    "llvm.call"(%7) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<void (ptr<i32>, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
