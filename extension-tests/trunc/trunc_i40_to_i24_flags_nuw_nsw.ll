
define i24 @main(i40 %0) {
  %2 = trunc nuw nsw i40 %0 to i24
  ret i24 %2
}
