package global.sesoc.www.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.www.dto.T_Group;

public interface T_GroupMapper {
   public int insertGroup(T_Group group);
   public List<T_Group>selectAllGroup();
   public T_Group selectOneGroup(T_Group group);
   public List<T_Group> selectMyGroupList(T_Group group);
   public int plusUserCount(T_Group group);
   public int miusUserCount(T_Group group);
   public List<Integer> checkApplyGroup(Map<String, String> map);
   public int deleteGroup(int groNum);
}