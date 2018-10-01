package global.sesoc.www.controller;

import java.io.IOException;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
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

	// 패턴분석 화면요청
	@RequestMapping(value = "/pattern", method = RequestMethod.GET)
	public String pattern(Locale locale, HttpSession session, Model model) {
		String userId = (String) session.getAttribute("loginId");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		String list = repository.selectCount(map);
		model.addAttribute("cateList", list);
		String unCheckedlist = repository.selectCountUnChecked(map);
		model.addAttribute("unCheckedlist", unCheckedlist);
		return "pattern/pattern";
	}

	// 패턴분석 첫번째: 카테고리별 분석
	@ResponseBody
	@RequestMapping(value = "/getCategory", method = RequestMethod.GET)
	public String getCategory(String userId, T_Schedule schedule) {
		Gson gson = new Gson();
		String checked = schedule.getChecked() + "";
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("checked", checked);

		List<T_Schedule> list = repository.selectCategory(map);

		System.out.println("djdj" + list);
		String g = gson.toJson(list);
		return g;
	}

	// 패턴분석 두번째: 월별 분석
	@ResponseBody
	@RequestMapping(value = "/getMonth", method = RequestMethod.GET)
	public String getMonth(String userId, T_Schedule schedule, Model model) {
		Gson gson = new Gson();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		System.out.println("유저아이디" + userId);
		List<T_Schedule> list = repository.selectCategory(map);
		String g = gson.toJson(list);
		return g;
	}

	// 패턴분석 세번째: 수행안한 스케줄 리스트
	@ResponseBody
	@RequestMapping(value = "/scheduleList", method = RequestMethod.POST)
	public List<T_Schedule> scheduleList(@RequestBody String checked, HttpSession session) {
		String userId = (String) session.getAttribute("loginId");
		List<T_Schedule> list = repository.select(userId, checked);
		return list;
	}

	@ResponseBody
	@RequestMapping(value = "/recPerCategory", method = RequestMethod.GET)
	public ArrayList<String[]> recPerCategory(HttpSession session, String category, Model model) {
		String result = "";
//		String village = (String) session.getAttribute("village");
		String village = "삼성동";

		String search = village + " " + category;
		System.out.println("검색어는 " + search);
		final String USER_AGENT = "Mozilla/5.0";

		// 1. URL 선언
		String connUrl = "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query="
				+ search;

		Connection conn = Jsoup.connect(connUrl).header("Content-Type", "application/json;charset=UTF-8")
				.userAgent(USER_AGENT).method(Connection.Method.GET).ignoreContentType(true);

		// 2. HTML 가져오기
		Document doc = null;
		try {
			doc = conn.get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// TODO POST의 data 값은 Jsoup.data(...) 을 사용하시면 됩니다.

		// 3. 가져온 HTML Document 를 확인하기
//		Elements first = doc.select("li.type_restaurant");
		Elements second = doc.select("ul.lst_map li");
		ArrayList<String[]> list = new ArrayList<String[]>();
		
		for (Element s : second) {
			String[] listed = new String[4];

			listed[0]=(s.select("a._sp_each_title").attr("href"));
			listed[1]=(s.select("a._sp_each_title").text());
			listed[2]=(s.select("span.tell").text());
			listed[3]=(s.select("span.ad_txt:nth-child(1)").text());
			list.add(listed);
		}
		System.out.println("list : " + list);
		return list;
	}
}
