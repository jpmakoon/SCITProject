package global.sesoc.www.dao;

import java.util.List;

import global.sesoc.www.dto.T_Reply;

public interface T_ReplyMapper {
   public int insertReply(T_Reply reply);
   
   public T_Reply selectNewReply(int boaNum);
   
   public List<T_Reply> selectBoardReply(int boaNum);
   
   public int deleteGroupReply(int groNum);
   
   public int deleteBoardReply(int boaNum);
   
   public int deleteReply(int repNum);
}