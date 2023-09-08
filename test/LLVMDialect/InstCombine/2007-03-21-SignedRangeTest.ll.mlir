"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -6 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 12 : i32} : () -> i32
    %2 = "llvm.sdiv"(%arg0, %1) : (i32, i32) -> i32
    %3 = "llvm.icmp"(%2, %0) {predicate = 1 : i64} : (i32, i32) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<i1 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<-6> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.mlir.constant"() {value = dense<12> : vector<2xi32>} : () -> vector<2xi32>
    %2 = "llvm.sdiv"(%arg0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.icmp"(%2, %0) {predicate = 1 : i64} : (vector<2xi32>, vector<2xi32>) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test_vec", type = !llvm.func<vector<2xi1> (vector<2xi32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
