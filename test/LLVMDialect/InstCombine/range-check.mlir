module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_and1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "sge" %arg0, %1 : i32
    %4 = llvm.icmp "slt" %arg0, %2 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @test_and1_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "sge" %arg0, %1 : i32
    %5 = llvm.icmp "slt" %arg0, %3 : i32
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @test_and2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.icmp "sle" %arg0, %2 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @test_and2_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.icmp "sle" %arg0, %3 : i32
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @test_and3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "sgt" %2, %arg0 : i32
    %4 = llvm.icmp "sge" %arg0, %1 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @test_and3_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "sgt" %3, %arg0 : i32
    %5 = llvm.icmp "sge" %arg0, %1 : i32
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @test_and4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "sge" %2, %arg0 : i32
    %4 = llvm.icmp "sge" %arg0, %1 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @test_and4_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "sge" %3, %arg0 : i32
    %5 = llvm.icmp "sge" %arg0, %1 : i32
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @test_or1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.icmp "sge" %arg0, %2 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @test_or1_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.icmp "sge" %arg0, %3 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @test_or2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "sle" %arg0, %1 : i32
    %4 = llvm.icmp "sgt" %arg0, %2 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @test_or2_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "sle" %arg0, %1 : i32
    %5 = llvm.icmp "sgt" %arg0, %3 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @test_or3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "sle" %2, %arg0 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @test_or3_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "sle" %3, %arg0 : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @test_or4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "slt" %2, %arg0 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @test_or4_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "slt" %3, %arg0 : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @negative1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "slt" %arg0, %2 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @negative1_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "slt" %arg0, %3 : i32
    %5 = llvm.icmp "sgt" %arg0, %1 : i32
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @negative2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @negative2_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %arg1 : i32
    %3 = llvm.icmp "sge" %arg0, %0 : i32
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @negative3(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg2, %0  : i32
    %3 = llvm.icmp "slt" %arg0, %2 : i32
    %4 = llvm.icmp "sge" %arg1, %1 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @negative3_logical(%arg0: i32, %arg1: i32, %arg2: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg2, %0  : i32
    %4 = llvm.icmp "slt" %arg0, %3 : i32
    %5 = llvm.icmp "sge" %arg1, %1 : i32
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @negative4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "ne" %arg0, %2 : i32
    %4 = llvm.icmp "sge" %arg0, %1 : i32
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @negative4_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "ne" %arg0, %3 : i32
    %5 = llvm.icmp "sge" %arg0, %1 : i32
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @negative5(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "slt" %arg0, %2 : i32
    %4 = llvm.icmp "sge" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @negative5_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg1, %0  : i32
    %4 = llvm.icmp "slt" %arg0, %3 : i32
    %5 = llvm.icmp "sge" %arg0, %1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.return %6 : i1
  }
}
