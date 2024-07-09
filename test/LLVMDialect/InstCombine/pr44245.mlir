module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: i1, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.undef : !llvm.ptr
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr
    llvm.cond_br %arg0, ^bb1(%0 : !llvm.ptr), ^bb2
  ^bb1(%3: !llvm.ptr):  // 2 preds: ^bb0, ^bb4
    llvm.store %3, %arg1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.cond_br %arg0, ^bb3, ^bb5
  ^bb3:  // pred: ^bb2
    %4 = llvm.load %2 {alignment = 16 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb4(%4 : !llvm.ptr)
  ^bb4(%5: !llvm.ptr):  // 8 preds: ^bb3, ^bb6, ^bb8, ^bb10, ^bb12, ^bb14, ^bb16, ^bb19
    llvm.br ^bb1(%5 : !llvm.ptr)
  ^bb5:  // pred: ^bb2
    llvm.cond_br %arg0, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    %6 = llvm.load %2 {alignment = 16 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb4(%6 : !llvm.ptr)
  ^bb7:  // pred: ^bb5
    llvm.cond_br %arg0, ^bb8, ^bb9
  ^bb8:  // pred: ^bb7
    %7 = llvm.load %2 {alignment = 16 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb4(%7 : !llvm.ptr)
  ^bb9:  // pred: ^bb7
    llvm.cond_br %arg0, ^bb10, ^bb11
  ^bb10:  // pred: ^bb9
    %8 = llvm.load %2 {alignment = 16 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb4(%8 : !llvm.ptr)
  ^bb11:  // pred: ^bb9
    llvm.cond_br %arg0, ^bb12, ^bb13
  ^bb12:  // pred: ^bb11
    %9 = llvm.load %2 {alignment = 16 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb4(%9 : !llvm.ptr)
  ^bb13:  // pred: ^bb11
    llvm.cond_br %arg0, ^bb14, ^bb15
  ^bb14:  // pred: ^bb13
    %10 = llvm.load %2 {alignment = 16 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb4(%10 : !llvm.ptr)
  ^bb15:  // pred: ^bb13
    llvm.cond_br %arg0, ^bb16, ^bb17
  ^bb16:  // pred: ^bb15
    %11 = llvm.load %2 {alignment = 16 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb4(%11 : !llvm.ptr)
  ^bb17:  // pred: ^bb15
    llvm.cond_br %arg0, ^bb18, ^bb20
  ^bb18:  // pred: ^bb17
    %12 = llvm.load %2 {alignment = 16 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb19(%12 : !llvm.ptr)
  ^bb19(%13: !llvm.ptr):  // 2 preds: ^bb18, ^bb20
    llvm.br ^bb4(%13 : !llvm.ptr)
  ^bb20:  // pred: ^bb17
    %14 = llvm.load %2 {alignment = 16 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.call %0() : !llvm.ptr, () -> ()
    llvm.br ^bb19(%14 : !llvm.ptr)
  }
  llvm.func local_unnamed_addr @test_2(%arg0: i1) {
    %0 = llvm.mlir.undef : !llvm.ptr
    llvm.br ^bb1(%0 : !llvm.ptr)
  ^bb1(%1: !llvm.ptr):  // 2 preds: ^bb0, ^bb5
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    llvm.cond_br %arg0, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %2 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb5(%2 : !llvm.ptr)
  ^bb4:  // pred: ^bb2
    %3 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb5(%3 : !llvm.ptr)
  ^bb5(%4: !llvm.ptr):  // 2 preds: ^bb3, ^bb4
    llvm.br ^bb1(%4 : !llvm.ptr)
  }
}
