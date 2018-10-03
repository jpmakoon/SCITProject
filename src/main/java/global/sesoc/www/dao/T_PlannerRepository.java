package global.sesoc.www.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.www.dto.T_Planner;

@Repository
public class T_PlannerRepository {
   @Autowired
   SqlSession session;
   public int insertPlanner(T_Planner planner) {
   T_PlannerMapper mapper=session.getMapper(T_PlannerMapper.class);
   int result=mapper.insertPlanner(planner);
   return result;
   }
   public List<T_Planner> plannerList(String userId){
      T_PlannerMapper mapper=session.getMapper(T_PlannerMapper.class);
      List<T_Planner> plannerList=mapper.plannerList(userId);
      return plannerList;
   }
   public T_Planner selectOneplanner() {
      T_PlannerMapper mapper=session.getMapper(T_PlannerMapper.class);
      T_Planner planner= mapper.selectOneplanner();
      return planner;
   }
   public int deletePlanner(int plaNum) {
      T_PlannerMapper mapper=session.getMapper(T_PlannerMapper.class);
      int result=mapper.deletePlanner(plaNum);
      return result;
   }
   public int maxPlanum() {
      T_PlannerMapper mapper=session.getMapper(T_PlannerMapper.class);
      int result=mapper.maxPlanum();
      return result;
   }
}