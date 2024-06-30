"module"() ( {
  "llvm.func"() ( {
    %0 = "llvm.mlir.undef"() : () -> vector<2xi16>
    %1 = "llvm.mlir.constant"() {value = 0 : i16} : () -> i16
    %2 = "llvm.mlir.null"() : () -> !llvm.ptr<array<1 x i16>>
    %3 = "llvm.getelementptr"(%2, %1, %0) : (!llvm.ptr<array<1 x i16>>, i16, vector<2xi16>) -> !llvm.vec<2 x ptr<i16>>
    %4 = "llvm.ptrtoint"(%3) : (!llvm.vec<2 x ptr<i16>>) -> vector<2xi16>
    "llvm.return"(%4) : (vector<2xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "patatino", type = !llvm.func<vector<2xi16> ()>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
