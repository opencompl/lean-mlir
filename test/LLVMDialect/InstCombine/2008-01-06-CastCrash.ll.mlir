module  {
  llvm.func @f() -> vector<2xi32> {
    %0 = llvm.mlir.undef : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }
  llvm.func @g() -> i32 {
    %0 = llvm.mlir.addressof @f : !llvm.ptr<func<vector<2xi32> ()>>
    %1 = llvm.bitcast %0 : !llvm.ptr<func<vector<2xi32> ()>> to !llvm.ptr<func<i32 ()>>
    %2 = llvm.call %1() : () -> i32
    llvm.return %2 : i32
  }
}
