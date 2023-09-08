"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.undef"() : () -> vector<2xi64>
    %1 = "llvm.xor"(%0, %0) : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    "llvm.return"(%1) : (vector<2xi64>) -> ()
  }) {linkage = 10 : i64, sym_name = "f", type = !llvm.func<vector<2xi64> ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
