package global.sesoc.www.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.www.dto.T_Request;

public interface T_RequestMapper {
	public int calendarShare(T_Request request);
	
	public List<T_Request> checkShare(T_Request requester);
	
	public List<T_Request> isCalendarShare(String userId);
	
	public int calendarAccept(T_Request request);
	
	public int delShareCal(T_Request request);
	
	public List<T_Request>shareCal(Map<String, String> map);
}
