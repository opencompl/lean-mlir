module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg1, %1 : i32
    %4 = llvm.xor %3, %2  : i1
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.and %arg0, %0  : i32
    %2 = llvm.and %arg1, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.lshr %arg0, %0  : i32
    %2 = llvm.lshr %arg1, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }
  llvm.func @test3vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    %2 = llvm.lshr %arg1, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %1, %2 : vector<2xi32>
    %4 = llvm.zext %3 : vector<2xi1> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @test3vec_poison1(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<24> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.lshr %arg0, %6  : vector<2xi32>
    %9 = llvm.lshr %arg1, %7  : vector<2xi32>
    %10 = llvm.icmp "eq" %8, %9 : vector<2xi32>
    %11 = llvm.zext %10 : vector<2xi1> to vector<2xi32>
    llvm.return %11 : vector<2xi32>
  }
  llvm.func @test3vec_poison2(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(17 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.lshr %arg0, %6  : vector<2xi32>
    %8 = llvm.lshr %arg1, %6  : vector<2xi32>
    %9 = llvm.icmp "eq" %7, %8 : vector<2xi32>
    %10 = llvm.zext %9 : vector<2xi1> to vector<2xi32>
    llvm.return %10 : vector<2xi32>
  }
  llvm.func @test3vec_diff(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %0  : vector<2xi32>
    %3 = llvm.lshr %arg1, %1  : vector<2xi32>
    %4 = llvm.icmp "eq" %2, %3 : vector<2xi32>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @"test3vec_non-uniform"(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[30, 31]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.lshr %arg0, %0  : vector<2xi32>
    %2 = llvm.lshr %arg1, %0  : vector<2xi32>
    %3 = llvm.icmp "eq" %1, %2 : vector<2xi32>
    %4 = llvm.zext %3 : vector<2xi1> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @test3i(%arg0: i32, %arg1: i32) -> i32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(29 : i32) : i32
    %1 = llvm.mlir.constant(35 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.lshr %arg1, %0  : i32
    %4 = llvm.or %2, %1  : i32
    %5 = llvm.or %3, %1  : i32
    %6 = llvm.icmp "eq" %4, %5 : i32
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }
  llvm.func @test4a(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.ashr %arg0, %0  : i32
    %4 = llvm.sub %1, %arg0  : i32
    %5 = llvm.lshr %4, %0  : i32
    %6 = llvm.or %3, %5  : i32
    %7 = llvm.icmp "slt" %6, %2 : i32
    llvm.return %7 : i1
  }
  llvm.func @test4a_vec(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<31> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.ashr %arg0, %0  : vector<2xi32>
    %5 = llvm.sub %2, %arg0  : vector<2xi32>
    %6 = llvm.lshr %5, %0  : vector<2xi32>
    %7 = llvm.or %4, %6  : vector<2xi32>
    %8 = llvm.icmp "slt" %7, %3 : vector<2xi32>
    llvm.return %8 : vector<2xi1>
  }
  llvm.func @test4b(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.ashr %arg0, %0  : i64
    %4 = llvm.sub %1, %arg0  : i64
    %5 = llvm.lshr %4, %0  : i64
    %6 = llvm.or %3, %5  : i64
    %7 = llvm.icmp "slt" %6, %2 : i64
    llvm.return %7 : i1
  }
  llvm.func @test4c(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.ashr %arg0, %0  : i64
    %4 = llvm.sub %1, %arg0  : i64
    %5 = llvm.lshr %4, %0  : i64
    %6 = llvm.or %3, %5  : i64
    %7 = llvm.trunc %6 : i64 to i32
    %8 = llvm.icmp "slt" %7, %2 : i32
    llvm.return %8 : i1
  }
  llvm.func @test4c_vec(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<63> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.ashr %arg0, %0  : vector<2xi64>
    %5 = llvm.sub %2, %arg0  : vector<2xi64>
    %6 = llvm.lshr %5, %0  : vector<2xi64>
    %7 = llvm.or %4, %6  : vector<2xi64>
    %8 = llvm.trunc %7 : vector<2xi64> to vector<2xi32>
    %9 = llvm.icmp "slt" %8, %3 : vector<2xi32>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @shift_trunc_signbit_test(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.icmp "slt" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @shift_trunc_signbit_test_vec_uses(%arg0: vector<2xi17>, %arg1: !llvm.ptr, %arg2: !llvm.ptr) -> vector<2xi1> {
    %0 = llvm.mlir.constant(4 : i17) : i17
    %1 = llvm.mlir.constant(dense<4> : vector<2xi17>) : vector<2xi17>
    %2 = llvm.mlir.constant(-1 : i13) : i13
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi13>) : vector<2xi13>
    %4 = llvm.lshr %arg0, %1  : vector<2xi17>
    llvm.store %4, %arg1 {alignment = 8 : i64} : vector<2xi17>, !llvm.ptr
    %5 = llvm.trunc %4 : vector<2xi17> to vector<2xi13>
    llvm.store %5, %arg2 {alignment = 4 : i64} : vector<2xi13>, !llvm.ptr
    %6 = llvm.icmp "sgt" %5, %3 : vector<2xi13>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @shift_trunc_wrong_shift(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.icmp "slt" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @shift_trunc_wrong_cmp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    %4 = llvm.icmp "slt" %3, %1 : i8
    llvm.return %4 : i1
  }
}
