module  {
  llvm.func @reduction_logical_or(%arg0: vector<4xi1>) -> i1 {
    %0 = llvm.call @llvm.vector.reduce.or.v4i1(%arg0) : (vector<4xi1>) -> i1
    llvm.return %0 : i1
  }
  llvm.func @reduction_logical_and(%arg0: vector<4xi1>) -> i1 {
    %0 = llvm.call @llvm.vector.reduce.and.v4i1(%arg0) : (vector<4xi1>) -> i1
    llvm.return %0 : i1
  }
  llvm.func @llvm.vector.reduce.or.v4i1(vector<4xi1>) -> i1
  llvm.func @llvm.vector.reduce.and.v4i1(vector<4xi1>) -> i1
}
