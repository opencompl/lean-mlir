module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @smax1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @smin1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @smax2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sge" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @smin2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sle" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @smax3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @smax3_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %arg0, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @smin3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @smin3_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %arg0, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }
  llvm.func @umax3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @umax3_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<5> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @umin3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.icmp "ult" %arg0, %0 : i32
    %3 = llvm.select %2, %arg0, %1 : i1, i32
    llvm.return %3 : i32
  }
  llvm.func @umin3_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @smax4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sge" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @smax4_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sge" %arg0, %1 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @smin4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sle" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @smin4_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "sle" %arg0, %1 : vector<2xi32>
    %3 = llvm.select %2, %arg0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @umax4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.icmp "uge" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @umax4_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "uge" %arg0, %0 : vector<2xi32>
    %2 = llvm.select %1, %arg0, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @umin4(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.icmp "ule" %arg0, %0 : i32
    %2 = llvm.select %1, %arg0, %0 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @umin4_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<9> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "ule" %arg0, %0 : vector<2xi32>
    %2 = llvm.select %1, %arg0, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @smax_sext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i64
    llvm.return %4 : i64
  }
  llvm.func @smax_sext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %4 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %5 = llvm.select %4, %3, %2 : vector<2xi1>, vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }
  llvm.func @smin_sext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i64
    llvm.return %4 : i64
  }
  llvm.func @smin_sext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %3 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %4 = llvm.icmp "slt" %arg0, %0 : vector<2xi32>
    %5 = llvm.select %4, %3, %2 : vector<2xi1>, vector<2xi64>
    llvm.return %5 : vector<2xi64>
  }
  llvm.func @umax_sext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i64
    llvm.return %4 : i64
  }
  llvm.func @umax_sext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @umin_sext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i64
    llvm.return %4 : i64
  }
  llvm.func @umin_sext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @umax_sext2(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i64
    llvm.return %4 : i64
  }
  llvm.func @umax_sext2_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %1, %2 : vector<2xi1>, vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @umin_sext2(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.sext %arg0 : i32 to i64
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.select %3, %1, %2 : i1, i64
    llvm.return %4 : i64
  }
  llvm.func @umin_sext2_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %1, %2 : vector<2xi1>, vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @umax_zext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.icmp "ugt" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i64
    llvm.return %4 : i64
  }
  llvm.func @umax_zext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.icmp "ugt" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @umin_zext(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.zext %arg0 : i32 to i64
    %3 = llvm.icmp "ult" %arg0, %0 : i32
    %4 = llvm.select %3, %2, %1 : i1, i64
    llvm.return %4 : i64
  }
  llvm.func @umin_zext_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %3 = llvm.icmp "ult" %arg0, %0 : vector<2xi32>
    %4 = llvm.select %3, %2, %1 : vector<2xi1>, vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @scalar_select_of_vectors(%arg0: vector<2xi16>, %arg1: vector<2xi16>, %arg2: i8) -> vector<2xi16> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg2, %0 : i8
    %2 = llvm.select %1, %arg0, %arg1 : i1, vector<2xi16>
    llvm.return %2 : vector<2xi16>
  }
}
