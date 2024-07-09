module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @escape32(i32)
  llvm.func @test_sext_zext(%arg0: i16) -> i64 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = llvm.sext %0 : i32 to i64
    llvm.return %1 : i64
  }
  llvm.func @test_used_sext_zext(%arg0: i16) -> i64 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = llvm.sext %0 : i32 to i64
    llvm.call @escape32(%0) : (i32) -> ()
    llvm.return %1 : i64
  }
  llvm.func @test_cast_select(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.mlir.constant(5 : i16) : i16
    %2 = llvm.select %arg0, %0, %1 : i1, i16
    %3 = llvm.zext %2 : i16 to i32
    llvm.return %3 : i32
  }
  llvm.func @test_or(%arg0: i64) {
    %0 = llvm.mlir.constant(256 : i64) : i64
    %1 = llvm.or %arg0, %0  : i64
    llvm.return
  }
  llvm.func @test_xor(%arg0: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    llvm.return
  }
  llvm.func @test_sub_neg(%arg0: i64) {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.sub %arg0, %0  : i64
    llvm.return
  }
  llvm.func @test_sub_pos(%arg0: i64) {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.sub %arg0, %0  : i64
    llvm.return
  }
  llvm.func @test_shl(%arg0: i64) {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.shl %arg0, %0  : i64
    llvm.return
  }
  llvm.func @test_lshr(%arg0: i64) {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.lshr %arg0, %0  : i64
    llvm.return
  }
  llvm.func @test_ashr(%arg0: i64) {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.ashr %arg0, %0  : i64
    llvm.return
  }
  llvm.func @test_mul(%arg0: i64) {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mul %arg0, %0  : i64
    llvm.return
  }
  llvm.func @test_sdiv(%arg0: i64) {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.sdiv %arg0, %0  : i64
    llvm.return
  }
  llvm.func @test_srem(%arg0: i64) {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.srem %arg0, %0  : i64
    llvm.return
  }
  llvm.func @test_ptrtoint(%arg0: !llvm.ptr) {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    llvm.return
  }
  llvm.func @test_and(%arg0: i64) {
    %0 = llvm.mlir.constant(256 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    llvm.return
  }
}
