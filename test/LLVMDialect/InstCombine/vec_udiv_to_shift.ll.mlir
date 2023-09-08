"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: vector<8xi16>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<32> : vector<8xi16>} : () -> vector<8xi16>
    %1 = "llvm.udiv"(%arg0, %0) : (vector<8xi16>, vector<8xi16>) -> vector<8xi16>
    "llvm.return"(%1) : (vector<8xi16>) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_vec8x16", type = !llvm.func<vector<8xi16> (vector<8xi16>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<16> : vector<4xi32>} : () -> vector<4xi32>
    %1 = "llvm.udiv"(%arg0, %0) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "llvm.return"(%1) : (vector<4xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_vec4x32", type = !llvm.func<vector<4xi32> (vector<4xi32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
