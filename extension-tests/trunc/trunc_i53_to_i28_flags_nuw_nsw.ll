
define i28 @main(i53 %0) {
  %2 = trunc nuw nsw i53 %0 to i28
  ret i28 %2
}
