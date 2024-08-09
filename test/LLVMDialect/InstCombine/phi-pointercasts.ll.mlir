module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_bitcast_1(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb3(%1: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test_bitcast_2(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb3(%1: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test_bitcast_3(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.call @use(%1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%1 : !llvm.ptr)
  ^bb3(%2: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %2 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test_bitcast_loads_in_different_bbs(%arg0: i1, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.call @use(%1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    %2 = llvm.load %arg2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb3(%2 : !llvm.ptr)
  ^bb3(%3: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test_gep_1(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @use.i32(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb3(%1: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @test_bitcast_not_foldable(%arg0: i1, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.call @use(%arg2) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg2 : !llvm.ptr)
  ^bb3(%1: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test_bitcast_with_extra_use(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb3(%1: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test_bitcast_different_bases(%arg0: i1, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg2 : !llvm.ptr)
  ^bb3(%1: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test_bitcast_gep_chains(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.call @use.i32(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%arg1 : !llvm.ptr)
  ^bb3(%1: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  }
  llvm.func @test_4_incoming_values_different_bases_1(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.switch %arg0 : i32, ^bb6 [
      0: ^bb1,
      1: ^bb2,
      2: ^bb3,
      3: ^bb4
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5(%arg2 : !llvm.ptr)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb4:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb5(%1: !llvm.ptr):  // 4 preds: ^bb1, ^bb2, ^bb3, ^bb4
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  ^bb6:  // pred: ^bb0
    llvm.return
  }
  llvm.func @test_4_incoming_values_different_bases_2(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.switch %arg0 : i32, ^bb6 [
      0: ^bb1,
      1: ^bb2,
      2: ^bb3,
      3: ^bb4
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%arg2 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb4:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb5(%1: !llvm.ptr):  // 4 preds: ^bb1, ^bb2, ^bb3, ^bb4
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  ^bb6:  // pred: ^bb0
    llvm.return
  }
  llvm.func @test_4_incoming_values_different_bases_3(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.switch %arg0 : i32, ^bb6 [
      0: ^bb1,
      1: ^bb2,
      2: ^bb3,
      3: ^bb4
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb3:  // pred: ^bb0
    llvm.call @use(%arg1) : (!llvm.ptr) -> ()
    llvm.br ^bb5(%arg1 : !llvm.ptr)
  ^bb4:  // pred: ^bb0
    llvm.br ^bb5(%arg2 : !llvm.ptr)
  ^bb5(%1: !llvm.ptr):  // 4 preds: ^bb1, ^bb2, ^bb3, ^bb4
    llvm.store %0, %1 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.return
  ^bb6:  // pred: ^bb0
    llvm.return
  }
  llvm.func @test_addrspacecast_1(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.addrspacecast %arg1 : !llvm.ptr to !llvm.ptr<1>
    %2 = llvm.addrspacecast %arg1 : !llvm.ptr to !llvm.ptr<1>
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : !llvm.ptr<1>)
  ^bb2:  // pred: ^bb0
    llvm.call @use.i8.addrspace1(%2) : (!llvm.ptr<1>) -> ()
    llvm.br ^bb3(%2 : !llvm.ptr<1>)
  ^bb3(%3: !llvm.ptr<1>):  // 2 preds: ^bb1, ^bb2
    llvm.store %0, %3 {alignment = 1 : i64} : i8, !llvm.ptr<1>
    llvm.return
  }
  llvm.func @use(!llvm.ptr)
  llvm.func @use.i32(!llvm.ptr)
  llvm.func @use.i8.addrspace1(!llvm.ptr<1>)
}
