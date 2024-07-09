module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @var() {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.func @denormal_input_preserve_sign_fcmp_olt_smallest_normalized(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "olt" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "olt" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "olt" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %10 = llvm.intr.fabs(%arg0)  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : (f32) -> f32
    %11 = llvm.fcmp "olt" %10, %0 : f32
    llvm.store volatile %11, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }
  llvm.func @denormal_input_preserve_sign_fcmp_uge_smallest_normalized(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "uge" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "uge" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "uge" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }
  llvm.func @denormal_input_preserve_sign_fcmp_oge_smallest_normalized(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "oge" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "oge" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "oge" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }
  llvm.func @denormal_input_preserve_sign_fcmp_ult_smallest_normalized(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "ult" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "ult" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "ult" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }
  llvm.func @denormal_input_preserve_sign_vector_fcmp_olt_smallest_normalized(%arg0: vector<2xf32>, %arg1: vector<2xf64>, %arg2: vector<2xf16>) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(dense<1.17549435E-38> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(dense<2.2250738585072014E-308> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.mlir.constant(dense<6.103520e-05> : vector<2xf16>) : vector<2xf16>
    %4 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %5 = llvm.fcmp "olt" %4, %0 : vector<2xf32>
    llvm.store volatile %5, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    %6 = llvm.intr.fabs(%arg1)  : (vector<2xf64>) -> vector<2xf64>
    %7 = llvm.fcmp "olt" %6, %2 : vector<2xf64>
    llvm.store volatile %7, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    %8 = llvm.intr.fabs(%arg2)  : (vector<2xf16>) -> vector<2xf16>
    %9 = llvm.fcmp "olt" %8, %3 : vector<2xf16>
    llvm.store volatile %9, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    llvm.return
  }
  llvm.func @denormal_input_preserve_sign_vector_fcmp_uge_smallest_normalized(%arg0: vector<2xf32>, %arg1: vector<2xf64>, %arg2: vector<2xf16>) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(dense<1.17549435E-38> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(dense<2.2250738585072014E-308> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.mlir.constant(dense<6.103520e-05> : vector<2xf16>) : vector<2xf16>
    %4 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %5 = llvm.fcmp "uge" %4, %0 : vector<2xf32>
    llvm.store volatile %5, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    %6 = llvm.intr.fabs(%arg1)  : (vector<2xf64>) -> vector<2xf64>
    %7 = llvm.fcmp "uge" %6, %2 : vector<2xf64>
    llvm.store volatile %7, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    %8 = llvm.intr.fabs(%arg2)  : (vector<2xf16>) -> vector<2xf16>
    %9 = llvm.fcmp "uge" %8, %3 : vector<2xf16>
    llvm.store volatile %9, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    llvm.return
  }
  llvm.func @denormal_input_preserve_sign_vector_fcmp_oge_smallest_normalized(%arg0: vector<2xf32>, %arg1: vector<2xf64>, %arg2: vector<2xf16>) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(dense<1.17549435E-38> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(dense<2.2250738585072014E-308> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.mlir.constant(dense<6.103520e-05> : vector<2xf16>) : vector<2xf16>
    %4 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %5 = llvm.fcmp "oge" %4, %0 : vector<2xf32>
    llvm.store volatile %5, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    %6 = llvm.intr.fabs(%arg1)  : (vector<2xf64>) -> vector<2xf64>
    %7 = llvm.fcmp "oge" %6, %2 : vector<2xf64>
    llvm.store volatile %7, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    %8 = llvm.intr.fabs(%arg2)  : (vector<2xf16>) -> vector<2xf16>
    %9 = llvm.fcmp "oge" %8, %3 : vector<2xf16>
    llvm.store volatile %9, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    llvm.return
  }
  llvm.func @denormal_input_preserve_sign_vector_fcmp_ult_smallest_normalized(%arg0: vector<2xf32>, %arg1: vector<2xf64>, %arg2: vector<2xf16>) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(dense<1.17549435E-38> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(dense<2.2250738585072014E-308> : vector<2xf64>) : vector<2xf64>
    %3 = llvm.mlir.constant(dense<6.103520e-05> : vector<2xf16>) : vector<2xf16>
    %4 = llvm.intr.fabs(%arg0)  : (vector<2xf32>) -> vector<2xf32>
    %5 = llvm.fcmp "ult" %4, %0 : vector<2xf32>
    llvm.store volatile %5, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    %6 = llvm.intr.fabs(%arg1)  : (vector<2xf64>) -> vector<2xf64>
    %7 = llvm.fcmp "ult" %6, %2 : vector<2xf64>
    llvm.store volatile %7, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    %8 = llvm.intr.fabs(%arg2)  : (vector<2xf16>) -> vector<2xf16>
    %9 = llvm.fcmp "ult" %8, %3 : vector<2xf16>
    llvm.store volatile %9, %1 {alignment = 1 : i64} : vector<2xi1>, !llvm.ptr
    llvm.return
  }
  llvm.func @denormal_input_positive_zero_fcmp_olt_smallest_normalized(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,positive-zero"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "olt" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "olt" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "olt" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }
  llvm.func @denormal_input_ieee(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,iee"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "olt" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "olt" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "olt" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }
  llvm.func @denormal_input_preserve_sign_f32_only(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math-f32", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "olt" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "olt" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "olt" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }
  llvm.func @wrong_fcmp_type_ole(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "ole" %4, %0 : f32
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.intr.fabs(%arg1)  : (f64) -> f64
    %7 = llvm.fcmp "ole" %6, %2 : f64
    llvm.store volatile %7, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %8 = llvm.intr.fabs(%arg2)  : (f16) -> f16
    %9 = llvm.fcmp "ole" %8, %3 : f16
    llvm.store volatile %9, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }
  llvm.func @missing_fabs(%arg0: f32, %arg1: f64, %arg2: f16) attributes {passthrough = [["denormal-fp-math", "ieee,preserve-sign"]]} {
    %0 = llvm.mlir.constant(1.17549435E-38 : f32) : f32
    %1 = llvm.mlir.addressof @var : !llvm.ptr
    %2 = llvm.mlir.constant(2.2250738585072014E-308 : f64) : f64
    %3 = llvm.mlir.constant(6.103520e-05 : f16) : f16
    %4 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.store volatile %4, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %5 = llvm.fcmp "olt" %arg1, %2 : f64
    llvm.store volatile %5, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    %6 = llvm.fcmp "olt" %arg2, %3 : f16
    llvm.store volatile %6, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return
  }
}
