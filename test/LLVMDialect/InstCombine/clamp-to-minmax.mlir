module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @clamp_float_fast_ordered_strict_maxmin(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "olt" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_fast_ordered_nonstrict_maxmin(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ole" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_fast_ordered_strict_minmax(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ogt" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_fast_ordered_nonstrict_minmax(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "oge" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_fast_unordered_strict_maxmin(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ult" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_fast_unordered_nonstrict_maxmin(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ule" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_fast_unordered_strict_minmax(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ugt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ugt" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_fast_unordered_nonstrict_minmax(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ugt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "uge" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_test_1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ugt" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.select %4, %3, %1 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_negative_wrong_const(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(5.120000e+02 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ugt" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.select %4, %3, %1 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_negative_same_op(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ult" %arg0, %1 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %5 = llvm.select %4, %3, %1 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_with_zero1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ole" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_with_zero2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 {fastmathFlags = #llvm.fastmath<fast>} : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "olt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_ordered_strict_maxmin1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "olt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_ordered_strict_maxmin2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "olt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_ordered_nonstrict_maxmin1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ole" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_ordered_nonstrict_maxmin2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ole" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_ordered_strict_minmax1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ogt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_ordered_strict_minmax2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ugt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ogt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_ordered_nonstrict_minmax1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "oge" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_ordered_nonstrict_minmax2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ugt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "oge" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_unordered_strict_maxmin1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ult" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_unordered_strict_maxmin2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ult" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_unordered_nonstrict_maxmin1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "olt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ule" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_unordered_nonstrict_maxmin2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ult" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ule" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_unordered_strict_minmax1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ugt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_unordered_strict_minmax2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ugt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "ugt" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_unordered_nonstrict_minmax1(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "uge" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @clamp_float_unordered_nonstrict_minmax2(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %2 = llvm.fcmp "ugt" %arg0, %0 : f32
    %3 = llvm.select %2, %arg0, %0 : i1, f32
    %4 = llvm.fcmp "uge" %arg0, %1 : f32
    %5 = llvm.select %4, %1, %3 : i1, f32
    llvm.return %5 : f32
  }
  llvm.func @ui32_clamp_and_cast_to_float(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %3 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %4 = llvm.uitofp %arg0 : i32 to f32
    %5 = llvm.icmp "ugt" %arg0, %0 : i32
    %6 = llvm.icmp "ult" %arg0, %1 : i32
    %7 = llvm.select %5, %2, %4 : i1, f32
    %8 = llvm.select %6, %3, %7 : i1, f32
    llvm.return %8 : f32
  }
  llvm.func @ui64_clamp_and_cast_to_float(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(255 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %3 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %4 = llvm.uitofp %arg0 : i64 to f32
    %5 = llvm.icmp "ugt" %arg0, %0 : i64
    %6 = llvm.icmp "ult" %arg0, %1 : i64
    %7 = llvm.select %5, %2, %4 : i1, f32
    %8 = llvm.select %6, %3, %7 : i1, f32
    llvm.return %8 : f32
  }
  llvm.func @mixed_clamp_to_float_1(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %0, %arg0 : i1, i32
    %4 = llvm.sitofp %3 : i32 to f32
    %5 = llvm.sitofp %arg0 : i32 to f32
    %6 = llvm.fcmp "ult" %5, %1 : f32
    %7 = llvm.select %6, %1, %4 : i1, f32
    llvm.return %7 : f32
  }
  llvm.func @mixed_clamp_to_i32_1(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.fcmp "ogt" %arg0, %0 : f32
    %3 = llvm.select %2, %0, %arg0 : i1, f32
    %4 = llvm.fptosi %3 : f32 to i32
    %5 = llvm.fptosi %arg0 : f32 to i32
    %6 = llvm.icmp "ult" %5, %1 : i32
    %7 = llvm.select %6, %1, %4 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @mixed_clamp_to_float_2(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %0, %arg0 : i1, i32
    %5 = llvm.sitofp %4 : i32 to f32
    %6 = llvm.icmp "slt" %arg0, %1 : i32
    %7 = llvm.select %6, %2, %5 : i1, f32
    llvm.return %7 : f32
  }
  llvm.func @mixed_clamp_to_i32_2(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.fcmp "ogt" %arg0, %0 : f32
    %4 = llvm.select %3, %0, %arg0 : i1, f32
    %5 = llvm.fptosi %4 : f32 to i32
    %6 = llvm.fcmp "olt" %arg0, %1 : f32
    %7 = llvm.select %6, %2, %5 : i1, i32
    llvm.return %7 : i32
  }
  llvm.func @mixed_clamp_to_float_vec(%arg0: vector<2xi32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<255> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %0, %arg0 : vector<2xi1>, vector<2xi32>
    %4 = llvm.sitofp %3 : vector<2xi32> to vector<2xf32>
    %5 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %6 = llvm.fcmp "ult" %5, %1 : vector<2xf32>
    %7 = llvm.select %6, %1, %4 : vector<2xi1>, vector<2xf32>
    llvm.return %7 : vector<2xf32>
  }
}
