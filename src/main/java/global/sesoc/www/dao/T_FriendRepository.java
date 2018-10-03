package global.sesoc.www.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.www.dto.T_Friend;

@Repository
public class T_FriendRepository {

	@Autowired
	SqlSession session;

	// 친구 요청
	public int friInsert(T_Friend friend) {
		T_FriendMapper mapper = session.getMapper(T_FriendMapper.class);
		int result = mapper.friInsert(friend);
		return result;
	}

	// 친구 체크
	public List<T_Friend> friCheck(T_Friend check) {
		T_FriendMapper mapper = session.getMapper(T_FriendMapper.class);
		List<T_Friend> list = mapper.friCheck(check);
		return list;
	}

	// 친구 수락(수정)
	public int friUpdate(T_Friend check) {
		T_FriendMapper mapper = session.getMapper(T_FriendMapper.class);
		int r = mapper.friUpdate(check);
		return r;
	}

	// 친구 거절(삭제)
	public int friDelete(T_Friend check) {
		T_FriendMapper mapper = session.getMapper(T_FriendMapper.class);
		int r = mapper.friDelete(check);
		return r;
	}

	// 수락한 친구 출력
	public List<T_Friend> myFriendList(String userId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("friAccepter", userId);
		map.put("friRequester", userId);
		T_FriendMapper mapper = session.getMapper(T_FriendMapper.class);
		List<T_Friend> list = mapper.myFriendList(map);
		return list;
	}

}
