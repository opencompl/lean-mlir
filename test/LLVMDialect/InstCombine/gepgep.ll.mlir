"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "buffer", type = !llvm.array<64 x f32>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use", type = !llvm.func<void (ptr<i8>)>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.constant"() {value = 64 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 63 : i64} : () -> i64
    %2 = "llvm.mlir.addressof"() {global_name = @buffer} : () -> !llvm.ptr<array<64 x f32>>
    %3 = "llvm.ptrtoint"(%2) : (!llvm.ptr<array<64 x f32>>) -> i64
    %4 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %5 = "llvm.sub"(%4, %3) : (i64, i64) -> i64
    %6 = "llvm.and"(%5, %1) : (i64, i64) -> i64
    %7 = "llvm.add"(%6, %0) : (i64, i64) -> i64
    %8 = "llvm.mlir.addressof"() {global_name = @buffer} : () -> !llvm.ptr<array<64 x f32>>
    %9 = "llvm.bitcast"(%8) : (!llvm.ptr<array<64 x f32>>) -> !llvm.ptr<i8>
    %10 = "llvm.getelementptr"(%9, %7) : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    "llvm.call"(%10) {callee = @use, fastmathFlags = #llvm.fastmath<>} : (!llvm.ptr<i8>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "f", type = !llvm.func<void ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
