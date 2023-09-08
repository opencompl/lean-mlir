"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i16} : () -> i16
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.alloca"(%2) : (i32) -> !llvm.ptr<array<3 x struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>>>
    %4 = "llvm.getelementptr"(%3, %1, %1) : (!llvm.ptr<array<3 x struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>>>, i32, i32) -> !llvm.ptr<struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>>
    %5 = "llvm.getelementptr"(%4, %1, %1) : (!llvm.ptr<struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>>, i32, i32) -> !llvm.ptr<struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>>
    %6 = "llvm.getelementptr"(%5, %1, %1) : (!llvm.ptr<struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>>, i32, i32) -> !llvm.ptr<struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>>
    %7 = "llvm.bitcast"(%6) : (!llvm.ptr<struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>>) -> !llvm.ptr<struct<(array<8 x i16>)>>
    %8 = "llvm.getelementptr"(%7, %1, %1) : (!llvm.ptr<struct<(array<8 x i16>)>>, i32, i32) -> !llvm.ptr<array<8 x i16>>
    %9 = "llvm.getelementptr"(%8, %1, %1) : (!llvm.ptr<array<8 x i16>>, i32, i32) -> !llvm.ptr<i16>
    "llvm.store"(%0, %9) : (i16, !llvm.ptr<i16>) -> ()
    "llvm.call"(%9) {callee = @bar, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i16>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<void (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<void (ptr<i16>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: !llvm.ptr<array<3 x struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>>, 1>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 0 : i16} : () -> i16
    %1 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %2 = "llvm.getelementptr"(%arg1, %1, %1) : (!llvm.ptr<array<3 x struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>>, 1>, i32, i32) -> !llvm.ptr<struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>, 1>
    %3 = "llvm.getelementptr"(%2, %1, %1) : (!llvm.ptr<struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>, 1>, i32, i32) -> !llvm.ptr<struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>, 1>
    %4 = "llvm.getelementptr"(%3, %1, %1) : (!llvm.ptr<struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>, 1>, i32, i32) -> !llvm.ptr<struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>, 1>
    %5 = "llvm.bitcast"(%4) : (!llvm.ptr<struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>, 1>) -> !llvm.ptr<struct<(array<8 x i16>)>, 1>
    %6 = "llvm.getelementptr"(%5, %1, %1) : (!llvm.ptr<struct<(array<8 x i16>)>, 1>, i32, i32) -> !llvm.ptr<array<8 x i16>, 1>
    %7 = "llvm.getelementptr"(%6, %1, %1) : (!llvm.ptr<array<8 x i16>, 1>, i32, i32) -> !llvm.ptr<i16, 1>
    "llvm.store"(%0, %7) : (i16, !llvm.ptr<i16, 1>) -> ()
    "llvm.call"(%7) {callee = @bar_as1, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i16, 1>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "foo_as1", type = !llvm.func<void (i32, ptr<array<3 x struct<packed (struct<(struct<(array<2 x struct<(struct<(i32)>)>>, array<2 x i8>, struct<(i16)>, array<2 x i8>, i8, i8)>)>)>>, 1>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "bar_as1", type = !llvm.func<void (ptr<i16, 1>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
