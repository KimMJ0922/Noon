package format;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

public class DateFormat {
	public String dateFormat(Timestamp writeday) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm",Locale.KOREA);
		
		Calendar c = Calendar.getInstance();
		long now = c.getTimeInMillis();
		
		String day = sdf.format(writeday);
		
		long dateM = writeday.getTime();
		long gap = now - dateM;

        String ret = "";
        gap = (long)(gap/1000);
        long hour = gap/3600;
        gap = gap%3600;
        long min = gap/60;
        long sec = gap%60;

        if(hour > 24){
            ret = day;
        }
        else if(hour > 0){
            ret = hour+"시간 전";
        }
        else if(min > 0){
            ret = min+"분 전";
        }
        else if(sec >= 0){
            ret = sec+"초 전";
        }
        else{
            ret = day;
        }
        
        
		return ret;
	}
}
