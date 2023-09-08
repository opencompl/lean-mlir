"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i16):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 500 : i32} : () -> i32
    %1 = "llvm.zext"(%arg0) : (i16) -> i32
    %2 = "llvm.icmp"(%1, %0) {predicate = 2 : i64} : (i32, i32) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "scalar_zext_slt", type = !llvm.func<i1 (i16)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xi16>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[500, 0, 501, 65535]> : vector<4xi32>} : () -> vector<4xi32>
    %1 = "llvm.zext"(%arg0) : (vector<4xi16>) -> vector<4xi32>
    %2 = "llvm.icmp"(%1, %0) {predicate = 2 : i64} : (vector<4xi32>, vector<4xi32>) -> i1
    "llvm.return"(%2) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "vector_zext_slt", type = !llvm.func<vector<4xi1> (vector<4xi16>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
