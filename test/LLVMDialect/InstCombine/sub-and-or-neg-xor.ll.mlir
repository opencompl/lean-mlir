module  {
  llvm.func @use(i32)
  llvm.func @sub_to_xor(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.sub %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @sub_to_xor_extra_use_sub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.sub %1, %0  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %2 : i32
  }
  llvm.func @sub_to_xor_extra_use_and(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.sub %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @sub_to_xor_extra_use_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.sub %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @sub_to_xor_or_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg1, %arg0  : i32
    %1 = llvm.and %arg0, %arg1  : i32
    %2 = llvm.sub %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @sub_to_xor_and_commuted(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    %1 = llvm.and %arg1, %arg0  : i32
    %2 = llvm.sub %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @sub_to_xor_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.or %arg0, %arg1  : vector<2xi32>
    %1 = llvm.and %arg1, %arg0  : vector<2xi32>
    %2 = llvm.sub %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @sub_to_xor_extra_use_and_or(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.or %arg0, %arg1  : i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = llvm.and %arg0, %arg1  : i32
    llvm.call @use(%1) : (i32) -> ()
    %2 = llvm.sub %1, %0  : i32
    llvm.return %2 : i32
  }
}
