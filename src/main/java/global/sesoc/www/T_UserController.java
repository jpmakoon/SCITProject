package global.sesoc.www;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.www.dao.T_UserRepository;
import global.sesoc.www.dto.T_User;

@Controller
public class T_UserController {
	@Autowired
	T_UserRepository repository;
	@Autowired
	SqlSession sqlSession;

    @RequestMapping(value="/login", method=RequestMethod.POST)
    public String login(T_User user, HttpSession session, Model model) {
    	T_User t = repository.selectOne(user);
    	if(t != null) {
    		session.setAttribute("loginId", t.getUserId());
    		session.setAttribute("loginName", t.getUserName());
    		return "user/userDetail";
    	}else {
    		model.addAttribute("islogined", "1");
    		return "index";
    	}
    }
}
