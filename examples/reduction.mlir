module {
  func @f1d(%arg0: memref<?xindex>) -> memref<?xindex> {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %0 = memref.dim %arg0, %c0 : memref<?xindex>
    %1 = memref.alloc(%0) : memref<?xindex>
    scf.for %arg1 = %c0 to %0 step %c1 {
      memref.store %arg1, %1[%arg1] : memref<?xindex>
    }
    return %1 : memref<?xindex>
  }
  func @f1d_known_dim(%arg0: memref<42xindex>) -> memref<42xindex> {
    %c42 = arith.constant 42 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %0 = memref.alloc() : memref<42xindex>
    scf.for %arg1 = %c0 to %c42 step %c1 {
      memref.store %arg1, %0[%arg1] : memref<42xindex>
    }
    return %0 : memref<42xindex>
  }
  func @eg3(%arg0: memref<42xf32>, %arg1: memref<42x420xf32>) -> memref<42xf32> {
    %c42 = arith.constant 42 : index
    %c420 = arith.constant 420 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %0 = memref.alloc() : memref<42xf32>
    memref.copy %arg0, %0 : memref<42xf32> to memref<42xf32>
    scf.for %arg2 = %c0 to %c42 step %c1 {
      scf.for %arg3 = %c0 to %c420 step %c1 {
        %1 = memref.load %arg1[%arg2, %arg3] : memref<42x420xf32>
        %2 = memref.load %0[%arg2] : memref<42xf32>
        %3 = arith.addf %1, %2 : f32
        memref.store %3, %0[%arg2] : memref<42xf32>
      }
    }
    return %0 : memref<42xf32>
  }
}

