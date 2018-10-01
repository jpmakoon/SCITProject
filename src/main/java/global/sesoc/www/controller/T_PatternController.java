package global.sesoc.www.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import global.sesoc.www.dao.T_ScheduleRepository;
import global.sesoc.www.dto.T_Schedule;

@Controller
public class T_PatternController {
	@Autowired
	T_ScheduleRepository repository;
	
	//패턴분석 화면요청
	@RequestMapping(value = "/pattern", method = RequestMethod.GET)
	public String pattern(Locale locale, HttpSession session, Model model) {
		String userId = (String) session.getAttribute("loginId");
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("userId",userId);
		String list= repository.selectCount(map);
		model.addAttribute("cateList", list);
		String unCheckedlist= repository.selectCountUnChecked(map);
		model.addAttribute("unCheckedlist", unCheckedlist);
		return "pattern/pattern";
	}
	//패턴분석 첫번째: 카테고리별 분석
	@ResponseBody
	@RequestMapping(value = "/getCategory", method = RequestMethod.GET)
	public String getCategory(String userId, T_Schedule schedule){
		Gson gson = new Gson();
		String checked =  schedule.getChecked()+"";
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("userId",userId);
		map.put("checked", checked);
		
		List<T_Schedule> list= repository.selectCategory(map);
		String g = gson.toJson(list);
		return g;
	}
	//패턴분석 두번째: 월별 분석
	@ResponseBody
	@RequestMapping(value = "/getMonth", method = RequestMethod.GET)
	public String getMonth(String userId, T_Schedule schedule, Model model){
		Gson gson = new Gson();
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("userId",userId);
		System.out.println("유저아이디"+userId);
		List<T_Schedule> list= repository.selectCategory(map);
		String g = gson.toJson(list);
		return g;
	}
	//패턴분석 세번째: 수행안한 스케줄 리스트
	@ResponseBody
	@RequestMapping(value="/scheduleList", method = RequestMethod.POST)
	public List<T_Schedule> scheduleList(@RequestBody String checked, HttpSession session) {
		String userId = (String) session.getAttribute("loginId");
		List<T_Schedule> list = repository.select(userId, checked);
		return list;
	}
}
