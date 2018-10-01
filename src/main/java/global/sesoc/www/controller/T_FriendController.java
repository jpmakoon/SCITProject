package global.sesoc.www.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.www.dao.T_FriendRepository;
import global.sesoc.www.dao.T_MessageRepository;
import global.sesoc.www.dao.T_UserRepository;
import global.sesoc.www.dto.T_Friend;
import global.sesoc.www.dto.T_Message;
import global.sesoc.www.dto.T_User;

@Controller
public class T_FriendController {

	@Autowired
	T_FriendRepository repository;
	
	@Autowired
	T_UserRepository repository2;
	
	@Autowired
	T_MessageRepository repository3;
	//친구리스트 보여주기
	@RequestMapping(value = "/friendList", method = RequestMethod.GET)
	public String friendList(HttpSession session, T_Friend check, Model model) {
		String userId = (String) session.getAttribute("loginId"); // 사용자가 요청받은 친구 친구요청이 수락된 친구
		check.setFriRequester(userId);
		check.setFriAccepter(userId);

		List<T_Friend> rList = new ArrayList<>();					// 요청리스트
		List<T_Friend> fList = new ArrayList<>();		 			//	친구리스트
		
		List<T_Friend> list = repository.friCheck(check);			
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getIsAccepted() == 0) {
				if (list.get(i).getFriAccepter().equals(userId)) {
					rList.add(list.get(i));
				}
			}
			if (list.get(i).getIsAccepted() == 1) {
				fList.add(list.get(i));
			}
		}
		
		List<T_User> requestList = new ArrayList<>();				// 요청한 유저의 정보 가져오기
		for (int i = 0; i < rList.size(); i++) {
				String reqId = rList.get(i).getFriRequester();
				T_User user = new T_User();
				user.setUserId(reqId);
				user = repository2.selectOne(user);
				requestList.add(user);
				System.out.println("아하하하하하하하"+requestList);
		}
		
		List<T_User> friList = new ArrayList<>();					// 친구리스트에 있는 유저들 정보 가져오기
		for (int i = 0; i < fList.size(); i++) {
			if(fList.get(i).getFriRequester().equals(userId)) {
				String friId = fList.get(i).getFriAccepter();
				T_User user = new T_User();
				user.setUserId(friId);
				user = repository2.selectOne(user);
				friList.add(user);
			}
			
			if(fList.get(i).getFriAccepter().equals(userId)) {
				String friId = fList.get(i).getFriRequester();
				T_User user = new T_User();
				user.setUserId(friId);
				user = repository2.selectOne(user);
				friList.add(user);
			}
		}
		repository3.updateMsg(userId);
		T_Message message = new T_Message();
		message.setUserB(userId);
		List<T_Message> msgList = repository3.messageList(message);
		
		
		model.addAttribute("msgList", msgList);
		model.addAttribute("requestList", requestList);
		model.addAttribute("friList", friList);

		return "friend/friendList";
	}
	//친구 요청
	@ResponseBody
	@RequestMapping(value = "/friRequest", method = RequestMethod.POST)
	public int friRequest(@RequestBody T_Friend friend, HttpSession session) {
		String friRequester = (String) session.getAttribute("loginId");
		friend.setFriRequester(friRequester);
		int result = repository.friInsert(friend);
		return result;
	}
	//그 사람이 나랑 친구인지 확인
	@ResponseBody
	@RequestMapping(value = "/friCheck", method = RequestMethod.POST)
	public String friCheck(@RequestBody String idList, HttpSession session, T_Friend check) {
		String userId = (String) session.getAttribute("loginId");
		String result = ""; // 친구가 아님
		check.setFriAccepter(idList);
		check.setFriRequester(idList);
		List<T_Friend> list = repository.friCheck(check);
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getIsAccepted() == 0) {
				if(list.get(i).getFriRequester().equals(userId)) {
					result = "0";	// 내가 친구 요청 함
				}
				if(list.get(i).getFriAccepter().equals(userId)) {
					result = "2"; // 누가 나한테 친구요청함
				}
			}
			if (list.get(i).getIsAccepted() == 1) {
				if(list.get(i).getFriRequester().equals(userId) || list.get(i).getFriAccepter().equals(userId)) {
					result = "1"; // 친구인 사람
				}
			}
		}
		System.out.println(result);
		return result;
	}
	//친구요청 수락
	@ResponseBody
	@RequestMapping(value = "/friAccept", method = RequestMethod.POST)
	public int friAccept(@RequestBody T_Friend check, HttpSession session) {
		String userId = (String) session.getAttribute("loginId");
		check.setFriAccepter(userId);
		System.out.println(check);
		int r = repository.friUpdate(check);
		return r;
	}
	//친구 삭제
	@ResponseBody
	@RequestMapping(value = "/friDelete", method = RequestMethod.POST)
	public int friDelete(@RequestBody T_Friend check, HttpSession session) {
		String userId = (String) session.getAttribute("loginId");
		check.setFriAccepter(userId);
		System.out.println(check);
		int r = repository.friDelete(check);
		return r;
	}
	//처음 로그인했을 때 친구요청 상태가 있는지 없는지 확인.
	@ResponseBody
	@RequestMapping(value = "/reqCheck", method = RequestMethod.POST)
	public List<T_User> reqCheck(T_Friend check, HttpSession session, Model model) {
		String userId = (String) session.getAttribute("loginId");
		check.setFriRequester(userId);
		check.setFriAccepter(userId);

		List<T_Friend> rList = new ArrayList<>();					// 요청리스트
		
		List<T_Friend> list = repository.friCheck(check);			
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getIsAccepted() == 0) {
				if (list.get(i).getFriAccepter().equals(userId)) {
					rList.add(list.get(i));
				}
			}
		}
		
		List<T_User> checkList = new ArrayList<>();				// 요청한 유저의 정보 가져오기
		for (int i = 0; i < rList.size(); i++) {
				String reqId = rList.get(i).getFriRequester();
				T_User user = new T_User();
				user.setUserId(reqId);
				user = repository2.selectOne(user);
				checkList.add(user);
		}
		System.out.println(checkList);
		return checkList;
	}
	@ResponseBody
	@RequestMapping(value="/myFriendList" , method=RequestMethod.POST)
	public List<T_Friend> myFriendList(HttpSession session){
		String userId=(String)session.getAttribute("loginId");
		T_Friend f=new T_Friend(); f.setFriAccepter(userId);
		List<T_Friend> list=repository.myFriendList(f);
		return list;
	}
	
}
