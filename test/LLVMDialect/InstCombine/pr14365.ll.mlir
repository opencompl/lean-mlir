"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1431655765 : i32} : () -> i32
    %3 = "llvm.and"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.xor"(%3, %1) : (i32, i32) -> i32
    %5 = "llvm.add"(%4, %0) : (i32, i32) -> i32
    %6 = "llvm.add"(%arg0, %5) : (i32, i32) -> i32
    "llvm.return"(%6) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test0", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<1> : vector<4xi32>} : () -> vector<4xi32>
    %1 = "llvm.mlir.constant"() {value = dense<-1> : vector<4xi32>} : () -> vector<4xi32>
    %2 = "llvm.mlir.constant"() {value = dense<1431655765> : vector<4xi32>} : () -> vector<4xi32>
    %3 = "llvm.and"(%arg0, %2) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %4 = "llvm.xor"(%3, %1) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %5 = "llvm.add"(%4, %0) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %6 = "llvm.add"(%arg0, %5) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "llvm.return"(%6) : (vector<4xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test0_vec", type = !llvm.func<vector<4xi32> (vector<4xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = -1 : i32} : () -> i32
    %1 = "llvm.mlir.constant"() {value = 1431655765 : i32} : () -> i32
    %2 = "llvm.mlir.constant"() {value = 1 : i32} : () -> i32
    %3 = "llvm.ashr"(%arg0, %2) : (i32, i32) -> i32
    %4 = "llvm.and"(%3, %1) : (i32, i32) -> i32
    %5 = "llvm.xor"(%4, %0) : (i32, i32) -> i32
    %6 = "llvm.add"(%5, %2) : (i32, i32) -> i32
    %7 = "llvm.add"(%arg0, %6) : (i32, i32) -> i32
    "llvm.return"(%7) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<-1> : vector<4xi32>} : () -> vector<4xi32>
    %1 = "llvm.mlir.constant"() {value = dense<1431655765> : vector<4xi32>} : () -> vector<4xi32>
    %2 = "llvm.mlir.constant"() {value = dense<1> : vector<4xi32>} : () -> vector<4xi32>
    %3 = "llvm.ashr"(%arg0, %2) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %4 = "llvm.and"(%3, %1) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %5 = "llvm.xor"(%4, %0) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %6 = "llvm.add"(%5, %2) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %7 = "llvm.add"(%arg0, %6) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "llvm.return"(%7) : (vector<4xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test1_vec", type = !llvm.func<vector<4xi32> (vector<4xi32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
