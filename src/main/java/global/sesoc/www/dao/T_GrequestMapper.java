package global.sesoc.www.dao;

import java.util.List;

import global.sesoc.www.dto.T_Grequest;
import global.sesoc.www.dto.T_GrequestUser;


public interface T_GrequestMapper {
   public int insertGrequest(T_Grequest gRequest);
   public List<T_Grequest> selectGrequest(T_Grequest gRequest);
   public List<T_Grequest> groupAccept(String accepter);
   public List<T_GrequestUser> selectGreqUsers(String userId);
   public int applySuccess(T_Grequest grequest);
   public T_Grequest selectGrequest2(T_Grequest gRequest);
   public int applyCancel(T_Grequest gRequest);
   public List<T_Grequest> checkInvite(T_Grequest grequest);
   public int groupMemberDelete(T_Grequest grequest);
   public int deleteGroupGrequest(int groNum);
   public List<T_Grequest> getGroupUsers(int groNum);
}