module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i8)
  llvm.func @rotl_eq_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @rotl_ne_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @rotl_eq_n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @rotl_ne_n1(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(-1 : i5) : i5
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi5>) : vector<2xi5>
    %2 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi5>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @rotl_ne_n1_poison(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i5
    %1 = llvm.mlir.constant(-1 : i5) : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %8 = llvm.icmp "ne" %7, %6 : vector<2xi5>
    llvm.return %8 : vector<2xi1>
  }
  llvm.func @rotl_eq_0_poison(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i5
    %1 = llvm.mlir.constant(0 : i5) : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %8 = llvm.icmp "eq" %7, %6 : vector<2xi5>
    llvm.return %8 : vector<2xi1>
  }
  llvm.func @rotl_eq_1_poison(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(1 : i5) : i5
    %1 = llvm.mlir.poison : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %8 = llvm.icmp "eq" %7, %6 : vector<2xi5>
    llvm.return %8 : vector<2xi1>
  }
  llvm.func @rotl_sgt_0_poison(%arg0: vector<2xi5>, %arg1: vector<2xi5>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i5
    %1 = llvm.mlir.constant(0 : i5) : i5
    %2 = llvm.mlir.undef : vector<2xi5>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi5>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi5>
    %7 = llvm.intr.fshl(%arg0, %arg0, %arg1)  : (vector<2xi5>, vector<2xi5>, vector<2xi5>) -> vector<2xi5>
    %8 = llvm.icmp "sgt" %7, %6 : vector<2xi5>
    llvm.return %8 : vector<2xi1>
  }
  llvm.func @rotr_eq_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @rotr_ne_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @rotr_eq_n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @rotr_ne_n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @rotr_ne_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @rotr_sgt_n1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg0, %arg1)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "sgt" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @fshr_sgt_n1(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.fshr(%arg0, %arg1, %arg2)  : (i8, i8, i8) -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
}
