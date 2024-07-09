module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_mul_fast_flags(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, f64)
  ^bb1(%4: i64, %5: f64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64
    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, f64), ^bb2(%8 : f64)
  ^bb2(%11: f64):  // pred: ^bb1
    llvm.return %11 : f64
  }
  llvm.func @test_nsz_nnan_flags_enabled(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, f64)
  ^bb1(%4: i64, %5: f64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64
    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<nnan, nsz>} : f64
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, f64), ^bb2(%8 : f64)
  ^bb2(%11: f64):  // pred: ^bb1
    llvm.return %11 : f64
  }
  llvm.func @test_nnan_flag_enabled(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, f64)
  ^bb1(%4: i64, %5: f64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64
    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, f64), ^bb2(%8 : f64)
  ^bb2(%11: f64):  // pred: ^bb1
    llvm.return %11 : f64
  }
  llvm.func @test_ninf_flag_enabled(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, f64)
  ^bb1(%4: i64, %5: f64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64
    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<ninf>} : f64
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, f64), ^bb2(%8 : f64)
  ^bb2(%11: f64):  // pred: ^bb1
    llvm.return %11 : f64
  }
  llvm.func @test_nsz_flag_enabled(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, f64)
  ^bb1(%4: i64, %5: f64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64
    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<nsz>} : f64
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, f64), ^bb2(%8 : f64)
  ^bb2(%11: f64):  // pred: ^bb1
    llvm.return %11 : f64
  }
  llvm.func @test_phi_initalise_to_non_zero(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, f64)
  ^bb1(%4: i64, %5: f64):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64
    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, f64), ^bb2(%8 : f64)
  ^bb2(%11: f64):  // pred: ^bb1
    llvm.return %11 : f64
  }
  llvm.func @test_multiple_phi_operands(%arg0: !llvm.ptr, %arg1: i1) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.cond_br %arg1, ^bb2(%0, %1 : i64, f64), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i64, f64)
  ^bb2(%4: i64, %5: f64):  // 3 preds: ^bb0, ^bb1, ^bb2
    %6 = llvm.getelementptr inbounds %arg0[%0, %4] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %7 = llvm.load %6 {alignment = 8 : i64} : !llvm.ptr -> f64
    %8 = llvm.fmul %5, %7  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb2(%9, %8 : i64, f64), ^bb3(%8 : f64)
  ^bb3(%11: f64):  // pred: ^bb2
    llvm.return %11 : f64
  }
  llvm.func @test_multiple_phi_operands_with_non_zero(%arg0: !llvm.ptr, %arg1: i1) -> f64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(1000 : i64) : i64
    llvm.cond_br %arg1, ^bb2(%0, %1 : i64, f64), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %2 : i64, f64)
  ^bb2(%5: i64, %6: f64):  // 3 preds: ^bb0, ^bb1, ^bb2
    %7 = llvm.getelementptr inbounds %arg0[%0, %5] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<1000 x f64>
    %8 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> f64
    %9 = llvm.fmul %6, %8  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %10 = llvm.add %5, %3  : i64
    %11 = llvm.icmp "ult" %10, %4 : i64
    llvm.cond_br %11, ^bb2(%10, %9 : i64, f64), ^bb3(%9 : f64)
  ^bb3(%12: f64):  // pred: ^bb2
    llvm.return %12 : f64
  }
  llvm.func @test_int_phi_operands(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, i32)
  ^bb1(%4: i64, %5: i32):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %8 = llvm.mul %5, %7 overflow<nsw>  : i32
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, i32), ^bb2(%8 : i32)
  ^bb2(%11: i32):  // pred: ^bb1
    llvm.return %11 : i32
  }
  llvm.func @test_int_phi_operands_initalise_to_non_zero(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, i32)
  ^bb1(%4: i64, %5: i32):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr inbounds %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %8 = llvm.mul %5, %7  : i32
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb1(%9, %8 : i64, i32), ^bb2(%8 : i32)
  ^bb2(%11: i32):  // pred: ^bb1
    llvm.return %11 : i32
  }
  llvm.func @test_multiple_int_phi_operands(%arg0: !llvm.ptr, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    llvm.cond_br %arg1, ^bb2(%0, %1 : i64, i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i64, i32)
  ^bb2(%4: i64, %5: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    %6 = llvm.getelementptr inbounds %arg0[%4] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %8 = llvm.mul %5, %7  : i32
    %9 = llvm.add %4, %2  : i64
    %10 = llvm.icmp "ult" %9, %3 : i64
    llvm.cond_br %10, ^bb2(%9, %8 : i64, i32), ^bb3(%8 : i32)
  ^bb3(%11: i32):  // pred: ^bb2
    llvm.return %11 : i32
  }
  llvm.func @test_multiple_int_phi_operands_initalise_to_non_zero(%arg0: !llvm.ptr, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(1000 : i64) : i64
    llvm.cond_br %arg1, ^bb2(%0, %1 : i64, i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %2 : i64, i32)
  ^bb2(%5: i64, %6: i32):  // 3 preds: ^bb0, ^bb1, ^bb2
    %7 = llvm.getelementptr inbounds %arg0[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %9 = llvm.mul %6, %8  : i32
    %10 = llvm.add %5, %3  : i64
    %11 = llvm.icmp "ult" %10, %4 : i64
    llvm.cond_br %11, ^bb2(%10, %9 : i64, i32), ^bb3(%9 : i32)
  ^bb3(%12: i32):  // pred: ^bb2
    llvm.return %12 : i32
  }
}
