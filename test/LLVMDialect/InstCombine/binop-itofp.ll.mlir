module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_ui_ui_i8_add(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.uitofp %1 : i8 to f16
    %4 = llvm.uitofp %2 : i8 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }
  llvm.func @test_ui_ui_i8_add_fail_overflow(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.uitofp %2 : i8 to f16
    %5 = llvm.uitofp %3 : i8 to f16
    %6 = llvm.fadd %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_ui_ui_i8_add_C(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(1.280000e+02 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_ui_ui_i8_add_C_fail_no_repr(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(1.275000e+02 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_ui_ui_i8_add_C_fail_overflow(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(1.290000e+02 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_si_si_i8_add(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.sitofp %1 : i8 to f16
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }
  llvm.func @test_si_si_i8_add_fail_overflow(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-64 : i8) : i8
    %1 = llvm.mlir.constant(-65 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.fadd %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_ui_si_i8_add(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.sitofp %1 : i8 to f16
    %4 = llvm.uitofp %2 : i8 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }
  llvm.func @test_ui_si_i8_add_overflow(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(65 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.uitofp %3 : i8 to f16
    %6 = llvm.fadd %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_ui_ui_i8_sub_C(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1.280000e+02 : f16) : f16
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fsub %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_ui_ui_i8_sub_C_fail_overflow(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(1.280000e+02 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fsub %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_si_si_i8_sub(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(-64 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_si_si_i8_sub_fail_overflow(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(-65 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_si_si_i8_sub_C(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(-6.400000e+01 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sitofp %2 : i8 to f16
    %4 = llvm.fsub %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_si_si_i8_sub_C_fail_overflow(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(65 : i8) : i8
    %1 = llvm.mlir.constant(-6.400000e+01 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.sitofp %2 : i8 to f16
    %4 = llvm.fsub %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_ui_si_i8_sub(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.uitofp %3 : i8 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_ui_si_i8_sub_fail_maybe_sign(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(64 : i8) : i8
    %1 = llvm.mlir.constant(63 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.and %arg1, %1  : i8
    %4 = llvm.uitofp %2 : i8 to f16
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_ui_ui_i8_mul(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.uitofp %1 : i8 to f16
    %4 = llvm.uitofp %2 : i8 to f16
    %5 = llvm.fmul %3, %4  : f16
    llvm.return %5 : f16
  }
  llvm.func @test_ui_ui_i8_mul_C(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(1.600000e+01 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_ui_ui_i8_mul_C_fail_overlow(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(14 : i8) : i8
    %1 = llvm.mlir.constant(1.900000e+01 : f16) : f16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.uitofp %2 : i8 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_si_si_i8_mul(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-8 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i8
    %5 = llvm.or %arg1, %2  : i8
    %6 = llvm.sitofp %4 : i8 to f16
    %7 = llvm.sitofp %5 : i8 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }
  llvm.func @test_si_si_i8_mul_fail_maybe_zero(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-8 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.sitofp %2 : i8 to f16
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.fmul %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_si_si_i8_mul_C_fail_no_repr(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-7.500000e+00 : f16) : f16
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i8
    %5 = llvm.sitofp %4 : i8 to f16
    %6 = llvm.fmul %5, %2  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_si_si_i8_mul_C_fail_overflow(%arg0: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-1.900000e+01 : f16) : f16
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i8
    %5 = llvm.sitofp %4 : i8 to f16
    %6 = llvm.fmul %5, %2  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_ui_si_i8_mul(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.and %arg1, %2  : i8
    %6 = llvm.add %5, %1  : i8
    %7 = llvm.sitofp %4 : i8 to f16
    %8 = llvm.uitofp %6 : i8 to f16
    %9 = llvm.fmul %7, %8  : f16
    llvm.return %9 : f16
  }
  llvm.func @test_ui_si_i8_mul_fail_maybe_zero(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.add %2, %1  : i8
    %4 = llvm.and %arg1, %0  : i8
    %5 = llvm.sitofp %3 : i8 to f16
    %6 = llvm.uitofp %4 : i8 to f16
    %7 = llvm.fmul %5, %6  : f16
    llvm.return %7 : f16
  }
  llvm.func @test_ui_si_i8_mul_fail_signed(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-4 : i8) : i8
    %3 = llvm.and %arg0, %0  : i8
    %4 = llvm.add %3, %1  : i8
    %5 = llvm.or %arg1, %2  : i8
    %6 = llvm.sitofp %4 : i8 to f16
    %7 = llvm.uitofp %5 : i8 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }
  llvm.func @test_ui_ui_i16_add(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.uitofp %1 : i16 to f16
    %4 = llvm.uitofp %2 : i16 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }
  llvm.func @test_ui_ui_i16_add_fail_not_promotable(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2049 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.uitofp %2 : i16 to f16
    %5 = llvm.uitofp %3 : i16 to f16
    %6 = llvm.fadd %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_ui_ui_i16_add_C(%arg0: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(6.348800e+04 : f16) : f16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.uitofp %2 : i16 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_ui_ui_i16_add_C_fail_overflow(%arg0: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(6.400000e+04 : f16) : f16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.uitofp %2 : i16 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_si_si_i16_add(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.or %arg0, %0  : i16
    %2 = llvm.or %arg1, %0  : i16
    %3 = llvm.sitofp %1 : i16 to f16
    %4 = llvm.sitofp %2 : i16 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }
  llvm.func @test_si_si_i16_add_fail_no_promotion(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.sub %2, %1  : i16
    %4 = llvm.or %arg1, %0  : i16
    %5 = llvm.sitofp %3 : i16 to f16
    %6 = llvm.sitofp %4 : i16 to f16
    %7 = llvm.fadd %5, %6  : f16
    llvm.return %7 : f16
  }
  llvm.func @test_si_si_i16_add_C_overflow(%arg0: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(3.481600e+04 : f16) : f16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.sitofp %2 : i16 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_si_si_i16_sub(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.sitofp %2 : i16 to f16
    %5 = llvm.sitofp %3 : i16 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_si_si_i16_sub_fail_no_promotion(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.mlir.constant(-2049 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.or %arg1, %1  : i16
    %4 = llvm.sitofp %2 : i16 to f16
    %5 = llvm.sitofp %3 : i16 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_ui_si_i16_sub(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.uitofp %1 : i16 to f16
    %4 = llvm.sitofp %2 : i16 to f16
    %5 = llvm.fsub %3, %4  : f16
    llvm.return %5 : f16
  }
  llvm.func @test_ui_si_i16_sub_fail_maybe_signed(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i16) : i16
    %1 = llvm.mlir.constant(2047 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.uitofp %2 : i16 to f16
    %5 = llvm.sitofp %3 : i16 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_ui_ui_i16_mul(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(255 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.uitofp %1 : i16 to f16
    %4 = llvm.uitofp %2 : i16 to f16
    %5 = llvm.fmul %3, %4  : f16
    llvm.return %5 : f16
  }
  llvm.func @test_ui_ui_i16_mul_fail_no_promotion(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(4095 : i16) : i16
    %1 = llvm.mlir.constant(3 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.uitofp %2 : i16 to f16
    %5 = llvm.uitofp %3 : i16 to f16
    %6 = llvm.fmul %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_si_si_i16_mul(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(126 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.mlir.constant(-255 : i16) : i16
    %3 = llvm.and %arg0, %0  : i16
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i16
    %5 = llvm.or %arg1, %2  : i16
    %6 = llvm.sitofp %4 : i16 to f16
    %7 = llvm.sitofp %5 : i16 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }
  llvm.func @test_si_si_i16_mul_fail_overflow(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(126 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.mlir.constant(-257 : i16) : i16
    %3 = llvm.and %arg0, %0  : i16
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i16
    %5 = llvm.or %arg1, %2  : i16
    %6 = llvm.sitofp %4 : i16 to f16
    %7 = llvm.sitofp %5 : i16 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }
  llvm.func @test_si_si_i16_mul_C_fail_overflow(%arg0: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-129 : i16) : i16
    %1 = llvm.mlir.constant(1.280000e+02 : f16) : f16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.sitofp %2 : i16 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_si_si_i16_mul_C_fail_no_promotion(%arg0: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-4097 : i16) : i16
    %1 = llvm.mlir.constant(5.000000e+00 : f16) : f16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.sitofp %2 : i16 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_ui_si_i16_mul(%arg0: i16 {llvm.noundef}, %arg1: i16 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(126 : i16) : i16
    %1 = llvm.mlir.constant(1 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.add %2, %1  : i16
    %4 = llvm.and %arg1, %0  : i16
    %5 = llvm.add %4, %1  : i16
    %6 = llvm.sitofp %3 : i16 to f16
    %7 = llvm.uitofp %5 : i16 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }
  llvm.func @test_ui_ui_i12_add(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i12) : i12
    %1 = llvm.and %arg0, %0  : i12
    %2 = llvm.and %arg1, %0  : i12
    %3 = llvm.uitofp %1 : i12 to f16
    %4 = llvm.uitofp %2 : i12 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }
  llvm.func @test_ui_ui_i12_add_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(2047 : i12) : i12
    %1 = llvm.mlir.constant(-2047 : i12) : i12
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.and %arg1, %1  : i12
    %4 = llvm.uitofp %2 : i12 to f16
    %5 = llvm.uitofp %3 : i12 to f16
    %6 = llvm.fadd %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_si_si_i12_add(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-1024 : i12) : i12
    %1 = llvm.or %arg0, %0  : i12
    %2 = llvm.or %arg1, %0  : i12
    %3 = llvm.sitofp %1 : i12 to f16
    %4 = llvm.sitofp %2 : i12 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }
  llvm.func @test_si_si_i12_add_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-1025 : i12) : i12
    %1 = llvm.or %arg0, %0  : i12
    %2 = llvm.or %arg1, %0  : i12
    %3 = llvm.sitofp %1 : i12 to f16
    %4 = llvm.sitofp %2 : i12 to f16
    %5 = llvm.fadd %3, %4  : f16
    llvm.return %5 : f16
  }
  llvm.func @test_si_si_i12_add_C_fail_overflow(%arg0: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-2048 : i12) : i12
    %1 = llvm.mlir.constant(-1.000000e+00 : f16) : f16
    %2 = llvm.or %arg0, %0  : i12
    %3 = llvm.sitofp %2 : i12 to f16
    %4 = llvm.fadd %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_ui_ui_i12_sub(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(1023 : i12) : i12
    %1 = llvm.and %arg0, %0  : i12
    %2 = llvm.and %arg1, %0  : i12
    %3 = llvm.uitofp %1 : i12 to f16
    %4 = llvm.uitofp %2 : i12 to f16
    %5 = llvm.fsub %3, %4  : f16
    llvm.return %5 : f16
  }
  llvm.func @test_ui_ui_i12_sub_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(1023 : i12) : i12
    %1 = llvm.mlir.constant(2047 : i12) : i12
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.and %arg1, %1  : i12
    %4 = llvm.uitofp %2 : i12 to f16
    %5 = llvm.uitofp %3 : i12 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_si_si_i12_sub(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(1023 : i12) : i12
    %1 = llvm.mlir.constant(-1024 : i12) : i12
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.or %arg1, %1  : i12
    %4 = llvm.sitofp %2 : i12 to f16
    %5 = llvm.sitofp %3 : i12 to f16
    %6 = llvm.fsub %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_si_si_i12_sub_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.sitofp %arg0 : i12 to f16
    %1 = llvm.sitofp %arg1 : i12 to f16
    %2 = llvm.fsub %0, %1  : f16
    llvm.return %2 : f16
  }
  llvm.func @test_ui_ui_i12_mul(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(31 : i12) : i12
    %1 = llvm.mlir.constant(63 : i12) : i12
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.and %arg1, %1  : i12
    %4 = llvm.uitofp %2 : i12 to f16
    %5 = llvm.uitofp %3 : i12 to f16
    %6 = llvm.fmul %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_ui_ui_i12_mul_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(31 : i12) : i12
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.mlir.constant(63 : i12) : i12
    %3 = llvm.and %arg0, %0  : i12
    %4 = llvm.add %3, %1  : i12
    %5 = llvm.and %arg1, %2  : i12
    %6 = llvm.uitofp %4 : i12 to f16
    %7 = llvm.uitofp %5 : i12 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }
  llvm.func @test_ui_ui_i12_mul_C(%arg0: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(31 : i12) : i12
    %1 = llvm.mlir.constant(6.400000e+01 : f16) : f16
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.uitofp %2 : i12 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_si_si_i12_mul(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(30 : i12) : i12
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.mlir.constant(-64 : i12) : i12
    %3 = llvm.and %arg0, %0  : i12
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i12
    %5 = llvm.or %arg1, %2  : i12
    %6 = llvm.sitofp %4 : i12 to f16
    %7 = llvm.sitofp %5 : i12 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }
  llvm.func @test_si_si_i12_mul_fail_overflow(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(30 : i12) : i12
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.mlir.constant(-128 : i12) : i12
    %3 = llvm.and %arg0, %0  : i12
    %4 = llvm.add %3, %1 overflow<nsw, nuw>  : i12
    %5 = llvm.or %arg1, %2  : i12
    %6 = llvm.sitofp %4 : i12 to f16
    %7 = llvm.sitofp %5 : i12 to f16
    %8 = llvm.fmul %6, %7  : f16
    llvm.return %8 : f16
  }
  llvm.func @test_si_si_i12_mul_fail_maybe_non_zero(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(30 : i12) : i12
    %1 = llvm.mlir.constant(-128 : i12) : i12
    %2 = llvm.and %arg0, %0  : i12
    %3 = llvm.or %arg1, %1  : i12
    %4 = llvm.sitofp %2 : i12 to f16
    %5 = llvm.sitofp %3 : i12 to f16
    %6 = llvm.fmul %4, %5  : f16
    llvm.return %6 : f16
  }
  llvm.func @test_si_si_i12_mul_C(%arg0: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-64 : i12) : i12
    %1 = llvm.mlir.constant(-1.600000e+01 : f16) : f16
    %2 = llvm.or %arg0, %0  : i12
    %3 = llvm.sitofp %2 : i12 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_si_si_i12_mul_C_fail_overflow(%arg0: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(-64 : i12) : i12
    %1 = llvm.mlir.constant(-6.400000e+01 : f16) : f16
    %2 = llvm.or %arg0, %0  : i12
    %3 = llvm.sitofp %2 : i12 to f16
    %4 = llvm.fmul %3, %1  : f16
    llvm.return %4 : f16
  }
  llvm.func @test_ui_si_i12_mul_nsw(%arg0: i12 {llvm.noundef}, %arg1: i12 {llvm.noundef}) -> f16 {
    %0 = llvm.mlir.constant(31 : i12) : i12
    %1 = llvm.mlir.constant(1 : i12) : i12
    %2 = llvm.mlir.constant(30 : i12) : i12
    %3 = llvm.and %arg0, %0  : i12
    %4 = llvm.add %3, %1  : i12
    %5 = llvm.and %arg1, %2  : i12
    %6 = llvm.add %5, %1  : i12
    %7 = llvm.uitofp %4 : i12 to f16
    %8 = llvm.sitofp %6 : i12 to f16
    %9 = llvm.fmul %7, %8  : f16
    llvm.return %9 : f16
  }
  llvm.func @test_ui_add_with_signed_constant(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-1.638300e+04 : f32) : f32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.uitofp %2 : i32 to f32
    %4 = llvm.fadd %3, %1  : f32
    llvm.return %4 : f32
  }
  llvm.func @missed_nonzero_check_on_constant_for_si_fmul(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.sitofp %4 : i16 to f32
    %6 = llvm.fmul %5, %2  : f32
    llvm.store %3, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %6 : f32
  }
  llvm.func @missed_nonzero_check_on_constant_for_si_fmul_vec(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.poison : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %6 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %7 = llvm.select %arg0, %0, %1 : i1, i32
    %8 = llvm.trunc %7 : i32 to i16
    %9 = llvm.insertelement %8, %2[%3 : i64] : vector<2xi16>
    %10 = llvm.insertelement %8, %9[%4 : i64] : vector<2xi16>
    %11 = llvm.sitofp %10 : vector<2xi16> to vector<2xf32>
    %12 = llvm.fmul %11, %6  : vector<2xf32>
    llvm.store %7, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %12 : vector<2xf32>
  }
  llvm.func @negzero_check_on_constant_for_si_fmul(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %3 = llvm.select %arg0, %0, %1 : i1, i32
    %4 = llvm.trunc %3 : i32 to i16
    %5 = llvm.sitofp %4 : i16 to f32
    %6 = llvm.fmul %5, %2  : f32
    llvm.store %3, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %6 : f32
  }
  llvm.func @nonzero_check_on_constant_for_si_fmul_vec_w_poison(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.poison : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %6 = llvm.mlir.poison : f32
    %7 = llvm.mlir.undef : vector<2xf32>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %6, %7[%8 : i32] : vector<2xf32>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %5, %9[%10 : i32] : vector<2xf32>
    %12 = llvm.select %arg0, %0, %1 : i1, i32
    %13 = llvm.trunc %12 : i32 to i16
    %14 = llvm.insertelement %13, %2[%3 : i64] : vector<2xi16>
    %15 = llvm.insertelement %13, %14[%4 : i64] : vector<2xi16>
    %16 = llvm.sitofp %15 : vector<2xi16> to vector<2xf32>
    %17 = llvm.fmul %16, %11  : vector<2xf32>
    llvm.store %12, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %17 : vector<2xf32>
  }
  llvm.func @nonzero_check_on_constant_for_si_fmul_nz_vec_w_poison(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.poison : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %6 = llvm.mlir.poison : f32
    %7 = llvm.mlir.undef : vector<2xf32>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %6, %7[%8 : i32] : vector<2xf32>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %5, %9[%10 : i32] : vector<2xf32>
    %12 = llvm.select %arg0, %0, %1 : i1, i32
    %13 = llvm.trunc %12 : i32 to i16
    %14 = llvm.insertelement %13, %2[%3 : i64] : vector<2xi16>
    %15 = llvm.insertelement %13, %14[%4 : i64] : vector<2xi16>
    %16 = llvm.sitofp %15 : vector<2xi16> to vector<2xf32>
    %17 = llvm.fmul %16, %11  : vector<2xf32>
    llvm.store %12, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %17 : vector<2xf32>
  }
  llvm.func @nonzero_check_on_constant_for_si_fmul_negz_vec_w_poison(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.mlir.constant(65529 : i32) : i32
    %1 = llvm.mlir.constant(53264 : i32) : i32
    %2 = llvm.mlir.poison : vector<2xi16>
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %6 = llvm.mlir.poison : f32
    %7 = llvm.mlir.undef : vector<2xf32>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %6, %7[%8 : i32] : vector<2xf32>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %5, %9[%10 : i32] : vector<2xf32>
    %12 = llvm.select %arg0, %0, %1 : i1, i32
    %13 = llvm.trunc %12 : i32 to i16
    %14 = llvm.insertelement %13, %2[%3 : i64] : vector<2xi16>
    %15 = llvm.insertelement %13, %14[%4 : i64] : vector<2xi16>
    %16 = llvm.sitofp %15 : vector<2xi16> to vector<2xf32>
    %17 = llvm.fmul %16, %11  : vector<2xf32>
    llvm.store %12, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %17 : vector<2xf32>
  }
}
