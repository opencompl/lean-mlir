"module"() ( {
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.call.preallocated.setup", type = !llvm.func<metadata (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.call.preallocated.arg", type = !llvm.func<ptr<i8> (metadata, i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "takes_i32", type = !llvm.func<void (i32)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "takes_i32_preallocated", type = !llvm.func<void (ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @takes_i32} : () -> !llvm.ptr<func<void (i32)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<void (i32)>>) -> !llvm.ptr<func<void (ptr<i32>)>>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %4 = "llvm.call"(%3) {callee = @llvm.call.preallocated.setup, fastmathFlags = #llvm.fastmath<>} : (i32) -> !llvm.metadata
    %5 = "llvm.call"(%4, %2) {callee = @llvm.call.preallocated.arg, fastmathFlags = #llvm.fastmath<>} : (!llvm.metadata, i32) -> !llvm.ptr<i8>
    %6 = "llvm.bitcast"(%5) : (!llvm.ptr<i8>) -> !llvm.ptr<i32>
    "llvm.call"(%1, %6) : (!llvm.ptr<func<void (ptr<i32>)>>, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "f", type = !llvm.func<void ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @takes_i32_preallocated} : () -> !llvm.ptr<func<void (ptr<i32>)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<void (ptr<i32>)>>) -> !llvm.ptr<func<void (i32)>>
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    "llvm.call"(%1, %2) : (!llvm.ptr<func<void (i32)>>, i32) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "g", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
