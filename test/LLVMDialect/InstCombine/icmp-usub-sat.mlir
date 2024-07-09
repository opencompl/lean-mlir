module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @icmp_eq_basic_positive(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_ne_basic_positive(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(8 : i16) : i16
    %1 = llvm.mlir.constant(9 : i16) : i16
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.icmp "ne" %2, %1 : i16
    llvm.return %3 : i1
  }
  llvm.func @icmp_ule_basic_positive(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "ule" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @icmp_ult_basic_positive(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(5 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i64, i64) -> i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @icmp_uge_basic_positive(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %2 = llvm.icmp "uge" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @icmp_ugt_basic_positive(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(3 : i16) : i16
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.icmp "ugt" %2, %1 : i16
    llvm.return %3 : i1
  }
  llvm.func @icmp_sle_basic_positive(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "sle" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @icmp_slt_basic_positive(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(24 : i64) : i64
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i64, i64) -> i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @icmp_sge_basic_positive(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_sgt_basic_positive(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.mlir.constant(5 : i16) : i16
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.icmp "sgt" %2, %1 : i16
    llvm.return %3 : i1
  }
  llvm.func @icmp_eq_basic_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-20 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_ne_basic_negative(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-80 : i16) : i16
    %1 = llvm.mlir.constant(9 : i16) : i16
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.icmp "ne" %2, %1 : i16
    llvm.return %3 : i1
  }
  llvm.func @icmp_ule_basic_negative(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-6 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "ule" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @icmp_ult_basic_negative(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-10 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i64, i64) -> i64
    %3 = llvm.icmp "ult" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @icmp_uge_basic_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-4 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "uge" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_ugt_basic_negative(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-10 : i16) : i16
    %1 = llvm.mlir.constant(3 : i16) : i16
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.icmp "ugt" %2, %1 : i16
    llvm.return %3 : i1
  }
  llvm.func @icmp_sle_basic_negative(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-10 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "sle" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @icmp_slt_basic_negative(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-24 : i64) : i64
    %1 = llvm.mlir.constant(5 : i64) : i64
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i64, i64) -> i64
    %3 = llvm.icmp "slt" %2, %1 : i64
    llvm.return %3 : i1
  }
  llvm.func @icmp_sge_basic_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-10 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_sgt_basic_negative(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(-20 : i16) : i16
    %1 = llvm.mlir.constant(5 : i16) : i16
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i16, i16) -> i16
    %3 = llvm.icmp "sgt" %2, %1 : i16
    llvm.return %3 : i1
  }
  llvm.func @icmp_eq_multiuse_positive(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.return %3 : i1
  }
  llvm.func @icmp_eq_multiuse_negative(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    llvm.return %3 : i1
  }
  llvm.func @icmp_eq_vector_positive_equal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_eq_vector_positive_unequal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_ne_vector_positive_equal(%arg0: vector<2xi16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi16>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_ne_vector_positive_unequal(%arg0: vector<2xi16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, 33]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.mlir.constant(dense<[7, 6]> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi16>, vector<2xi16>) -> vector<2xi16>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi16>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_ule_vector_positive_equal(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_ule_vector_positive_unequal(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[3, 35]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[5, 7]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_sgt_vector_positive_equal(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<409623> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1234> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_sgt_vector_positive_unequal(%arg0: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[320498, 409623]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<[1234, 3456]> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi64>, vector<2xi64>) -> vector<2xi64>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi64>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_eq_vector_negative_equal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-5> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_eq_vector_negative_unequal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-10, -20]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[5, 6]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_eq_vector_multiuse_positive_equal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.call @use.v2i8(%2) : (vector<2xi8>) -> ()
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_eq_vector_multiuse_negative_equal(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-20> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.usub.sat(%arg0, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi8>
    llvm.call @use.v2i8(%2) : (vector<2xi8>) -> ()
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @use.i8(i8)
  llvm.func @use.v2i8(vector<2xi8>)
}
