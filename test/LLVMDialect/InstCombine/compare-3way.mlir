module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @test_low_sgt(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sgt" %6, %0 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test_low_slt(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "slt" %6, %0 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test_low_sge(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sge" %6, %0 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test_low_sle(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sle" %6, %0 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test_low_ne(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "ne" %6, %0 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test_low_eq(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "eq" %6, %0 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test_mid_sgt(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sgt" %6, %2 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test_mid_slt(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "slt" %6, %2 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test_mid_sge(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sge" %6, %2 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test_mid_sle(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sle" %6, %2 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test_mid_ne(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "ne" %6, %2 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test_mid_eq(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "eq" %6, %2 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test_high_sgt(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sgt" %6, %1 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test_high_slt(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "slt" %6, %1 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test_high_sge(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sge" %6, %1 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test_high_sle(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "sle" %6, %1 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test_high_ne(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "ne" %6, %1 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @test_high_eq(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @non_standard_low(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "eq" %6, %0 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @non_standard_mid(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "eq" %6, %2 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @non_standard_high(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %arg1 : i64
    %4 = llvm.icmp "slt" %arg0, %arg1 : i64
    %5 = llvm.select %4, %0, %1 : i1, i32
    %6 = llvm.select %3, %2, %5 : i1, i32
    %7 = llvm.icmp "eq" %6, %1 : i32
    llvm.cond_br %7, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%6) : (i32) -> ()
    llvm.return
  }
  llvm.func @non_standard_bound1(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.mlir.constant(-20 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %arg1 : i64
    %5 = llvm.icmp "slt" %arg0, %arg1 : i64
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    llvm.cond_br %8, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%7) : (i32) -> ()
    llvm.return
  }
  llvm.func @non_standard_bound2(%arg0: i64, %arg1: i64) {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-2 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %arg1 : i64
    %5 = llvm.icmp "slt" %arg0, %arg1 : i64
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "eq" %7, %3 : i32
    llvm.cond_br %8, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.call @use(%7) : (i32) -> ()
    llvm.return
  }
}
