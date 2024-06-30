"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "x", type = vector<2xi64>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "xx", type = !llvm.array<13 x vector<2xi64>>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "x.as2", type = vector<2xi64>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @x} : () -> !llvm.ptr<vector<2xi64>>
    %2 = "llvm.getelementptr"(%1, %0) : (!llvm.ptr<vector<2xi64>>, i32) -> !llvm.ptr<vector<2xi64>>
    %3 = "llvm.load"(%2) : (!llvm.ptr<vector<2xi64>>) -> vector<2xi64>
    "llvm.return"(%3) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "static_hem", type = !llvm.func<vector<2xi64> ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @x} : () -> !llvm.ptr<vector<2xi64>>
    %1 = "llvm.getelementptr"(%0, %arg0) : (!llvm.ptr<vector<2xi64>>, i32) -> !llvm.ptr<vector<2xi64>>
    %2 = "llvm.load"(%1) : (!llvm.ptr<vector<2xi64>>) -> vector<2xi64>
    "llvm.return"(%2) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "hem", type = !llvm.func<vector<2xi64> (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @xx} : () -> !llvm.ptr<array<13 x vector<2xi64>>>
    %1 = "llvm.getelementptr"(%0, %arg0, %arg1) : (!llvm.ptr<array<13 x vector<2xi64>>>, i32, i32) -> !llvm.ptr<vector<2xi64>>
    %2 = "llvm.load"(%1) : (!llvm.ptr<vector<2xi64>>) -> vector<2xi64>
    "llvm.return"(%2) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "hem_2d", type = !llvm.func<vector<2xi64> (i32, i32)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @x} : () -> !llvm.ptr<vector<2xi64>>
    %1 = "llvm.load"(%0) : (!llvm.ptr<vector<2xi64>>) -> vector<2xi64>
    "llvm.return"(%1) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<vector<2xi64> ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<vector<2xi64>>
    "llvm.call"(%1) {callee = @kip, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<vector<2xi64>>) -> ()
    %2 = "llvm.load"(%1) : (!llvm.ptr<vector<2xi64>>) -> vector<2xi64>
    "llvm.return"(%2) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<vector<2xi64> ()>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 7 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @x} : () -> !llvm.ptr<vector<2xi64>>
    %2 = "llvm.getelementptr"(%1, %0) : (!llvm.ptr<vector<2xi64>>, i32) -> !llvm.ptr<vector<2xi64>>
    "llvm.store"(%arg0, %2) : (vector<2xi64>, !llvm.ptr<vector<2xi64>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "static_hem_store", type = !llvm.func<void (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @x} : () -> !llvm.ptr<vector<2xi64>>
    %1 = "llvm.getelementptr"(%0, %arg0) : (!llvm.ptr<vector<2xi64>>, i32) -> !llvm.ptr<vector<2xi64>>
    "llvm.store"(%arg1, %1) : (vector<2xi64>, !llvm.ptr<vector<2xi64>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "hem_store", type = !llvm.func<void (i32, vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i32, %arg2: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @xx} : () -> !llvm.ptr<array<13 x vector<2xi64>>>
    %1 = "llvm.getelementptr"(%0, %arg0, %arg1) : (!llvm.ptr<array<13 x vector<2xi64>>>, i32, i32) -> !llvm.ptr<vector<2xi64>>
    "llvm.store"(%arg2, %1) : (vector<2xi64>, !llvm.ptr<vector<2xi64>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "hem_2d_store", type = !llvm.func<void (i32, i32, vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @x} : () -> !llvm.ptr<vector<2xi64>>
    "llvm.store"(%arg0, %0) : (vector<2xi64>, !llvm.ptr<vector<2xi64>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "foo_store", type = !llvm.func<void (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<vector<2xi64>>
    "llvm.call"(%1) {callee = @kip, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<vector<2xi64>>) -> ()
    "llvm.store"(%arg0, %1) : (vector<2xi64>, !llvm.ptr<vector<2xi64>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bar_store", type = !llvm.func<void (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "kip", type = !llvm.func<void (ptr<vector<2xi64>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
