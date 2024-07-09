module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.zext %arg0 : i8 to i64
    %1 = llvm.zext %arg1 : i8 to i64
    %2 = llvm.add %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i8
    llvm.return %3 : i8
  }
  llvm.func @test2(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.zext %arg0 : i16 to i64
    %1 = llvm.zext %arg1 : i16 to i64
    %2 = llvm.add %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i16
    llvm.return %3 : i16
  }
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.zext %arg0 : i32 to i64
    %1 = llvm.zext %arg1 : i32 to i64
    %2 = llvm.add %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i32
    llvm.return %3 : i32
  }
  llvm.func @test4(%arg0: i9, %arg1: i9) -> i9 {
    %0 = llvm.zext %arg0 : i9 to i64
    %1 = llvm.zext %arg1 : i9 to i64
    %2 = llvm.add %0, %1  : i64
    %3 = llvm.trunc %2 : i64 to i9
    llvm.return %3 : i9
  }
}
