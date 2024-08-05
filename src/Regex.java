package utils;

import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class Regex {
    // ID Regex
    public static final String ID_REGEX = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,20}$";

    // Password Regex
    public static final String PW_REGEX = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,20}$";

    // Contact Regex
    public static final String CONTACT_REGEX = "^(0[2-9]\\d{1,2}|010)-(\\d{3,4})-(\\d{4})$";

    // Name Regex
    public static final String NAME_REGEX = "^[가-힣]{2,6}$";

    // Schedule Regex
    public static final String SCHEDULE_REGEX = "^.{4,50}$";

    // Time Regex
    public static final String TIME_REGEX = "^(?:[01]\\d|2[0-3]):[0-5]\\d$";

    // Method to validate input using regex
    public static boolean isValidInput(String input, String regex) {
        if (Utils.isNullOrEmpty(input)) {
            return false;
        }
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(input);
        return matcher.matches();
    }
}
