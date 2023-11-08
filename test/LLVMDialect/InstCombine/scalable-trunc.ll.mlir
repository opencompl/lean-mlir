"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i32>, %arg1: !llvm.vec<? x 4 x i32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 31 : i32} : () -> i32
    %1 = "llvm.call"(%0) {callee = @llvm.aarch64.sve.ptrue.nxv16i1, fastmathFlags = #llvm.fastmath<>} : (i32) -> !llvm.vec<? x 16 x i1>
    %2 = "llvm.bitcast"(%arg1) : (!llvm.vec<? x 4 x i32>) -> !llvm.vec<? x 2 x i64>
    %3 = "llvm.call"(%1) {callee = @llvm.aarch64.sve.convert.from.svbool.nxv2i1, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<? x 16 x i1>) -> !llvm.vec<? x 2 x i1>
    %4 = "llvm.trunc"(%2) : (!llvm.vec<? x 2 x i64>) -> !llvm.vec<? x 2 x i32>
    "llvm.call"(%4, %3, %arg0) {callee = @llvm.aarch64.sve.st1.nxv2i32, fastmathFlags = #llvm.fastmath<>} : (!llvm.vec<? x 2 x i32>, !llvm.vec<? x 2 x i1>, !llvm.ptr<i32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "trunc_nxv2i64_to_nxv2i32", type = !llvm.func<void (ptr<i32>, vec<? x 4 x i32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.aarch64.sve.st1.nxv2i32", type = !llvm.func<void (vec<? x 2 x i32>, vec<? x 2 x i1>, ptr<i32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.aarch64.sve.convert.from.svbool.nxv2i1", type = !llvm.func<vec<? x 2 x i1> (vec<? x 16 x i1>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.aarch64.sve.ptrue.nxv16i1", type = !llvm.func<vec<? x 16 x i1> (i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
