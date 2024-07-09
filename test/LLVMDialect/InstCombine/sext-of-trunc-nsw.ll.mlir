module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use8(i8)
  llvm.func @use4(i4)
  llvm.func @usevec(vector<2xi8>)
  llvm.func @t0(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.trunc %1 : i8 to i4
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }
  llvm.func @t1(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.trunc %1 : i8 to i4
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }
  llvm.func @n2(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.trunc %1 : i8 to i4
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }
  llvm.func @t3_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    llvm.call @usevec(%1) : (vector<2xi8>) -> ()
    %2 = llvm.trunc %1 : vector<2xi8> to vector<2xi4>
    %3 = llvm.sext %2 : vector<2xi4> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @t4_vec_nonsplat(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[4, 3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.ashr %arg0, %0  : vector<2xi8>
    llvm.call @usevec(%1) : (vector<2xi8>) -> ()
    %2 = llvm.trunc %1 : vector<2xi8> to vector<2xi4>
    %3 = llvm.sext %2 : vector<2xi4> to vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @t5_extrause(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.ashr %arg0, %0  : i8
    llvm.call @use8(%1) : (i8) -> ()
    %2 = llvm.trunc %1 : i8 to i4
    llvm.call @use4(%2) : (i4) -> ()
    %3 = llvm.sext %2 : i4 to i16
    llvm.return %3 : i16
  }
  llvm.func @narrow_source_matching_signbits(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.sext %4 : i8 to i64
    llvm.return %5 : i64
  }
  llvm.func @narrow_source_not_matching_signbits(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.sext %4 : i8 to i64
    llvm.return %5 : i64
  }
  llvm.func @wide_source_matching_signbits(%arg0: i32) -> i24 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.sext %4 : i8 to i24
    llvm.return %5 : i24
  }
  llvm.func @wide_source_not_matching_signbits(%arg0: i32) -> i24 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.sext %4 : i8 to i24
    llvm.return %5 : i24
  }
  llvm.func @same_source_matching_signbits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.sext %4 : i8 to i32
    llvm.return %5 : i32
  }
  llvm.func @same_source_not_matching_signbits(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.sext %4 : i8 to i32
    llvm.return %5 : i32
  }
  llvm.func @same_source_matching_signbits_extra_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.sext %4 : i8 to i32
    llvm.return %5 : i32
  }
  llvm.func @same_source_not_matching_signbits_extra_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.shl %1, %2 overflow<nsw>  : i32
    %4 = llvm.trunc %3 : i32 to i8
    llvm.call @use8(%4) : (i8) -> ()
    %5 = llvm.sext %4 : i8 to i32
    llvm.return %5 : i32
  }
}
