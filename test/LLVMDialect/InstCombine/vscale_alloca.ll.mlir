"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.vec<? x 4 x i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<vec<? x 4 x i32>>
    "llvm.store"(%arg0, %1) : (!llvm.vec<? x 4 x i32>, !llvm.ptr<vec<? x 4 x i32>>) -> ()
    %2 = "llvm.load"(%1) : (!llvm.ptr<vec<? x 4 x i32>>) -> !llvm.vec<? x 4 x i32>
    "llvm.return"(%2) : (!llvm.vec<? x 4 x i32>) -> ()
  }) {linkage = 10 : i64, sym_name = "alloca", type = !llvm.func<vec<? x 4 x i32> (vec<? x 4 x i32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.vec<? x 4 x i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<vec<? x 4 x i32>>
    "llvm.store"(%arg0, %1) : (!llvm.vec<? x 4 x i32>, !llvm.ptr<vec<? x 4 x i32>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "alloca_dead_store", type = !llvm.func<void (vec<? x 4 x i32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (...)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<vec<? x 16 x i8>>
    "llvm.call"(%1) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<vec<? x 16 x i8>>) -> ()
    %2 = "llvm.alloca"(%0) : (i32) -> !llvm.ptr<struct<()>>
    "llvm.call"(%2) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<struct<()>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "alloca_zero_byte_move_first_inst", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
