"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "memrchr", type = !llvm.func<ptr<i8> (ptr<i8>, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1, %arg2) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    "llvm.return"(%0) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<ptr<i8> (ptr<i8>, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i32, %arg2: i32):  // no predecessors
    %0 = "llvm.call"(%arg0, %arg1, %arg2) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    "llvm.return"(%0) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<ptr<i8> (ptr<i8>, i32, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    "llvm.return"(%1) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<ptr<i8> (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 5 : i32} : () -> i32
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    "llvm.return"(%1) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<ptr<i8> (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @memrchr, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, i32, i32) -> !llvm.ptr<i8>
    "llvm.return"(%1) : (!llvm.ptr<i8>) -> ()
  }) {linkage = 10 : i64, sym_name = "test5", type = !llvm.func<ptr<i8> (ptr<i8>, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
