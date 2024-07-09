module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.func @use(!llvm.ptr) -> i32
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: i1) -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.call @use(%0) : (!llvm.ptr) -> i32
    llvm.br ^bb4(%3 : i32)
  ^bb2:  // pred: ^bb0
    %4 = llvm.call @use(%1) : (!llvm.ptr) -> i32
    llvm.cond_br %arg1, ^bb4(%4 : i32), ^bb3
  ^bb3:  // pred: ^bb2
    %5 = llvm.call @use(%1) : (!llvm.ptr) -> i32
    llvm.br ^bb4(%5 : i32)
  ^bb4(%6: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return %6 : i32
  }
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: i1) -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.cond_br %2, ^bb5(%1 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.cond_br %arg1, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %4 = llvm.call @use(%0) : (!llvm.ptr) -> i32
    llvm.br ^bb5(%4 : i32)
  ^bb3:  // pred: ^bb1
    %5 = llvm.call @use(%3) : (!llvm.ptr) -> i32
    llvm.cond_br %arg1, ^bb5(%5 : i32), ^bb4
  ^bb4:  // pred: ^bb3
    %6 = llvm.call @use(%3) : (!llvm.ptr) -> i32
    llvm.br ^bb5(%6 : i32)
  ^bb5(%7: i32):  // 4 preds: ^bb0, ^bb2, ^bb3, ^bb4
    llvm.return %7 : i32
  }
}
