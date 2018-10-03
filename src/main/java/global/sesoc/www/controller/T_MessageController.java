package global.sesoc.www.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.www.dao.T_MessageRepository;
import global.sesoc.www.dto.T_Message;

@Controller
public class T_MessageController {

	@Autowired
	T_MessageRepository repository;
	
	//메세지 화면 보기
	@RequestMapping(value = "/messageList", method = RequestMethod.GET)
	public String messageList(HttpSession session, String senduserId, String receiveuserid, String msg, String date, Model model) {
		String userId = (String)session.getAttribute("loginId");
		model.addAttribute("userId", userId);
		model.addAttribute("senduserId", senduserId);
		model.addAttribute("receiveuserid", receiveuserid);
		model.addAttribute("msg", msg);
		model.addAttribute("date", date);
		return "messenger/messageWindow";
	}	
		
	@ResponseBody
	@RequestMapping(value = "/msgDelete", method = RequestMethod.POST)
	public int msgDelete(@RequestBody String messageNum,  HttpSession session) {
		int temp = Integer.parseInt(messageNum);
		T_Message msg = new T_Message();
		msg.setMesNum(temp);
		int r = repository.msgDelete(msg);
		return r;
	}	

	@ResponseBody
	@RequestMapping(value = "/msgCount", method = RequestMethod.POST)
	public int msgCount(HttpSession session) {
		String userId = (String)session.getAttribute("loginId");
		int result = repository.msgCount(userId);
		return result;
	}
}
