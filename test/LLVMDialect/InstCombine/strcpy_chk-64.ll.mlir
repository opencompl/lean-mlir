"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<array<32 x i8>>
    %4 = "llvm.getelementptr"(%3, %1, %1) : (!llvm.ptr<array<32 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %arg0, %0) {callee = @__strcpy_chk, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.call"(%4) {callee = @func2, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "func", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 32 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<array<32 x i8>>
    %4 = "llvm.getelementptr"(%3, %1, %1) : (!llvm.ptr<array<32 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%4, %arg0, %0) {callee = @__strcpy_chk, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.call"(%4) {callee = @func2, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "func_no_null_opt", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "__strcpy_chk", type = !llvm.func<ptr<i8> (ptr<i8>, ptr<i8>, i64)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "func2", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
