module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @get_ptr.i8() -> !llvm.ptr
  llvm.func @get_ptr.i32() -> !llvm.ptr
  llvm.func @foo.i8(!llvm.ptr)
  llvm.func @foo.i32(!llvm.ptr)
  llvm.func @test_gep_and_bitcast(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call @get_ptr.i8() : () -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb3(%3, %4 : !llvm.ptr, i32)
  ^bb2:  // pred: ^bb0
    %5 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb3(%5, %6 : !llvm.ptr, i32)
  ^bb3(%7: !llvm.ptr, %8: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %1, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    %9 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.select %arg1, %8, %9 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @test_gep_and_bitcast_arg(%arg0: !llvm.ptr, %arg1: i1, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb3(%2, %3 : !llvm.ptr, i32)
  ^bb2:  // pred: ^bb0
    %4 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb3(%4, %5 : !llvm.ptr, i32)
  ^bb3(%6: !llvm.ptr, %7: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %1, %6 {alignment = 4 : i64} : i32, !llvm.ptr
    %8 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %9 = llvm.select %arg2, %7, %8 : i1, i32
    llvm.return %9 : i32
  }
  llvm.func @test_gep_and_bitcast_phi(%arg0: i1, %arg1: i1, %arg2: i1) -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.call @get_ptr.i8() : () -> !llvm.ptr
    llvm.br ^bb3(%3, %3 : !llvm.ptr, !llvm.ptr)
  ^bb2:  // pred: ^bb0
    %4 = llvm.call @get_ptr.i32() : () -> !llvm.ptr
    llvm.br ^bb3(%4, %0 : !llvm.ptr, !llvm.ptr)
  ^bb3(%5: !llvm.ptr, %6: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.call @foo.i8(%6) : (!llvm.ptr) -> ()
    llvm.cond_br %arg1, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %7 = llvm.getelementptr inbounds %5[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb6(%7, %8 : !llvm.ptr, i32)
  ^bb5:  // pred: ^bb3
    %9 = llvm.getelementptr inbounds %5[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %10 = llvm.load %9 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb6(%9, %10 : !llvm.ptr, i32)
  ^bb6(%11: !llvm.ptr, %12: i32):  // 2 preds: ^bb4, ^bb5
    llvm.store %2, %11 {alignment = 4 : i64} : i32, !llvm.ptr
    %13 = llvm.load %11 {alignment = 4 : i64} : !llvm.ptr -> i32
    %14 = llvm.select %arg2, %12, %13 : i1, i32
    llvm.return %14 : i32
  }
  llvm.func @test_gep_i32ptr(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call @get_ptr.i32() : () -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb3(%3, %4 : !llvm.ptr, i32)
  ^bb2:  // pred: ^bb0
    %5 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb3(%5, %6 : !llvm.ptr, i32)
  ^bb3(%7: !llvm.ptr, %8: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %1, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    %9 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.select %arg1, %8, %9 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @test_gep_and_bitcast_gep_base_ptr(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call @get_ptr.i8() : () -> !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.getelementptr inbounds %3[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb3(%4, %5 : !llvm.ptr, i32)
  ^bb2:  // pred: ^bb0
    %6 = llvm.getelementptr inbounds %3[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb3(%6, %7 : !llvm.ptr, i32)
  ^bb3(%8: !llvm.ptr, %9: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %1, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    %10 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32
    %11 = llvm.select %arg1, %9, %10 : i1, i32
    llvm.return %11 : i32
  }
  llvm.func @test_gep_and_bitcast_same_bb(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call @get_ptr.i8() : () -> !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.cond_br %arg0, ^bb2(%3, %4 : !llvm.ptr, i32), ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb2(%5, %6 : !llvm.ptr, i32)
  ^bb2(%7: !llvm.ptr, %8: i32):  // 2 preds: ^bb0, ^bb1
    llvm.store %1, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    %9 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.select %arg1, %8, %9 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @test_gep_and_bitcast_same_bb_and_extra_use(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call @get_ptr.i8() : () -> !llvm.ptr
    %3 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.call @foo.i32(%3) : (!llvm.ptr) -> ()
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.cond_br %arg0, ^bb2(%3, %4 : !llvm.ptr, i32), ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.br ^bb2(%5, %6 : !llvm.ptr, i32)
  ^bb2(%7: !llvm.ptr, %8: i32):  // 2 preds: ^bb0, ^bb1
    llvm.store %1, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    %9 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.select %arg1, %8, %9 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @test_gep(%arg0: i1, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.call @get_ptr.i8() : () -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.br ^bb3(%3, %4 : !llvm.ptr, i8)
  ^bb2:  // pred: ^bb0
    %5 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.load %5 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.br ^bb3(%5, %6 : !llvm.ptr, i8)
  ^bb3(%7: !llvm.ptr, %8: i8):  // 2 preds: ^bb1, ^bb2
    llvm.store %1, %7 {alignment = 1 : i64} : i8, !llvm.ptr
    %9 = llvm.load %7 {alignment = 1 : i64} : !llvm.ptr -> i8
    %10 = llvm.select %arg1, %8, %9 : i1, i8
    llvm.return %10 : i8
  }
  llvm.func @test_extra_uses(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call @get_ptr.i8() : () -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.call @foo.i32(%3) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%3, %4 : !llvm.ptr, i32)
  ^bb2:  // pred: ^bb0
    %5 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.call @foo.i32(%5) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%5, %6 : !llvm.ptr, i32)
  ^bb3(%7: !llvm.ptr, %8: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %1, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    %9 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.select %arg1, %8, %9 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @test_extra_uses_non_inbounds(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.call @get_ptr.i8() : () -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.call @foo.i32(%3) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%3, %4 : !llvm.ptr, i32)
  ^bb2:  // pred: ^bb0
    %5 = llvm.getelementptr %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.call @foo.i32(%5) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%5, %6 : !llvm.ptr, i32)
  ^bb3(%7: !llvm.ptr, %8: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %1, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    %9 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.select %arg1, %8, %9 : i1, i32
    llvm.return %10 : i32
  }
  llvm.func @test_extra_uses_multiple_geps(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.call @get_ptr.i8() : () -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.getelementptr inbounds %3[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.call @foo.i32(%4) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%4, %5 : !llvm.ptr, i32)
  ^bb2:  // pred: ^bb0
    %6 = llvm.getelementptr %3[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %7 = llvm.getelementptr inbounds %6[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.call @foo.i32(%7) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%7, %8 : !llvm.ptr, i32)
  ^bb3(%9: !llvm.ptr, %10: i32):  // 2 preds: ^bb1, ^bb2
    llvm.store %2, %9 {alignment = 4 : i64} : i32, !llvm.ptr
    %11 = llvm.load %9 {alignment = 4 : i64} : !llvm.ptr -> i32
    %12 = llvm.select %arg1, %10, %11 : i1, i32
    llvm.return %12 : i32
  }
  llvm.func @test_gep_extra_uses(%arg0: i1, %arg1: i1) -> i8 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.call @get_ptr.i8() : () -> !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.call @foo.i8(%3) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%3, %4 : !llvm.ptr, i8)
  ^bb2:  // pred: ^bb0
    %5 = llvm.getelementptr inbounds %2[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %6 = llvm.load %5 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.call @foo.i8(%5) : (!llvm.ptr) -> ()
    llvm.br ^bb3(%5, %6 : !llvm.ptr, i8)
  ^bb3(%7: !llvm.ptr, %8: i8):  // 2 preds: ^bb1, ^bb2
    llvm.store %1, %7 {alignment = 1 : i64} : i8, !llvm.ptr
    %9 = llvm.load %7 {alignment = 1 : i64} : !llvm.ptr -> i8
    %10 = llvm.select %arg1, %8, %9 : i1, i8
    llvm.return %10 : i8
  }
  llvm.func @takeAddress(!llvm.ptr)
  llvm.func @test_dont_optimize_swifterror(%arg0: i1, %arg1: i1, %arg2: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.call @takeAddress(%2) : (!llvm.ptr) -> ()
    llvm.call @takeAddress(%3) : (!llvm.ptr) -> ()
    llvm.store %arg2, %2 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb3(%4 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    %5 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.br ^bb3(%5 : !llvm.ptr)
  ^bb3(%6: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %1, %2 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    %7 = llvm.select %arg1, %6, %1 : i1, !llvm.ptr
    llvm.return %7 : !llvm.ptr
  }
}
