module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @uaddo_commute1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "ugt" %arg0, %1 : i32
    %4 = llvm.select %3, %arg2, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @uaddo_commute2(%arg0: vector<2xi32>, %arg1: vector<2xi32>, %arg2: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg1, %0  : vector<2xi32>
    %2 = llvm.add %arg1, %arg0  : vector<2xi32>
    %3 = llvm.icmp "ugt" %arg0, %1 : vector<2xi32>
    %4 = llvm.select %3, %arg2, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @uaddo_commute3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "ult" %1, %arg0 : i32
    %4 = llvm.select %3, %arg2, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @uaddo_commute4(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg1, %arg0  : i32
    %3 = llvm.icmp "ult" %1, %arg0 : i32
    %4 = llvm.select %3, %arg2, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @uaddo_commute5(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "ugt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %arg2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @uaddo_commute6(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg1, %arg0  : i32
    %3 = llvm.icmp "ugt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %arg2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @uaddo_commute7(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "ult" %1, %arg0 : i32
    %4 = llvm.select %3, %2, %arg2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @uaddo_commute8(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg1, %arg0  : i32
    %3 = llvm.icmp "ult" %1, %arg0 : i32
    %4 = llvm.select %3, %2, %arg2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @uaddo_wrong_pred1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "ult" %arg0, %1 : i32
    %4 = llvm.select %3, %arg2, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @uaddo_wrong_pred2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg1, %0  : i32
    %2 = llvm.add %arg0, %arg1  : i32
    %3 = llvm.icmp "uge" %arg0, %1 : i32
    %4 = llvm.select %3, %arg2, %2 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @uaddo_1(%arg0: i8, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    llvm.store %1, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @uaddo_neg1(%arg0: i8, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    llvm.store %1, %arg1 {alignment = 1 : i64} : i8, !llvm.ptr
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
}
