
def p_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg2 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %2, %arg1 : i32
  %4 = llvm.xor %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg2 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %2, %arg1 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_proof : p_before ⊑ p_after := by
  sorry



def p_splatvec_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.and %arg0, %arg2 : vector<2xi32>
  %2 = llvm.xor %arg2, %0 : vector<2xi32>
  %3 = llvm.and %2, %arg1 : vector<2xi32>
  %4 = llvm.xor %1, %3 : vector<2xi32>
  "llvm.return"(%4) : (vector<2xi32>) -> ()
}
]
def p_splatvec_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>, %arg2 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<-1> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = llvm.and %arg0, %arg2 : vector<2xi32>
  %2 = llvm.xor %arg2, %0 : vector<2xi32>
  %3 = llvm.and %2, %arg1 : vector<2xi32>
  %4 = llvm.or %1, %3 : vector<2xi32>
  "llvm.return"(%4) : (vector<2xi32>) -> ()
}
]
theorem p_splatvec_proof : p_splatvec_before ⊑ p_splatvec_after := by
  sorry



def p_constmask_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 65280 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_constmask_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 65280 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.or %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_constmask_proof : p_constmask_before ⊑ p_constmask_after := by
  sorry



def p_constmask_splatvec_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<65280> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-65281> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.and %arg0, %0 : vector<2xi32>
  %3 = llvm.and %arg1, %1 : vector<2xi32>
  %4 = llvm.xor %2, %3 : vector<2xi32>
  "llvm.return"(%4) : (vector<2xi32>) -> ()
}
]
def p_constmask_splatvec_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<65280> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-65281> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.and %arg0, %0 : vector<2xi32>
  %3 = llvm.and %arg1, %1 : vector<2xi32>
  %4 = llvm.or %2, %3 : vector<2xi32>
  "llvm.return"(%4) : (vector<2xi32>) -> ()
}
]
theorem p_constmask_splatvec_proof : p_constmask_splatvec_before ⊑ p_constmask_splatvec_after := by
  sorry



def p_constmask2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 61440 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.xor %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_constmask2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 61440 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.or %2, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_constmask2_proof : p_constmask2_before ⊑ p_constmask2_after := by
  sorry



def p_constmask2_splatvec_before := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<61440> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-65281> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.and %arg0, %0 : vector<2xi32>
  %3 = llvm.and %arg1, %1 : vector<2xi32>
  %4 = llvm.xor %2, %3 : vector<2xi32>
  "llvm.return"(%4) : (vector<2xi32>) -> ()
}
]
def p_constmask2_splatvec_after := [llvm|
{
^0(%arg0 : vector<2xi32>, %arg1 : vector<2xi32>):
  %0 = "llvm.mlir.constant"() <{"value" = dense<61440> : vector<2xi32>}> : () -> vector<2xi32>
  %1 = "llvm.mlir.constant"() <{"value" = dense<-65281> : vector<2xi32>}> : () -> vector<2xi32>
  %2 = llvm.and %arg0, %0 : vector<2xi32>
  %3 = llvm.and %arg1, %1 : vector<2xi32>
  %4 = llvm.or %2, %3 : vector<2xi32>
  "llvm.return"(%4) : (vector<2xi32>) -> ()
}
]
theorem p_constmask2_splatvec_proof : p_constmask2_splatvec_before ⊑ p_constmask2_splatvec_after := by
  sorry



def p_commutative0_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg0 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %2, %arg1 : i32
  %4 = llvm.xor %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_commutative0_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg0 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %2, %arg1 : i32
  %4 = llvm.or %1, %3 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_commutative0_proof : p_commutative0_before ⊑ p_commutative0_after := by
  sorry



def p_commutative2_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg2 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %2, %arg1 : i32
  %4 = llvm.xor %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_commutative2_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg0, %arg2 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %2, %arg1 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_commutative2_proof : p_commutative2_before ⊑ p_commutative2_after := by
  sorry



def p_commutative4_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg0 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %2, %arg1 : i32
  %4 = llvm.xor %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_commutative4_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32, %arg2 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = -1 : i32}> : () -> i32
  %1 = llvm.and %arg2, %arg0 : i32
  %2 = llvm.xor %arg2, %0 : i32
  %3 = llvm.and %2, %arg1 : i32
  %4 = llvm.or %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_commutative4_proof : p_commutative4_before ⊑ p_commutative4_after := by
  sorry



def p_constmask_commutative_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 65280 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.xor %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def p_constmask_commutative_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 65280 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{"value" = -65281 : i32}> : () -> i32
  %2 = llvm.and %arg0, %0 : i32
  %3 = llvm.and %arg1, %1 : i32
  %4 = llvm.or %3, %2 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
theorem p_constmask_commutative_proof : p_constmask_commutative_before ⊑ p_constmask_commutative_after := by
  sorry



def n3_constmask_samemask_before := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 65280 : i32}> : () -> i32
  %1 = llvm.and %arg0, %0 : i32
  %2 = llvm.and %arg1, %0 : i32
  %3 = llvm.xor %1, %2 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def n3_constmask_samemask_after := [llvm|
{
^0(%arg0 : i32, %arg1 : i32):
  %0 = "llvm.mlir.constant"() <{"value" = 65280 : i32}> : () -> i32
  %1 = llvm.xor %arg0, %arg1 : i32
  %2 = llvm.and %1, %0 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem n3_constmask_samemask_proof : n3_constmask_samemask_before ⊑ n3_constmask_samemask_after := by
  sorry


