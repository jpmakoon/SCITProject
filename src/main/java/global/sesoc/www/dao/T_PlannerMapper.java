package global.sesoc.www.dao;

import java.util.List;

import global.sesoc.www.dto.T_Planner;

public interface T_PlannerMapper {
   public int insertPlanner(T_Planner planner);
   public List<T_Planner> plannerList(String userId);
   public T_Planner selectOneplanner();
   public int deletePlanner(int plaNum);
   public int maxPlanum();
}