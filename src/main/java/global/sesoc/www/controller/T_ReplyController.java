package global.sesoc.www.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.www.dao.T_ReplyRepository;
import global.sesoc.www.dto.T_Reply;
@Controller
public class T_ReplyController {
	@Autowired
	T_ReplyRepository T_ReplyRepository;
	@ResponseBody
	@RequestMapping(value="/insertReply",method=RequestMethod.POST)
	public T_Reply insertReply(@RequestBody T_Reply r, HttpSession session) {
		
		String userId=(String)session.getAttribute("loginId");
		r.setUserId(userId);
		int result=T_ReplyRepository.insertReply(r);
	
		T_Reply reply=T_ReplyRepository.selectNewReply(r.getBoaNum());
		System.out.println(reply);
		return reply;
	}
	@ResponseBody
	@RequestMapping(value="/selectBoardReply",method=RequestMethod.POST)
	public List<T_Reply> selectBoardReply(@RequestBody T_Reply r){
		List<T_Reply> list=T_ReplyRepository.selectBoardReply(r.getBoaNum());
		
		return list;
	}
	
	   @ResponseBody
	   @RequestMapping(value="/deleteReply",method=RequestMethod.POST)
	   public int deleteReply(@RequestBody T_Reply r){
	      int result=T_ReplyRepository.deleteReply(r.getRepNum());
	      
	      return result;
	   }
}

