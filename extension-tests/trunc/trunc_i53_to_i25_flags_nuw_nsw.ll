
define i25 @main(i53 %0) {
  %2 = trunc nuw nsw i53 %0 to i25
  ret i25 %2
}
