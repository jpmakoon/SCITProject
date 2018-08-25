package global.sesoc.www.dao;

import global.sesoc.www.dto.T_User;

public interface T_UserMapper {
	
	//로그인, 아이디체크
	public T_User selectOne(T_User user);

}
