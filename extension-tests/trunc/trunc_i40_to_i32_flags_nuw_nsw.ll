
define i32 @main(i40 %0) {
  %2 = trunc nuw nsw i40 %0 to i32
  ret i32 %2
}
