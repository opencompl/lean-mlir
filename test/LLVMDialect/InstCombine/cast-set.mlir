module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.bitcast %arg0 : i32 to i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.bitcast %arg0 : i32 to i32
    %1 = llvm.bitcast %arg1 : i32 to i32
    %2 = llvm.icmp "ne" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @test4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.bitcast %arg0 : i32 to i32
    %2 = llvm.shl %1, %0  : i32
    %3 = llvm.bitcast %2 : i32 to i32
    llvm.return %3 : i32
  }
  llvm.func @test5(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.and %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i16
    llvm.return %3 : i16
  }
  llvm.func @test6(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test6a(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test7(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }
}
