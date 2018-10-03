package global.sesoc.www.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.www.dto.T_Reply;

@Repository
public class T_ReplyRepository {
   @Autowired
   SqlSession session;
   
   public int insertReply(T_Reply reply) {
      T_ReplyMapper mapper=session.getMapper(T_ReplyMapper.class);
      int result=mapper.insertReply(reply);
      return result;
   }
   
   public T_Reply selectNewReply(int boaNum) {
      T_ReplyMapper mapper=session.getMapper(T_ReplyMapper.class);
      T_Reply r=mapper.selectNewReply(boaNum);
      return r;
   }
   
   public List<T_Reply> selectBoardReply(int boaNum){
      T_ReplyMapper mapper=session.getMapper(T_ReplyMapper.class);
      List<T_Reply> list=mapper.selectBoardReply(boaNum);
      return list;
   }
   public int deleteGroupReply(int groNum) {
      T_ReplyMapper mapper=session.getMapper(T_ReplyMapper.class);
      int result=mapper.deleteGroupReply(groNum);
      return result;
   }
   
   public int deleteBoardReply(int boaNum) {
      T_ReplyMapper mapper=session.getMapper(T_ReplyMapper.class);
      int result=mapper.deleteBoardReply(boaNum);
      return result;
   }
   
   public int deleteReply(int repNum) {
      T_ReplyMapper mapper=session.getMapper(T_ReplyMapper.class);
      int result=mapper.deleteReply(repNum);
      return result;
   }
}