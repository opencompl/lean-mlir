"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 8 : i32} : () -> i32
    %2 = "llvm.srem"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.and"(%2, %0) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "a", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<1> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() {value = dense<8> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.srem"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.and"(%2, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%3) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "a_vec", type = !llvm.func<vector<2xi32> (vector<2xi32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
