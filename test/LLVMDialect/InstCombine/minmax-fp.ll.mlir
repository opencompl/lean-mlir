module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t1(%arg0: f32) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ult" %arg0, %0 : f32
    %2 = llvm.select %1, %arg0, %0 : i1, f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @t2(%arg0: f32) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fpext %arg0 : f32 to f64
    %4 = llvm.select %2, %3, %1 : i1, f64
    llvm.return %4 : f64
  }
  llvm.func @t4(%arg0: f64) -> f32 {
    %0 = llvm.mlir.constant(5.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 : f64
    %3 = llvm.fptrunc %arg0 : f64 to f32
    %4 = llvm.select %2, %3, %1 : i1, f32
    llvm.return %4 : f32
  }
  llvm.func @t5(%arg0: f32) -> f64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5.001000e+00 : f64) : f64
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fpext %arg0 : f32 to f64
    %4 = llvm.select %2, %3, %1 : i1, f64
    llvm.return %4 : f64
  }
  llvm.func @not_maxnum(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.select %2, %1, %arg0 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @t6(%arg0: f32) -> f64 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fpext %arg0 : f32 to f64
    %4 = llvm.select %2, %3, %1 : i1, f64
    llvm.return %4 : f64
  }
  llvm.func @t7(%arg0: f32) -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fpext %arg0 : f32 to f64
    %4 = llvm.select %2, %3, %1 : i1, f64
    llvm.return %4 : f64
  }
  llvm.func @fmin_fmin_zero_mismatch(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %1 : i1, f32
    %4 = llvm.fcmp "olt" %3, %1 : f32
    %5 = llvm.select %4, %3, %1 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @fmax_fmax_zero_mismatch(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %1 : i1, f32
    %4 = llvm.fcmp "ogt" %0, %3 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @t8(%arg0: f32) -> i64 {
    %0 = llvm.mlir.constant(5.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fptoui %arg0 : f32 to i64
    %4 = llvm.select %2, %3, %1 : i1, i64
    llvm.return %4 : i64
  }
  llvm.func @t9(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fptosi %arg0 : f32 to i8
    %4 = llvm.select %2, %3, %1 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @t11(%arg0: f32, %arg1: f32) -> i8 {
    %0 = llvm.fcmp "ult" %arg1, %arg0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %1 = llvm.fptosi %arg0 : f32 to i8
    %2 = llvm.fptosi %arg1 : f32 to i8
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @t12(%arg0: f32, %arg1: f32) -> i8 {
    %0 = llvm.fcmp "ult" %arg1, %arg0 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %1 = llvm.fptosi %arg0 : f32 to i8
    %2 = llvm.fptosi %arg1 : f32 to i8
    %3 = llvm.select %0, %2, %1 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @t13(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(1.500000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.fptosi %arg0 : f32 to i8
    %4 = llvm.select %2, %3, %1 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @t14(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.fcmp "ule" %arg0, %0 : f32
    %3 = llvm.fptosi %arg0 : f32 to i8
    %4 = llvm.select %2, %3, %1 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @t14_commute(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.fcmp "ule" %arg0, %0 : f32
    %3 = llvm.fptosi %arg0 : f32 to i8
    %4 = llvm.select %2, %1, %3 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @t15(%arg0: f32) -> i8 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.fcmp "ule" %arg0, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f32
    %3 = llvm.fptosi %arg0 : f32 to i8
    %4 = llvm.select %2, %3, %1 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @t16(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sitofp %arg0 : i32 to f64
    %4 = llvm.select %2, %3, %1 : i1, f64
    llvm.return %4 : f64
  }
  llvm.func @t17(%arg0: i32) -> f64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.sitofp %arg0 : i32 to f64
    %4 = llvm.select %2, %3, %1 : i1, f64
    llvm.return %4 : f64
  }
  llvm.func @fneg_fmax(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fneg %arg0  : f32
    %1 = llvm.fneg %arg1  : f32
    %2 = llvm.fcmp "ogt" %0, %1 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %3 = llvm.select %2, %0, %1 : i1, f32
    llvm.return %3 : f32
  }
  llvm.func @fsub_fmax(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.fsub %0, %arg0  : vector<2xf32>
    %2 = llvm.fsub %0, %arg1  : vector<2xf32>
    %3 = llvm.fcmp "uge" %1, %2 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : vector<2xf32>
    %4 = llvm.select %3, %1, %2 : vector<2xi1>, vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @fsub_fmin(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fsub %0, %arg0  : vector<2xf64>
    %2 = llvm.fsub %0, %arg1  : vector<2xf64>
    %3 = llvm.fcmp "olt" %1, %2 {fastmathFlags = #llvm.fastmath<nnan>} : vector<2xf64>
    %4 = llvm.select %3, %1, %2 : vector<2xi1>, vector<2xf64>
    llvm.return %4 : vector<2xf64>
  }
  llvm.func @fneg_fmin(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fneg %arg0  : f64
    %1 = llvm.fneg %arg1  : f64
    %2 = llvm.fcmp "ule" %0, %1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64
    %3 = llvm.select %2, %0, %1 : i1, f64
    llvm.return %3 : f64
  }
  llvm.func @maxnum_ogt_fmf_on_select(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @maxnum_oge_fmf_on_select(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : vector<2xf32>
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : vector<2xi1>, vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @maxnum_ogt_fmf_on_fcmp(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32
    %1 = llvm.select %0, %arg0, %arg1 : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @maxnum_oge_fmf_on_fcmp(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : vector<2xf32>
    %1 = llvm.select %0, %arg0, %arg1 : vector<2xi1>, vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @maxnum_no_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @maxnum_no_nnan(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @minnum_olt_fmf_on_select(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @minnum_ole_fmf_on_select(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : vector<2xf32>
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : vector<2xi1>, vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @minnum_olt_fmf_on_fcmp(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f32
    %1 = llvm.select %0, %arg0, %arg1 : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @minnum_ole_fmf_on_fcmp(%arg0: vector<2xf32>, %arg1: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan, ninf, nsz>} : vector<2xf32>
    %1 = llvm.select %0, %arg0, %arg1 : vector<2xi1>, vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @minnum_no_nsz(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @minnum_no_nnan(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f32
    %1 = llvm.select %0, %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nsz>} : i1, f32
    llvm.return %1 : f32
  }
  llvm.func @pr64937_preserve_min_idiom(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(3.276700e+04 : f32) : f32
    %1 = llvm.mlir.constant(6.553600e+04 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan>} : f32
    %3 = llvm.select %2, %arg0, %0 {fastmathFlags = #llvm.fastmath<nnan>} : i1, f32
    %4 = llvm.fmul %3, %1  {fastmathFlags = #llvm.fastmath<nnan>} : f32
    llvm.return %4 : f32
  }
}
