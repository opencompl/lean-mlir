module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i8)
  llvm.func @rol_eq(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @rol_ne(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ne" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @ror_eq(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshr(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @ror_ne(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshr(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ne" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @rol_eq_use(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @rol_eq_uses(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    llvm.call @use(%0) : (i8) -> ()
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @rol_eq_vec(%arg0: vector<2xi5>, %arg1: vector<2xi5>, %arg2: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg2)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg2)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %2 = llvm.icmp "eq" %0, %1 : vector<2xi5>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @ror_eq_vec(%arg0: vector<2xi5>, %arg1: vector<2xi5>, %arg2: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.intr.fshr(%arg0, %arg0, %arg2)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %1 = llvm.intr.fshr(%arg1, %arg1, %arg2)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %2 = llvm.icmp "eq" %0, %1 : vector<2xi5>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @rol_eq_cst(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @rol_ne_cst(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @rol_eq_cst_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.intr.fshl(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ror_eq_cst(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @ror_ne_cst(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @rol_eq_cst_vec(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(3 : i5) : i5
    %1 = llvm.mlir.constant(dense<3> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.constant(2 : i5) : i5
    %3 = llvm.mlir.constant(dense<2> : vector<2xi5>) : vector<2xi5>
    %4 = llvm.intr.fshl(%arg0, %arg0, %1)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %5 = llvm.icmp "eq" %4, %3 : vector<2xi5>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @rol_eq_cst_undef(%arg0: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(3 : i5) : i5
    %1 = llvm.mlir.constant(dense<3> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.mlir.undef : i5
    %3 = llvm.mlir.constant(2 : i5) : i5
    %4 = llvm.mlir.undef : vector<2xi5>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi5>
    %9 = llvm.intr.fshl(%arg0, %arg0, %1)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %10 = llvm.icmp "eq" %9, %8 : vector<2xi5>
    llvm.return %10 : vector<2xi1>
  }
  llvm.func @no_rotate(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @wrong_pred(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ult" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @amounts_mismatch(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8) -> i1 {
    %0 = llvm.intr.fshl(%arg0, %arg0, %arg2)  : (i8, i8, i8) -> i8
    %1 = llvm.intr.fshl(%arg1, %arg1, %arg3)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @wrong_pred2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(27 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.intr.fshr(%arg0, %arg0, %0)  : (i8, i8, i8) -> i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
}
