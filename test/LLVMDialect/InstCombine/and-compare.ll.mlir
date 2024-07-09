module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.func @use.i8(i8)
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(65280 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "ne" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @test1vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<65280> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.and %arg0, %0  : vector<2xi32>
    %2 = llvm.and %arg1, %0  : vector<2xi32>
    %3 = llvm.icmp "ne" %1, %2 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @test2(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(128 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @test2vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.and %arg0, %0  : vector<2xi64>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test3(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(128 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "ne" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @test3vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<128> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.and %arg0, %0  : vector<2xi64>
    %4 = llvm.icmp "ne" %3, %2 : vector<2xi64>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test_ne_cp2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-16 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %2, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @test_ne_cp2_2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "eq" %3, %2 : i8
    llvm.return %4 : i1
  }
  llvm.func @test_ne_cp2_other_okay_all_ones(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %2, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @test_ne_cp2_other_fail2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-16 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %2, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @test_ne_cp2_other_okay(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %2, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @test_ne_cp2_other_okay2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(16 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "ne" %3, %2 : i8
    llvm.return %4 : i1
  }
}
