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

import global.sesoc.www.dao.T_RequestRepository;
import global.sesoc.www.dao.T_UserRepository;
import global.sesoc.www.dto.T_Request;
import global.sesoc.www.dto.T_User;

@Controller
public class T_RequestController {
	@Autowired
	T_RequestRepository T_RequestRepository;
	@Autowired
	T_UserRepository T_UserRepository;
	
	
	@ResponseBody
	@RequestMapping(value="/calendarShare", method=RequestMethod.POST)
	public int calendarShare(@RequestBody T_Request request, HttpSession session) {
		String userId=(String)session.getAttribute("loginId");
		request.setRequester(userId);
		
		T_Request checkReq=new T_Request(); checkReq.setReqAccepter(userId);
		checkReq.setRequester(request.getReqAccepter());
		List<T_Request>list2=T_RequestRepository.checkShare(request);
		List<T_Request>list=T_RequestRepository.checkShare(checkReq);
		
		if(list.size() != 0 || list2.size() != 0) {
			return 0;
		}else {
			int result=T_RequestRepository.calendarShare(request);
			return result; 
		}
	}
	@ResponseBody
	@RequestMapping(value="/isCalendarShare", method=RequestMethod.POST)
	public List<T_Request> isCalendarShare(HttpSession session){
		String userId=(String)session.getAttribute("loginId");
		List<T_Request> list=T_RequestRepository.isCalendarShare(userId);
		return list;
	}
	@RequestMapping(value="/isShareRequest", method=RequestMethod.GET)
	public String isShareRequest(HttpSession session,Model model) {
		String userId=(String)session.getAttribute("loginId");
		List<T_User>requestList=new ArrayList<>();
		List<T_Request> rList=T_RequestRepository.isCalendarShare(userId);
		
		for (int i = 0; i < rList.size(); i++) {
			String reqId = rList.get(i).getRequester();
			T_User user = new T_User();
			user.setUserId(reqId);
			user = T_UserRepository.selectOne(user);
			requestList.add(user);
		}
		System.out.println("AAA"+rList);
		model.addAttribute("rList",rList);
		model.addAttribute("requestList",requestList);
		return "request/isShareRequest";
	}
	@ResponseBody
	@RequestMapping(value="/calendarAccept", method=RequestMethod.POST)
	public int calendarAccept(@RequestBody T_Request request, HttpSession session) {
		String userId=(String)session.getAttribute("loginId");
		request.setReqAccepter(userId);
		System.out.println("알이큐" + request);
		int result=T_RequestRepository.calendarAccept(request);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/delShareCal", method=RequestMethod.POST)
	public int delShareCal(@RequestBody T_Request request, HttpSession session) {
		String userId=(String)session.getAttribute("loginId");
		request.setReqAccepter(userId);
	
		int result=T_RequestRepository.delShareCal(request);
		return result;
	}
	
	@ResponseBody
	   @RequestMapping(value="/shareCal", method=RequestMethod.POST)
	   public List<String> shareCal(HttpSession session){
	      String userId=(String)session.getAttribute("loginId");
	      List<T_Request>rList=T_RequestRepository.shareCal(userId);
	      List<String> list=new ArrayList<String>();
	      
	      for (int i = 0; i < rList.size(); i++) {
	         if(!rList.get(i).getRequester().equals(userId)) {
	            list.add(rList.get(i).getRequester());
	            }
	         if(!rList.get(i).getReqAccepter().equals(userId)) {
	            list.add(rList.get(i).getReqAccepter());
	         }
	      }
	      return list;
	      
	   }
	
	@RequestMapping(value="/shareCalendar", method=RequestMethod.GET)
	public String shareCalendar(T_Request request,HttpSession session,Model model) {
		String userId=(String)session.getAttribute("loginId");
		request.setReqAccepter(userId);
		model.addAttribute("req",request);
		return "request/shareCalendar";
	}
}
