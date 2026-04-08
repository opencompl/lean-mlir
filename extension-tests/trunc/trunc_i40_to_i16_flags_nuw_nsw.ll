
define i16 @main(i40 %0) {
  %2 = trunc nuw nsw i40 %0 to i16
  ret i16 %2
}
