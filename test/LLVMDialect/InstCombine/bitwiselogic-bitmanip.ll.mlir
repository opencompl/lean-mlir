module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_or_fshl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    %1 = llvm.intr.fshl(%arg2, %arg3, %arg4)  : (i32, i32, i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_and_fshl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    %1 = llvm.intr.fshl(%arg2, %arg3, %arg4)  : (i32, i32, i32) -> i32
    %2 = llvm.and %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_xor_fshl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    %1 = llvm.intr.fshl(%arg2, %arg3, %arg4)  : (i32, i32, i32) -> i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_or_fshr(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.intr.fshr(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    %1 = llvm.intr.fshr(%arg2, %arg3, %arg4)  : (i32, i32, i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_or_fshl_cascade(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i32, i32, i32) -> i32
    %2 = llvm.intr.fshl(%arg1, %arg1, %0)  : (i32, i32, i32) -> i32
    %3 = llvm.intr.fshl(%arg2, %arg2, %0)  : (i32, i32, i32) -> i32
    %4 = llvm.or %1, %2  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @test_or_bitreverse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %1 = llvm.intr.bitreverse(%arg1)  : (i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_or_bitreverse_constant(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-16777216 : i32) : i32
    %1 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %2 = llvm.or %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_or_bswap(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %1 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_or_bswap_constant(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-16777216 : i32) : i32
    %1 = llvm.intr.bswap(%arg0)  : (i32) -> i32
    %2 = llvm.or %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_or_fshl_fshr(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    %1 = llvm.intr.fshr(%arg2, %arg3, %arg4)  : (i32, i32, i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_or_bitreverse_bswap(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    %1 = llvm.intr.bswap(%arg1)  : (i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_or_fshl_mismatched_shamt(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    %1 = llvm.intr.fshl(%arg2, %arg3, %arg5)  : (i32, i32, i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_add_fshl(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    %1 = llvm.intr.fshl(%arg2, %arg3, %arg4)  : (i32, i32, i32) -> i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_or_fshl_multiuse(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) -> i32 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg4)  : (i32, i32, i32) -> i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.intr.fshl(%arg2, %arg3, %arg4)  : (i32, i32, i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_or_bitreverse_multiuse(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.bitreverse(%arg0)  : (i32) -> i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.intr.bitreverse(%arg1)  : (i32) -> i32
    %2 = llvm.or %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_or_fshl_constant(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-16777216 : i32) : i32
    %1 = llvm.intr.fshl(%arg0, %arg1, %arg2)  : (i32, i32, i32) -> i32
    %2 = llvm.or %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @use(i32)
}
