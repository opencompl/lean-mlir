"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 1 : i64, sym_name = "S", type = !llvm.array<33 x i8>, value = "panic: restorelist inconsistency\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "h", type = !llvm.array<2 x i8>, value = "h\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "hel", type = !llvm.array<4 x i8>, value = "hel\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "hello_u", type = !llvm.array<8 x i8>, value = "hello_u\00"} : () -> ()
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "UnknownConstant", type = i128} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: !llvm.ptr<i8>, %arg2: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.call"(%arg0, %arg1, %1, %0) {callee = @llvm.memmove.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<void (ptr<i8>, ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>, %arg1: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @S} : () -> !llvm.ptr<array<33 x i8>>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<array<33 x i8>>, i32, i32) -> !llvm.ptr<i8>
    "llvm.call"(%arg0, %3, %arg1, %0) {callee = @llvm.memmove.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<void (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<array<1024 x i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 4 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = false} : () -> i1
    %3 = "llvm.mlir.constant"() {value = 2 : i32} : () -> i32
    %4 = "llvm.mlir.addressof"() {global_name = @hello_u} : () -> !llvm.ptr<array<8 x i8>>
    %5 = "llvm.mlir.addressof"() {global_name = @hel} : () -> !llvm.ptr<array<4 x i8>>
    %6 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %7 = "llvm.mlir.addressof"() {global_name = @h} : () -> !llvm.ptr<array<2 x i8>>
    %8 = "llvm.getelementptr"(%7, %6, %6) : (!llvm.ptr<array<2 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %9 = "llvm.getelementptr"(%5, %6, %6) : (!llvm.ptr<array<4 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %10 = "llvm.getelementptr"(%4, %6, %6) : (!llvm.ptr<array<8 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %11 = "llvm.getelementptr"(%arg0, %6, %6) : (!llvm.ptr<array<1024 x i8>>, i32, i32) -> !llvm.ptr<i8>
    "llvm.call"(%11, %8, %3, %2) {callee = @llvm.memmove.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    "llvm.call"(%11, %9, %1, %2) {callee = @llvm.memmove.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    "llvm.call"(%11, %10, %0, %2) {callee = @llvm.memmove.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<i32 (ptr<array<1024 x i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 100 : i32} : () -> i32
    "llvm.call"(%arg0, %arg0, %1, %0) {callee = @llvm.memmove.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = false} : () -> i1
    %1 = "llvm.mlir.constant"() {value = 16 : i32} : () -> i32
    %2 = "llvm.mlir.addressof"() {global_name = @UnknownConstant} : () -> !llvm.ptr<i128>
    %3 = "llvm.bitcast"(%2) : (!llvm.ptr<i128>) -> !llvm.ptr<i8>
    "llvm.call"(%3, %arg0, %1, %0) {callee = @llvm.memmove.p0i8.p0i8.i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, i32, i1) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "memmove_to_constant", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.memmove.p0i8.p0i8.i32", type = !llvm.func<void (ptr<i8>, ptr<i8>, i32, i1)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
