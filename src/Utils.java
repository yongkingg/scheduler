package utils;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class Utils {
    public static String filterNumbers(String input) {
        if (input == null) {
            return "";
        }
        StringBuilder numbers = new StringBuilder();
        Pattern pattern = Pattern.compile("\\d+");
        Matcher matcher = pattern.matcher(input);
        while (matcher.find()) {
            numbers.append(matcher.group());
        }
        return numbers.toString();
    }
}
