module  {
  llvm.func @ctpop_bitreverse(%arg0: i32) -> i32 {
    %0 = llvm.call @llvm.bitreverse.i32(%arg0) : (i32) -> i32
    %1 = llvm.call @llvm.ctpop.i32(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @ctpop_bitreverse_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.call @llvm.bitreverse.v2i64(%arg0) : (vector<2xi64>) -> vector<2xi64>
    %1 = llvm.call @llvm.ctpop.v2i64(%0) : (vector<2xi64>) -> vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }
  llvm.func @ctpop_bswap(%arg0: i32) -> i32 {
    %0 = llvm.call @llvm.bswap.i32(%arg0) : (i32) -> i32
    %1 = llvm.call @llvm.ctpop.i32(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @ctpop_bswap_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.call @llvm.bswap.v2i64(%arg0) : (vector<2xi64>) -> vector<2xi64>
    %1 = llvm.call @llvm.ctpop.v2i64(%0) : (vector<2xi64>) -> vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }
  llvm.func @llvm.bitreverse.i32(i32) -> i32
  llvm.func @llvm.bitreverse.v2i64(vector<2xi64>) -> vector<2xi64>
  llvm.func @llvm.bswap.i32(i32) -> i32
  llvm.func @llvm.bswap.v2i64(vector<2xi64>) -> vector<2xi64>
  llvm.func @llvm.ctpop.i32(i32) -> i32
  llvm.func @llvm.ctpop.v2i64(vector<2xi64>) -> vector<2xi64>
}
