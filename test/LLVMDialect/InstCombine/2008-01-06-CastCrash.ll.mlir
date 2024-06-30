"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.undef"() : () -> vector<2xi32>
    "llvm.return"(%0) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "f", type = !llvm.func<vector<2xi32> ()>} : () -> ()
  "llvm.func"() ( {
    %0 = "llvm.mlir.addressof"() {global_name = @f} : () -> !llvm.ptr<func<vector<2xi32> ()>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<vector<2xi32> ()>>) -> !llvm.ptr<func<i32 ()>>
    %2 = "llvm.call"(%1) : (!llvm.ptr<func<i32 ()>>) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "g", type = !llvm.func<i32 ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
