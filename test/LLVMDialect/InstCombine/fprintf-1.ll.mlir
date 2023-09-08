"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "hello_world", type = !llvm.array<13 x i8>, value = "hello world\0A\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "percent_c", type = !llvm.array<3 x i8>, value = "%c\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "percent_d", type = !llvm.array<3 x i8>, value = "%d\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "percent_f", type = !llvm.array<3 x i8>, value = "%f\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "percent_s", type = !llvm.array<3 x i8>, value = "%s\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "percent_m", type = !llvm.array<3 x i8>, value = "%m\00"} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "fprintf", type = !llvm.func<i32 (ptr<struct<"FILE", ()>>, ptr<i8>, ...)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"FILE", ()>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @hello_world} : () -> !llvm.ptr<array<13 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%arg0, %2) {callee = @fprintf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>) -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify1", type = !llvm.func<void (ptr<struct<"FILE", ()>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"FILE", ()>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 104 : i8} : () -> i8
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @percent_c} : () -> !llvm.ptr<array<3 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%arg0, %3, %0) {callee = @fprintf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>, i8) -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify2", type = !llvm.func<void (ptr<struct<"FILE", ()>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"FILE", ()>>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @hello_world} : () -> !llvm.ptr<array<13 x i8>>
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @percent_s} : () -> !llvm.ptr<array<3 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.getelementptr"(%0, %1, %1) : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %5 = "llvm.call"(%arg0, %3, %4) {callee = @fprintf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify3", type = !llvm.func<void (ptr<struct<"FILE", ()>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"FILE", ()>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 187 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @percent_d} : () -> !llvm.ptr<array<3 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%arg0, %3, %0) {callee = @fprintf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>, i32) -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify4", type = !llvm.func<void (ptr<struct<"FILE", ()>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"FILE", ()>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @hello_world} : () -> !llvm.ptr<array<13 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%arg0, %2) {callee = @fprintf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>) -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_simplify5", type = !llvm.func<void (ptr<struct<"FILE", ()>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"FILE", ()>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1.870000e+00 : f64} : () -> f64
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @percent_f} : () -> !llvm.ptr<array<3 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %4 = "llvm.call"(%arg0, %3, %0) {callee = @fprintf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>, f64) -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_simplify1", type = !llvm.func<void (ptr<struct<"FILE", ()>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"FILE", ()>>, %arg1: f64):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @percent_f} : () -> !llvm.ptr<array<3 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%arg0, %2, %arg1) {callee = @fprintf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>, f64) -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_simplify2", type = !llvm.func<void (ptr<struct<"FILE", ()>>, f64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"FILE", ()>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @hello_world} : () -> !llvm.ptr<array<13 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<13 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%arg0, %2) {callee = @fprintf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_simplify3", type = !llvm.func<i32 (ptr<struct<"FILE", ()>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<struct<"FILE", ()>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @percent_m} : () -> !llvm.ptr<array<3 x i8>>
    %2 = "llvm.getelementptr"(%1, %0, %0) : (!llvm.ptr<array<3 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %3 = "llvm.call"(%arg0, %2) {callee = @fprintf, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<"FILE", ()>>, !llvm.ptr<i8>) -> i32
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test_no_simplify4", type = !llvm.func<void (ptr<struct<"FILE", ()>>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
