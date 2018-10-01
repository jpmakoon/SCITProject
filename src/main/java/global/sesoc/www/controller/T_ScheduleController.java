package global.sesoc.www.controller;


import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
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
import global.sesoc.www.dao.T_PlannerRepository;
import global.sesoc.www.dao.T_ScheduleRepository;
import global.sesoc.www.dto.T_Friend;
import global.sesoc.www.dto.T_Group;
import global.sesoc.www.dto.T_Planner;
import global.sesoc.www.dto.T_Schedule;
import global.sesoc.www.dto.T_User;

@Controller
public class T_ScheduleController {
	@Autowired
	T_ScheduleRepository T_ScheduleRepository; 
	@Autowired
	T_FriendRepository T_FriendRepository;
	@Autowired
	T_PlannerRepository T_PlannerRepository;
	@RequestMapping(value="/scheduleList", method=RequestMethod.GET)
	public String scheduleList(Model model,T_Schedule schedule) {
		
		List<T_Schedule> list=T_ScheduleRepository.selectPlannerSchedule(schedule.getPlaNum()); //userId를 session의 loginId로
		model.addAttribute("plaNum",schedule.getPlaNum());
		model.addAttribute("schdulelist",list);
		return "schedule/scheduleList";		
	}
	@ResponseBody
	@RequestMapping(value="/selectContent", method=RequestMethod.POST)
	public T_Schedule selectContent(@RequestBody T_Schedule s) {

		T_Schedule schedule=T_ScheduleRepository.selectOneUserSchedule(s);
		return schedule;
	}
	@RequestMapping(value="/scheduleDetail" , method=RequestMethod.GET)
	public String scheduleDetail(T_Schedule schedule,Model model) {
		T_Schedule s=T_ScheduleRepository.selectOneUserSchedule(schedule);
		model.addAttribute("schedule",s);
		return "schedule/scheduleDetail";
	}
	
	//schedule insert
	@RequestMapping(value="/insertSchedule", method=RequestMethod.GET)
	public String insertSchedule(Model model,T_Schedule s) {	//화면요청
		model.addAttribute("plaNum",s.getPlaNum());
		return "schedule/insertSchedule";
	}
	@RequestMapping(value="/insertSchedule", method=RequestMethod.POST)
	public String insertSchedule(T_Schedule s,Model model, HttpSession session) {	//schedule insert -- db
		String userId=(String)session.getAttribute("loginId");
		
		List<T_Planner> plannerList=T_PlannerRepository.plannerList(userId);
		model.addAttribute("plannerList",plannerList);
		
		int result= T_ScheduleRepository.insertSchedule(s);
	
		return "schedule/plannerList";
	}
	
	
	//schedule update
	@RequestMapping(value="/scheduleUpdate" , method=RequestMethod.GET)
	public String scheduleUpdate(T_Schedule schedule,Model model) { 	//화면 요청
		System.out.println("1:"+schedule);
		T_Schedule s=T_ScheduleRepository.selectOneUserSchedule(schedule);
		System.out.println("ssss"+s);
		model.addAttribute("schedule",s);
		return "schedule/scheduleUpdate";
	}
	@RequestMapping(value="/scheduleUpdate" , method=RequestMethod.POST)
	public String scheduleUpdate(Model model,T_Schedule schedule) {		//schedule update -- db
			
		int result=T_ScheduleRepository.updateSchedule(schedule);
		
		List<T_Schedule> list=T_ScheduleRepository.selectPlannerSchedule(schedule.getPlaNum()); //userId를 session의 loginId로
		model.addAttribute("plaNum",schedule.getPlaNum());
		model.addAttribute("schdulelist",list);
		return "redirect:/scheduleList";
	}
	@ResponseBody
	@RequestMapping(value="/selectUserAllSchedule" , method=RequestMethod.POST)
	public List<T_Schedule> selectUserAllSchedule(HttpSession session){
		String userId=(String)session.getAttribute("loginId");
		List<T_Schedule> schduleList=T_ScheduleRepository.selectUserAllSchedule(userId);
		return schduleList;
		
	}
	@ResponseBody
	@RequestMapping(value="/scheduleUpdate1" , method=RequestMethod.POST)
	public int scheduleUpdate1(@RequestBody T_Schedule schedule) {		//schedule update -- db
		T_Schedule sctitle=new T_Schedule(); sctitle.setSchTitle("제목을 입력해주세요.");
		sctitle.setSchContent("내용을 입력해주세요.");
		if(schedule.getSchTitle().trim().length()==0) {
			return 1;
		}else if (schedule.getSchContent().trim().length()==0) {
			return 2;
		}else if (schedule.getSchStartdate().trim().length()==0) {
			return 3;
		}else if (schedule.getSchEnddate().trim().length()==0) {
			return 4; 
		}else {
			int result=T_ScheduleRepository.updateSchedule1(schedule);
			T_Schedule schedule2=T_ScheduleRepository.selectOneUserSchedule(schedule);
			return schedule.getPlaNum();
		}
		
	}
	@ResponseBody
	@RequestMapping(value="/selectFriendAllSchedule" , method=RequestMethod.POST)
	public List<T_Schedule> selectFriendAllSchedule(@RequestBody T_User user){

		List<T_Schedule> schduleList=T_ScheduleRepository.selectUserAllSchedule(user.getUserId());	
		return schduleList;
	}
	@RequestMapping(value="/calendar", method=RequestMethod.GET)
	public String Calendar(Model model , HttpSession session) {
		String userId=(String)session.getAttribute("loginId");
		T_Friend friend=new T_Friend(); friend.setFriAccepter(userId); 
		
		List<T_Schedule> list=T_ScheduleRepository.selectUserAllSchedule("aaa");
		List<T_Friend> fList=T_FriendRepository.myFriendList(friend);
		
		model.addAttribute("fList",fList);
		model.addAttribute("schedule",list);
		return "schedule/calendar";
	}
	@ResponseBody
	@RequestMapping(value="/deleteSchedule", method=RequestMethod.POST)
	public int deleteSchedule(@RequestBody T_Schedule schedule) {
		System.out.println(schedule);
		System.out.println(schedule.getSchNum());
		int result=T_ScheduleRepository.deleteSchedule(schedule.getSchNum());
		System.out.println(result);
		return result;
	}
	@ResponseBody
	@RequestMapping(value="/selectMixSchedule", method=RequestMethod.POST)
	public List<T_Schedule> selectMixSchedule(@RequestBody T_User user,HttpSession session){
		String loginId=(String)session.getAttribute("loginId");
		System.out.println(user);

		List<T_Schedule> list=T_ScheduleRepository.selectMixSchedule(loginId, user.getUserId());
		System.out.println(list);
		return list;
		
	}

