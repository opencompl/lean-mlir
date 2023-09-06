module  {
  llvm.func @zext_add(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(44 : i16) : i16
    %1 = llvm.zext %arg0 : i8 to i16
    %2 = llvm.add %1, %0  : i16
    %3 = llvm.and %2, %1  : i16
    llvm.return %3 : i16
  }
  llvm.func @zext_sub(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(-5 : i16) : i16
    %1 = llvm.zext %arg0 : i8 to i16
    %2 = llvm.sub %0, %1  : i16
    %3 = llvm.and %2, %1  : i16
    llvm.return %3 : i16
  }
  llvm.func @zext_mul(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.zext %arg0 : i8 to i16
    %2 = llvm.mul %1, %0  : i16
    %3 = llvm.and %2, %1  : i16
    llvm.return %3 : i16
  }
  llvm.func @zext_lshr(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.zext %arg0 : i8 to i16
    %2 = llvm.lshr %1, %0  : i16
    %3 = llvm.and %2, %1  : i16
    llvm.return %3 : i16
  }
  llvm.func @zext_ashr(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(2 : i16) : i16
    %1 = llvm.zext %arg0 : i8 to i16
    %2 = llvm.ashr %1, %0  : i16
    %3 = llvm.and %2, %1  : i16
    llvm.return %3 : i16
  }
  llvm.func @zext_shl(%arg0: i8) -> i16 {
    %0 = llvm.mlir.constant(3 : i16) : i16
    %1 = llvm.zext %arg0 : i8 to i16
    %2 = llvm.shl %1, %0  : i16
    %3 = llvm.and %2, %1  : i16
    llvm.return %3 : i16
  }
  llvm.func @zext_add_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[44, 42]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.add %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @zext_sub_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[-5, -4]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.sub %0, %1  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @zext_mul_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[3, -2]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.mul %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @zext_lshr_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[4, 2]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.lshr %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @zext_ashr_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[2, 3]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.ashr %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @zext_shl_vec(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[3, 2]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.shl %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @zext_lshr_vec_overshift(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[4, 8]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.lshr %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @zext_lshr_vec_undef(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.undef : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.lshr %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @zext_shl_vec_overshift(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.constant(dense<[8, 2]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.shl %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
  llvm.func @zext_shl_vec_undef(%arg0: vector<2xi8>) -> vector<2xi16> {
    %0 = llvm.mlir.undef : vector<2xi16>
    %1 = llvm.zext %arg0 : vector<2xi8> to vector<2xi16>
    %2 = llvm.shl %1, %0  : vector<2xi16>
    %3 = llvm.and %2, %1  : vector<2xi16>
    llvm.return %3 : vector<2xi16>
  }
}
