package global.sesoc.www.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.www.dto.T_Group;

@Repository
public class T_GroupRepository {
   @Autowired
   SqlSession session;
   
   public int insertGroup(T_Group group) {
      T_GroupMapper mapper=session.getMapper(T_GroupMapper.class);
      int result=mapper.insertGroup(group);
      return result;
   }
   
   public List<T_Group> selectAllGroup(){
      T_GroupMapper mapper=session.getMapper(T_GroupMapper.class);
      List<T_Group>list=mapper.selectAllGroup();
      return list;
   }
   public T_Group selectOneGroup(T_Group group) {
      T_GroupMapper mapper=session.getMapper(T_GroupMapper.class);
      T_Group g=mapper.selectOneGroup(group);
      return g;
   }
   public List<T_Group> selectMyGroupList(T_Group group){
      T_GroupMapper mapper=session.getMapper(T_GroupMapper.class);
      List<T_Group> list=mapper.selectMyGroupList(group);
      return list;
   }
   public int plusUserCount(T_Group group) {
      T_GroupMapper mapper=session.getMapper(T_GroupMapper.class);
      int result=mapper.plusUserCount(group);
      return result;
   }
   public int miusUserCount(T_Group group) {
      T_GroupMapper mapper=session.getMapper(T_GroupMapper.class);
      int result=mapper.miusUserCount(group);
      return result;
   }
   public List<Integer>checkApplyGroup(String loginId){
      T_GroupMapper mapper=session.getMapper(T_GroupMapper.class);
      Map<String, String> map=new HashMap<String,String>();
      map.put("loginId", loginId);
      List<Integer> list=mapper.checkApplyGroup(map);
      return list;
   }
   public int deleteGroup(int groNum) {
      T_GroupMapper mapper=session.getMapper(T_GroupMapper.class);
      int result=mapper.deleteGroup(groNum);
      return result;
   }
   
}