package global.sesoc.www.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.www.dto.T_Schedule;

@Repository
public class T_ScheduleRepository {
   @Autowired
   SqlSession session;

   public List<T_Schedule> selectCategory(HashMap<String, String> map) {
      T_ScheduleMapper mapper = session.getMapper(T_ScheduleMapper.class);
      List<T_Schedule> t = mapper.selectCategory(map);
      return t;
   }
   
   public List<T_Schedule> select(String userId, String checked) {
      T_ScheduleMapper mapper = session.getMapper(T_ScheduleMapper.class);
      Map<String, Object> map = new HashMap<>();
      map.put("userId", userId);
      map.put("checked", checked);
      List<T_Schedule> ts = mapper.select(map);
      return ts;
   }
   
   public String selectCount(HashMap<String, String> map) {
      T_ScheduleMapper mapper = session.getMapper(T_ScheduleMapper.class);
      String t_count = mapper.selectCount(map);
      return t_count;
   }
   
   public String selectCountUnChecked(HashMap<String, String> map) {
      T_ScheduleMapper mapper = session.getMapper(T_ScheduleMapper.class);
      String t_count = mapper.selectCountUnChecked(map);
      return t_count;
   }

   public int insertSchedule(T_Schedule schedule) {
      T_ScheduleMapper mapper=session.getMapper(T_ScheduleMapper.class);
      int result=mapper.insertSchedule(schedule);
      return result;
   }
   
   public List<T_Schedule> selectUserSchedule(String userId) {
      T_ScheduleMapper mapper=session.getMapper(T_ScheduleMapper.class);
      List<T_Schedule> list=mapper.selectUserSchedule(userId);
      return list;
   }
   
   public T_Schedule selectOneUserSchedule(T_Schedule schedule) {
      T_ScheduleMapper mapper=session.getMapper(T_ScheduleMapper.class);
      T_Schedule s=mapper.selectOneUserSchedule(schedule);
      return s;
   }
   
   public List<T_Schedule> selectPlannerSchedule(int plaNum) {
      T_ScheduleMapper mapper=session.getMapper(T_ScheduleMapper.class);
      List<T_Schedule> scheduleList=mapper.selectPlannerSchedule(plaNum);
      return scheduleList;
   }
   
   public int updateSchedule(T_Schedule schedule) {
      T_ScheduleMapper mapper=session.getMapper(T_ScheduleMapper.class);
      int result=mapper.updateSchedule(schedule);
      return result;
   }
   public int updateSchedule1(T_Schedule schedule) {
      T_ScheduleMapper mapper=session.getMapper(T_ScheduleMapper.class);
      int result=mapper.updateSchedule1(schedule);
      return result;
   }
   public int deletePlanner_Schedule(int plaNum) {
      T_ScheduleMapper mapper=session.getMapper(T_ScheduleMapper.class);
      int result=mapper.deletePlanner_Schedule(plaNum);
      return result;
   }
   
   public int deleteSchedule(int schNum) {
      T_ScheduleMapper mapper=session.getMapper(T_ScheduleMapper.class);
      int result=mapper.deleteSchedule(schNum);
      return result;
   }
   
   public List<T_Schedule> selectUserAllSchedule(String userId){
      T_ScheduleMapper mapper=session.getMapper(T_ScheduleMapper.class);
      List<T_Schedule> schduleList=mapper.selectUserAllSchedule(userId);
      return schduleList;
   }
   
   public List<T_Schedule> selectUserPlannerSchedule(String userId, int plaNum){
      Map<String, Object>map=new HashMap<String,Object>();
      map.put("userId", userId);   map.put("plaNum", plaNum);
      T_ScheduleMapper mapper=session.getMapper(T_ScheduleMapper.class);
      List<T_Schedule> schduleList =mapper.selectUserPlannerSchedule(map);
      return schduleList;
   }
   
   public List<T_Schedule> selectMixSchedule(String loginId,String friendId){
      Map<String, String> map=new HashMap<String,String>();
      map.put("loginId", loginId);   map.put("friendId", friendId);
      System.out.println("mix_map"+map);
      T_ScheduleMapper mapper=session.getMapper(T_ScheduleMapper.class);
      List<T_Schedule> list=mapper.selectMixSchedule(map);
      return list;
      
   }
   
   public List<T_Schedule> selectGroupSchedule(int groNum){
      T_ScheduleMapper mapper=session.getMapper(T_ScheduleMapper.class);
      List<T_Schedule>list=mapper.selectGroupSchedule(groNum);
      return list;
   }
   
   public List<T_Schedule> selectCategoryP(String userId) {
      T_ScheduleMapper mapper = session.getMapper(T_ScheduleMapper.class);
      List<T_Schedule> replyList = mapper.selectCategoryP(userId);
      System.out.println(userId);
      System.out.println("========= Repository ============");
      
      return replyList;
   }
   
   public int delete(int schNum) {
      T_ScheduleMapper mapper = session.getMapper(T_ScheduleMapper.class);
      int result = mapper.delete(schNum);
      
      return result;
   }
    
   public List<T_Schedule> selectCategoryMoon(String userId){
      T_ScheduleMapper mapper = session.getMapper(T_ScheduleMapper.class);
      List<T_Schedule> replyList = mapper.selectCategoryMoon(userId);
      System.out.println(userId);
      
      return replyList;
   }
   
   public int updateCheck(T_Schedule checked) {
      T_ScheduleMapper mapper = session.getMapper(T_ScheduleMapper.class);
      int check = mapper.updateCheck(checked);
      
      return check;
   }
   public int insertShareSchedule(T_Schedule schedule) {
      System.out.println("repo++"+schedule);
      T_ScheduleMapper mapper=session.getMapper(T_ScheduleMapper.class);
      int result=mapper.insertShareSchedule(schedule);
      return result;
   }

}