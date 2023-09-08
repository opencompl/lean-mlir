"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.init.trampoline", type = !llvm.func<void (ptr<i8>, ptr<i8>, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.adjust.trampoline", type = !llvm.func<ptr<i8> (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "f", type = !llvm.func<i32 (ptr<i8>, i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<i8>
    %1 = "llvm.mlir.addressof"() {global_name = @f} : () -> !llvm.ptr<func<i32 (ptr<i8>, i32)>>
    %2 = "llvm.bitcast"(%1) : (!llvm.ptr<func<i32 (ptr<i8>, i32)>>) -> !llvm.ptr<i8>
    %3 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.alloca"(%4) : (i32) -> !llvm.ptr<array<10 x i8>>
    %6 = "llvm.getelementptr"(%5, %3, %3) : (!llvm.ptr<array<10 x i8>>, i32, i32) -> !llvm.ptr<i8>
    "llvm.call"(%6, %2, %0) {callee = @llvm.init.trampoline, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %7 = "llvm.call"(%6) {callee = @llvm.adjust.trampoline, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %8 = "llvm.bitcast"(%7) : (!llvm.ptr<i8>) -> !llvm.ptr<func<i32 (i32)>>
    %9 = "llvm.call"(%8, %arg0) : (!llvm.ptr<func<i32 (i32)>>, i32) -> i32
    "llvm.return"(%9) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test0", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<i8>
    %1 = "llvm.mlir.addressof"() {global_name = @f} : () -> !llvm.ptr<func<i32 (ptr<i8>, i32)>>
    %2 = "llvm.bitcast"(%1) : (!llvm.ptr<func<i32 (ptr<i8>, i32)>>) -> !llvm.ptr<i8>
    "llvm.call"(%arg1, %2, %0) {callee = @llvm.init.trampoline, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %3 = "llvm.call"(%arg1) {callee = @llvm.adjust.trampoline, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %4 = "llvm.bitcast"(%3) : (!llvm.ptr<i8>) -> !llvm.ptr<func<i32 (i32)>>
    %5 = "llvm.call"(%4, %arg0) : (!llvm.ptr<func<i32 (i32)>>, i32) -> i32
    "llvm.return"(%5) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i32 (i32, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.call"(%arg1) {callee = @llvm.adjust.trampoline, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<i8>) -> !llvm.ptr<func<i32 (i32)>>
    %2 = "llvm.call"(%1, %arg0) : (!llvm.ptr<func<i32 (i32)>>, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test2", type = !llvm.func<i32 (i32, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: !llvm.ptr<i8>):  // no predecessors
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<i8>
    %1 = "llvm.mlir.addressof"() {global_name = @f} : () -> !llvm.ptr<func<i32 (ptr<i8>, i32)>>
    %2 = "llvm.bitcast"(%1) : (!llvm.ptr<func<i32 (ptr<i8>, i32)>>) -> !llvm.ptr<i8>
    "llvm.call"(%arg1, %2, %0) {callee = @llvm.init.trampoline, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %3 = "llvm.call"(%arg1) {callee = @llvm.adjust.trampoline, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %4 = "llvm.bitcast"(%3) : (!llvm.ptr<i8>) -> !llvm.ptr<func<i32 (i32)>>
    %5 = "llvm.call"(%4, %arg0) : (!llvm.ptr<func<i32 (i32)>>, i32) -> i32
    %6 = "llvm.call"(%arg1) {callee = @llvm.adjust.trampoline, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %7 = "llvm.bitcast"(%6) : (!llvm.ptr<i8>) -> !llvm.ptr<func<i32 (i32)>>
    %8 = "llvm.call"(%7, %arg0) : (!llvm.ptr<func<i32 (i32)>>, i32) -> i32
    "llvm.return"(%8) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test3", type = !llvm.func<i32 (i32, ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.null"() : () -> !llvm.ptr<i8>
    %1 = "llvm.mlir.addressof"() {global_name = @f} : () -> !llvm.ptr<func<i32 (ptr<i8>, i32)>>
    %2 = "llvm.bitcast"(%1) : (!llvm.ptr<func<i32 (ptr<i8>, i32)>>) -> !llvm.ptr<i8>
    %3 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %4 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %5 = "llvm.alloca"(%4) : (i32) -> !llvm.ptr<array<10 x i8>>
    %6 = "llvm.getelementptr"(%5, %3, %3) : (!llvm.ptr<array<10 x i8>>, i32, i32) -> !llvm.ptr<i8>
    "llvm.call"(%6, %2, %0) {callee = @llvm.init.trampoline, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> ()
    %7 = "llvm.call"(%6) {callee = @llvm.adjust.trampoline, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %8 = "llvm.bitcast"(%7) : (!llvm.ptr<i8>) -> !llvm.ptr<func<i32 (i32)>>
    %9 = "llvm.call"(%8, %arg0) : (!llvm.ptr<func<i32 (i32)>>, i32) -> i32
    %10 = "llvm.call"(%6) {callee = @llvm.adjust.trampoline, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %11 = "llvm.bitcast"(%7) : (!llvm.ptr<i8>) -> !llvm.ptr<func<i32 (i32)>>
    %12 = "llvm.call"(%11, %arg0) : (!llvm.ptr<func<i32 (i32)>>, i32) -> i32
    %13 = "llvm.call"(%6) {callee = @llvm.adjust.trampoline, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> !llvm.ptr<i8>
    %14 = "llvm.bitcast"(%13) : (!llvm.ptr<i8>) -> !llvm.ptr<func<i32 (i32)>>
    %15 = "llvm.call"(%14, %arg0) : (!llvm.ptr<func<i32 (i32)>>, i32) -> i32
    "llvm.return"(%15) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test4", type = !llvm.func<i32 (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
