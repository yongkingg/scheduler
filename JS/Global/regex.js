export const idRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,20}$/;
export const pwRegex =
  /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$/;
export const contactRegex = /^(0[2-9]\d{1,2})-(\d{3,4})-(\d{4})$/;
export const nameRegex =
  /^(?=.*[가-힣]{2,})(?=.*[A-Za-z]{5,})[A-Za-z가-힣]{7,20}$/;
