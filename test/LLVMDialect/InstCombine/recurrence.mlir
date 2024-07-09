module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_or(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%1: i64):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.or %1, %0  : i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.br ^bb1(%2 : i64)
  }
  llvm.func @test_or2(%arg0: i64, %arg1: i64) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.or %0, %arg1  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.br ^bb1(%1 : i64)
  }
  llvm.func @test_or3(%arg0: i64, %arg1: i64) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.or %arg1, %0  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.br ^bb1(%1 : i64)
  }
  llvm.func @test_or4(%arg0: i64, %arg1: !llvm.ptr) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.load volatile %arg1 {alignment = 4 : i64} : !llvm.ptr -> i64
    %2 = llvm.or %0, %1  : i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.br ^bb1(%2 : i64)
  }
  llvm.func @test_and(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%1: i64):  // 2 preds: ^bb0, ^bb1
    %2 = llvm.and %1, %0  : i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.br ^bb1(%2 : i64)
  }
  llvm.func @test_and2(%arg0: i64, %arg1: i64) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.and %0, %arg1  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.br ^bb1(%1 : i64)
  }
  llvm.func @test_and3(%arg0: i64, %arg1: i64) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.and %arg1, %0  : i64
    llvm.call @use(%1) : (i64) -> ()
    llvm.br ^bb1(%1 : i64)
  }
  llvm.func @test_and4(%arg0: i64, %arg1: !llvm.ptr) -> i64 {
    llvm.br ^bb1(%arg0 : i64)
  ^bb1(%0: i64):  // 2 preds: ^bb0, ^bb1
    %1 = llvm.load volatile %arg1 {alignment = 4 : i64} : !llvm.ptr -> i64
    %2 = llvm.and %0, %1  : i64
    llvm.call @use(%2) : (i64) -> ()
    llvm.br ^bb1(%2 : i64)
  }
  llvm.func @use(i64)
}
