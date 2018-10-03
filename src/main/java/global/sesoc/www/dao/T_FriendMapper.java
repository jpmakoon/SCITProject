package global.sesoc.www.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.www.dto.T_Friend;

public interface T_FriendMapper {

	int friInsert(T_Friend friend); //친구추가요청

	List<T_Friend> friCheck(T_Friend check); // 친구 목록확인

	int friUpdate(T_Friend check);	//친구수락(수정)

	int friDelete(T_Friend check);	//친구거절(삭제)
	
	List<T_Friend> myFriendList(Map<String, String> map); //수락한 친구 출력
}
