module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g() {addr_space = 0 : i32} : i32
  llvm.func @use(i8)
  llvm.func @use_vec(vector<2xi8>)
  llvm.func @or_and_not_constant_commute0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.or %arg1, %arg0  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @or_and_not_constant_commute1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.and %0, %2  : i32
    %4 = llvm.and %1, %arg1  : i32
    %5 = llvm.or %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @or_and_not_constant_commute2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.or %arg1, %arg0  : i32
    %3 = llvm.and %2, %0  : i32
    %4 = llvm.and %arg1, %1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @or_and_not_constant_commute3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.or %arg0, %arg1  : i32
    %3 = llvm.and %0, %2  : i32
    %4 = llvm.and %1, %arg1  : i32
    %5 = llvm.or %4, %3  : i32
    llvm.return %5 : i32
  }
  llvm.func @or_and_not_constant_commute0_splat(%arg0: vector<2xi7>, %arg1: vector<2xi7>) -> vector<2xi7> {
    %0 = llvm.mlir.constant(42 : i7) : i7
    %1 = llvm.mlir.constant(dense<42> : vector<2xi7>) : vector<2xi7>
    %2 = llvm.mlir.constant(-43 : i7) : i7
    %3 = llvm.mlir.constant(dense<-43> : vector<2xi7>) : vector<2xi7>
    %4 = llvm.or %arg1, %arg0  : vector<2xi7>
    %5 = llvm.and %4, %1  : vector<2xi7>
    %6 = llvm.and %arg1, %3  : vector<2xi7>
    %7 = llvm.or %5, %6  : vector<2xi7>
    llvm.return %7 : vector<2xi7>
  }
  llvm.func @or_and_or_commute0(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(59 : i8) : i8
    %2 = llvm.mlir.constant(64 : i8) : i8
    %3 = llvm.or %arg0, %0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.and %3, %1  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.and %arg0, %2  : i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.or %4, %5  : i8
    llvm.return %6 : i8
  }
  llvm.func @or_and_or_commute1(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(16 : i8) : i8
    %1 = llvm.mlir.constant(59 : i8) : i8
    %2 = llvm.mlir.constant(64 : i8) : i8
    %3 = llvm.or %arg0, %0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.and %3, %1  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.and %arg0, %2  : i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.or %5, %4  : i8
    llvm.return %6 : i8
  }
  llvm.func @or_and_or_commute1_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<16> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<59> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<64> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.or %arg0, %0  : vector<2xi8>
    llvm.call @use_vec(%3) : (vector<2xi8>) -> ()
    %4 = llvm.and %3, %1  : vector<2xi8>
    llvm.call @use_vec(%4) : (vector<2xi8>) -> ()
    %5 = llvm.and %arg0, %2  : vector<2xi8>
    llvm.call @use_vec(%5) : (vector<2xi8>) -> ()
    %6 = llvm.or %5, %4  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }
  llvm.func @or_and_or_commute2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-69 : i8) : i8
    %2 = llvm.mlir.constant(64 : i8) : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.or %3, %arg0  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.and %4, %1  : i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.and %arg0, %2  : i8
    llvm.call @use(%6) : (i8) -> ()
    %7 = llvm.or %5, %6  : i8
    llvm.return %7 : i8
  }
  llvm.func @or_and_or_commute2_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-69> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<64> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.lshr %arg1, %0  : vector<2xi8>
    %4 = llvm.or %3, %arg0  : vector<2xi8>
    llvm.call @use_vec(%4) : (vector<2xi8>) -> ()
    %5 = llvm.and %4, %1  : vector<2xi8>
    llvm.call @use_vec(%5) : (vector<2xi8>) -> ()
    %6 = llvm.and %arg0, %2  : vector<2xi8>
    llvm.call @use_vec(%6) : (vector<2xi8>) -> ()
    %7 = llvm.or %5, %6  : vector<2xi8>
    llvm.return %7 : vector<2xi8>
  }
  llvm.func @or_and_or_commute3(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-69 : i8) : i8
    %2 = llvm.mlir.constant(64 : i8) : i8
    %3 = llvm.lshr %arg1, %0  : i8
    %4 = llvm.or %3, %arg0  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.and %4, %1  : i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.and %arg0, %2  : i8
    llvm.call @use(%6) : (i8) -> ()
    %7 = llvm.or %6, %5  : i8
    llvm.return %7 : i8
  }
  llvm.func @or_and2_or2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(-71 : i8) : i8
    %3 = llvm.mlir.constant(66 : i8) : i8
    %4 = llvm.or %arg0, %0  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.or %arg0, %1  : i8
    llvm.call @use(%5) : (i8) -> ()
    %6 = llvm.and %4, %2  : i8
    llvm.call @use(%6) : (i8) -> ()
    %7 = llvm.and %5, %3  : i8
    llvm.call @use(%7) : (i8) -> ()
    %8 = llvm.or %6, %7  : i8
    llvm.return %8 : i8
  }
  llvm.func @or_and2_or2_splat(%arg0: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-71> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<66> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.or %arg0, %0  : vector<2xi8>
    llvm.call @use_vec(%4) : (vector<2xi8>) -> ()
    %5 = llvm.or %arg0, %1  : vector<2xi8>
    llvm.call @use_vec(%5) : (vector<2xi8>) -> ()
    %6 = llvm.and %4, %2  : vector<2xi8>
    llvm.call @use_vec(%6) : (vector<2xi8>) -> ()
    %7 = llvm.and %5, %3  : vector<2xi8>
    llvm.call @use_vec(%7) : (vector<2xi8>) -> ()
    %8 = llvm.or %6, %7  : vector<2xi8>
    llvm.return %8 : vector<2xi8>
  }
  llvm.func @and_or_hoist_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.or %2, %arg1  : i8
    %4 = llvm.and %3, %1  : i8
    llvm.return %4 : i8
  }
  llvm.func @and_xor_hoist_mask_vec_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.xor %2, %arg1  : vector<2xi8>
    %4 = llvm.and %3, %1  : vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }
  llvm.func @and_xor_hoist_mask_commute(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(43 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.mul %arg1, %0  : i8
    %4 = llvm.lshr %arg0, %1  : i8
    %5 = llvm.xor %3, %4  : i8
    %6 = llvm.and %5, %2  : i8
    llvm.return %6 : i8
  }
  llvm.func @and_or_hoist_mask_commute_vec_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<43> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mul %arg1, %0  : vector<2xi8>
    %4 = llvm.lshr %arg0, %1  : vector<2xi8>
    %5 = llvm.or %3, %4  : vector<2xi8>
    %6 = llvm.and %5, %2  : vector<2xi8>
    llvm.return %6 : vector<2xi8>
  }
  llvm.func @pr64114_and_xor_hoist_mask_constexpr() -> i32 {
    %0 = llvm.mlir.addressof @g : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i32
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.lshr %1, %2  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.and %5, %3  : i32
    llvm.return %6 : i32
  }
  llvm.func @and_or_do_not_hoist_mask(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.or %2, %arg1  : i8
    %4 = llvm.and %3, %1  : i8
    %5 = llvm.mul %3, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @or_or_and_complex(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.constant(71776119061217280 : i64) : i64
    %2 = llvm.mlir.constant(-72057594037927936 : i64) : i64
    %3 = llvm.mlir.constant(1095216660480 : i64) : i64
    %4 = llvm.mlir.constant(280375465082880 : i64) : i64
    %5 = llvm.mlir.constant(16711680 : i64) : i64
    %6 = llvm.mlir.constant(4278190080 : i64) : i64
    %7 = llvm.mlir.constant(255 : i64) : i64
    %8 = llvm.mlir.constant(65280 : i64) : i64
    %9 = llvm.lshr %arg0, %0  : i64
    %10 = llvm.and %9, %1  : i64
    %11 = llvm.shl %arg0, %0  : i64
    %12 = llvm.and %11, %2  : i64
    %13 = llvm.or %10, %12  : i64
    %14 = llvm.and %9, %3  : i64
    %15 = llvm.or %13, %14  : i64
    %16 = llvm.and %11, %4  : i64
    %17 = llvm.or %15, %16  : i64
    %18 = llvm.and %9, %5  : i64
    %19 = llvm.or %17, %18  : i64
    %20 = llvm.and %11, %6  : i64
    %21 = llvm.or %19, %20  : i64
    %22 = llvm.and %9, %7  : i64
    %23 = llvm.or %21, %22  : i64
    %24 = llvm.and %11, %8  : i64
    %25 = llvm.or %23, %24  : i64
    llvm.return %25 : i64
  }
  llvm.func @or_or_and_noOneUse(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.and %arg0, %arg1  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.and %arg0, %arg3  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.or %arg2, %1  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.or %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @or_or_and_pat1(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.udiv %0, %arg2  : i8
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.and %arg0, %arg3  : i8
    %4 = llvm.or %1, %3  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @or_or_and_pat2(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.udiv %0, %arg2  : i8
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.and %arg3, %arg0  : i8
    %4 = llvm.or %1, %3  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @or_or_and_pat3(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.udiv %0, %arg2  : i8
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.and %arg1, %arg3  : i8
    %4 = llvm.or %1, %3  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @or_or_and_pat4(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.udiv %0, %arg2  : i8
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.and %arg3, %arg1  : i8
    %4 = llvm.or %1, %3  : i8
    %5 = llvm.or %4, %2  : i8
    llvm.return %5 : i8
  }
  llvm.func @or_or_and_pat5(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.and %arg0, %arg1  : i8
    %1 = llvm.and %arg0, %arg3  : i8
    %2 = llvm.or %1, %arg2  : i8
    %3 = llvm.or %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @or_or_and_pat6(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.and %arg0, %arg1  : i8
    %1 = llvm.and %arg3, %arg0  : i8
    %2 = llvm.or %1, %arg2  : i8
    %3 = llvm.or %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @or_or_and_pat7(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.and %arg0, %arg1  : i8
    %1 = llvm.and %arg1, %arg3  : i8
    %2 = llvm.or %1, %arg2  : i8
    %3 = llvm.or %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @or_or_and_pat8(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.and %arg0, %arg1  : i8
    %1 = llvm.and %arg3, %arg1  : i8
    %2 = llvm.or %1, %arg2  : i8
    %3 = llvm.or %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @or_and_or_noOneUse(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.and %arg0, %arg1  : i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.and %arg0, %arg3  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.or %arg2, %1  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.or %0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @or_and_or_pat1(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.udiv %0, %arg2  : i8
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.and %arg0, %arg3  : i8
    %4 = llvm.or %1, %3  : i8
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @or_and_or_pat2(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.udiv %0, %arg2  : i8
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.and %arg3, %arg0  : i8
    %4 = llvm.or %1, %3  : i8
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @or_and_or_pat3(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.udiv %0, %arg2  : i8
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.and %arg1, %arg3  : i8
    %4 = llvm.or %1, %3  : i8
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @or_and_or_pat4(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.udiv %0, %arg2  : i8
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.and %arg3, %arg1  : i8
    %4 = llvm.or %1, %3  : i8
    %5 = llvm.or %2, %4  : i8
    llvm.return %5 : i8
  }
  llvm.func @or_and_or_pat5(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.and %arg0, %arg1  : i8
    %1 = llvm.and %arg0, %arg3  : i8
    %2 = llvm.or %1, %arg2  : i8
    %3 = llvm.or %0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @or_and_or_pat6(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.and %arg0, %arg1  : i8
    %1 = llvm.and %arg3, %arg0  : i8
    %2 = llvm.or %1, %arg2  : i8
    %3 = llvm.or %0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @or_and_or_pat7(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.and %arg0, %arg1  : i8
    %1 = llvm.and %arg1, %arg3  : i8
    %2 = llvm.or %1, %arg2  : i8
    %3 = llvm.or %0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @or_and_or_pat8(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.and %arg0, %arg1  : i8
    %1 = llvm.and %arg3, %arg1  : i8
    %2 = llvm.or %1, %arg2  : i8
    %3 = llvm.or %0, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @use2(i32)
  llvm.func @or_or_and_noOneUse_fail1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(23 : i32) : i32
    %1 = llvm.mlir.constant(925 : i32) : i32
    %2 = llvm.mlir.constant(157 : i32) : i32
    %3 = llvm.ashr %arg0, %0  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.zext %4 : i8 to i32
    %6 = llvm.and %5, %1  : i32
    llvm.call @use2(%6) : (i32) -> ()
    %7 = llvm.and %3, %arg1  : i32
    %8 = llvm.or %7, %6  : i32
    %9 = llvm.ashr %arg1, %0  : i32
    %10 = llvm.and %9, %2  : i32
    %11 = llvm.or %8, %10  : i32
    llvm.return %11 : i32
  }
  llvm.func @or_or_and_noOneUse_fail2(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1, %arg5: i1, %arg6: i1, %arg7: i1) -> !llvm.struct<(i1, i1, i1, i1, i1)> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.undef : !llvm.struct<(i1, i1, i1, i1, i1)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i1, i1, i1, i1, i1)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<(i1, i1, i1, i1, i1)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<(i1, i1, i1, i1, i1)> 
    %6 = llvm.insertvalue %1, %5[3] : !llvm.struct<(i1, i1, i1, i1, i1)> 
    %7 = llvm.insertvalue %1, %6[4] : !llvm.struct<(i1, i1, i1, i1, i1)> 
    %8 = llvm.and %arg0, %arg4  : i1
    %9 = llvm.and %arg3, %arg7  : i1
    %10 = llvm.xor %arg2, %arg6  : i1
    %11 = llvm.and %arg1, %arg5  : i1
    %12 = llvm.xor %11, %0  : i1
    %13 = llvm.and %8, %arg1  : i1
    %14 = llvm.and %10, %arg5  : i1
    %15 = llvm.or %11, %14  : i1
    %16 = llvm.or %15, %13  : i1
    %17 = llvm.xor %16, %0  : i1
    %18 = llvm.xor %17, %0  : i1
    %19 = llvm.xor %9, %0  : i1
    %20 = llvm.and %19, %12  : i1
    %21 = llvm.xor %20, %0  : i1
    %22 = llvm.insertvalue %18, %7[0] : !llvm.struct<(i1, i1, i1, i1, i1)> 
    %23 = llvm.insertvalue %12, %22[1] : !llvm.struct<(i1, i1, i1, i1, i1)> 
    %24 = llvm.insertvalue %0, %23[2] : !llvm.struct<(i1, i1, i1, i1, i1)> 
    %25 = llvm.insertvalue %arg3, %24[3] : !llvm.struct<(i1, i1, i1, i1, i1)> 
    %26 = llvm.insertvalue %21, %25[4] : !llvm.struct<(i1, i1, i1, i1, i1)> 
    llvm.return %26 : !llvm.struct<(i1, i1, i1, i1, i1)>
  }
}
