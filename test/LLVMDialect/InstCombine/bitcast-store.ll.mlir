"module"() ( {
  "llvm.mlir.global"() ( {
  }) {constant, linkage = 10 : i64, sym_name = "G", type = !llvm.array<5 x ptr<i8>>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: !llvm.ptr<f32>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (i32) -> f32
    "llvm.store"(%0, %arg1) : (f32, !llvm.ptr<f32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<void (i32, ptr<f32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i8, 1>, %arg1: !llvm.ptr<ptr<i8>>):  // no predecessors
    %0 = "llvm.bitcast"(%arg1) : (!llvm.ptr<ptr<i8>>) -> !llvm.ptr<ptr<i8, 1>>
    "llvm.store"(%arg0, %0) : (!llvm.ptr<i8, 1>, !llvm.ptr<ptr<i8, 1>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bar", type = !llvm.func<void (ptr<i8, 1>, ptr<ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>, %arg1: !llvm.ptr<ptr<struct<"swift.error", opaque>>>):  // no predecessors
    %0 = "llvm.bitcast"(%arg0) : (!llvm.ptr<i64>) -> !llvm.ptr<struct<"swift.error", opaque>>
    "llvm.store"(%0, %arg1) : (!llvm.ptr<struct<"swift.error", opaque>>, !llvm.ptr<ptr<struct<"swift.error", opaque>>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "swifterror_store", type = !llvm.func<void (ptr<i64>, ptr<ptr<struct<"swift.error", opaque>>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<ppc_fp128>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i128} : () -> i128
    %1 = "llvm.mlir.constant"() {value = 0 : i128} : () -> i128
    %2 = "llvm.or"(%1, %0) : (i128, i128) -> i128
    %3 = "llvm.bitcast"(%2) : (i128) -> !llvm.ppc_fp128
    "llvm.store"(%3, %arg0) : (!llvm.ppc_fp128, !llvm.ptr<ppc_fp128>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "ppcf128_ones_store", type = !llvm.func<void (ptr<ppc_fp128>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