	@ResponseBody
	@RequestMapping(value="/selectUserPlannerSchedule",method=RequestMethod.POST)
	public List<T_Schedule> selectUserPlannerSchedule(@RequestBody T_Planner planner,HttpSession session){
		String userId=(String)session.getAttribute("loginId");
		System.out.println(planner);
		List<T_Schedule>list=T_ScheduleRepository.selectUserPlannerSchedule(userId, planner.getPlaNum());
		System.out.println("asasa::"+list);
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value="/selectGroupSchedule",method=RequestMethod.POST)
	public List<T_Schedule> selectGroupSchedule(@RequestBody T_Group group){
		System.out.println("aa::"+group);
		List<T_Schedule> list=T_ScheduleRepository.selectGroupSchedule(group.getGroNum());
		System.out.println("aaa::"+list);
		return list;
	}
	
	@RequestMapping(value="schDelete", method=RequestMethod.POST)
	public String schDelete(String schNum) {
		System.out.println(schNum +"schDelete쪽입니다.");
		int result = T_ScheduleRepository.delete(Integer.parseInt(schNum));
		
		if(result == 1) {
			return "성공!";
		}
		
		return "실패";
	}
	
	@RequestMapping(value = "/selectAll", method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> selectAll(Model model,HttpSession session){
		String userId = (String) session.getAttribute("loginId");
	/*	String userName = (String) session.getAttribute("loginName");*/
		
		List<T_Schedule> replylist = T_ScheduleRepository.selectCategoryMoon(userId);	
		List<Integer> percentlist = new ArrayList<Integer>();
		
		for(int i = 0; i < replylist.size(); i++) {
			T_Schedule sch = replylist.get(i);
			percentlist.add(getPercent(sch));
			System.out.println(userId);
		}
		
		HashMap<String, Object> list = new HashMap<String, Object>();
		list.put("replylist", replylist);
		list.put("percentlist", percentlist);
		model.addAttribute("replylist", replylist);
		System.out.println(list);
		
		return list;
		
	}
	
	private int getPercent(T_Schedule schedule) {
		String start = schedule.getSchStartdate();
		String end = schedule.getSchEnddate();
		
		String[] startdate = start.split("-");
		String[] enddate = end.split("-");
		
		LocalDate todate = LocalDate.now();
		LocalDate schStartdate = LocalDate.of(Integer.parseInt(startdate[0]),Integer.parseInt(startdate[1]),Integer.parseInt(startdate[2])); // 2016-04-02
		LocalDate schEnddate = LocalDate.of(Integer.parseInt(enddate[0]),Integer.parseInt(enddate[1]),Integer.parseInt(enddate[2]));
		
		int allDate = (int) ChronoUnit.DAYS.between(schStartdate, schEnddate);  //몇일 간인지 가저오는 기능
		
		int passDate = (int) ChronoUnit.DAYS.between(schStartdate, todate); //스케줄 시작날로부터 며칠이 지났는지
		
		String sAllDate = String.valueOf(allDate);
		Double temp = passDate/Double.parseDouble(sAllDate);
		
		int percent = (int)(temp * 100);
		
		if(percent > 100) 
			return 100;
		else 
			return percent;
		
	}
	
	@RequestMapping(value="/schUpdate", method=RequestMethod.GET)
	public @ResponseBody int updateCheck(T_Schedule checked) {
		System.out.println(checked+"뭐지");
		int check = T_ScheduleRepository.updateCheck(checked);
		
		return check;

	}
}


