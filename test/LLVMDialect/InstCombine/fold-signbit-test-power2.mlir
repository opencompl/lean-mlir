module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i8)
  llvm.func @use_i1(i1)
  llvm.func @use_i1_vec(vector<2xi1>)
  llvm.func @pow2_or_zero_is_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.and %arg0, %2  : i8
    %4 = llvm.icmp "slt" %3, %0 : i8
    %5 = llvm.icmp "ugt" %3, %1 : i8
    llvm.call @use_i1(%5) : (i1) -> ()
    llvm.return %4 : i1
  }
  llvm.func @pow2_or_zero_is_negative_commute(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mul %0, %arg0  : i8
    %3 = llvm.sub %1, %2  : i8
    %4 = llvm.and %3, %2  : i8
    %5 = llvm.icmp "slt" %4, %1 : i8
    llvm.return %5 : i1
  }
  llvm.func @pow2_or_zero_is_negative_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.sub %1, %arg0  : vector<2xi8>
    %4 = llvm.and %arg0, %3  : vector<2xi8>
    %5 = llvm.icmp "slt" %4, %1 : vector<2xi8>
    %6 = llvm.icmp "ugt" %4, %2 : vector<2xi8>
    llvm.call @use_i1_vec(%6) : (vector<2xi1>) -> ()
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @pow2_or_zero_is_negative_vec_commute(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mul %0, %arg0  : vector<2xi8>
    %4 = llvm.sub %2, %3  : vector<2xi8>
    %5 = llvm.and %4, %3  : vector<2xi8>
    %6 = llvm.icmp "slt" %5, %2 : vector<2xi8>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @pow2_or_zero_is_not_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = llvm.sub %0, %arg0  : i8
    %4 = llvm.and %arg0, %3  : i8
    %5 = llvm.icmp "sgt" %4, %1 : i8
    %6 = llvm.icmp "ult" %4, %2 : i8
    llvm.call @use_i1(%6) : (i1) -> ()
    llvm.return %5 : i1
  }
  llvm.func @pow2_or_zero_is_not_negative_commute(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.mul %0, %arg0  : i8
    %4 = llvm.sub %1, %3  : i8
    %5 = llvm.and %4, %3  : i8
    %6 = llvm.icmp "sgt" %5, %2 : i8
    llvm.return %6 : i1
  }
  llvm.func @pow2_or_zero_is_not_negative_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.sub %1, %arg0  : vector<2xi8>
    %5 = llvm.and %arg0, %4  : vector<2xi8>
    %6 = llvm.icmp "sgt" %5, %2 : vector<2xi8>
    %7 = llvm.icmp "ult" %5, %3 : vector<2xi8>
    llvm.call @use_i1_vec(%7) : (vector<2xi1>) -> ()
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @pow2_or_zero_is_not_negative_vec_commute(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %4 = llvm.mul %0, %arg0  : vector<2xi8>
    %5 = llvm.sub %2, %4  : vector<2xi8>
    %6 = llvm.and %5, %4  : vector<2xi8>
    %7 = llvm.icmp "sgt" %6, %3 : vector<2xi8>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @pow2_or_zero_is_negative_extra_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sub %0, %arg0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.and %arg0, %1  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "slt" %2, %0 : i8
    llvm.return %3 : i1
  }
}
