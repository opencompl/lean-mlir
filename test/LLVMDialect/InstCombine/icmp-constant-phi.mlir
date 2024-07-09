module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_eq(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(456 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %3 = llvm.icmp "eq" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @test_slt(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(456 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %3 = llvm.icmp "slt" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @test_sle(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(456 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %3 = llvm.icmp "sle" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @test_ne(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(456 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @test_ne_undef(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(456 : i32) : i32
    %1 = llvm.mlir.undef : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i32)
  ^bb3(%2: i32):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %3 = llvm.icmp "ne" %2, %0 : i32
    llvm.return %3 : i1
  }
  llvm.func @test_ne_int_vector(%arg0: i1) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<456> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<123> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<[123, 456]> : vector<2xi32>) : vector<2xi32>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : vector<2xi32>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : vector<2xi32>)
  ^bb3(%3: vector<2xi32>):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi32>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test_ne_float(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(1.250000e+00 : f32) : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : f32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : f32)
  ^bb3(%2: f32):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %3 = llvm.fcmp "one" %2, %0 : f32
    llvm.return %3 : i1
  }
  llvm.func @test_ne_float_undef(%arg0: i1) -> i1 {
    %0 = llvm.mlir.undef : f32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.250000e+00 : f32) : f32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : f32)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : f32)
  ^bb3(%3: f32):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %4 = llvm.fcmp "one" %3, %2 : f32
    llvm.return %4 : i1
  }
  llvm.func @test_ne_float_vector(%arg0: i1) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<4.562500e+02> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.constant(dense<1.232500e+02> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.constant(dense<[1.232500e+02, 4.562500e+02]> : vector<2xf32>) : vector<2xf32>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : vector<2xf32>)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : vector<2xf32>)
  ^bb3(%3: vector<2xf32>):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4
  ^bb4:  // pred: ^bb3
    %4 = llvm.fcmp "one" %3, %2 : vector<2xf32>
    llvm.return %4 : vector<2xi1>
  }
}
