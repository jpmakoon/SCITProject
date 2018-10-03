package global.sesoc.www.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import global.sesoc.www.dto.T_Schedule;

public interface T_ScheduleMapper {
   public List<T_Schedule> selectCategory(HashMap<String, String> map);
   public List<T_Schedule> select(Map<String, Object> map);
   public String selectCount(HashMap<String, String> map);
   public String selectCountUnChecked(HashMap<String, String> map);
   public int insertSchedule(T_Schedule schedule);
   public List<T_Schedule> selectUserSchedule(String userId);
   public T_Schedule selectOneUserSchedule(T_Schedule schedule);
   public List<T_Schedule>  selectPlannerSchedule(int plaNum);
   public int updateSchedule(T_Schedule schedule);
   public int deletePlanner_Schedule(int plaNum);
   public int deleteSchedule(int schNum);
   public List<T_Schedule> selectUserAllSchedule(String userId);
   public List<T_Schedule> selectUserPlannerSchedule(Map<String, Object> map);
   public List<T_Schedule> selectMixSchedule(Map<String,String> map);
   public List<T_Schedule>selectGroupSchedule(int groNum);
   public List<T_Schedule> selectCategoryP(String userId);
   public int delete(int schNum);
   public List<T_Schedule> selectCategoryMoon(String userId);
    public int updateCheck(T_Schedule checked);
    public int updateSchedule1(T_Schedule schedule);
    public int insertShareSchedule(T_Schedule schedule);
}