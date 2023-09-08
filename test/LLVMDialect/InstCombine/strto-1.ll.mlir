"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strtol", type = !llvm.func<i32 (ptr<i8>, ptr<ptr<i8>>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strtod", type = !llvm.func<f64 (ptr<i8>, ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strtof", type = !llvm.func<f32 (ptr<i8>, ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strtoul", type = !llvm.func<i64 (ptr<i8>, ptr<ptr<i8>>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strtoll", type = !llvm.func<i64 (ptr<i8>, ptr<ptr<i8>>, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strtold", type = !llvm.func<f64 (ptr<i8>, ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "strtoull", type = !llvm.func<i64 (ptr<i8>, ptr<ptr<i8>>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.mlir.null"() : () -> !llvm.ptr<ptr<i8>>
    %2 = "llvm.call"(%arg0, %1, %0) {callee = @strtol, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify1", type = !llvm.func<void (ptr<i8>, ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<ptr<i8>>
    %1 = "llvm.call"(%arg0, %0) {callee = @strtod, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> f64
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify2", type = !llvm.func<void (ptr<i8>, ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<ptr<i8>>
    %1 = "llvm.call"(%arg0, %0) {callee = @strtof, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> f32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify3", type = !llvm.func<void (ptr<i8>, ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.mlir.null"() : () -> !llvm.ptr<ptr<i8>>
    %2 = "llvm.call"(%arg0, %1, %0) {callee = @strtoul, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify4", type = !llvm.func<void (ptr<i8>, ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.mlir.null"() : () -> !llvm.ptr<ptr<i8>>
    %2 = "llvm.call"(%arg0, %1, %0) {callee = @strtoll, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify5", type = !llvm.func<void (ptr<i8>, ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<ptr<i8>>
    %1 = "llvm.call"(%arg0, %0) {callee = @strtold, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>) -> f64
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify6", type = !llvm.func<void (ptr<i8>, ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.mlir.null"() : () -> !llvm.ptr<ptr<i8>>
    %2 = "llvm.call"(%arg0, %1, %0) {callee = @strtoull, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i64
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify7", type = !llvm.func<void (ptr<i8>, ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @strtol, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<ptr<i8>>, i32) -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_simplify1", type = !llvm.func<void (ptr<i8>, ptr<ptr<i8>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
