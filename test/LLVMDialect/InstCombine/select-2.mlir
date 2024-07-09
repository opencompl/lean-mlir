module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(18 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.lshr %arg1, %1  : i32
    %4 = llvm.select %2, %3, %arg1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @t2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(18 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    %3 = llvm.and %arg1, %1  : i32
    %4 = llvm.select %2, %3, %arg1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @t3(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    %2 = llvm.select %1, %arg0, %0 : i1, f32
    %3 = llvm.fadd %2, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %3 : f32
  }
  llvm.func @ashr_exact_poison_constant_fold(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.select %arg0, %arg1, %0 : i1, i8
    %3 = llvm.ashr %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @ashr_exact(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.select %arg0, %arg1, %0 : i1, i8
    %3 = llvm.ashr %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @shl_nsw_nuw_poison_constant_fold(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.select %arg0, %0, %arg1 : i1, i8
    %3 = llvm.shl %1, %2 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @shl_nsw_nuw(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.select %arg0, %0, %arg1 : i1, i8
    %3 = llvm.shl %1, %2 overflow<nsw, nuw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @add_nsw_poison_constant_fold(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(65 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.select %arg0, %arg1, %0 : i1, i8
    %3 = llvm.add %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }
  llvm.func @add_nsw(%arg0: i1, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(64 : i8) : i8
    %2 = llvm.select %arg0, %arg1, %0 : i1, i8
    %3 = llvm.add %2, %1 overflow<nsw>  : i8
    llvm.return %3 : i8
  }
}
