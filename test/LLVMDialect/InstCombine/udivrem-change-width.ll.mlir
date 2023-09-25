"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "b", type = !llvm.array<1 x i8>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "g1", type = !llvm.array<1 x i8>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "g2", type = !llvm.array<1 x i8>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "g3", type = !llvm.array<1 x i8>} : () -> ()
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "g4", type = !llvm.array<1 x i8>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i8) -> i32
    %1 = "llvm.zext"(%arg1) : (i8) -> i32
    %2 = "llvm.udiv"(%0, %1) : (i32, i32) -> i32
    %3 = "llvm.trunc"(%2) : (i32) -> i8
    "llvm.return"(%3) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_i8", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi32>
    %1 = "llvm.zext"(%arg1) : (vector<2xi8>) -> vector<2xi32>
    %2 = "llvm.udiv"(%0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.trunc"(%2) : (vector<2xi32>) -> vector<2xi8>
    "llvm.return"(%3) : (vector<2xi8>) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_i8_vec", type = !llvm.func<vector<2xi8> (vector<2xi8>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i8) -> i32
    %1 = "llvm.zext"(%arg1) : (i8) -> i32
    %2 = "llvm.urem"(%0, %1) : (i32, i32) -> i32
    %3 = "llvm.trunc"(%2) : (i32) -> i8
    "llvm.return"(%3) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "urem_i8", type = !llvm.func<i8 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi32>
    %1 = "llvm.zext"(%arg1) : (vector<2xi8>) -> vector<2xi32>
    %2 = "llvm.urem"(%0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = "llvm.trunc"(%2) : (vector<2xi32>) -> vector<2xi8>
    "llvm.return"(%3) : (vector<2xi8>) -> ()
  }) {linkage = 10 : i64, sym_name = "urem_i8_vec", type = !llvm.func<vector<2xi8> (vector<2xi8>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i8) -> i32
    %1 = "llvm.zext"(%arg1) : (i8) -> i32
    %2 = "llvm.udiv"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_i32", type = !llvm.func<i32 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi32>
    %1 = "llvm.zext"(%arg1) : (vector<2xi8>) -> vector<2xi32>
    %2 = "llvm.udiv"(%0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%2) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_i32_vec", type = !llvm.func<vector<2xi32> (vector<2xi8>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i8) -> i32
    %1 = "llvm.zext"(%arg1) : (i8) -> i32
    %2 = "llvm.udiv"(%0, %1) : (i32, i32) -> i32
    %3 = "llvm.add"(%0, %1) : (i32, i32) -> i32
    %4 = "llvm.mul"(%2, %3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_i32_multiuse", type = !llvm.func<i32 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i9, %arg1: i9):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i9) -> i32
    %1 = "llvm.zext"(%arg1) : (i9) -> i32
    %2 = "llvm.udiv"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_illegal_type", type = !llvm.func<i32 (i9, i9)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i8) -> i32
    %1 = "llvm.zext"(%arg1) : (i8) -> i32
    %2 = "llvm.urem"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "urem_i32", type = !llvm.func<i32 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi32>
    %1 = "llvm.zext"(%arg1) : (vector<2xi8>) -> vector<2xi32>
    %2 = "llvm.urem"(%0, %1) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%2) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "urem_i32_vec", type = !llvm.func<vector<2xi32> (vector<2xi8>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i8) -> i32
    %1 = "llvm.zext"(%arg1) : (i8) -> i32
    %2 = "llvm.urem"(%0, %1) : (i32, i32) -> i32
    %3 = "llvm.add"(%0, %1) : (i32, i32) -> i32
    %4 = "llvm.mul"(%2, %3) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "urem_i32_multiuse", type = !llvm.func<i32 (i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i9, %arg1: i9):  // no predecessors
    %0 = "llvm.zext"(%arg0) : (i9) -> i32
    %1 = "llvm.zext"(%arg1) : (i9) -> i32
    %2 = "llvm.urem"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "urem_illegal_type", type = !llvm.func<i32 (i9, i9)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.zext"(%arg0) : (i8) -> i32
    %2 = "llvm.udiv"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_i32_c", type = !llvm.func<i32 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[10, 17]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi32>
    %2 = "llvm.udiv"(%1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%2) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_i32_c_vec", type = !llvm.func<vector<2xi32> (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.zext"(%arg0) : (i8) -> i32
    %2 = "llvm.udiv"(%1, %0) : (i32, i32) -> i32
    %3 = "llvm.add"(%1, %2) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_i32_c_multiuse", type = !llvm.func<i32 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i9):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.zext"(%arg0) : (i9) -> i32
    %2 = "llvm.udiv"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_illegal_type_c", type = !llvm.func<i32 (i9)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.zext"(%arg0) : (i8) -> i32
    %2 = "llvm.urem"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "urem_i32_c", type = !llvm.func<i32 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[10, 17]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.zext"(%arg0) : (vector<2xi8>) -> vector<2xi32>
    %2 = "llvm.urem"(%1, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%2) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "urem_i32_c_vec", type = !llvm.func<vector<2xi32> (vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.zext"(%arg0) : (i8) -> i32
    %2 = "llvm.urem"(%1, %0) : (i32, i32) -> i32
    %3 = "llvm.add"(%1, %2) : (i32, i32) -> i32
    "llvm.return"(%3) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "urem_i32_c_multiuse", type = !llvm.func<i32 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i9):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.zext"(%arg0) : (i9) -> i32
    %2 = "llvm.urem"(%1, %0) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "urem_illegal_type_c", type = !llvm.func<i32 (i9)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.zext"(%arg0) : (i8) -> i32
    %2 = "llvm.udiv"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_c_i32", type = !llvm.func<i32 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 10 : i32} : () -> i32
    %1 = "llvm.zext"(%arg0) : (i8) -> i32
    %2 = "llvm.urem"(%0, %1) : (i32, i32) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "urem_c_i32", type = !llvm.func<i32 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @b} : () -> !llvm.ptr<array<1 x i8>>
    %1 = "llvm.ptrtoint"(%0) : (!llvm.ptr<array<1 x i8>>) -> i8
    %2 = "llvm.zext"(%1) : (i8) -> i32
    %3 = "llvm.zext"(%arg0) : (i8) -> i32
    %4 = "llvm.udiv"(%3, %2) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_constexpr", type = !llvm.func<i32 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @g1} : () -> !llvm.ptr<array<1 x i8>>
    %1 = "llvm.ptrtoint"(%0) : (!llvm.ptr<array<1 x i8>>) -> i8
    %2 = "llvm.zext"(%1) : (i8) -> i32
    %3 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    %4 = "llvm.udiv"(%3, %2) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_const_constexpr", type = !llvm.func<i32 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @g2} : () -> !llvm.ptr<array<1 x i8>>
    %1 = "llvm.ptrtoint"(%0) : (!llvm.ptr<array<1 x i8>>) -> i8
    %2 = "llvm.zext"(%1) : (i8) -> i32
    %3 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    %4 = "llvm.urem"(%3, %2) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "urem_const_constexpr", type = !llvm.func<i32 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @g3} : () -> !llvm.ptr<array<1 x i8>>
    %2 = "llvm.ptrtoint"(%1) : (!llvm.ptr<array<1 x i8>>) -> i8
    %3 = "llvm.zext"(%2) : (i8) -> i32
    %4 = "llvm.udiv"(%3, %0) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "udiv_constexpr_const", type = !llvm.func<i32 (i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 42 : i32} : () -> i32
    %1 = "llvm.mlir.addressof"() {global_name = @g4} : () -> !llvm.ptr<array<1 x i8>>
    %2 = "llvm.ptrtoint"(%1) : (!llvm.ptr<array<1 x i8>>) -> i8
    %3 = "llvm.zext"(%2) : (i8) -> i32
    %4 = "llvm.urem"(%3, %0) : (i32, i32) -> i32
    "llvm.return"(%4) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "urem_constexpr_const", type = !llvm.func<i32 (i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
