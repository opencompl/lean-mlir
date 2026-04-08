
define i12 @main(i53 %0) {
  %2 = trunc nuw nsw i53 %0 to i12
  ret i12 %2
}
