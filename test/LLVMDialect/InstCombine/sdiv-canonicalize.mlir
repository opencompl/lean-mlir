module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @X(5 : i32) {addr_space = 0 : i32} : i32
  llvm.func @use(i32)
  llvm.func @test_sdiv_canonicalize_op0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.sdiv %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_sdiv_canonicalize_op0_exact(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.sdiv %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_sdiv_canonicalize_op1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mul %arg1, %0  : i32
    %3 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %4 = llvm.sdiv %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @test_sdiv_canonicalize_nonsw(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.sdiv %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test_sdiv_canonicalize_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %1, %arg0 overflow<nsw>  : vector<2xi32>
    %3 = llvm.sdiv %2, %arg1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @test_sdiv_canonicalize_multiple_uses(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0 overflow<nsw>  : i32
    %2 = llvm.sdiv %1, %arg1  : i32
    %3 = llvm.sdiv %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test_sdiv_canonicalize_constexpr(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.addressof @X : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %4 = llvm.sub %2, %3 overflow<nsw>  : i64
    %5 = llvm.sdiv %arg0, %4  : i64
    llvm.return %5 : i64
  }
  llvm.func @sdiv_abs_nsw(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32
    %1 = llvm.sdiv %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @sdiv_abs_nsw_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (vector<4xi32>) -> vector<4xi32>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @sdiv_abs(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = false}> : (i32) -> i32
    %1 = llvm.sdiv %0, %arg0  : i32
    llvm.return %1 : i32
  }
  llvm.func @sdiv_abs_extra_use(%arg0: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg0) <{is_int_min_poison = true}> : (i32) -> i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.sdiv %0, %arg0  : i32
    llvm.return %1 : i32
  }
}
