package utils;

import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;


public class Utils {
    // Null 또는 빈 문자열 체크 메서드
    public static boolean isNullOrEmpty(String str) {
        return str == null || str.isEmpty() || str.trim().isEmpty();
    }

    // 숫자 필터링 메서드
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

    // 현재 시간 가져오기 메서드
    public static String getCurrentTime() {
        LocalDateTime now = LocalDateTime.now(ZoneId.of("Asia/Seoul")); 
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
        return now.format(formatter);
    }
}
