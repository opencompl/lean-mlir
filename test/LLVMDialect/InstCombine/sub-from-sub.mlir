module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g0() {addr_space = 0 : i32, alignment = 1 : i64} : i8
  llvm.mlir.global external @g1() {addr_space = 0 : i32, alignment = 1 : i64} : i8
  llvm.func @use8(i8)
  llvm.func @t0(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.sub %0, %arg2  : i8
    llvm.return %1 : i8
  }
  llvm.func @t1_flags(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw, nuw>  : i8
    %1 = llvm.sub %0, %arg2 overflow<nsw, nuw>  : i8
    llvm.return %1 : i8
  }
  llvm.func @t1_flags_nuw_only(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nuw>  : i8
    %1 = llvm.sub %0, %arg2 overflow<nuw>  : i8
    llvm.return %1 : i8
  }
  llvm.func @t1_flags_sub_nsw_sub(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %1 = llvm.sub %0, %arg2  : i8
    llvm.return %1 : i8
  }
  llvm.func @t1_flags_nuw_first(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nuw>  : i8
    %1 = llvm.sub %0, %arg2  : i8
    llvm.return %1 : i8
  }
  llvm.func @t1_flags_nuw_second(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.sub %0, %arg2 overflow<nuw>  : i8
    llvm.return %1 : i8
  }
  llvm.func @t1_flags_nuw_nsw_first(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1 overflow<nsw, nuw>  : i8
    %1 = llvm.sub %0, %arg2  : i8
    llvm.return %1 : i8
  }
  llvm.func @t1_flags_nuw_nsw_second(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    %1 = llvm.sub %0, %arg2 overflow<nsw, nuw>  : i8
    llvm.return %1 : i8
  }
  llvm.func @n2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%0) : (i8) -> ()
    %1 = llvm.sub %0, %arg2  : i8
    llvm.return %1 : i8
  }
  llvm.func @t3_c0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    %2 = llvm.sub %1, %arg1  : i8
    llvm.return %2 : i8
  }
  llvm.func @t4_c1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %arg0, %0  : i8
    %2 = llvm.sub %1, %arg1  : i8
    llvm.return %2 : i8
  }
  llvm.func @t5_c2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    %2 = llvm.sub %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @t6_c0_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %1, %arg1  : i8
    llvm.return %2 : i8
  }
  llvm.func @t7_c1_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %1, %arg1  : i8
    llvm.return %2 : i8
  }
  llvm.func @t8_c2_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.sub %arg0, %arg1  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.sub %1, %0  : i8
    llvm.return %2 : i8
  }
  llvm.func @t9_c0_c2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.sub %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @t10_c1_c2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.sub %arg0, %0  : i8
    %3 = llvm.sub %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @t11_c0_c2_extrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func @t12_c1_c2_exrause(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.sub %arg0, %0  : i8
    llvm.call @use8(%2) : (i8) -> ()
    %3 = llvm.sub %2, %1  : i8
    llvm.return %3 : i8
  }
  llvm.func unnamed_addr @constantexpr0(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.addressof @g0 : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.add %arg0, %1  : i32
    %4 = llvm.sub %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func unnamed_addr @constantexpr1(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.addressof @g1 : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.sub %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func unnamed_addr @constantexpr2(%arg0: i32, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.addressof @g0 : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.mlir.addressof @g1 : !llvm.ptr
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.sub %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @pr49870(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.addressof @g0 : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.xor %arg0, %0  : i64
    %4 = llvm.add %3, %2  : i64
    llvm.return %4 : i64
  }
}
