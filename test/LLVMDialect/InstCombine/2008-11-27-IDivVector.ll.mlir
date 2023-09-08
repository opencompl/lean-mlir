"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<1> : vector<2xi8>} : () -> vector<2xi8>
    %1 = "llvm.udiv"(%arg0, %0) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    "llvm.return"(%1) : (vector<2xi8>) -> ()
  }) {linkage = 10 : i64, sym_name = "f", type = !llvm.func<vector<2xi8> (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<1> : vector<2xi8>} : () -> vector<2xi8>
    %1 = "llvm.sdiv"(%arg0, %0) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    "llvm.return"(%1) : (vector<2xi8>) -> ()
  }) {linkage = 10 : i64, sym_name = "g", type = !llvm.func<vector<2xi8> (vector<2xi8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
