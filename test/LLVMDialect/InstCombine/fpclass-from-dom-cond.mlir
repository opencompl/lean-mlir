module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.fcmp "ueq" %arg0, %0 : f32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1
    llvm.return %3 : i1
  }
  llvm.func @test2(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(9.9999999747524271E-7 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.fcmp "olt" %arg0, %0 : f64
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    %4 = llvm.fcmp "oeq" %arg0, %1 : f64
    llvm.return %4 : i1
  }
  llvm.func @test3(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %3 = llvm.fcmp "ogt" %arg0, %0 : f32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %5 = llvm.fcmp "oeq" %4, %2 : f32
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }
  llvm.func @test4(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(9.99999997E-7 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : f32
  ^bb2:  // pred: ^bb0
    %4 = llvm.fcmp "oeq" %arg0, %1 : f32
    %5 = llvm.fdiv %2, %arg0  : f32
    %6 = llvm.select %4, %2, %5 : i1, f32
    llvm.return %6 : f32
  }
  llvm.func @test5(%arg0: f64, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg1, ^bb1, ^bb4(%0 : f64)
  ^bb1:  // pred: ^bb0
    %3 = llvm.fcmp "uno" %arg0, %1 : f64
    llvm.cond_br %3, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.return %2 : i1
  ^bb3:  // pred: ^bb1
    llvm.br ^bb4(%arg0 : f64)
  ^bb4(%4: f64):  // 2 preds: ^bb0, ^bb3
    %5 = "llvm.intr.is.fpclass"(%4) <{bit = 411 : i32}> : (f64) -> i1
    llvm.return %5 : i1
  }
  llvm.func @test6(%arg0: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(9218868437227405312 : i64) : i64
    %3 = llvm.fcmp "ogt" %arg0, %0 : f64
    llvm.cond_br %3, ^bb1, ^bb2(%1 : i1)
  ^bb1:  // pred: ^bb0
    %4 = llvm.intr.fabs(%arg0)  : (f64) -> f64
    %5 = llvm.bitcast %4 : f64 to i64
    %6 = llvm.icmp "eq" %5, %2 : i64
    llvm.br ^bb2(%6 : i1)
  ^bb2(%7: i1):  // 2 preds: ^bb0, ^bb1
    llvm.return %7 : i1
  }
  llvm.func @test7(%arg0: f32) -> i1 {
    %0 = "llvm.intr.is.fpclass"(%arg0) <{bit = 345 : i32}> : (f32) -> i1
    llvm.cond_br %0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = "llvm.intr.is.fpclass"(%arg0) <{bit = 456 : i32}> : (f32) -> i1
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    %2 = "llvm.intr.is.fpclass"(%arg0) <{bit = 456 : i32}> : (f32) -> i1
    llvm.return %2 : i1
  }
  llvm.func @test8(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 575 : i32}> : (f32) -> i1
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %4 = "llvm.intr.is.fpclass"(%arg0) <{bit = 575 : i32}> : (f32) -> i1
    llvm.return %4 : i1
  }
  llvm.func @test9(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %3 = llvm.fcmp "olt" %arg0, %0 : f32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.fcmp "oeq" %arg0, %2 : f32
    llvm.return %4 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }
  llvm.func @test10(%arg0: f32) -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %3 = llvm.fcmp "olt" %arg0, %0 : f32
    %4 = llvm.fneg %arg0  : f32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.fcmp "oeq" %4, %2 : f32
    llvm.return %5 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }
  llvm.func @test11_and(%arg0: f32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(0xFF800000 : f32) : f32
    %3 = llvm.fcmp "olt" %arg0, %0 : f32
    %4 = llvm.fneg %arg0  : f32
    %5 = llvm.and %3, %arg1  : i1
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %6 = llvm.fcmp "oeq" %4, %2 : f32
    llvm.return %6 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }
  llvm.func @test12_or(%arg0: f32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.fcmp "ueq" %arg0, %0 : f32
    %3 = llvm.or %2, %arg1  : i1
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    %4 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1
    llvm.return %4 : i1
  }
  llvm.func @test1_no_dominating(%arg0: f32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = llvm.fcmp "ueq" %arg0, %0 : f32
    llvm.cond_br %2, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.return %1 : i1
  ^bb3:  // 2 preds: ^bb0, ^bb1
    %3 = "llvm.intr.is.fpclass"(%arg0) <{bit = 783 : i32}> : (f32) -> i1
    llvm.return %3 : i1
  }
  llvm.func @test_signbit_check(%arg0: f32, %arg1: i1) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.fneg %arg0  : f32
    llvm.br ^bb4(%3 : f32)
  ^bb2:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb4(%arg0 : f32)
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4(%arg0 : f32)
  ^bb4(%4: f32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %5 = llvm.intr.fabs(%4)  : (f32) -> f32
    llvm.return %5 : f32
  }
  llvm.func @test_signbit_check_fail(%arg0: f32, %arg1: i1) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.bitcast %arg0 : f32 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.fneg %arg0  : f32
    llvm.br ^bb4(%3 : f32)
  ^bb2:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb4(%arg0 : f32)
  ^bb3:  // pred: ^bb2
    %4 = llvm.fneg %arg0  : f32
    llvm.br ^bb4(%4 : f32)
  ^bb4(%5: f32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %6 = llvm.intr.fabs(%5)  : (f32) -> f32
    llvm.return %6 : f32
  }
  llvm.func @test_signbit_check_wrong_type(%arg0: vector<2xf32>, %arg1: i1) -> vector<2xf32> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<2xf32> to i64
    %2 = llvm.icmp "slt" %1, %0 : i64
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.fneg %arg0  : vector<2xf32>
    llvm.br ^bb4(%3 : vector<2xf32>)
  ^bb2:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb4(%arg0 : vector<2xf32>)
  ^bb3:  // pred: ^bb2
    llvm.br ^bb4(%arg0 : vector<2xf32>)
  ^bb4(%4: vector<2xf32>):  // 3 preds: ^bb1, ^bb2, ^bb3
    %5 = llvm.intr.fabs(%4)  : (vector<2xf32>) -> vector<2xf32>
    llvm.return %5 : vector<2xf32>
  }
}
