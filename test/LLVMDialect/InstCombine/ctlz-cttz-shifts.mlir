module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @lshr_ctlz_true(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @shl_nuw_ctlz_true(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @shl_nuw_nsw_ctlz_true(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.shl %0, %arg0 overflow<nsw, nuw>  : i32
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @lshr_exact_cttz_true(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @shl_cttz_true(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @vec2_lshr_ctlz_true(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = true}> : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @vec2_shl_nuw_ctlz_true(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0 overflow<nuw>  : vector<2xi32>
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = true}> : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @vec2_shl_nuw_nsw_ctlz_true(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0 overflow<nsw, nuw>  : vector<2xi32>
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = true}> : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @vec2_lshr_exact_cttz_true(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = true}> : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @vec2_shl_cttz_true(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = true}> : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @vec2_shl_nsw_ctlz_true_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0 overflow<nsw>  : vector<2xi32>
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = true}> : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @vec2_lshr_ctlz_false_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @vec2_shl_ctlz_false_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @vec2_lshr_cttz_false_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @vec2_shl_cttz_false_neg(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[8387584, 4276440]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.shl %0, %arg0  : vector<2xi32>
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @lshr_ctlz_faslse_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @shl_ctlz_false_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = "llvm.intr.ctlz"(%1) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @lshr_cttz_false_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %2 : i32
  }
  llvm.func @shl_cttz_false_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8387584 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = "llvm.intr.cttz"(%1) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %2 : i32
  }
}
