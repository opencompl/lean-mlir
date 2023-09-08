"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg1) : (i8) -> i32
    %1 = "llvm.shl"(%arg0, %0) : (i32, i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "t0_shl", type = !llvm.func<i32 (i32, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg1) : (i8) -> i32
    %1 = "llvm.lshr"(%arg0, %0) : (i32, i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "t1_lshr", type = !llvm.func<i32 (i32, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg1) : (i8) -> i32
    %1 = "llvm.ashr"(%arg0, %0) : (i32, i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "t2_ashr", type = !llvm.func<i32 (i32, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.sext"(%arg1) : (vector<2xi8>) -> vector<2xi32>
    %1 = "llvm.shl"(%arg0, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%1) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "t3_vec_shl", type = !llvm.func<vector<2xi32> (vector<2xi32>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.sext"(%arg1) : (vector<2xi8>) -> vector<2xi32>
    %1 = "llvm.lshr"(%arg0, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%1) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "t4_vec_lshr", type = !llvm.func<vector<2xi32> (vector<2xi32>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>, %arg1: vector<2xi8>):  // no predecessors
    %0 = "llvm.sext"(%arg1) : (vector<2xi8>) -> vector<2xi32>
    %1 = "llvm.ashr"(%arg0, %0) : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    "llvm.return"(%1) : (vector<2xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "t5_vec_ashr", type = !llvm.func<vector<2xi32> (vector<2xi32>, vector<2xi8>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg1) : (i8) -> i32
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %1 = "llvm.shl"(%arg0, %0) : (i32, i32) -> i32
    %2 = "llvm.ashr"(%1, %0) : (i32, i32) -> i32
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "t6_twoshifts", type = !llvm.func<i32 (i32, i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.fshl.i7", type = !llvm.func<i7 (i7, i7, i7)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.fshr.i7", type = !llvm.func<i7 (i7, i7, i7)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i7, %arg1: i7, %arg2: i6):  // no predecessors
    %0 = "llvm.sext"(%arg2) : (i6) -> i7
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @llvm.fshl.i7, fastmathFlags = #llvm.fastmath<>} : (i7, i7, i7) -> i7
    "llvm.return"(%1) : (i7) -> ()
  }) {linkage = 10 : i64, sym_name = "n7_fshl", type = !llvm.func<i7 (i7, i7, i6)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i7, %arg1: i7, %arg2: i6):  // no predecessors
    %0 = "llvm.sext"(%arg2) : (i6) -> i7
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @llvm.fshr.i7, fastmathFlags = #llvm.fastmath<>} : (i7, i7, i7) -> i7
    "llvm.return"(%1) : (i7) -> ()
  }) {linkage = 10 : i64, sym_name = "n8_fshr", type = !llvm.func<i7 (i7, i7, i6)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.fshl.i8", type = !llvm.func<i8 (i8, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.fshr.i8", type = !llvm.func<i8 (i8, i8, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i6):  // no predecessors
    %0 = "llvm.sext"(%arg2) : (i6) -> i8
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @llvm.fshl.i8, fastmathFlags = #llvm.fastmath<>} : (i8, i8, i8) -> i8
    "llvm.return"(%1) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t9_fshl", type = !llvm.func<i8 (i8, i8, i6)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i8, %arg1: i8, %arg2: i6):  // no predecessors
    %0 = "llvm.sext"(%arg2) : (i6) -> i8
    %1 = "llvm.call"(%arg0, %arg1, %0) {callee = @llvm.fshr.i8, fastmathFlags = #llvm.fastmath<>} : (i8, i8, i8) -> i8
    "llvm.return"(%1) : (i8) -> ()
  }) {linkage = 10 : i64, sym_name = "t10_fshr", type = !llvm.func<i8 (i8, i8, i6)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "use32", type = !llvm.func<void (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg1) : (i8) -> i32
    "llvm.call"(%0) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    %1 = "llvm.shl"(%arg0, %0) : (i32, i32) -> i32
    "llvm.return"(%1) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "n11_extrause", type = !llvm.func<i32 (i32, i8)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32, %arg1: i8):  // no predecessors
    %0 = "llvm.sext"(%arg1) : (i8) -> i32
    "llvm.br"()[^bb1] : () -> ()
  ^bb1:  // pred: ^bb0
    %1 = "llvm.shl"(%arg0, %0) : (i32, i32) -> i32
    %2 = "llvm.ashr"(%1, %0) : (i32, i32) -> i32
    "llvm.br"()[^bb2] : () -> ()
  ^bb2:  // pred: ^bb1
    "llvm.call"(%0) {callee = @use32, fastmathFlags = #llvm.fastmath<>} : (i32) -> ()
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "n12_twoshifts_and_extrause", type = !llvm.func<i32 (i32, i8)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
