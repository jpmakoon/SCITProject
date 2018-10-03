package global.sesoc.www.dao;

import java.util.List;

import global.sesoc.www.dto.T_Board;

public interface T_BoardMapper {
   public int insertBoard(T_Board board);

   public List<T_Board> selectGroNumBoard(int groNum);
   
   public T_Board detailBoard(T_Board board);
   
   public int deleteGroupBoard(int groNum);
   
   public int deleteBoard(int boaNum);
}