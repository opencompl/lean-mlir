module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_imply_not1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.call @use(%3) : (i1) -> ()
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    llvm.call @use(%4) : (i1) -> ()
    %5 = llvm.xor %3, %2  : i1
    %6 = llvm.or %4, %5  : i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @func1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @func2() : () -> ()
    llvm.unreachable
  }
  llvm.func @test_imply_not2(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.select %3, %arg1, %1 : i1, i1
    %5 = llvm.xor %3, %2  : i1
    %6 = llvm.or %4, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @test_imply_not3(%arg0: i32, %arg1: i32, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.call @use(%2) : (i1) -> ()
    %3 = llvm.icmp "slt" %arg0, %arg1 : i32
    %4 = llvm.xor %2, %0  : i1
    %5 = llvm.select %4, %arg2, %1 : i1, i1
    %6 = llvm.and %3, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @func1()
  llvm.func @func2()
  llvm.func @use(i1)
}
