"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.init.trampoline", type = !llvm.func<void (ptr<i8>, ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.adjust.trampoline", type = !llvm.func<ptr<i8> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "f", type = !llvm.func<i32 (ptr<struct<"struct.FRAME.nest", (i32, ptr<func<i32 (...)>>)>>, ...)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @f} : () -> !llvm.ptr<func<i32 (ptr<struct<"struct.FRAME.nest", (i32, ptr<func<i32 (...)>>)>>, ...)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<i32 (ptr<struct<"struct.FRAME.nest", (i32, ptr<func<i32 (...)>>)>>, ...)>>) -> !llvm.ptr<i8>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %4 = "llvm.alloca"(%3) : (i32) -> !llvm.ptr<struct<"struct.FRAME.nest", (i32, ptr<func<i32 (...)>>)>>
    %5 = "llvm.alloca"(%3) : (i32) -> !llvm.ptr<array<10 x i8>>
    %6 = "llvm.getelementptr"(%5, %2, %2) : (!llvm.ptr<array<10 x i8>>, i32, i32) -> !llvm.ptr<i8>
    %7 = "llvm.getelementptr"(%4, %2, %2) : (!llvm.ptr<struct<"struct.FRAME.nest", (i32, ptr<func<i32 (...)>>)>>, i32, i32) -> !llvm.ptr<i32>
    "llvm.store"(%arg0, %7) : (i32, !llvm.ptr<i32>) -> ()
    %8 = "llvm.bitcast"(%4) : (!llvm.ptr<struct<"struct.FRAME.nest", (i32, ptr<func<i32 (...)>>)>>) -> !llvm.ptr<i8>
    "llvm.call"(%6, %1, %8) {callee = @llvm.init.trampoline, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %9 = "llvm.call"(%6) {callee = @llvm.adjust.trampoline, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %10 = "llvm.getelementptr"(%4, %2, %3) : (!llvm.ptr<struct<"struct.FRAME.nest", (i32, ptr<func<i32 (...)>>)>>, i32, i32) -> !llvm.ptr<ptr<func<i32 (...)>>>
    %11 = "llvm.bitcast"(%9) : (!llvm.ptr<i8>) -> !llvm.ptr<func<i32 (...)>>
    "llvm.store"(%11, %10) : (!llvm.ptr<func<i32 (...)>>, !llvm.ptr<ptr<func<i32 (...)>>>) -> ()
    %12 = "llvm.call"(%11, %2) : (!llvm.ptr<func<i32 (...)>>, i32) -> i32
    "llvm.return"(%12) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "nest", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
